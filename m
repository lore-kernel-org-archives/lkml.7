Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DEDC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FD92067B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwXJA5P7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbfKHTvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:51:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39586 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732622AbfKHTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:51:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id a11so8376728wra.6;
        Fri, 08 Nov 2019 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIq7Ju31y/qMWpSLAwnBA7KnxR+phPe2Cxa8JB0kXdE=;
        b=KwXJA5P7vuIzRxu2jjoRh/RDwr9CvefzLKufUIBy+/ArIjgYsZd4SOztW2aLo3ig/S
         MLYwMZNXH5MoCYkzktFQ1lU0TQSaKfn7uaSOtbnQmqBXCA4uiaBhno4JEjy1Rea4gPlO
         YQaUGMrLSoDYx1Rh3KMnv1RUaW9JEl8LoKDOUX+vksbtJIy/gDCNH/E3b3MaObNBJvt2
         dpofsgAQDk4R0HBXoJa0yI80pt8uwLszkShHFIUSYTR7H+jlxTPoNTq/0nXTg4sTvdFA
         vkXbK2ke8dbFrHE6fMNoMGgK19/jYh/g5+m1jUANdQOvyxB7B8NCzc5ng8xoeGgRNULw
         QLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RIq7Ju31y/qMWpSLAwnBA7KnxR+phPe2Cxa8JB0kXdE=;
        b=S1FuaRSu9lCfmJev3uvf+wFXFLCPusv/8raIZGNpMFm8ESuhAqRr8NS5eVkJg4AjhI
         RkRsaNUTK7RovMeTe+AqavrYjKPM04pJpNn/8V8DfdvtkriBauulNklzyKLJbgbpMQGe
         dh4wxatcLjir9MmcKMOr6j7tJ6doWol7jWUU/UkxzkxJPdh6hGGFOVRu34QLEzHBTTrF
         PbTwwVZ4CY2R/p0cZMqy+2qTRHDQ5UtF5oR41ipFkPgkDRdgDUfPjE1mbsWjkJk5f+bm
         3B9Q03ekFoN13cJPQe0/DFjHeRAQMBoMf6hUgfle8apiDRpBbRQJzUWHJrUJoT8LpEUo
         olZg==
X-Gm-Message-State: APjAAAWW8faOjTYK+F4gTjtwqXo0nC/y61ZewNMaNOAhCRP9EAKkqCYK
        rHB186RqZqbbsWarrr6K1j0=
X-Google-Smtp-Source: APXvYqw4vLiqza4NZ7wOlgPRWebELPp1Mzj0ZrBg571uG2KBbqDJPJMpWqicJsa/NF3xW95g3Fde/w==
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr9651286wrs.85.1573242680471;
        Fri, 08 Nov 2019 11:51:20 -0800 (PST)
Received: from arch-vook.lan ([77.125.77.116])
        by smtp.googlemail.com with ESMTPSA id g5sm8629926wmf.37.2019.11.08.11.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 11:51:19 -0800 (PST)
From:   Omer Shalev <omerdeshalev@gmail.com>
Cc:     omerdeshalev@gmail.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media:usb:cpia2: Properly check framebuffer mmap offsets
Date:   Fri,  8 Nov 2019 21:50:36 +0000
Message-Id: <20191108215038.59170-1-omerdeshalev@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpai2 driver's mmap implementation wasn't properly check for all
possible offset values. Given a huge offset value , the calculation
start_offset + size can wrap around to a low value and pass the check

Signed-off-by: Omer Shalev <omerdeshalev@gmail.com>
---
 drivers/media/usb/cpia2/cpia2_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/cpia2/cpia2_core.c b/drivers/media/usb/cpia2/cpia2_core.c
index 20c50c2d042e..9d621cfb2d74 100644
--- a/drivers/media/usb/cpia2/cpia2_core.c
+++ b/drivers/media/usb/cpia2/cpia2_core.c
@@ -2390,18 +2390,22 @@ int cpia2_remap_buffer(struct camera_data *cam, struct vm_area_struct *vma)
 {
 	const char *adr = (const char *)vma->vm_start;
 	unsigned long size = vma->vm_end-vma->vm_start;
-	unsigned long start_offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long start = (unsigned long) adr;
+	unsigned long start_offset;
 	unsigned long page, pos;
 
 	DBG("mmap offset:%ld size:%ld\n", start_offset, size);
 
 	if (!video_is_registered(&cam->vdev))
 		return -ENODEV;
+
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+		return -EINVAL;
 
+	start_offset = vma->vm_pgoff << PAGE_SHIFT;
 	if (size > cam->frame_size*cam->num_frames  ||
 	    (start_offset % cam->frame_size) != 0 ||
-	    (start_offset+size > cam->frame_size*cam->num_frames))
+	    (start_offset > cam->frame_size*cam->num_frames - size))
 		return -EINVAL;
 
 	pos = ((unsigned long) (cam->frame_buffer)) + start_offset;
-- 
2.23.0

