Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB93C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DEA2067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3IF44u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfJLGxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33324 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbfJLGxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id r17so10769351wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xYNaygMbd21QTie4NeAZZNYx9YnNHVu9c1OqSN5Gf6U=;
        b=I3IF44u6t3ND7sZz0+JegnRFquaT8wyBcQgZnDZYJjkOm53dtMN0u1YYnfeakndm2/
         06GVx9P7IrJCWVCmZTQcoEcd+O49axRKnh9rKDTKwlGLQuR0OH1weuknLJJRoUTOgUE7
         txg7zComQk04jZrPEDMG/Swz34kMNuE9Y8KAkJ0Iduk7ZgZRKtIOwhyISwSEVDsl2NdL
         kiwxJ5k4eTLAN65B66iw97wG5XugayifItdeMlmEeOeZBrpJxjFgcHluDbLeGdZozWU6
         l4HYPilQfM7o2TFoMiwdUJzCR0O4k7fHZY7krwPIRChVfnim3RP9W2t82O4zhVEjzUoo
         83Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xYNaygMbd21QTie4NeAZZNYx9YnNHVu9c1OqSN5Gf6U=;
        b=TWxsMujOCMNczXQGDK6keK+baJTF8+tHqQM3V6xRIE+A2B9KMWYUcpqsAW+2B4ReId
         Ps8jSWn6NHY2ySNrAg48vpyByKMIWnqjexkWvxIS3SGkn7lGyvjuDvXAnfXibICJEP6y
         G6uZfC2G7kr3XvJWD1gv3H2qiMI/wFG4Qa5MIS7r0GqPK1tqAtqLxE2Cx7DmnuhO6s+d
         ixlXzqZH0DdkAFyTO9kU/EeJC9eIdPQWXz529V9+MXGllbK3d1gHx104QK5/+HiDaHSn
         MbiLQBqSwrjwASraL4YAdWhYV03ZxvH66S12PXquy789nRvr8OnFdwDI/RDJCUPCHktL
         YcRw==
X-Gm-Message-State: APjAAAVGSI9NgoFyQWzoW8nHkNpPFYHYEzCdbluSlrXrFcIxyyYmJdj6
        OUxtH5+QDTn6PBFnfdYVlVdyZg==
X-Google-Smtp-Source: APXvYqwTWU6dUXRzmsADNPqH3uiAuNFMSSR3fadd88y/t2XXcKUagh0ynAT+0klnLvTo5WTSUT7USA==
X-Received: by 2002:a1c:2e50:: with SMTP id u77mr6567745wmu.64.1570863194641;
        Fri, 11 Oct 2019 23:53:14 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 10/11] thermal: Remove thermal_zone_device_update() stub
Date:   Sat, 12 Oct 2019 08:52:54 +0200
Message-Id: <20191012065255.23249-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012065255.23249-1-daniel.lezcano@linaro.org>
References: <20191012065255.23249-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of the function depends on THERMAL, no stub is
needed. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index ae72fe771e07..8daa179918a1 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -427,9 +427,6 @@ static inline struct thermal_zone_device *thermal_zone_device_register(
 static inline void thermal_zone_device_unregister(
 	struct thermal_zone_device *tz)
 { }
-static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
-					      enum thermal_notify_event event)
-{ }
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
-- 
2.17.1

