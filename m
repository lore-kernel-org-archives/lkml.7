Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9576CC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6758E2467A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1nloryK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAFPRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:17:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32822 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgAFPRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:17:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so50070979wrq.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SOmEZGQpMcpl6KDihwRiQnkiTEmQlzVwGvhf3uAJ7uE=;
        b=h1nloryK6q5QEDoF84Jg4fU1td226wfY8TNiivSZxmD2+DtGs6fGxuh4seu+uhrCar
         rkfwxSWrP5XkpKfx6JspmwRVK0OQYz+AWQ4AF5uGtY5pwmeTaUHbKMpBZ18vgqXScZBO
         XGIbLNveoFGJJAtBncNhx85zRx3+O/PvuQMM7izDQX1QVXR73zpTOJiAnSEISb086EXl
         ktQbesxin9FmTtZX0GXSf03D6vWJqvvAnhWcG3aZM7uv7JMJoay8fa7VKakS8Krl9LnH
         PJIgjnqRunCGw5sTEhzkC+jUGDMXzyzbZsXun6jLpRZPmCvmWXOc1LqpJ8xeQ4CGVLoF
         RLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SOmEZGQpMcpl6KDihwRiQnkiTEmQlzVwGvhf3uAJ7uE=;
        b=O+4EzJQgLjMl6oYoJuNEFV1Un2v8VBWOAczLdfOsoG94YHoM0KOH4br2w4urGv8rZ8
         7NNNsy3a+vsOrdNBR616VyUFhQM5wkb7OQt5V5foWQ6mgF1rLWSrHE8xYszwKssEcTWD
         5xKF+KbEda4OljnGtT0uRPZStBywOIA5DsXJ9xtdZ9R0Eo8UuIJwaI6TrSXMvjSvFkuN
         AWEaIWMXVI/+WKKBkAvIimg0hIYfEnWbAaT8fpXEUTGr4g3OsHRB1EjkL5y9y3YLnxWe
         MLeM/cDkEPuJ0SJbkbqad7op8i9eT/SCMS42Ri9E2sH2wDNtMIlDGEn8p+IgXOoGqU6S
         YZfA==
X-Gm-Message-State: APjAAAW2puJMgSIKS8hunGgT805+eAwAPnCOEQ5OMhCs6zrmB9az2DTQ
        GGG9n+EuMiV9nXa4Kr/qFhE/8+7gXqNTmA==
X-Google-Smtp-Source: APXvYqwMbChwE+QuvzUOzzlahZytW31FsGCmoxK+c31HuRNQAv4fnXL+sBrROUYhvkm3zpQ6qaKSXw==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr111561575wrp.17.1578323823241;
        Mon, 06 Jan 2020 07:17:03 -0800 (PST)
Received: from localhost.localdomain ([62.178.82.229])
        by smtp.gmail.com with ESMTPSA id l3sm72122463wrt.29.2020.01.06.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 07:17:02 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/6] drm/etnaviv: update hardware headers from rnndb
Date:   Mon,  6 Jan 2020 16:16:46 +0100
Message-Id: <20200106151655.311413-2-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106151655.311413-1-christian.gmeiner@gmail.com>
References: <20200106151655.311413-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the state HI header from rnndb commit
7f1ce75 ("rnndb: document some GPU identity register")

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/state_hi.xml.h | 29 ++++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/state_hi.xml.h b/drivers/gpu/drm/etnaviv/state_hi.xml.h
index 41d8da2b6f4f..004d8ddacf6a 100644
--- a/drivers/gpu/drm/etnaviv/state_hi.xml.h
+++ b/drivers/gpu/drm/etnaviv/state_hi.xml.h
@@ -8,17 +8,17 @@ This file was generated by the rules-ng-ng headergen tool in this git repository
 git clone git://0x04.net/rules-ng-ng
 
 The rules-ng-ng source files this header was generated from are:
-- state.xml     (  26087 bytes, from 2017-12-18 16:51:59)
-- common.xml    (  35468 bytes, from 2018-01-22 13:48:54)
-- common_3d.xml (  14615 bytes, from 2017-12-18 16:51:59)
-- state_hi.xml  (  30232 bytes, from 2018-02-15 15:48:01)
-- copyright.xml (   1597 bytes, from 2016-12-08 16:37:56)
-- state_2d.xml  (  51552 bytes, from 2016-12-08 16:37:56)
-- state_3d.xml  (  79992 bytes, from 2017-12-18 16:51:59)
-- state_blt.xml (  13405 bytes, from 2017-12-18 16:51:59)
-- state_vg.xml  (   5975 bytes, from 2016-12-08 16:37:56)
-
-Copyright (C) 2012-2018 by the following authors:
+- state.xml     (  26666 bytes, from 2019-12-20 21:20:35)
+- common.xml    (  35468 bytes, from 2018-02-10 13:09:26)
+- common_3d.xml (  15058 bytes, from 2019-12-28 20:02:03)
+- state_hi.xml  (  30552 bytes, from 2019-12-28 20:02:48)
+- copyright.xml (   1597 bytes, from 2018-02-10 13:09:26)
+- state_2d.xml  (  51552 bytes, from 2018-02-10 13:09:26)
+- state_3d.xml  (  83098 bytes, from 2019-12-28 20:02:03)
+- state_blt.xml (  14252 bytes, from 2019-10-20 19:59:15)
+- state_vg.xml  (   5975 bytes, from 2018-02-10 13:09:26)
+
+Copyright (C) 2012-2019 by the following authors:
 - Wladimir J. van der Laan <laanwj@gmail.com>
 - Christian Gmeiner <christian.gmeiner@gmail.com>
 - Lucas Stach <l.stach@pengutronix.de>
@@ -48,6 +48,9 @@ DEALINGS IN THE SOFTWARE.
 #define MMU_EXCEPTION_SLAVE_NOT_PRESENT				0x00000001
 #define MMU_EXCEPTION_PAGE_NOT_PRESENT				0x00000002
 #define MMU_EXCEPTION_WRITE_VIOLATION				0x00000003
+#define MMU_EXCEPTION_OUT_OF_BOUND				0x00000004
+#define MMU_EXCEPTION_READ_SECURITY_VIOLATION			0x00000005
+#define MMU_EXCEPTION_WRITE_SECURITY_VIOLATION			0x00000006
 #define VIVS_HI							0x00000000
 
 #define VIVS_HI_CLOCK_CONTROL					0x00000000
@@ -140,6 +143,8 @@ DEALINGS IN THE SOFTWARE.
 
 #define VIVS_HI_CHIP_TIME					0x0000002c
 
+#define VIVS_HI_CHIP_CUSTOMER_ID				0x00000030
+
 #define VIVS_HI_CHIP_MINOR_FEATURE_0				0x00000034
 
 #define VIVS_HI_CACHE_CONTROL					0x00000038
@@ -237,6 +242,8 @@ DEALINGS IN THE SOFTWARE.
 
 #define VIVS_HI_BLT_INTR					0x000000d4
 
+#define VIVS_HI_CHIP_ECO_ID					0x000000e8
+
 #define VIVS_HI_AUXBIT						0x000000ec
 
 #define VIVS_PM							0x00000000
-- 
2.24.1

