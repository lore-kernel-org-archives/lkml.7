Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D071C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CF320637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014139;
	bh=mrrRUe3U+lIbdKRBPsxyc8MbEhLBzm8SELnziKYmXNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wrtbWkB9X3m1XZi1P3QZz3pDcw44mh2JA3hitS/WeX04sQSRM9UVa0KS2yTmqMg8k
	 oJ1cmKhzChm4j/QkXK7tB+1LkzLGJjdiAhqOdGa5DOzWbN/PaWomPxeyu93iLoEbQa
	 6oovvQhhlKSYwaCCONdoQjV4yS+cvxIof0guK5QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfLJVmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:42:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbfLJVeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:34:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CA072467B;
        Tue, 10 Dec 2019 21:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013642;
        bh=mrrRUe3U+lIbdKRBPsxyc8MbEhLBzm8SELnziKYmXNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKZcrZNwDn2fMgLFvEQvLk5rOkD4ADRGviGkOJIBVmq0xFtN3IxGg7h5etCcMjGAG
         gzQWfA0a8a/r0xUaFimj43pApxp7kzGy62CnIbHPBQaN3L3LaHblZUGlBrazThyt1C
         wJWalJ5S8Pa74P5L599q7F09e/XYmONaCp/KhZ8U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 082/177] ALSA: hda - Fix pending unsol events at shutdown
Date:   Tue, 10 Dec 2019 16:30:46 -0500
Message-Id: <20191210213221.11921-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit ca58f55108fee41d87c9123f85ad4863e5de7f45 ]

This is an alternative fix attemp for the issue reported in the commit
caa8422d01e9 ("ALSA: hda: Flush interrupts on disabling") that was
reverted later due to regressions.  Instead of tweaking the hardware
disablement order and the enforced irq flushing, do calling
cancel_work_sync() of the unsol work early enough, and explicitly
ignore the unsol events during the shutdown by checking the
bus->shutdown flag.

Fixes: caa8422d01e9 ("ALSA: hda: Flush interrupts on disabling")
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://lore.kernel.org/r/s5h1ruxt9cz.wl-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_bind.c  | 4 ++++
 sound/pci/hda/hda_intel.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 8db1890605f60..c175b2cf63f77 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -42,6 +42,10 @@ static void hda_codec_unsol_event(struct hdac_device *dev, unsigned int ev)
 {
 	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
 
+	/* ignore unsol events during shutdown */
+	if (codec->bus->shutdown)
+		return;
+
 	if (codec->patch_ops.unsol_event)
 		codec->patch_ops.unsol_event(codec, ev);
 }
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0b24c5ce2fd6a..d63fea5d1c929 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1492,8 +1492,11 @@ static int azx_free(struct azx *chip)
 static int azx_dev_disconnect(struct snd_device *device)
 {
 	struct azx *chip = device->device_data;
+	struct hdac_bus *bus = azx_bus(chip);
 
 	chip->bus.shutdown = 1;
+	cancel_work_sync(&bus->unsol_work);
+
 	return 0;
 }
 
-- 
2.20.1

