Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C258EC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A352184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="G8gQaHLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbfEXIzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:55:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34402 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390240AbfEXIyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so13377941eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mUAcB3sU0dD3E/MUylEVVwC2GTKxo8rk41HcMoWy7Z0=;
        b=G8gQaHLZUx+WzPRhTW9uW/COq5N31wy0ORbu7OIDAR64WlKCvpFjKEJSkBXQceNUqU
         Pf2ZP8mFN3py9TSDiJCyhwRzpd2XkYyNoHJZxCR/dIW1IXyui6OCcrPWPzlGghN5ZXxa
         ENIvnIJhRgK6TnD1XZkchnjTIKtsaX7Tf2OIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mUAcB3sU0dD3E/MUylEVVwC2GTKxo8rk41HcMoWy7Z0=;
        b=L3N+reFxL5odm52YCXZyZBxMUrgwMTtLjZPcLSbd5iHTvsGrBhQP6DIR/iWbYD2y4e
         hPYLmoiIC0yMzM53RW+96n9zbpNTvkkseDTEEL5CbxX3NIsgHYU8yl0b0S77WBmIFOA7
         W5mFDbBO6Mb4ZGCAxY1FVf7WpBlnwX7CrEFCAqKjrwD3KBAot3z6lsXMKAsHyu27cbQF
         Od1JuUMe8HwbkchbT6JoOozf0S+PWKHi9VtXLhSm+s6CRNYWh0kN6Eg8G6E4XCbltdlO
         Lwu/YdTIERGP4tE/FzzTeArxh8etGU0XWS899/xAZDUVRinBFGL48jg6UuNMI0QJV10b
         WX2Q==
X-Gm-Message-State: APjAAAWsHTLNR2cWQVeKJuC8pXtIbuqhOFMYDYp+HYKEayhiul/8nuyL
        yW1riSLDulvjrU4ysumVQR5GpRx0sYo=
X-Google-Smtp-Source: APXvYqz2qHhN5A2pWKpVJsBUdeEY8H62cdHPVnuNt4a6bkkHftmLnMSppn0lpuPcH/owQLYONbNwfA==
X-Received: by 2002:a17:906:d557:: with SMTP id gk23mr78999185ejb.285.1558688083594;
        Fri, 24 May 2019 01:54:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:42 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>
Subject: [PATCH 32/33] staging/olpc_dcon: Add drm conversion to TODO
Date:   Fri, 24 May 2019 10:53:53 +0200
Message-Id: <20190524085354.27411-33-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this driver is pretty horrible from a design pov, and needs a complete
overhaul. Concrete thing that annoys me is that it looks at
registered_fb, which is an internal thing to fbmem.c and fbcon.c. And
ofc it gets the lifetime rules all wrong (it should at least use
get/put_fb_info).

Looking at the history, there's been an attempt at dropping this from
staging in 2016, but that had to be reverted. Since then not real
effort except the usual stream of trivial patches, and fbdev has been
formally closed for any new hw support. Time to try again and drop
this?

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
---
 drivers/staging/olpc_dcon/TODO | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/olpc_dcon/TODO b/drivers/staging/olpc_dcon/TODO
index 665a0b061719..fe09efbc7f77 100644
--- a/drivers/staging/olpc_dcon/TODO
+++ b/drivers/staging/olpc_dcon/TODO
@@ -1,4 +1,11 @@
 TODO:
+	- complete rewrite:
+	  1. The underlying fbdev drivers need to be converted into drm kernel
+	     modesetting drivers.
+	  2. The dcon low-power display mode can then be integrated using the
+	     drm damage tracking and self-refresh helpers.
+	  This bolted-on self-refresh support that digs around in fbdev
+	  internals, but isn't properly integrated, is not the correct solution.
 	- see if vx855 gpio API can be made similar enough to cs5535 so we can
 	  share more code
 	- convert all uses of the old GPIO API from <linux/gpio.h> to the
-- 
2.20.1

