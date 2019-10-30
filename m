Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B81CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD65320656
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450609;
	bh=1Y+xRVtxzd2fp4h43+XE1wF9wYKRdu6H+a18mpLMYN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7RvXksntUpqpJyWf9jib8ecfEP8F7XeRY5JnCpUouJ0soR/nFJh/H5VSVtWJpPou
	 HwKCHtnmRXkcuicUNNjEp/E9qg9EXT6/4ISt2CZQRW9hV+w6ZVLdptwdu9DGRxX/aP
	 U+Y7m1bBSHidOh2s8CloPfMB4aWwWGgU1ard3L6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfJ3PuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfJ3PuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:50:05 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1042A208C0;
        Wed, 30 Oct 2019 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450604;
        bh=1Y+xRVtxzd2fp4h43+XE1wF9wYKRdu6H+a18mpLMYN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MH0ogyrrLSwD83I1eLYqQPY36ETjUAGBvI2VpkqsciUJoXpU1zN3I4qwjhlT/yHeL
         Pcj+Wo8lt4RTsLFTIcRov9SjtqbvXyflDJ14YBP91Jb4HNN7cuQOzOlR9lc3paIeB2
         oUcW1GFIJReknGdSP9XJDMkQihcR4rREys9YBCdk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 12/81] ASoC: SOF: loader: fix kernel oops on firmware boot failure
Date:   Wed, 30 Oct 2019 11:48:18 -0400
Message-Id: <20191030154928.9432-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030154928.9432-1-sashal@kernel.org>
References: <20191030154928.9432-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 798614885a0e1b867ceb0197c30c2d82575c73b0 ]

When we fail to boot the firmware, we encounter a kernel oops in
hda_dsp_get_registers(), which is called conditionally in
hda_dsp_dump() when the sdev_>boot_complete flag is set.

Setting this flag _after_ dumping the data fixes the issue and does
not change the programming flow.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190927200538.660-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 952a19091c582..01775231f2b8d 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -370,10 +370,10 @@ int snd_sof_run_firmware(struct snd_sof_dev *sdev)
 				 msecs_to_jiffies(sdev->boot_timeout));
 	if (ret == 0) {
 		dev_err(sdev->dev, "error: firmware boot failure\n");
-		/* after this point FW_READY msg should be ignored */
-		sdev->boot_complete = true;
 		snd_sof_dsp_dbg_dump(sdev, SOF_DBG_REGS | SOF_DBG_MBOX |
 			SOF_DBG_TEXT | SOF_DBG_PCI);
+		/* after this point FW_READY msg should be ignored */
+		sdev->boot_complete = true;
 		return -EIO;
 	}
 
-- 
2.20.1

