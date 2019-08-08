Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E298CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82792173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291727;
	bh=W8JslaqknLvwnDsLKL4JOkdNHkzXZHPuBoQQEQdUfKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K+5L9soXvhqQivt/SYFHc595bXUqq+qRepGKXUsFbpYgjj5W5tiTro2YUA25pi0sc
	 btRsvoAJygDb92lCoLQ/XZiRX7wJvkR7/D1KsEUvLMzsGtAM13VxtOmz6Ro/6QVzBZ
	 5osp4rh0muxCGLhNF7eI4wpGABsUtEiSrGuPrwzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404560AbfHHTG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404529AbfHHTGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:06:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3E32184E;
        Thu,  8 Aug 2019 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291210;
        bh=W8JslaqknLvwnDsLKL4JOkdNHkzXZHPuBoQQEQdUfKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2NmDI1dHIUt1slEwoGBhF0xAYeak0c92UW/IFqnBdqhgUvVLQbwR1Oo2itdrIlKu
         Ww6eFqi8mGTz58v9b4UEwqGUkHQVw6KNvT/aj8xLFPMnMSoSEnc44/5CPhrmGd6aAQ
         X1qVWx5M8R6Ah975QjjPNI5t/1vIEdmGwXR341iI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Tranchetti <stranche@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 28/56] net: qualcomm: rmnet: Fix incorrect UL checksum offload logic
Date:   Thu,  8 Aug 2019 21:04:54 +0200
Message-Id: <20190808190454.065714907@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
References: <20190808190452.867062037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit a7cf3d24ee6081930feb4c830a7f6f16ebe31c49 ]

The udp_ip4_ind bit is set only for IPv4 UDP non-fragmented packets
so that the hardware can flip the checksum to 0xFFFF if the computed
checksum is 0 per RFC768.

However, this bit had to be set for IPv6 UDP non fragmented packets
as well per hardware requirements. Otherwise, IPv6 UDP packets
with computed checksum as 0 were transmitted by hardware and were
dropped in the network.

In addition to setting this bit for IPv6 UDP, the field is also
appropriately renamed to udp_ind as part of this change.

Fixes: 5eb5f8608ef1 ("net: qualcomm: rmnet: Add support for TX checksum offload")
Cc: Sean Tranchetti <stranche@codeaurora.org>
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h      |    2 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c |   13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
@@ -51,7 +51,7 @@ struct rmnet_map_dl_csum_trailer {
 struct rmnet_map_ul_csum_header {
 	__be16 csum_start_offset;
 	u16 csum_insert_offset:14;
-	u16 udp_ip4_ind:1;
+	u16 udp_ind:1;
 	u16 csum_enabled:1;
 } __aligned(1);
 
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -206,9 +206,9 @@ rmnet_map_ipv4_ul_csum_header(void *iphd
 	ul_header->csum_insert_offset = skb->csum_offset;
 	ul_header->csum_enabled = 1;
 	if (ip4h->protocol == IPPROTO_UDP)
-		ul_header->udp_ip4_ind = 1;
+		ul_header->udp_ind = 1;
 	else
-		ul_header->udp_ip4_ind = 0;
+		ul_header->udp_ind = 0;
 
 	/* Changing remaining fields to network order */
 	hdr++;
@@ -239,6 +239,7 @@ rmnet_map_ipv6_ul_csum_header(void *ip6h
 			      struct rmnet_map_ul_csum_header *ul_header,
 			      struct sk_buff *skb)
 {
+	struct ipv6hdr *ip6h = (struct ipv6hdr *)ip6hdr;
 	__be16 *hdr = (__be16 *)ul_header, offset;
 
 	offset = htons((__force u16)(skb_transport_header(skb) -
@@ -246,7 +247,11 @@ rmnet_map_ipv6_ul_csum_header(void *ip6h
 	ul_header->csum_start_offset = offset;
 	ul_header->csum_insert_offset = skb->csum_offset;
 	ul_header->csum_enabled = 1;
-	ul_header->udp_ip4_ind = 0;
+
+	if (ip6h->nexthdr == IPPROTO_UDP)
+		ul_header->udp_ind = 1;
+	else
+		ul_header->udp_ind = 0;
 
 	/* Changing remaining fields to network order */
 	hdr++;
@@ -419,7 +424,7 @@ sw_csum:
 	ul_header->csum_start_offset = 0;
 	ul_header->csum_insert_offset = 0;
 	ul_header->csum_enabled = 0;
-	ul_header->udp_ip4_ind = 0;
+	ul_header->udp_ind = 0;
 
 	priv->stats.csum_sw++;
 }


