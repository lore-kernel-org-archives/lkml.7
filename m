Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7766C072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F16020856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SW60b7nI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfETIW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42003 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbfETIWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id l25so22497587eda.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SbM4kkl5EWVc1Lud+LN0uVoCMIXyfC33Tfm6rZ3mnEI=;
        b=SW60b7nIdATIPrwIWT9oaGpKEoAZHbdQlROc0UqUsAS10sCqELdn+dY7HDkmX5YTds
         yZ5phBYpFJyDH5V9PQPmkhmxB7CtZmaxADWsHNnsI9mYQppWf25NMEL5tGf9F4QVcodj
         8X4ejWbghPqnUvuMd2Uq38ikh4YOZRHHgb8IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SbM4kkl5EWVc1Lud+LN0uVoCMIXyfC33Tfm6rZ3mnEI=;
        b=cUN6PFC8RWZ9SusNzyI8ih2r4xDt2nJUodK7fhBb2f+/MUbXf4GP5dua8miQcwFo6e
         hdGihXwCUinxi7zjoWcPRddDKy5Cgi5fdWJ4GdCXerQf4RBXtzUvrJUbP5AZ4ufGShND
         Lcn08ShnphYJBG3EMHzxdUyV7X5ykkZ9l3C36bZmjGeQMdsKsjkPQqu+ud/j7dngjGSD
         0WI9qp/tMH5oMZ8Tq9UFS4PQinpYtlC6PNWo4KEgJp7eAsuKIbvqpVtEZGDFHAcriZtZ
         Zp+pTH98iPRdsmL22RY1Y///+eY+dzzKAA9j8Os18mI6gzqjkjqLBdEdvNqmUtwIVgrv
         p3yA==
X-Gm-Message-State: APjAAAX111ir43ZVaV+3huC1AGm0yxqO0s0s1OkvxcJ2bozUdT0K294M
        6OdsRnkmGelimo9YRFIHcFJtYg==
X-Google-Smtp-Source: APXvYqxqPql4lZWwJLVOFFGLuWmPeQWFMGasN2gXQcRCWWC75MWt4Ank1BJS5Y0nm96pOu/UVBpZqQ==
X-Received: by 2002:a17:906:e0c5:: with SMTP id gl5mr57097610ejb.212.1558340543985;
        Mon, 20 May 2019 01:22:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:23 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 01/33] dummycon: Sprinkle locking checks
Date:   Mon, 20 May 2019 10:21:44 +0200
Message-Id: <20190520082216.26273-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of trying to understand the locking (or lack thereof) in the
fbcon/vt/fbdev maze, annotate everything.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 drivers/video/console/dummycon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 45ad925ad5f8..2352b4c37826 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -33,6 +33,8 @@ static bool dummycon_putc_called;
 
 void dummycon_register_output_notifier(struct notifier_block *nb)
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	raw_notifier_chain_register(&dummycon_output_nh, nb);
 
 	if (dummycon_putc_called)
@@ -41,11 +43,15 @@ void dummycon_register_output_notifier(struct notifier_block *nb)
 
 void dummycon_unregister_output_notifier(struct notifier_block *nb)
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	raw_notifier_chain_unregister(&dummycon_output_nh, nb);
 }
 
 static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	dummycon_putc_called = true;
 	raw_notifier_call_chain(&dummycon_output_nh, 0, NULL);
 }
-- 
2.20.1

