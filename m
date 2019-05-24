Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6C6C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D1520675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmnk0FGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfEXCch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:32:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46489 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfEXCch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:32:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id r18so3503739pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 19:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mN/NXs4p7vHqDk7rTpmOP13LGQmOSI+Gshg9r4qyd1M=;
        b=bmnk0FGTthU8bpOEtEMJ2JLGJQ0K3KS/kp9cCpL9SDdg+SMeoauGDG41UP9H5XRh34
         9OJ1nU3MoZO8SoAGGhCUWosmEdiNJKmHb/NQrnDG61zi/RDoDW38Vd8QyDiF8LU4RVW6
         FrzliAYF+kiJDKtsb7kSqfIpAG7H/rELoWj7/TFc9wluWhH4ldnjPjtcxZlAGFyXu5i2
         SmsY8BixiQpx4KIhaX5Ou/yipZdFIlC1w3f1glKkOLV1ZQUx1LAQMTPm1MFG/Dr9YfxS
         zO0lOIF8ZqYWjM+A+8MupS1Ri5ASW2xt6a1tcrE/L/voTVLRpjUlNM7YDEtLkknN9OYl
         ThuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mN/NXs4p7vHqDk7rTpmOP13LGQmOSI+Gshg9r4qyd1M=;
        b=BjVLCP3IKgoG3kq+ZFbxdYCTzQR7XTXw4AgyuaqxizboqxzeFnpxW5K2QNoWDm6KPH
         VaN7fPH2D+YLd2TllDl7pqcPI+FwM+WeAGP+Yd7uA/8yb24s2/cjS9nrdww9RRufuQQh
         KBJFc6utd47LQTZJqCC+f5ISgKHAX+keiqF4lO0K2e4Mo5IQJkw1+RAmY7O3xl+qmqxL
         y9qHXtnLMUgW1bBSWmPr4mJK1eM/Igd0XW/s2DWcpjbpemhwyXiMYfHXBPHTHcqivjR5
         6sUZCTBUMxZjRimmIpfyXDuMRo4BvHLpToBcqfGMEQb8EvxFV3ybFntbc2jL2zRwJ6y3
         bbjQ==
X-Gm-Message-State: APjAAAURlHQ1jT6mz6YYE3JkbofVacOR4Q933haiXSuEJIbJQA8H7plO
        GiGXGQQnVugvoqZfiBe+Jqw=
X-Google-Smtp-Source: APXvYqygkdPnjJQzopiBCTMKEpkzXahl5pfibl6+5ljhQnCmYhOciGLy7S+iRFBKOt6V+36EX1ok3Q==
X-Received: by 2002:a17:902:b205:: with SMTP id t5mr53350395plr.314.1558665156301;
        Thu, 23 May 2019 19:32:36 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id a26sm803923pfl.177.2019.05.23.19.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:32:35 -0700 (PDT)
Date:   Fri, 24 May 2019 10:32:22 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com
Cc:     jani.nikula@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm_edid-load: Fix a missing-check bug in
 drm_load_edid_firmware()
Message-ID: <20190524023222.GA5302@zhanggen-UX430UQ>
References: <20190522123920.GB6772@zhanggen-UX430UQ>
 <87o93u7d3s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o93u7d3s.fsf@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drm_load_edid_firmware(), fwstr is allocated by kstrdup(). And fwstr
is dereferenced in the following codes. However, memory allocation 
functions such as kstrdup() may fail and returns NULL. Dereferencing 
this null pointer may cause the kernel go wrong. Thus we should check 
this kstrdup() operation.
Further, if kstrdup() returns NULL, we should return ERR_PTR(-ENOMEM) to
the caller site.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---
diff --git a/drivers/gpu/drm/drm_edid_load.c b/drivers/gpu/drm/drm_edid_load.c
index a491509..a0e107a 100644
--- a/drivers/gpu/drm/drm_edid_load.c
+++ b/drivers/gpu/drm/drm_edid_load.c
@@ -290,6 +290,8 @@ struct edid *drm_load_edid_firmware(struct drm_connector *connector)
 	 * the last one found one as a fallback.
 	 */
 	fwstr = kstrdup(edid_firmware, GFP_KERNEL);
+	if (!fwstr)
+		return ERR_PTR(-ENOMEM);
 	edidstr = fwstr;
 
 	while ((edidname = strsep(&edidstr, ","))) {
---
