Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CEDC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1234A2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bMQ2bjpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfE1JDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47005 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfE1JDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id f37so30560843edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLUCrKXHKAt3A/bBQVqTCTeOCvNqnrpALUNOe9jfHr4=;
        b=bMQ2bjpJBQsrLyF5NtCNtdDCqdZu00kxLhGVHuMgu5Ecnfugp/vFvZTt9YPT8/0NBT
         jUEC2OIP1/tU6emJgemxpDua5SKNi51ovh5LtpPGk1dY31H2NH0+z5o2haeY9WRwVZEj
         Fd6Bp0VSshVT08iDz2tigAozeP4D6d32wcQR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLUCrKXHKAt3A/bBQVqTCTeOCvNqnrpALUNOe9jfHr4=;
        b=Xyqv22TcANRPX0hVz3/kd/IOfGgdO96HRHBkbMiFAivjt/DbXkP4JN31fzM179+tSD
         fyD+ioVrIxqGHk1Sku2947bBW6SOJpgCu5FHgPTsWvpsBZAoBaRi2bNkcO/Ste+etJQ8
         DnAwoIdQUQSnf4kVcklwnOm93CisaQdZX6bD3FxyEiFGXuSjbwKoh+tUQr/Eigcr3+mW
         yvVbbN/XSXMcubBWoblme4f0ljNA+NG9nWVIWR+v1UQug94s/Q2Yyogm7aWMQqUsp638
         /R8U+MAYaB5TWmlCODeafj8xFhNWpy157DA7Wlzmtc4SSqYd98zweaLA0gVqfwIguIkl
         tXag==
X-Gm-Message-State: APjAAAV0YycP99qz42cwxmdBJxM2lHSGCjEtVgyrkOx7iBWkOP+yMnzF
        Jb+ZQGqa6VMzjkGm3x7ghrtXMnrVSfA=
X-Google-Smtp-Source: APXvYqzLN70+l87QPlEz8uE9d+Hi4atwthd0XgMpMbEkaPaxgOCAKWKU1k0iYUwvw4YO9wheHnEZxg==
X-Received: by 2002:a50:b665:: with SMTP id c34mr127787580ede.148.1559034191897;
        Tue, 28 May 2019 02:03:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:11 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 01/33] dummycon: Sprinkle locking checks
Date:   Tue, 28 May 2019 11:02:32 +0200
Message-Id: <20190528090304.9388-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of trying to understand the locking (or lack thereof) in the
fbcon/vt/fbdev maze, annotate everything.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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
index ff886e99104b..2a0d0bda7faa 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -34,6 +34,8 @@ static bool dummycon_putc_called;
 
 void dummycon_register_output_notifier(struct notifier_block *nb)
 {
+	WARN_CONSOLE_UNLOCKED();
+
 	raw_notifier_chain_register(&dummycon_output_nh, nb);
 
 	if (dummycon_putc_called)
@@ -42,11 +44,15 @@ void dummycon_register_output_notifier(struct notifier_block *nb)
 
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

