Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EAAC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409A721850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8XDVAag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfGXMNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:13:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45947 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfGXMNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:13:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so20858195pfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yOe9je3y3azuxEkbZtWAgzy/O8tv7xt/7UDFJgcMfj4=;
        b=s8XDVAagfffx5f9BWX1AzPwmmHmm5GOZ3QuKYZ4yMZ69IcT4jkecK2Bg8Yy/vpcKC+
         dthic2I4LPTJcLT4z0STllQckoVS7Fw4OyKGPqxUtz3vexpptdyxut782KbjsCJQco7w
         BoC8SjYltzNvBjuQjU1TTYTgOy5t/dwdTcMPW/AEvuGJ19zZdBs/ctzvexJ8E49ckblB
         OQRe/jbhe/tMsiDL5ZirfuNh0b6HqCQvls6OEVnYFFB9N4WT7Rw9hd93wmj3ld1pU6bW
         57jEMd9adYRQJ6uVhCrAG07o4wwok59qaNSYx4VnSwbvmdAT3lEzYRTvss0db4JLOrhe
         QITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yOe9je3y3azuxEkbZtWAgzy/O8tv7xt/7UDFJgcMfj4=;
        b=QFUb6sHJBf3wcIptW4MXDImJiivxlr09/A9395znfWXvGjS24oIVALPLgRTuCjXJMo
         eCdfR5dfXnCZ9YYGNU4gw8KQkzZwQdwb5K8wkJkAF9DweUxHd5fZ+aM4P6TFQwy9DuhW
         79bsVMKO48WwAJy7FmnamdTc7xdH5ZagSyB+RDa5jnhMKEqHyJwcN4AfH6u89gPwzG10
         sLs6W1fEAY1XDZrkcEjg8HZ0RsR3FqPMBubL37NvVhwUIDqgXdEzNEBZIY2jqNsy+EkO
         Ia/G1nb0McVyp+O48OnBQsYX/bt4WLNdZpNv0EK3FEZW+G0fv/FjYm6zPi0oqlF0Lnzp
         qK3w==
X-Gm-Message-State: APjAAAUocgIBY+r+ios634RoiVtJhZgzEABGbfb3nlWtK0v+W+v0WikS
        ose5N1jVQeH8rBzg+lJwIQ4=
X-Google-Smtp-Source: APXvYqwlapnzHOWglZEataQxo8AjBg+B2YemqkqgWG33hfLPCnq47yi/DxSiTBSZj4GhDAGlntYt0g==
X-Received: by 2002:a63:1749:: with SMTP id 9mr28651971pgx.0.1563970415766;
        Wed, 24 Jul 2019 05:13:35 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id g66sm47009665pfb.44.2019.07.24.05.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 05:13:35 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, bhelgaas@google.com,
        tglx@linutronix.de, rfontana@redhat.com,
        gregkh@linuxfoundation.org, kirr@nexedi.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ALSA: core: Fix possible null-pointer dereferences in snd_timer_proc_read()
Date:   Wed, 24 Jul 2019 20:13:27 +0800
Message-Id: <20190724121327.9894-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snd_timer_proc_read(), there is an if statement on line 1204 to check
whether timer->card is NULL:
    if (timer->card && timer->card->shutdown)

When timer->card is NULL, it is used on lines 1212 and 1215:
    timer->card->number

Thus, possible null-pointer dereferences may occur.

To fix these bugs, timer->card is checked before being used.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/core/timer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 5c9fbf3f4340..967d06a3cdec 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1208,11 +1208,13 @@ static void snd_timer_proc_read(struct snd_info_entry *entry,
 			snd_iprintf(buffer, "G%i: ", timer->tmr_device);
 			break;
 		case SNDRV_TIMER_CLASS_CARD:
-			snd_iprintf(buffer, "C%i-%i: ",
-				    timer->card->number, timer->tmr_device);
+			snd_iprintf(buffer, "C%i-%i: ", 
+					timer->card ? timer->card->number : -1, 
+					timer->tmr_device);
 			break;
 		case SNDRV_TIMER_CLASS_PCM:
-			snd_iprintf(buffer, "P%i-%i-%i: ", timer->card->number,
+			snd_iprintf(buffer, "P%i-%i-%i: ",
+					timer->card ? timer->card->number : -1,
 				    timer->tmr_device, timer->tmr_subdevice);
 			break;
 		default:
-- 
2.17.0

