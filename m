Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89003C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A132070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582365;
	bh=HYoTWX3g4BW3SFMRdttz7fodosr6Dmom2jeED6Oa9T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LFxKPXb4baaoUnODAE9/nOyRgLMLMSruyrVsMR/p7ky3G/dsiLnUdWUpINw0cN0Xk
	 K9gLaf2KDtEEBJClhKVkNG5EiL2ksUGM1g3zdqyjybQO5lC3GN7oeQZ329wCwWV5Wc
	 C7u+ak4pn5V2h239ZzuqD92p10YAd8UfBnz9B0yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbfCZGjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732661AbfCZGjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:18 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1BAB20870;
        Tue, 26 Mar 2019 06:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582357;
        bh=HYoTWX3g4BW3SFMRdttz7fodosr6Dmom2jeED6Oa9T4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BbHe+BXDNomcEhJyQFfIebzml1ZZFXamzXgqcgVr7pXlKPPeHB7hwExHGJ1H/mzF0
         sqyggGDZoZQpytKgvC5tCDvHljmcGM9CoPbjQkOmjzPUsPmWOE2YjlOiarhuR2M6yN
         hzDNsSsm+Z/3XJOkuIWpzXovb2i4zP+lekB7RiRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 31/52] ALSA: hda - Dont trigger jackpoll_work in azx_resume
Date:   Tue, 26 Mar 2019 15:30:18 +0900
Message-Id: <20190326042702.537074660@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

commit 744c67ffeb06f2d2493f4049ba0bd19698ce0adf upstream.

The commit 3baffc4a84d7 (ALSA: hda/intel: Refactoring PM code) changed
the behaviour of azx_resume(), it triggers the jackpoll_work after
applying this commit.

This change introduced a new issue, all codecs are runtime active
after S3, and will not call runtime_suspend() automatically.

The root cause is the jackpoll_work calls snd_hda_power_up/down_pm,
and it calls up_pm before snd_hdac_enter_pm is called, while calls
the down_pm in the middle of enter_pm and leave_pm is called. This
makes the dev->power.usage_count unbalanced after S3.

To fix it, let azx_resume() don't trigger jackpoll_work as before
it did.

Fixes: 3baffc4a84d7 ("ALSA: hda/intel: Refactoring PM code")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -947,7 +947,7 @@ static void __azx_runtime_suspend(struct
 	display_power(chip, false);
 }
 
-static void __azx_runtime_resume(struct azx *chip)
+static void __azx_runtime_resume(struct azx *chip, bool from_rt)
 {
 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
 	struct hdac_bus *bus = azx_bus(chip);
@@ -964,7 +964,7 @@ static void __azx_runtime_resume(struct
 	azx_init_pci(chip);
 	hda_intel_init_chip(chip, true);
 
-	if (status) {
+	if (status && from_rt) {
 		list_for_each_codec(codec, &chip->bus)
 			if (status & (1 << codec->addr))
 				schedule_delayed_work(&codec->jackpoll_work,
@@ -1016,7 +1016,7 @@ static int azx_resume(struct device *dev
 			chip->msi = 0;
 	if (azx_acquire_irq(chip, 1) < 0)
 		return -EIO;
-	__azx_runtime_resume(chip);
+	__azx_runtime_resume(chip, false);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 
 	trace_azx_resume(chip);
@@ -1081,7 +1081,7 @@ static int azx_runtime_resume(struct dev
 	chip = card->private_data;
 	if (!azx_has_pm_runtime(chip))
 		return 0;
-	__azx_runtime_resume(chip);
+	__azx_runtime_resume(chip, true);
 
 	/* disable controller Wake Up event*/
 	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &


