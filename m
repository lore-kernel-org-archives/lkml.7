Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48262C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCE5206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519757;
	bh=IXpBmKx0KAyoZiN8CC06cqY2NS0+d/5UaucNXV6Fj+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oRrkMNfGVsOVFllAk+5TE+yOijdfMajFLdmU9MWRV0BCS1twDxfYSCvQLOW21bKt9
	 NhbK3YgG55Sq8UDw1ANJLIvBRJM/Rwk3lCZUUaljpvqZksoYmzNhcLSFgGJiYBe2p5
	 OtUBqFlqi2Fit8+rhNe+3IjfgHITRpV5UgvjUwSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfLPSJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbfLPSJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:09:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1844F2166E;
        Mon, 16 Dec 2019 18:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519752;
        bh=IXpBmKx0KAyoZiN8CC06cqY2NS0+d/5UaucNXV6Fj+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4GbzhZH/9nXg8504o8SipQU747qS8+ZHklVhEo6NvoN3RXv6zBnm3wiMv/IyGy9i
         9GbqD1+8tHtpF7E/cq4svhLRNR+6ce3Whoc1XfrQpR21RkCHVPgga30pIGcpFRT9XE
         DI14cClnbLigsAQ26xCdzwyghZra7WifHM5kOzZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 5.3 054/180] iwlwifi: pcie: fix support for transmitting SKBs with fraglist
Date:   Mon, 16 Dec 2019 18:48:14 +0100
Message-Id: <20191216174826.118104634@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 4f4925a7b23428d5719af5a2816586b2a0e6fd19 upstream.

When the implementation of SKBs with fraglist was sent upstream, a
merge-damage occurred and half the patch was not applied.

This causes problems in high-throughput situations with AX200 devices,
including low throughput and FW crashes.

Introduce the part that was missing from the original patch.

Fixes: 0044f1716c4d ("iwlwifi: pcie: support transmitting SKBs with fraglist")
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ This patch was created by me, but the original author of this code
  is Johannes, so his s-o-b is here and he's marked as the author of
  the patch. ]
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -469,6 +469,7 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx(stru
 	dma_addr_t tb_phys;
 	int len, tb1_len, tb2_len;
 	void *tb1_addr;
+	struct sk_buff *frag;
 
 	tb_phys = iwl_pcie_get_first_tb_dma(txq, idx);
 
@@ -517,6 +518,19 @@ iwl_tfh_tfd *iwl_pcie_gen2_build_tx(stru
 	if (iwl_pcie_gen2_tx_add_frags(trans, skb, tfd, out_meta))
 		goto out_err;
 
+	skb_walk_frags(skb, frag) {
+		tb_phys = dma_map_single(trans->dev, frag->data,
+					 skb_headlen(frag), DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(trans->dev, tb_phys)))
+			goto out_err;
+		iwl_pcie_gen2_set_tb(trans, tfd, tb_phys, skb_headlen(frag));
+		trace_iwlwifi_dev_tx_tb(trans->dev, skb,
+					frag->data,
+					skb_headlen(frag));
+		if (iwl_pcie_gen2_tx_add_frags(trans, frag, tfd, out_meta))
+			goto out_err;
+	}
+
 	return tfd;
 
 out_err:


