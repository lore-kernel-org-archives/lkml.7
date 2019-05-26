Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830F0C282E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 07:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CC22085A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 07:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ2+9rTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfEZH4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 03:56:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:47084 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEZH4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 03:56:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so2919745pfm.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KlCZZbqSoq/MJg7RIhnS5XN0yjpHRVX96n1/cDuyLB4=;
        b=oQ2+9rTU2vAEU4CZXBWNSm4rFLCyGCxJEYa2/sofNGkwBlEFqVFnjSECKFGJH8uokt
         gV2RtAomnUR1jar2QNyACLY5IVAc/Z3qeBdZgm/IPAA96sO4crn+jUR0BYFu0SVkJCXM
         RAvle730TddMpMRxnw1tvzNY6hB+Xi2zy9Fg2M1rTSuE6RvIH3hPcw7fC1SyhepvOGo6
         6CC8AjS0KkPZkTqVdVNlJy0MY4aRBOcSZY37ER1bnahe2m9hJBZza46h5Hd+QgeKejf1
         kuyJFzA5+zHu6/Q82Da3Y/hymRPWSVbhGCtXM/6OiJ8uNS06uFEdcJDyL7fGyaZs4Okf
         B4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KlCZZbqSoq/MJg7RIhnS5XN0yjpHRVX96n1/cDuyLB4=;
        b=fiqvTcu+NJeBt2WPa9417JtN13+dH04cTDJrgTxGHBOftMoFC7Tp5ie06LUX4/T70H
         BeDc7h4JBAfMkbYB3NyDedphlw64qloxW7vh5HdDhldEPBhc6g0UAdOivKVMg132LvL/
         JWP3cPwRgPPwD3uSfV4ouAdzVvrL9GVJSqX9YRnXzkxH53zjOZBFVFw7HY1jB6fJ1m6W
         1qEDUd/YVRsbHs9HYJ20Wu1NO/PSZCTvmq8ZODsJaV320xokVKiHEEKqYkWlo7gk+DT1
         wN13vQUNVxocVIM8DehOljahgm5+NWpGTjjurgsyLeOZgSMTSSghyMvQqGTmwVNZuC/k
         w6xA==
X-Gm-Message-State: APjAAAWsQ4v1y479EL4GlT9xlkSzFyc32OXyBfF91gpUjZ6ol20Xvecr
        uoqo0iak/6iraKYSdzcJyvs=
X-Google-Smtp-Source: APXvYqx4mtbkMYP7BtHxoAsheCKF7G3ehabBGjanIgM05/vsT/7ztFMbjgGagVmDcICsu2KPzs1X/Q==
X-Received: by 2002:a63:fd50:: with SMTP id m16mr2717464pgj.192.1558857400300;
        Sun, 26 May 2019 00:56:40 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id 5sm7703827pfh.109.2019.05.26.00.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 00:56:39 -0700 (PDT)
Date:   Sun, 26 May 2019 13:26:33 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/gvt: remove duplicate entry of trace
Message-ID: <20190526075633.GA9245@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate include of trace.h

Issue identified by includecheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/i915/gvt/trace_points.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/trace_points.c b/drivers/gpu/drm/i915/gvt/trace_points.c
index a3deed69..569f5e3 100644
--- a/drivers/gpu/drm/i915/gvt/trace_points.c
+++ b/drivers/gpu/drm/i915/gvt/trace_points.c
@@ -32,5 +32,4 @@
 
 #ifndef __CHECKER__
 #define CREATE_TRACE_POINTS
-#include "trace.h"
 #endif
-- 
2.7.4

