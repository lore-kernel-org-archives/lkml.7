Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFAFC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ED82077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 23:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgAGXEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 18:04:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42557 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgAGXEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:04:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so1207500qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 15:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bs8NMK22XFYTZSerY7vskoSjOxNnBJD2Ihu3wEWVhiM=;
        b=KHSzv6OcnM/lD9cXjfh1QY6Utyr6U+BewTRmitfCAKu9tmhVaXaTm1UonO7xOOV3db
         s5IMztrbLGEDSq3uKqXqD7e8NTqay07L5LfGHBTAvCd+n2onFJOHpGrG3siJfuqEzM3X
         ttpP+UTjLnRaWQVtd7ZGLrWCElGEbLI8dh1WEhTkxIsCbgqDkzuqk9J1jDABJ2XGuGl5
         SUycf9na5D50X1sJNy1r+XUJoG3DbusmGtV4V1tvCQFCpD3NUPub0K7gdrAJx2QRRknq
         JtgzcFhIzLeWar1kF9DWie1G8h65Hpow+e04Ut+xIT5L+m70NO8WbA85FDaqcz6F11hr
         GZeg==
X-Gm-Message-State: APjAAAW0hg2OoK5CzHACKSHtTewqMb7cEBKk7ZjeTqbvxAmK3AVFvXwA
        nQjLd6wOQi/o253Iy6RUk5M=
X-Google-Smtp-Source: APXvYqzInlnLnPYZHZBnzOfUecua986pJo1JuorqPqmzDTMi8FfncC409DpdnVK+S8A9nKRoKdHqlg==
X-Received: by 2002:ac8:4a11:: with SMTP id x17mr1217967qtq.226.1578438251469;
        Tue, 07 Jan 2020 15:04:11 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k184sm568617qke.2.2020.01.07.15.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 15:04:10 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Christopher Head <bugs@chead.ca>
Subject: [PATCH] x86/sysfb: Fix check for bad VRAM size
Date:   Tue,  7 Jan 2020 18:04:10 -0500
Message-Id: <20200107230410.2291947-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking whether the reported lfb_size makes sense, we PAGE_ALIGN
height * stride before seeing whether it exceeds the reported size.

This doesn't work if height * stride is not an exact number of pages.
For example, as reported in kernel bugzilla linked, an 800x600x32 EFI
framebuffer gets skipped because of this.

Move the PAGE_ALIGN to after the check vs size.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=206051
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/kernel/sysfb_simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sysfb_simplefb.c b/arch/x86/kernel/sysfb_simplefb.c
index 01f0e2263b86..298fc1edd9c9 100644
--- a/arch/x86/kernel/sysfb_simplefb.c
+++ b/arch/x86/kernel/sysfb_simplefb.c
@@ -90,11 +90,11 @@ __init int create_simplefb(const struct screen_info *si,
 	if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
 		size <<= 16;
 	length = mode->height * mode->stride;
-	length = PAGE_ALIGN(length);
 	if (length > size) {
 		printk(KERN_WARNING "sysfb: VRAM smaller than advertised\n");
 		return -EINVAL;
 	}
+	length = PAGE_ALIGN(length);
 
 	/* setup IORESOURCE_MEM as framebuffer memory */
 	memset(&res, 0, sizeof(res));
-- 
2.24.1

