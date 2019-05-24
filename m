Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE8CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F9F2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cr4/gjFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389920AbfEXIyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42256 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389814AbfEXIyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so13312428eda.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yy90SY5/chDu3adwLkHoQhEeL0uOM1NOJmociVMUU4s=;
        b=cr4/gjFrfCNevqAiAU9XqP6SgaiJysx3vBZGTSUBi4Tj3eINXfE6JbxBD90g/EpTwJ
         4JQVeLiyNj3LzpQgPFL5r1fEe1QbInyfZNSa+ug0Hhv2ZX76nidAtG293D6DcIILXwb9
         ub+6k0ddJsOAmQfUOdPQyaUFYod34VrM/+dBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yy90SY5/chDu3adwLkHoQhEeL0uOM1NOJmociVMUU4s=;
        b=JzbQ/GEdzBk46qxrTAzSKrXh1tG/v5lC+YlD5XhYn0eAcGA+n+eoKmSpm7HnWYS/Gr
         AwoLik/m6S8iLFFcKtu4cwvs+z3kmNLpRUk7xUG3idwTa+ZtWZAa3IWWCfOyaHPl828E
         g22jpXav273cd27j8mhK9CYKLDqBaLQevglNwi97BZAlaKf79R2ak9bYwUOrx4fEYwOM
         Xv48B8SBW0lt+bhJ9liZ/HPBZh9XtCqQfmHJKRJdUuXK8jL1ryDtu/3T0WT8goOnYU2g
         X/ZKnIyraQ+DpbF/Hurs2T1qqz840KuQm7R6z2cshOumUOvzRo/v1VogMqKtMfQONF2B
         MGug==
X-Gm-Message-State: APjAAAUFIS3SloJbIonNB2wq+jXZzI+6YjKC8mUOKPHZCGHhNYxn8YrB
        RqY6ktUv4pRWd6CJtuGvb4tcPMpJS3c=
X-Google-Smtp-Source: APXvYqz15CcdTjoLDAvdkpWywDjCZ1ETBfsWrIz7EZVLfyKyYHnY14mFy7VmZfhdjvd4e/aLWEyXzA==
X-Received: by 2002:a50:b19a:: with SMTP id m26mr103783554edd.243.1558688048165;
        Fri, 24 May 2019 01:54:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:07 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/33] fbdev/cyber2000: Remove struct display
Date:   Fri, 24 May 2019 10:53:27 +0200
Message-Id: <20190524085354.27411-7-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entirely unused.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/video/fbdev/cyber2000fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 9a5751cb4e16..452ef07b3a06 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -61,7 +61,6 @@
 struct cfb_info {
 	struct fb_info		fb;
 	struct display_switch	*dispsw;
-	struct display		*display;
 	unsigned char		__iomem *region;
 	unsigned char		__iomem *regs;
 	u_int			id;
-- 
2.20.1

