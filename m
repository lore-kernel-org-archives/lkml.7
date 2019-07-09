Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBD1C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC5C2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfGISvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:51:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43688 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGISvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:51:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so19579226qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sI2iJQyCLYlamWmjn8gLYgqmvq/qbA4oh6QTkJNpxYw=;
        b=ShiE+TOgMUHBcU9BQDXT7T7hdwy+pGfk7qko8xkpXiLE1S+oDD9xBgt8cfwerGAUVA
         6ms2x6xRW6dhfPBHEnTZGvSEpE4HUWGehf+cuKqXYdQ0gqwI8UcT8SYoq2qydgobK/uz
         +YHiDE2m9W6+XX7XJ05nTfnAD1vuFHTHzrSPqUh6gzuDu+PEP63NrPH9WDEUHwJ8wTUL
         sA5UQyifUEFdb345QdUHRYjmVCKu0rgYYNBZiAGTrKf5wDmciIAAuEaZgocJ5BX39zt4
         LaB0ezBT/H3s/E+sJbaPhwYTIeK3zML1xPzmKBrOtpPB9VFsX0FOS1JVgURW8aGfBMh1
         07OA==
X-Gm-Message-State: APjAAAXxh3t5UhEHKKFafjYjBdnUHnqT3Z+QwQEznk0jN2reaBssGJur
        GQSf88jAkl9NQJBAonsb5MdpE7zzwZlPPx/Mxg0=
X-Google-Smtp-Source: APXvYqyT/tThcmxAKorV8LTlUXibyDJWsesI4MTnxTQy/SCN9uc32kJY+4LGiIzTuAnQ5BP1+riqaPhXPn4U/gm08kA=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr20062850qtf.204.1562698310948;
 Tue, 09 Jul 2019 11:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190704055217.45860-1-natechancellor@gmail.com> <20190704055217.45860-6-natechancellor@gmail.com>
In-Reply-To: <20190704055217.45860-6-natechancellor@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Jul 2019 20:51:33 +0200
Message-ID: <CAK8P3a1vEtrS7SbhCPVxoYBcroT+Hr3Q4LFs6AJJ8G8GVw5SVA@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/amd/display: Use proper enum conversion functions
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 7:52 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:336:8:
> warning: implicit conversion from enumeration type 'enum smu_clk_type'
> to different enumeration type 'enum amd_pp_clock_type'
> [-Wenum-conversion]
>                                         dc_to_smu_clock_type(clk_type),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:421:14:
> warning: implicit conversion from enumeration type 'enum
> amd_pp_clock_type' to different enumeration type 'enum smu_clk_type'
> [-Wenum-conversion]
>                                         dc_to_pp_clock_type(clk_type),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> There are functions to properly convert between all of these types, use
> them so there are no longer any warnings.

I had a different solution for this one as well. The difference is that your
patch keeps the types and assumes that the functions do the right thing
(i.e. the warning was correct), while my version assumes that the code
works correctly, but the types are wrong (a false positive warning).

One of the two patches is correct, the other one is broken, but I have
no idea which one.

      Arnd

From 61316b80c852d103bb61e1ce9904002414600125 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 8 Jul 2019 17:44:05 +0200
Subject: [PATCH] drm/amd/powerplay: fix one more incorrect enum conversion

Similar to a previous patch, this one converts the type from a
function argument of a different enum type:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:336:8:
error: implicit conversion from enumeration type 'enum smu_clk_type'
to different enumeration type 'enum amd_pp_clock_type'
[-Werror,-Wenum-conversion]
                                          dc_to_smu_clock_type(clk_type),
                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:868:77: note:
expanded from macro 'smu_get_clock_by_type'
        ((smu)->funcs->get_clock_by_type ?
(smu)->funcs->get_clock_by_type((smu), (type), (clocks)) : 0)
                                           ~
            ^~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:421:14:
error: implicit conversion from enumeration type 'enum
amd_pp_clock_type' to different enumeration type 'enum smu_clk_type'
[-Werror,-Wenum-conversion]

dc_to_pp_clock_type(clk_type),

^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:872:111:
note: expanded from macro 'smu_get_clock_by_type_with_latency'

Add another type cast.

Fixes: e5e4e22391c2 ("drm/amd/powerplay: add interface to get clock by
type with latency for display (v2)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index eac09bfe3be2..88e3f8456b1c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -333,7 +333,7 @@ bool dm_pp_get_clock_levels_by_type(
                }
        } else if (adev->smu.funcs && adev->smu.funcs->get_clock_by_type) {
                if (smu_get_clock_by_type(&adev->smu,
-                                         dc_to_smu_clock_type(clk_type),
+                                         (enum
amd_pp_clock_type)dc_to_smu_clock_type(clk_type),
                                          &pp_clks)) {
                        get_default_clock_levels(clk_type, dc_clks);
                        return true;
@@ -418,7 +418,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
                        return false;
        } else if (adev->smu.ppt_funcs &&
adev->smu.ppt_funcs->get_clock_by_type_with_latency) {
                if (smu_get_clock_by_type_with_latency(&adev->smu,
-
dc_to_pp_clock_type(clk_type),
+                                                      (enum
smu_clk_type)dc_to_pp_clock_type(clk_type),
                                                       &pp_clks))
                        return false;
        }
