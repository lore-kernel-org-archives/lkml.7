Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D6AC742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA6C2064B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfGLJhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:37:31 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfGLJha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:37:30 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MdNLi-1iLCk53jKC-00ZPIO; Fri, 12 Jul 2019 11:37:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Duke Du <Duke.Du@amd.com>, Charlene Liu <charlene.liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] drm/amd/display: Support clang option for stack alignment
Date:   Fri, 12 Jul 2019 11:37:00 +0200
Message-Id: <20190712093720.1461418-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d225NHDmVD8iHvGnyul/A/ipRUep4hflYOdBban/FHrJgvhxnwv
 4MOV5qJc3d5lz4zwHGjhcNI0lO6YeTDm7VaRk9k1YAdyNbsflFi7qPCg/GwFqlbD0OrsWYN
 FzvL8RHmKRWR1k4HjLX5fBsO5NlMAPZrlHpxcA/UIv+Sl9Iv3G9E7bFJKG7hCU0MpdQvLtR
 oZHlNirSXwa7UbVjwnrTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lTHGrsZeWDM=:JXCj53bNX2jlA8G/jk8q9+
 ku8scKecqGHwd//M28KuzmF+Udem5qyLlHQV2zMS1Jg3rBvvg/cNt4x6RrCo5RH6PKIGrSu/i
 B/Bti/71s2AuQlWoXGqjfoFlxuug3UgBX91WMWnSENAN1bSjgZ0ZemyFsCYG5tvDjkOghoxGS
 /lDssxfXCq/AfHwMHdJajXPlEkIhVNxuUnssbH56PS2JISYB8pfKvyKYnymBNJcFBMUGvSVuy
 kqrT+3lW6FHT25MyhMn2IkdYmyNKC70IIoY+rVkZ8YXDd2UDXKt2jvizqLEpk+9RFAxrR4S8B
 z8Ac0OgVJ+uBz/9k/yLMWNwMsnTp+XGzWX3qEr0PBnXU+JiI1yQzyZe9t0KzBrxqkgPvzL3ia
 zSePZ2s3kMktRQXEgA7hTXaxOi7u/HnGhkrK3rgKy0nnOji2+J+gIunq7HQoyZUpNKIXQJk8S
 Cp6eTKeARkhKlWgOF52HoJLP7NGu8FjXF3EuVOTgSSGDLRPpIquHuUDQYwIiWKYikXIP2NNN7
 wrnP3dPMWR9AL2YKmn/pVOchHMns4PVWViw8RiufYmdSP6uq3D8+5R7HhuBJYClSZ2mRmowMQ
 9VVEiEKk2z8iku0UcsJOZolAmOHxj/dd+7a8zB5dUSgvf/OSVonGiG7c+Zy+L5RzpMLu6RXd9
 g8TQse+9URd/yHET2bfxsVwbp/AF2e+qur4ac7cUDBd0VZCEj9YrMHtstMcgxWK0eWHD7BzmR
 FBtEJaNLWUDMuqMFssmtpEc9hsZPhizIMAx1Pw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As previously fixed for dml in commit 4769278e5c7f ("amdgpu/dc/dml:
Support clang option for stack alignment") and calcs in commit
cc32ad8f559c ("amdgpu/dc/calcs: Support clang option for stack
alignment"), dcn20 uses an option that is not available with clang:

clang: error: unknown argument: '-mpreferred-stack-boundary=4'
scripts/Makefile.build:281: recipe for target 'drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o' failed

Use the same trick that we have in the other two files.

Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  8 +++++++-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 16 ++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 1b68de27ba74..e9721a906592 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -10,7 +10,13 @@ ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
 DCN20 += dcn20_dsc.o
 endif
 
-CFLAGS_dcn20_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+	cc_stack_align := -mpreferred-stack-boundary=4
+else ifneq ($(call cc-option, -mstack-alignment=16),)
+	cc_stack_align := -mstack-alignment=16
+endif
+
+CFLAGS_dcn20_resource.o := -mhard-float -msse $(cc_stack_align)
 
 AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
index c5d5b94e2604..e019cd9447e8 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
@@ -1,10 +1,18 @@
 #
 # Makefile for the 'dsc' sub-component of DAL.
 
-CFLAGS_rc_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_rc_calc_dpi.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_codec_main_amd.o := -mhard-float -msse -mpreferred-stack-boundary=4
-CFLAGS_dc_dsc.o := -mhard-float -msse -mpreferred-stack-boundary=4
+ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
+	cc_stack_align := -mpreferred-stack-boundary=4
+else ifneq ($(call cc-option, -mstack-alignment=16),)
+	cc_stack_align := -mstack-alignment=16
+endif
+
+dsc_ccflags := -mhard-float -msse $(cc_stack_align)
+
+CFLAGS_rc_calc.o := $(dsc_ccflags)
+CFLAGS_rc_calc_dpi.o := $(dsc_ccflags)
+CFLAGS_codec_main_amd.o := $(dsc_ccflags)
+CFLAGS_dc_dsc.o := $(dsc_ccflags)
 
 DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
 
-- 
2.20.0

