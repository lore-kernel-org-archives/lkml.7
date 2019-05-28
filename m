Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D5C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2723F2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Jr4diFnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfE1JDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35101 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfE1JDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so30641670edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zV1k/wyKbSK4unVk9Zsa3jP6q9n4lvzRcxAhP6ZZB9c=;
        b=Jr4diFnn4D12FEqGpJQ+RuXfm8du2nWF1rRHD4W7cIEGcbaXABy4y7PYtm1RWYCGsM
         4VUgAtZNFYUQNW5orIhfjotHfmaMRBcdXOU7lv9qvqyzRqJa5qThyVjqHAx5MH9qVK6q
         lTOmQV05XsP0H1DMu730MHM4S7AOOkuX/FVNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zV1k/wyKbSK4unVk9Zsa3jP6q9n4lvzRcxAhP6ZZB9c=;
        b=R6sxvtdlBn7z4SIjbkgV56kOrO40RZ3CZvf1WH29oE3WxfYyToybmfkLwEBLGSToU6
         hScazwdQOMo7jaBqSoHrCghOcUv8pI5cL5uLV45eZSLGEd18nkroc5Inq1f8ULZnRoMn
         Q36QgHU+sEJYN295eWnGPRL4SqnJUWTBP7fGN7NzEbUQ7pHosm7SdmgFu9TpkwYnTF0d
         CkGLgz9qEe+5SlUYsK8mGWR5myHDjnItsvC/U2qRhQq9xAtcFeDtRyRbAbEJEWqsoppA
         c9k9lxGoNZFhi/Zwboiz2ENMF1pQs+Zwpj4bU6auOWDIQPyYqj8TTNXHWC/I/4n/5lFp
         jpmg==
X-Gm-Message-State: APjAAAVQlzKlnVuonKMpnB3O7glLI/eRppQBsOEqjXd15lVMa91GLMXr
        z/vdXeqixJf+46mg8op+BDtEMAqY7Hw=
X-Google-Smtp-Source: APXvYqzAGcPvnepTOvwWRDQxzLcJ/M058MuV1V355eV9v96p3PIpDSwE+P8RHoMQgcX7eCRUeENRAg==
X-Received: by 2002:a50:8a46:: with SMTP id i64mr126930218edi.177.1559034193385;
        Tue, 28 May 2019 02:03:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:12 -0700 (PDT)
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
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 02/33] fbdev: locking check for fb_set_suspend
Date:   Tue, 28 May 2019 11:02:33 +0200
Message-Id: <20190528090304.9388-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just drive-by, nothing systematic yet.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/core/fbmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d1949c92be98..8ba674ffb3c9 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1985,6 +1985,8 @@ void fb_set_suspend(struct fb_info *info, int state)
 {
 	struct fb_event event;
 
+	WARN_CONSOLE_UNLOCKED();
+
 	event.info = info;
 	if (state) {
 		fb_notifier_call_chain(FB_EVENT_SUSPEND, &event);
-- 
2.20.1

