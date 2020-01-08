Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE63C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D331E206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgAHM6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:58:17 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbgAHM6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:58:15 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 17C797F26F29BD2CC0B6;
        Wed,  8 Jan 2020 20:58:14 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 Jan 2020
 20:58:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <rfontana@redhat.com>,
        <allison@lohutok.net>, <hslester96@gmail.com>,
        <o-takashi@sakamocchi.jp>, <kjlu@umn.edu>, <yuehaibing@huawei.com>,
        <tglx@linutronix.de>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ALSA: pci: echoaudio: remove set but not used variable 'chip'
Date:   Wed, 8 Jan 2020 20:58:03 +0800
Message-ID: <20200108125803.45584-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/pci/echoaudio/echoaudio.c: In function snd_echo_mixer_info:
sound/pci/echoaudio/echoaudio.c:1233:20: warning: variable chip set but not used [-Wunused-but-set-variable]
sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vmixer_info':
sound/pci/echoaudio/echoaudio.c:1300:20: warning: variable 'chip' set but not used [-Wunused-but-set-variable]

commit e67c3f0fd44c ("ALSA: pci: echoaudio: remove usage
of dimen menber of elem_value structure") left behind this
unused variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/echoaudio/echoaudio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 07fe0b3..0941a7a 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1230,9 +1230,6 @@ static const struct snd_kcontrol_new snd_echo_intput_nominal_level = {
 static int snd_echo_mixer_info(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_info *uinfo)
 {
-	struct echoaudio *chip;
-
-	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
@@ -1300,9 +1297,6 @@ static struct snd_kcontrol_new snd_echo_monitor_mixer = {
 static int snd_echo_vmixer_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
 {
-	struct echoaudio *chip;
-
-	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 1;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
-- 
2.7.4


