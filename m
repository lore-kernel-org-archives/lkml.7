Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A96AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495A12054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126826;
	bh=WZAtU4FR4+1q2WBsXAn9z/FFFPhXlTxXqUPg00OvDbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CoOLSfBHy0XRDfNuMRHLpTaIzM5K0vUmo0AJ3dGG4nF1KOKmy5GQUs9MUBN3PdRJg
	 zBg0GRYVPiV6iBziuoPojodWILmJe/aG2GYwyyfFp7vmdUjvD8rMZdnEZi2aF2BKu2
	 Xl8KORFmA9cZbldpImv+Gf/Z1lNFhxgaJIry//oY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390374AbfDXR1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389753AbfDXR1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:27:01 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73B12054F;
        Wed, 24 Apr 2019 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126821;
        bh=WZAtU4FR4+1q2WBsXAn9z/FFFPhXlTxXqUPg00OvDbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cIYZ7UI8dnkrDZGDjE00Dc0TNhi9N7cl5Z6QEN//C0kCScO4jLJQzbgYPu9nKP9O8
         0tW56oyYEt4/2NyXov2ATrBkDg6Y6NSwBNm23/Z6UvsKYefrzPeSJXODoSDgdBVBub
         ZbbM2V26OK3oOglqtEvuuxZiQGEheDRu7CiKbsxw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 09/70] ipv4: recompile ip options in ipv4_link_failure
Date:   Wed, 24 Apr 2019 19:09:29 +0200
Message-Id: <20190424170908.578877124@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Suryaputra <ssuryaextr@gmail.com>

[ Upstream commit ed0de45a1008991fdaa27a0152befcb74d126a8b ]

Recompile IP options since IPCB may not be valid anymore when
ipv4_link_failure is called from arp_error_report.

Refer to the commit 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
and the commit before that (9ef6b42ad6fd) for a similar issue.

Signed-off-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1195,8 +1195,16 @@ static struct dst_entry *ipv4_dst_check(
 static void ipv4_link_failure(struct sk_buff *skb)
 {
 	struct rtable *rt;
+	struct ip_options opt;
 
-	icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
+	/* Recompile ip options since IPCB may not be valid anymore.
+	 */
+	memset(&opt, 0, sizeof(opt));
+	opt.optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
+	if (__ip_options_compile(dev_net(skb->dev), &opt, skb, NULL))
+		return;
+
+	__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &opt);
 
 	rt = skb_rtable(skb);
 	if (rt)


