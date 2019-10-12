Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6935C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE2E2067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tswCzgp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfJLGx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36595 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbfJLGxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id y19so14100605wrd.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vSl/Ur1B9aK/gm2LM58l+jZvn+wzF8KR6Icoca7PTeo=;
        b=tswCzgp7QkQx0AP2oQ0KYfFcbz/UIZZxnLtlyPNgDA7tENRvpjRyuCnTZ7UFzWxhTr
         1m2Ss6xAd8iS0646KxYUqPFBdvXU9TZTBudSnjwtJb+SKPXK1TzQIblugN4gJQjc2bKE
         5naSLq++3TK/v3kcpGvacmM+TvsEdaRUGggltf4NdJrLIVP6BEj5pSrbykk35z5fwvmc
         ciuN1/a13/o8llkNXw3L+PbtGBiZLFkg6tUOeoxqk3TwIthUH+zQdlfDCazhuZrcxVTm
         QDRrqiLAVXeGxF78BC27idXeRQH9Bb6d2eun8lxyd/ZINpbRpwh1XtQbQxVoGl2HDh2r
         HvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vSl/Ur1B9aK/gm2LM58l+jZvn+wzF8KR6Icoca7PTeo=;
        b=dzk3Gnu1esbWTfVGBuEz06BfGS0uy4nTWS61/LBaq5i1UUO7UZ61M9gphXDNBa6S4D
         pmfRnWA31fTGKW+jmvM7sADVzoJha25sZVUTWT9b4jmDeOMi+MRkoHsVdbP9KqCN0Vay
         W01BDt0yFdzy0Wna1r6oD4dncD586waXc5M42zzeeglBmgBgG8jXg/aO7umE+XtxnPxF
         MpuBrA7PEnmBf57pE9zCJQHMqlxzQuch6brYTmz6uM09W/LnC5r5L45vcrV3sgKOaYqf
         VdIxpE+ibE7DwwxtQo3qXuQGKpTxTHQL+hSqUX/gUjGQrosZdb/M/VyUj+N4B+zjTHje
         AAvw==
X-Gm-Message-State: APjAAAW0U8y0rZYoQrAHqUGFHwkLzX1d297NcmVGcp2mQ0uUrUhSSTrd
        cd0O3ooy9BHmnU2JGLo3XiC/bA==
X-Google-Smtp-Source: APXvYqzI7Fh1Q2MyXWRXGOrHUSPGd/7iRe01YUbb3EDulz+HoQFnXPt+p/31MQeoWP+ge2vhX7E+DA==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr16296403wrw.10.1570863193492;
        Fri, 11 Oct 2019 23:53:13 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 09/11] thermal: Remove stubs for thermal_zone_[un]bind_cooling_device
Date:   Sat, 12 Oct 2019 08:52:53 +0200
Message-Id: <20191012065255.23249-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012065255.23249-1-daniel.lezcano@linaro.org>
References: <20191012065255.23249-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of the functions depends on THERMAL, it is pointless to
define stubs. Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index d77baa523093..ae72fe771e07 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -427,16 +427,6 @@ static inline struct thermal_zone_device *thermal_zone_device_register(
 static inline void thermal_zone_device_unregister(
 	struct thermal_zone_device *tz)
 { }
-static inline int thermal_zone_bind_cooling_device(
-	struct thermal_zone_device *tz, int trip,
-	struct thermal_cooling_device *cdev,
-	unsigned long upper, unsigned long lower,
-	unsigned int weight)
-{ return -ENODEV; }
-static inline int thermal_zone_unbind_cooling_device(
-	struct thermal_zone_device *tz, int trip,
-	struct thermal_cooling_device *cdev)
-{ return -ENODEV; }
 static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
 					      enum thermal_notify_event event)
 { }
-- 
2.17.1

