Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D31C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F0320B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbfHFHBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:01:05 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:59564 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731557AbfHFHBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:01:05 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x76713N6032292
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 6 Aug 2019 03:01:04 -0400
Received: by mail-lf1-f48.google.com with SMTP id h28so60088615lfj.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 00:01:04 -0700 (PDT)
X-Gm-Message-State: APjAAAXJZn0jGz2YEYN5eYho59GgwRavRcFVp0GUnLadpliTYXpfeFIn
        dJ2PXqF2IY+7jHF/9LHVyFRh2sI5rU2bnsXeNhc=
X-Google-Smtp-Source: APXvYqzK+h1zd05B5faJWK4k6lnbLwPVygF0Bc2bfH0WYGAZDBEe12r9ifxxD8N9NgISRwr6acMQCGJE4l4x2+UVOtA=
X-Received: by 2002:a19:cbc4:: with SMTP id b187mr1253490lfg.27.1565074863147;
 Tue, 06 Aug 2019 00:01:03 -0700 (PDT)
MIME-Version: 1.0
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Tue, 6 Aug 2019 03:00:27 -0400
X-Gmail-Original-Message-ID: <CAAa=b7f=SG6QR248JD9_VP89B=D2p3pdYcSAzRLchbJTpdXt_A@mail.gmail.com>
Message-ID: <CAAa=b7f=SG6QR248JD9_VP89B=D2p3pdYcSAzRLchbJTpdXt_A@mail.gmail.com>
Subject: [PATCH] ALSA: usb-audio: fix a memory leak bug
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snd_usb_get_audioformat_uac3(), a structure for channel maps 'chmap' is
allocated through kzalloc() before the execution goto 'found_clock'.
However, this structure is not deallocated if the memory allocation for
'pd' fails, leading to a memory leak bug.

To fix the above issue, free 'fp->chmap' before returning NULL.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/usb/stream.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 7ee9d17..e852c7f 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1043,6 +1043,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,

                pd = kzalloc(sizeof(*pd), GFP_KERNEL);
                if (!pd) {
+                       kfree(fp->chmap);
                        kfree(fp->rate_table);
                        kfree(fp);
                        return NULL;
--
2.7.4
