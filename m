Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E23FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051D521773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128102;
	bh=QQRmxag+k+Z1YfmCMjZzcuGFWHWNqk5ShkOqsSGePjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OxvcOd1am4HxF9ogH/2mGUEkZiKgaiCwuDbiYHKMrxLGu7t6ahi6rvegNDXMsVpG8
	 xrpHU2CKVJ6GdDgAtwLslliyGdfWPFaR72oV6J2a1TH0MWdGP3KHYOQdhOUvF6FGPS
	 D6uq8qa5xZs3cUw3BVzTSbVcnONAIMADZsS1lTwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391122AbfDXRbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391104AbfDXRbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:31:08 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9E9F2077C;
        Wed, 24 Apr 2019 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127065;
        bh=QQRmxag+k+Z1YfmCMjZzcuGFWHWNqk5ShkOqsSGePjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Evh8BdqgRewiWUTuSd5mp5UO0oyUT5dlNPTjkDp7KPNtV9naxBMSrE4YSG1HDhw5Q
         mD1mAk9vlDSD7ClyXOWLJOvONynf5hIZg6bA3d4+LrwSji+1XT8KkEcUKN4AZ8Ld++
         n4Fu1/Bq6X9q5E8L/ZVbrTBioqQzgic3f9Tk6iEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuya Kusakabe <yuya.kusakabe@gmail.com>,
        Takeru Hayasaka <taketarou2@gmail.com>,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 06/96] net: Fix missing meta data in skb with vlan packet
Date:   Wed, 24 Apr 2019 19:09:11 +0200
Message-Id: <20190424170920.251085561@linuxfoundation.org>
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

From: Yuya Kusakabe <yuya.kusakabe@gmail.com>

[ Upstream commit d85e8be2a5a02869f815dd0ac2d743deb4cd7957 ]

skb_reorder_vlan_header() should move XDP meta data with ethernet header
if XDP meta data exists.

Fixes: de8f3a83b0a0 ("bpf: add meta pointer for direct access")
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Signed-off-by: Takeru Hayasaka <taketarou2@gmail.com>
Co-developed-by: Takeru Hayasaka <taketarou2@gmail.com>
Reviewed-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5071,7 +5071,8 @@ EXPORT_SYMBOL_GPL(skb_gso_validate_mac_l
 
 static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
 {
-	int mac_len;
+	int mac_len, meta_len;
+	void *meta;
 
 	if (skb_cow(skb, skb_headroom(skb)) < 0) {
 		kfree_skb(skb);
@@ -5083,6 +5084,13 @@ static struct sk_buff *skb_reorder_vlan_
 		memmove(skb_mac_header(skb) + VLAN_HLEN, skb_mac_header(skb),
 			mac_len - VLAN_HLEN - ETH_TLEN);
 	}
+
+	meta_len = skb_metadata_len(skb);
+	if (meta_len) {
+		meta = skb_metadata_end(skb) - meta_len;
+		memmove(meta + VLAN_HLEN, meta, meta_len);
+	}
+
 	skb->mac_header += VLAN_HLEN;
 	return skb;
 }


