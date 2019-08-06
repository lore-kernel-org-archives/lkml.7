Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F411EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68C52086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 06:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfHFGNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 02:13:47 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:59080 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731560AbfHFGNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 02:13:47 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x766DgjQ031603
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 6 Aug 2019 02:13:43 -0400
Received: by mail-lf1-f51.google.com with SMTP id h28so59983994lfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 23:13:43 -0700 (PDT)
X-Gm-Message-State: APjAAAWCs/i8dkY2hNBACdw7brQNDQ4PknQ9d/zrqBoQJZ23rCLsdbvA
        58LiUm0WmqBONmXDeAUaFOqWWQacOKQunNkQhiw=
X-Google-Smtp-Source: APXvYqw1rV8RcMwhWvkw7ZNGJnFRxEGT7QjoZpw//yMfjk/vN5bfurliBHT9CDnOIGrD5vrZ4HS7tCa02o/2rRsOax0=
X-Received: by 2002:ac2:48b8:: with SMTP id u24mr1134365lfg.170.1565072022191;
 Mon, 05 Aug 2019 23:13:42 -0700 (PDT)
MIME-Version: 1.0
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Tue, 6 Aug 2019 02:13:06 -0400
X-Gmail-Original-Message-ID: <CAAa=b7eiG_rpjfL8c-dWjpxSf3XPJxJbcVPrE1W0_1j-9s1QEg@mail.gmail.com>
Message-ID: <CAAa=b7eiG_rpjfL8c-dWjpxSf3XPJxJbcVPrE1W0_1j-9s1QEg@mail.gmail.com>
Subject: [PATCH] ALSA: usb-audio: fix a memory leak bug
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In add_new_ctl(), a mixer element structure is allocated through kzalloc()
and the pointer is saved to 'elem'. Later on, a new alsa control element is
created and added to this structure. In case the add process fails, i.e.,
the return value of snd_usb_mixer_add_control() is less than 0, the
allocated structure is not freed, leading to a memory leak.

To fix the above issue, free 'elem' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/usb/mixer_scarlett.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 83715fd..a6c028a 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -562,8 +562,10 @@ static int add_new_ctl(struct usb_mixer_interface *mixer,
        strlcpy(kctl->id.name, name, sizeof(kctl->id.name));

        err = snd_usb_mixer_add_control(&elem->head, kctl);
-       if (err < 0)
+       if (err < 0) {
+               kfree(elem);
                return err;
+       }

        if (elem_ret)
                *elem_ret = elem;
--
2.7.4
