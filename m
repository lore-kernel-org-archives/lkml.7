Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092D6C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC812067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JybpEL8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfJLGxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:53:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55372 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbfJLGxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so12324918wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 23:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pLeOxxToFlzhf4ijtkJsBjt2I5eCWkMMUorTQgLbLE4=;
        b=JybpEL8SzP1gopHe6/v2yw1y51wtcs1fuJB0dYf7mGfUjS3iYBN/CRa+RRYd0rjeG+
         x8BctNK1HUAzfaNbSDjgmLHjMM57dTBo6emq8ZjevWIww1cIedjSAVZQY7SlLcK9wV+0
         ys5H5G7RaE3WbuAkYrmKk9GAoy81UIP3wfvyKxsYctDwCf4sexj8RFrkScz3QgLDu5v0
         g4TWxoLW9OanFianj4yoC+/vbVyaxtnaRZP1PIC7MFPZbbtDPR5HZQMWnY1tru3MOMkt
         zEtQ8xrwjHw62uA1od4g9xFDkaKQslqhChdUI174bkfIofjmeo5in2OqFvGrpG89KV7s
         Sk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pLeOxxToFlzhf4ijtkJsBjt2I5eCWkMMUorTQgLbLE4=;
        b=ZMERGl/JQkSTVzDqh63PBMbCgO5ZZ6X1xxCKFmqKtWKuw/vVOeIB/X9SMuvPE1gN+o
         7YsE2i6lvKiA3mDHy2+xIkL0YxLCqoyeQLzdtVh/iK+Q/nDHvqySAjAq+/5AU1RK8zUJ
         y+EdDNUMmhNUHRSO65VYiaJlFidVVX0Y58HvNRz0Rx6hDHsDHHvxsnM5b/rFki0BKjWh
         2C8h3Ze7i4lM0S7hlSn7IUxY4T199sQQrxSxdMSqhnRT5kN3ol0mJOyjFTpPRROCa+7J
         DxmtHNZK5Ig7G1NyfvGWMllo4GO/Nk6BVIFiswbIQT2eHBqVe4O9ELffhwcORU7XDM61
         DgbQ==
X-Gm-Message-State: APjAAAXZMLFpMQqBwx540Lr99dygpADn/oJklcc0RUt1E/YyDY2HMFoO
        vB2VhIUbkm74GSv2BjkgIj1mju8mJII=
X-Google-Smtp-Source: APXvYqzgHvi2P4aJwjRScJDHQDzmxdaYfwA2yL4H2bsKKNMNKrOP+VhKxgNWSG/0xUft56sRgsFWyA==
X-Received: by 2002:a1c:444:: with SMTP id 65mr6152319wme.73.1570863192353;
        Fri, 11 Oct 2019 23:53:12 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f437:29a8:ed69:7bab])
        by smtp.gmail.com with ESMTPSA id z5sm17450497wrs.54.2019.10.11.23.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 23:53:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: [PATCH 08/11] thermal: Change IS_ENABLED to IFDEF in the header file
Date:   Sat, 12 Oct 2019 08:52:52 +0200
Message-Id: <20191012065255.23249-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191012065255.23249-1-daniel.lezcano@linaro.org>
References: <20191012065255.23249-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework can not be compiled as a module. The IS_ENABLED
macro is useless here and can be replaced by an ifdef.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 4436addc0e83..d77baa523093 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -384,7 +384,7 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
 
 #endif
 
-#if IS_ENABLED(CONFIG_THERMAL)
+#ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,
 		struct thermal_zone_params *, int, int);
-- 
2.17.1

