Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7EDC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBC621537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600298;
	bh=TSKGw1r5dLtQbJRCdmKWf5HSmP9FklzelECTG9HgAjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mnPh3Wu+30DORYDWqjzn0vLE3/wQnG5aHqexNKsMzySsT/8LdktRIorESHzIEA37Z
	 cP71fd60CodVRTYSYkoTPSJJope7qy62BVvA/K5XLCgO2Itqc3Hr2eu72xUDCi+5Cw
	 LuE4nZxO4NztjoUG37fQGAVjTMbrmw4fNNX8IPFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbfGHPiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389649AbfGHPaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:30:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F90521537;
        Mon,  8 Jul 2019 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599838;
        bh=TSKGw1r5dLtQbJRCdmKWf5HSmP9FklzelECTG9HgAjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgZfkfXY0XbGKfxsXZnwLi8u9lwUgkygkjSfepjCkZGOk0Lb9oX1J+jJvio0c6NI1
         dbVjjTlyrEMWR51kbGdUz2oF+OPP/HdcjK72zqoNTXom4BJlIN5FzPPFv6FS/aI+YO
         63vYKFpyTHo7fCnfEctPpWvejY3SePzjyRiwLdPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 89/90] dmaengine: qcom: bam_dma: Fix completed descriptors count
Date:   Mon,  8 Jul 2019 17:13:56 +0200
Message-Id: <20190708150527.042392553@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

commit f6034225442c4a87906d36e975fd9e99a8f95487 upstream.

One space is left unused in circular FIFO to differentiate
'full' and 'empty' cases. So take that in to account while
counting for the descriptors completed.

Fixes the issue reported here,
	https://lkml.org/lkml/2019/6/18/669

Cc: stable@vger.kernel.org
Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/qcom/bam_dma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -808,6 +808,9 @@ static u32 process_channel_irqs(struct b
 		/* Number of bytes available to read */
 		avail = CIRC_CNT(offset, bchan->head, MAX_DESCRIPTORS + 1);
 
+		if (offset < bchan->head)
+			avail--;
+
 		list_for_each_entry_safe(async_desc, tmp,
 					 &bchan->desc_list, desc_node) {
 			/* Not enough data to read */


