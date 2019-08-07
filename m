Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8BCC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E0C2199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfHGGP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:15:56 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:44652 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfHGGP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:15:56 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x776Fsfj059912
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 02:15:55 -0400
Received: by mail-lf1-f41.google.com with SMTP id z15so58847743lfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 23:15:55 -0700 (PDT)
X-Gm-Message-State: APjAAAVccdD1E4zktA0/aEMQD7KPGRuYzPONAD6P9t8zWgp9LDh2BJEe
        YMkRuZvFqmQdC5D47APhjcdsVOcd0iwS+OrqYCQ=
X-Google-Smtp-Source: APXvYqy4XMRsGmpJdQ8mDa5OGjnpO7xdZnCatFepXfm3Gwb+MVnr3/vNwfV36DaNYOTUYvY941x7Lpslz9YDzUCxxBU=
X-Received: by 2002:ac2:418f:: with SMTP id z15mr4688367lfh.177.1565158553796;
 Tue, 06 Aug 2019 23:15:53 -0700 (PDT)
MIME-Version: 1.0
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Wed, 7 Aug 2019 02:15:17 -0400
X-Gmail-Original-Message-ID: <CAAa=b7ffFNc4zuQfXEwsS363=kX_ZOx0+jhg4WM3JQ-d7n-LMA@mail.gmail.com>
Message-ID: <CAAa=b7ffFNc4zuQfXEwsS363=kX_ZOx0+jhg4WM3JQ-d7n-LMA@mail.gmail.com>
Subject: [PATCH] ALSA: pcm: fix a memory leak bug
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hiface_pcm_init(), 'rt' is firstly allocated through kzalloc(). Later
on, hiface_pcm_init_urb() is invoked to initialize 'rt->out_urbs[i]'.
However, if the initialization fails, 'rt' is not deallocated, leading to a
memory leak bug.

To fix the above issue, free 'rt' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/usb/hiface/pcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 14fc1e1..5dbcd0d 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -599,8 +599,10 @@ int hiface_pcm_init(struct hiface_chip *chip, u8
extra_freq)
        for (i = 0; i < PCM_N_URBS; i++) {
                ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
                                    hiface_pcm_out_urb_handler);
-               if (ret < 0)
+               if (ret < 0) {
+                       kfree(rt);
                        return ret;
+               }
        }

        ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
-- 
2.7.4
