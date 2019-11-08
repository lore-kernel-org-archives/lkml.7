Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71143FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBBE222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213394;
	bh=E19oXiWamBZ3jQIs/It2J/lNITsNHRyrUBJ4VSnzC/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aMSuq1rlmANlhZkfNYP2Voody6yn0g39U1bwEfXCVqUHF4m+TLAF8DfvFtvPT6Y80
	 ZaKwCvjKWhQquhGOAD0bCq40Jrsde+712U3r3bJYHNY9LDwEFV9LYlqkWv9w1j7SrV
	 EDhM4rESsuNYE8P0yYeP1VoGu+8FP1Wn4V4AiB5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733111AbfKHLnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390287AbfKHLnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AF3521D82;
        Fri,  8 Nov 2019 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213381;
        bh=E19oXiWamBZ3jQIs/It2J/lNITsNHRyrUBJ4VSnzC/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfhXFwt3JoN63+GbRK9PJ06wEHeYGDe8UuNaMt9NzwNd9VwKTguVjs+5yjI2a2V7J
         aJPRXZJ8nvK2SX+7oHDc5bYT+7KKPUUWeiyLxi3E5KtAQTtSReugeC3fwYSJfrlExw
         sw5FkDu2qpk4bw0pAX3efFTwVcVKQZ7Ahq6Vfm/w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 204/205] s390/qeth: limit csum offload erratum to L3 devices
Date:   Fri,  8 Nov 2019 06:37:51 -0500
Message-Id: <20191108113752.12502-204-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit f231dc9dbd789b0f98a15941e3cebedb4ad72ad5 ]

Combined L3+L4 csum offload is only required for some L3 HW. So for
L2 devices, don't offload the IP header csum calculation.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reference-ID: JUP 394553
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h    | 5 -----
 drivers/s390/net/qeth_l3_main.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index b2657582cfcfd..41a2f901ccee5 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -902,11 +902,6 @@ static inline void qeth_tx_csum(struct sk_buff *skb, u8 *flags, int ipv)
 	if ((ipv == 4 && ip_hdr(skb)->protocol == IPPROTO_UDP) ||
 	    (ipv == 6 && ipv6_hdr(skb)->nexthdr == IPPROTO_UDP))
 		*flags |= QETH_HDR_EXT_UDP;
-	if (ipv == 4) {
-		/* some HW requires combined L3+L4 csum offload: */
-		*flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
-		ip_hdr(skb)->check = 0;
-	}
 }
 
 static inline void qeth_put_buffer_pool_entry(struct qeth_card *card,
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 9c5e801b3f6cb..c60660cb5a031 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2054,6 +2054,11 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 
 	if (!skb_is_gso(skb) && skb->ip_summed == CHECKSUM_PARTIAL) {
 		qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, ipv);
+		/* some HW requires combined L3+L4 csum offload: */
+		if (ipv == 4) {
+			hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
+			ip_hdr(skb)->check = 0;
+		}
 		if (card->options.performance_stats)
 			card->perf_stats.tx_csum++;
 	}
-- 
2.20.1

