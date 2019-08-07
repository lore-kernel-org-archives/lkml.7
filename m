Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2B3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CEF2199C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfHGHKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:10:40 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:45264 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbfHGHKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:10:39 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x777AajM061015
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 03:10:37 -0400
Received: by mail-lj1-f179.google.com with SMTP id t28so84456541lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 00:10:37 -0700 (PDT)
X-Gm-Message-State: APjAAAVXiswFLtgrBOM7Cr9rOrI/6JBvC8YDNlN5tAGH0wbv+se3XcRS
        nZNHktfKJeOMjitHOPLolfOZx/UbCtnBnpcGUgk=
X-Google-Smtp-Source: APXvYqwTvZanyI0YZ9uQfaH1U+yBWhv+RJAwn5jJTqCGs8BDn7kVZC6l4H9aknl4nymRLzxWK49L4da/xdA1y1Rxk4s=
X-Received: by 2002:a2e:8892:: with SMTP id k18mr4034234lji.239.1565161835957;
 Wed, 07 Aug 2019 00:10:35 -0700 (PDT)
MIME-Version: 1.0
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Wed, 7 Aug 2019 03:09:59 -0400
X-Gmail-Original-Message-ID: <CAAa=b7dkPm4JqF4_cPwJo_6_aoobr6OyezCb2A9-aAFHNWffeQ@mail.gmail.com>
Message-ID: <CAAa=b7dkPm4JqF4_cPwJo_6_aoobr6OyezCb2A9-aAFHNWffeQ@mail.gmail.com>
Subject: [PATCH v2] ALSA: pcm: fix multiple memory leak bugs
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
on, hiface_pcm_init_urb() is invoked to initialize 'rt->out_urbs[i]'. In
hiface_pcm_init_urb(), 'rt->out_urbs[i].buffer' is allocated through
kzalloc().  However, if hiface_pcm_init_urb() fails, both 'rt' and
'rt->out_urbs[i].buffer' are not deallocated, leading to memory leak bugs.
Also, 'rt->out_urbs[i].buffer' is not deallocated if snd_pcm_new() fails.

To fix the above issues, free 'rt' and 'rt->out_urbs[i].buffer'.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/usb/hiface/pcm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 14fc1e1..9b132aa 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -599,12 +599,18 @@ int hiface_pcm_init(struct hiface_chip *chip, u8
extra_freq)
        for (i = 0; i < PCM_N_URBS; i++) {
                ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
                                    hiface_pcm_out_urb_handler);
-               if (ret < 0)
+               if (ret < 0) {
+                       for (; i >= 0; i--)
+                               kfree(rt->out_urbs[i].buffer);
+                       kfree(rt);
                        return ret;
+               }
        }

        ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
        if (ret < 0) {
+               for (i = 0; i < PCM_N_URBS; i++)
+                       kfree(rt->out_urbs[i].buffer);
                kfree(rt);
                dev_err(&chip->dev->dev, "Cannot create pcm instance\n");
                return ret;
-- 
2.7.4
