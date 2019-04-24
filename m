Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAC2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C59E21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126972;
	bh=CTG6qnDEawfmUufGk1oiMnUwBpP2Hg2Lk/F42dzZNzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nht9xHhSpCFlaVf06wdvC2JBd9CvASmxqA8vvdbP1SlOmqBGG1vR/Yoxcol+uwsPx
	 2v54kI5ZUd8hVHFDBEU4VkDwK9eGhY3yM7tJL8Oh8hdHU1G0w4Tymohwt/tDjuc83y
	 SclJ5rMkRtxkFxs3rIhzpwzU9lvBkDnLzjmxo7jU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390824AbfDXR3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390811AbfDXR32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:28 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7270B2054F;
        Wed, 24 Apr 2019 17:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126967;
        bh=CTG6qnDEawfmUufGk1oiMnUwBpP2Hg2Lk/F42dzZNzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CAVwLVWMY/uP2nvG8fzyUMgCQk/zB1MV4xQQjrKDD5HJMkO2n1aXW8OKypbSVTy9G
         7sm1aWzgtAPtrF/PTXoO70k+FRJ0Tj6EwyV+gPEGySd57SC+mJnWTrVXlNG2EWnThX
         fCkyRE+dNRdb+pxx3PrNgIdAqucV8p5y71hBqwgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 12/96] ipv4: recompile ip options in ipv4_link_failure
Date:   Wed, 24 Apr 2019 19:09:17 +0200
Message-Id: <20190424170920.624539038@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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
@@ -1188,8 +1188,16 @@ static struct dst_entry *ipv4_dst_check(
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


