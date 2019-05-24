Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C04C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A43B2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c/FPyF4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389816AbfEXIyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37169 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389709AbfEXIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so13334151edw.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SbM4kkl5EWVc1Lud+LN0uVoCMIXyfC33Tfm6rZ3mnEI=;
        b=c/FPyF4yrdA+kyY4YOL61v9wViH0qXWsWn7LeQbNFRkgk/NtlJDZd/2fQOm5/hWjBa
         PLBpGyU8BH+CjKkw/vlnSJ1M9WN303wo9Lz5muTXupETgpDMznUolBtQcGizX4JWfCai
         ayz2xzztT1E0yJ7VrbMfYeDSWGkMTKBHplZi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SbM4kkl5EWVc1Lud+LN0uVoCMIXyfC33Tfm6rZ3mnEI=;
        b=EfGUPJqfFV5PLXFCl6waCqeJooJXZiiv2nRd5hU9Qyltmt1XjLLTlFBm1KrDNK3m/v
         e43jxkVQDPXCIF3tmpIMKlNZbESArLztVJGxCo/0BR7ZGxkGoHpQm28i9ay6HTON0UzM
         OnENC5w9mC1d7hnWh5Mj6TdjOWNi/OC3PqDY/PvXYQ8JLt3rtBoAMjz74zUmeIqz6OPT
         gxUrrH7RoJk2LcOds/QhlK/eUUItP7qcOXt07FK1rakXtxoFkahp82aICWvxVjWMxB6y
         7mtcKtrwmtaH0cCCR8rL8ow+jocFtkuBJtFn+DQ9GfkmfJr+fpH9SZ4yHAvHns+GG0Ls
         bB1A==
X-Gm-Message-State: APjAAAURb7iiawJuAGyKNpneYKQGmP2NVHwjOmGvEi33uigE6Ut26Rtj
        Set47GwgEjxUVRMEoAskYhKwUgdz178=
X-Google-Smtp-Source: APXvYqwCsy7wS1y18TiVxkSUCraHHH/2ZdqufPRJtqnU28F6RF/leE8tdjhD6kmcJQEGce2Dp+lTBA==
X-Received: by 2002:a50:b1d1:: with SMTP id n17mr103556301edd.131.1558688042014;
        Fri, 24 May 2019 01:54:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:01 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 01/33] dummycon: Sprinkle locking checks
Date:   Fri, 24 May 2019 10:53:22 +0200
Message-Id: <20190524085354.27411-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
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

