Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D91C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CEE24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781300;
	bh=raEhjKyyauHBwil+/jEVLYQR1fmpfbl5W8O9XSVWr3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0cgp+Va2CrFC59IEJERA2/Ae93hdCm1ffyZNQ30iVXpKXWkPJKR5ix3W6gfdnI+Mm
	 m2YDMAXY2XfAiOOiu8SzuUbdNpbBAsV0nJzAK2vBUdqnF6s/6B1OYy6ovQlhi6r8AY
	 6CPsapTXYH9MTLKwUK5PGehD71xYSn5zEZKFpxvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfLSSsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:48:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:41294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729339AbfLSSsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:48:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D300F24683;
        Thu, 19 Dec 2019 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781291;
        bh=raEhjKyyauHBwil+/jEVLYQR1fmpfbl5W8O9XSVWr3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J97np0op+4/ZXgxyPpPxb4ImFWJG7Zm2w8gaCBjdnsk/rxfvGpg3xGC6w5OLd5Zkq
         mdwaHZu/cjvbWN/mlxQX8abSqKw38xvU8/aUztMe+pOeZfRelKm6kKcDSCTbIr/CZ6
         DRvmDMjanjTn2K24PHuhCejCuSUQqVgJY0fJi+fc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 124/199] ALSA: hda - Fix pending unsol events at shutdown
Date:   Thu, 19 Dec 2019 19:33:26 +0100
Message-Id: <20191219183221.826025855@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 sound/pci/hda/hda_bind.c  |    4 ++++
 sound/pci/hda/hda_intel.c |    3 +++
 2 files changed, 7 insertions(+)

--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -42,6 +42,10 @@ static void hda_codec_unsol_event(struct
 {
 	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
 
+	/* ignore unsol events during shutdown */
+	if (codec->bus->shutdown)
+		return;
+
 	if (codec->patch_ops.unsol_event)
 		codec->patch_ops.unsol_event(codec, ev);
 }
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1275,8 +1275,11 @@ static int azx_free(struct azx *chip)
 static int azx_dev_disconnect(struct snd_device *device)
 {
 	struct azx *chip = device->device_data;
+	struct hdac_bus *bus = azx_bus(chip);
 
 	chip->bus.shutdown = 1;
+	cancel_work_sync(&bus->unsol_work);
+
 	return 0;
 }
 


