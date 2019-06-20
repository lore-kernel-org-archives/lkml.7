Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0237FC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34692089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054497;
	bh=O1AOVWIfY8FUP0UKPr0TTotD4YyJ3xpe9kg3M8Azp08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ehxCI0vwOeasJm52SYNXexw7tsai7qVZklV65J9EJAYSDiPa1WIbuVb5JiBUugsuP
	 6hoj5e6qm6i5T3frLGu6TZoxX9vYMa/advVbDrXkOECthZH06MRKiroMoSgggoQnUq
	 +qJNBUPy24jdzdt76pfoEMX+N53iJp1EW+ZcP8e4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfFTSO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbfFTSOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:14:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E27F21530;
        Thu, 20 Jun 2019 18:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054491;
        bh=O1AOVWIfY8FUP0UKPr0TTotD4YyJ3xpe9kg3M8Azp08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1KqBXslC9KyRVaAphIEmZ9vLjPCrqAGDzypsjcWnobHIGfdFdmcDEoSCfCqvf75kF
         7+x1/m1gVrP+JAcqwxNGdny5i3ePsFVcpOMG9QsbiPtnUzMIDiCHOOwRpLBIM5njUf
         LGLvALcWgsXmGScFQQJ5eVND9VKEe2sYXpm2vzQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <gnault@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 17/98] vxlan: Dont assume linear buffers in error handler
Date:   Thu, 20 Jun 2019 19:56:44 +0200
Message-Id: <20190620174350.058456278@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit 8399a6930d12f5965230f4ff058228a4cc80c0b9 ]

In commit c3a43b9fec8a ("vxlan: ICMP error lookup handler") I wrongly
assumed buffers from icmp_socket_deliver() would be linear. This is not
the case: icmp_socket_deliver() only guarantees we have 8 bytes of linear
data.

Eric fixed this same issue for fou and fou6 in commits 26fc181e6cac
("fou, fou6: do not assume linear skbs") and 5355ed6388e2 ("fou, fou6:
avoid uninit-value in gue_err() and gue6_err()").

Use pskb_may_pull() instead of checking skb->len, and take into account
the fact we later access the VXLAN header with udp_hdr(), so we also
need to sum skb_transport_header() here.

Reported-by: Guillaume Nault <gnault@redhat.com>
Fixes: c3a43b9fec8a ("vxlan: ICMP error lookup handler")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1765,7 +1765,7 @@ static int vxlan_err_lookup(struct sock
 	struct vxlanhdr *hdr;
 	__be32 vni;
 
-	if (skb->len < VXLAN_HLEN)
+	if (!pskb_may_pull(skb, skb_transport_offset(skb) + VXLAN_HLEN))
 		return -EINVAL;
 
 	hdr = vxlan_hdr(skb);


