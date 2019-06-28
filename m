Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB868C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BAA208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfF1MRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:17:30 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfF1MRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:17:30 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MrPyJ-1iJFBE2Bdf-00oWeE; Fri, 28 Jun 2019 14:17:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/selftests: reduce stack usage
Date:   Fri, 28 Jun 2019 14:16:45 +0200
Message-Id: <20190628121712.1928142-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C9/HEI9D+7aWk3tbGABcmZ/leTmR3184GywOIUB4Ww6SaT0fSGl
 AlI8tsV2cidfF4tEGD3CVJUlgVZ1o/jRsk1D7TGuZnrMWsh8vMg0IDU5bCs0ajv39LWe3Lq
 X2VNIXlp4mOXTfqATV7W1rAoayvjvMOxal1hS5MAnsC0+sj4gpmkKBhsmJ7Oo1ZFFpk+3/1
 exnJ2wRpHQp2aofnJ/A+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+UmGTThXWoE=:JSznRAuZ8zA8y5g5O+nSE7
 RFRzNN4fsVL7Xf++RxG32gIybvWtYkGnTDjfsyuD6203/xv5JIWNLcnl8pZlMxx43yckkjmvQ
 bnEUfZQoOLdxKCWNoSpOzQMirteGp8wGvFGOnaZf/0AsKkMNvm3MS66KyobwDw9W4VeB/Yy7O
 ZRJf8YV13BDAT0hbW8eC1bS2XPuwT1cwQ3hmnAT0M+AsSRlAWJaW15ekHCxzm87sDgycDX+a+
 DliZd4MmUImBm6wpxVZwbEkSkSPN5ucVQAE/Nqpwlurhanlm0eS9uvVuijO6f8qY5F6n2JpR+
 s/8RsIwWeZT3HTi89MyTutI4iR36SwPUuzSJbbbFYz/99WDW392aqGZPDQWnZBwrC0GSJnM+N
 wmshhyfE2d3Pev/MBdOAY4ohALbfwi4RR2w95Sv6qyI97kUNFSdv2MfJD0ZdzfERJJ+cFy0/d
 1D9leVH92tar9sWzOY5tujVKoDSAsD3p8g3eXFAxu+HwbfR708a0JM/Oms1fg+xE/HZww9CY8
 TaseEJ1hGDVcIbyxjrqz3hMD5N2HXg8PsVHJaGBFJgeyJRB27Re5FRmFW6gUOG7Jc5SslN4Gh
 ytlJG2KGvJV3SPUMbPFzTVBw5s4jMexnH1P4tHmFKI5k2yGBvBHMSgurhMzHCZxGzgu0eSb2f
 f3dRSQrCwvEVvXBYOSo1YChX6iNtf/Qozv0ZUKGHfyjjcF+wgFrTF0OYx93UOo+TeNnPIMnlZ
 FhJfxpsIQx9JRWl/e6NviK/lIv/paFq8hFxiaw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting a large drm_connector object on the stack can lead to warnings
in some configuration, such as:

drivers/gpu/drm/selftests/test-drm_cmdline_parser.c:18:12: error: stack frame size of 1040 bytes in function 'drm_cmdline_test_res' [-Werror,-Wframe-larger-than=]
static int drm_cmdline_test_res(void *ignored)

Since the object is never modified, just declare it as 'static const'
and allow this to be passed down.

Fixes: b7ced38916a9 ("drm/selftests: Add command line parser selftests")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/drm_modes.c                   |   8 +-
 .../drm/selftests/test-drm_cmdline_parser.c   | 136 +++++++-----------
 include/drm/drm_modes.h                       |   2 +-
 3 files changed, 53 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 57e6408288c8..910561d4f071 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1448,7 +1448,7 @@ static int drm_mode_parse_cmdline_refresh(const char *str, char **end_ptr,
 }
 
 static int drm_mode_parse_cmdline_extra(const char *str, int length,
-					struct drm_connector *connector,
+					const struct drm_connector *connector,
 					struct drm_cmdline_mode *mode)
 {
 	int i;
@@ -1493,7 +1493,7 @@ static int drm_mode_parse_cmdline_extra(const char *str, int length,
 
 static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
 					   bool extras,
-					   struct drm_connector *connector,
+					   const struct drm_connector *connector,
 					   struct drm_cmdline_mode *mode)
 {
 	const char *str_start = str;
@@ -1555,7 +1555,7 @@ static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
 }
 
 static int drm_mode_parse_cmdline_options(char *str, size_t len,
-					  struct drm_connector *connector,
+					  const struct drm_connector *connector,
 					  struct drm_cmdline_mode *mode)
 {
 	unsigned int rotation = 0;
@@ -1689,7 +1689,7 @@ static int drm_mode_parse_cmdline_options(char *str, size_t len,
  * True if a valid modeline has been parsed, false otherwise.
  */
 bool drm_mode_parse_command_line_for_connector(const char *mode_option,
-					       struct drm_connector *connector,
+					       const struct drm_connector *connector,
 					       struct drm_cmdline_mode *mode)
 {
 	const char *name;
diff --git a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c b/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
index bef4edde6f9f..14c96edb13df 100644
--- a/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
+++ b/drivers/gpu/drm/selftests/test-drm_cmdline_parser.c
@@ -15,13 +15,14 @@
 #include "drm_selftest.h"
 #include "test-drm_modeset_common.h"
 
+static const struct drm_connector no_connector = {};
+
 static int drm_cmdline_test_res(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -42,11 +43,10 @@ static int drm_cmdline_test_res(void *ignored)
 
 static int drm_cmdline_test_res_missing_x(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("x480",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -54,11 +54,10 @@ static int drm_cmdline_test_res_missing_x(void *ignored)
 
 static int drm_cmdline_test_res_missing_y(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("1024x",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -66,11 +65,10 @@ static int drm_cmdline_test_res_missing_y(void *ignored)
 
 static int drm_cmdline_test_res_bad_y(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("1024xtest",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -78,11 +76,10 @@ static int drm_cmdline_test_res_bad_y(void *ignored)
 
 static int drm_cmdline_test_res_missing_y_bpp(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("1024x-24",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -90,11 +87,10 @@ static int drm_cmdline_test_res_missing_y_bpp(void *ignored)
 
 static int drm_cmdline_test_res_vesa(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480M",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -115,11 +111,10 @@ static int drm_cmdline_test_res_vesa(void *ignored)
 
 static int drm_cmdline_test_res_vesa_rblank(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480MR",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -140,11 +135,10 @@ static int drm_cmdline_test_res_vesa_rblank(void *ignored)
 
 static int drm_cmdline_test_res_rblank(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480R",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -165,11 +159,10 @@ static int drm_cmdline_test_res_rblank(void *ignored)
 
 static int drm_cmdline_test_res_bpp(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -191,11 +184,10 @@ static int drm_cmdline_test_res_bpp(void *ignored)
 
 static int drm_cmdline_test_res_bad_bpp(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480-test",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -203,11 +195,10 @@ static int drm_cmdline_test_res_bad_bpp(void *ignored)
 
 static int drm_cmdline_test_res_refresh(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480@60",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -229,11 +220,10 @@ static int drm_cmdline_test_res_refresh(void *ignored)
 
 static int drm_cmdline_test_res_bad_refresh(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480@refresh",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -241,11 +231,10 @@ static int drm_cmdline_test_res_bad_refresh(void *ignored)
 
 static int drm_cmdline_test_res_bpp_refresh(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -268,11 +257,10 @@ static int drm_cmdline_test_res_bpp_refresh(void *ignored)
 
 static int drm_cmdline_test_res_bpp_refresh_interlaced(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60i",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -295,11 +283,10 @@ static int drm_cmdline_test_res_bpp_refresh_interlaced(void *ignored)
 
 static int drm_cmdline_test_res_bpp_refresh_margins(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60m",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -322,11 +309,10 @@ static int drm_cmdline_test_res_bpp_refresh_margins(void *ignored)
 
 static int drm_cmdline_test_res_bpp_refresh_force_off(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60d",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -349,11 +335,10 @@ static int drm_cmdline_test_res_bpp_refresh_force_off(void *ignored)
 
 static int drm_cmdline_test_res_bpp_refresh_force_on_off(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480-24@60de",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -361,11 +346,10 @@ static int drm_cmdline_test_res_bpp_refresh_force_on_off(void *ignored)
 
 static int drm_cmdline_test_res_bpp_refresh_force_on(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60e",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -388,11 +372,10 @@ static int drm_cmdline_test_res_bpp_refresh_force_on(void *ignored)
 
 static int drm_cmdline_test_res_bpp_refresh_force_on_analog(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60D",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -415,10 +398,11 @@ static int drm_cmdline_test_res_bpp_refresh_force_on_analog(void *ignored)
 
 static int drm_cmdline_test_res_bpp_refresh_force_on_digital(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
+	static const struct drm_connector connector = {
+		.connector_type = DRM_MODE_CONNECTOR_DVII,
+	};
 
-	connector.connector_type = DRM_MODE_CONNECTOR_DVII;
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60D",
 							   &connector,
 							   &mode));
@@ -443,11 +427,10 @@ static int drm_cmdline_test_res_bpp_refresh_force_on_digital(void *ignored)
 
 static int drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480-24@60ime",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -470,11 +453,10 @@ static int drm_cmdline_test_res_bpp_refresh_interlaced_margins_force_on(void *ig
 
 static int drm_cmdline_test_res_margins_force_on(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480me",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -495,11 +477,10 @@ static int drm_cmdline_test_res_margins_force_on(void *ignored)
 
 static int drm_cmdline_test_res_vesa_margins(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480Mm",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -520,11 +501,10 @@ static int drm_cmdline_test_res_vesa_margins(void *ignored)
 
 static int drm_cmdline_test_res_invalid_mode(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480f",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -532,11 +512,10 @@ static int drm_cmdline_test_res_invalid_mode(void *ignored)
 
 static int drm_cmdline_test_res_bpp_wrong_place_mode(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480e-24",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -544,11 +523,10 @@ static int drm_cmdline_test_res_bpp_wrong_place_mode(void *ignored)
 
 static int drm_cmdline_test_name(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(strcmp(mode.name, "NTSC"));
 	FAIL_ON(mode.refresh_specified);
@@ -559,11 +537,10 @@ static int drm_cmdline_test_name(void *ignored)
 
 static int drm_cmdline_test_name_bpp(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC-24",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(strcmp(mode.name, "NTSC"));
 
@@ -577,11 +554,10 @@ static int drm_cmdline_test_name_bpp(void *ignored)
 
 static int drm_cmdline_test_name_bpp_refresh(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC-24@60",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -589,11 +565,10 @@ static int drm_cmdline_test_name_bpp_refresh(void *ignored)
 
 static int drm_cmdline_test_name_refresh(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC@60",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -601,11 +576,10 @@ static int drm_cmdline_test_name_refresh(void *ignored)
 
 static int drm_cmdline_test_name_refresh_wrong_mode(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC@60m",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -613,11 +587,10 @@ static int drm_cmdline_test_name_refresh_wrong_mode(void *ignored)
 
 static int drm_cmdline_test_name_refresh_invalid_mode(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("NTSC@60f",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -625,11 +598,10 @@ static int drm_cmdline_test_name_refresh_invalid_mode(void *ignored)
 
 static int drm_cmdline_test_name_option(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC,rotate=180",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(strcmp(mode.name, "NTSC"));
@@ -640,11 +612,10 @@ static int drm_cmdline_test_name_option(void *ignored)
 
 static int drm_cmdline_test_name_bpp_option(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("NTSC-24,rotate=180",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(strcmp(mode.name, "NTSC"));
@@ -657,11 +628,10 @@ static int drm_cmdline_test_name_bpp_option(void *ignored)
 
 static int drm_cmdline_test_rotate_0(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=0",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -683,11 +653,10 @@ static int drm_cmdline_test_rotate_0(void *ignored)
 
 static int drm_cmdline_test_rotate_90(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=90",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -709,11 +678,10 @@ static int drm_cmdline_test_rotate_90(void *ignored)
 
 static int drm_cmdline_test_rotate_180(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=180",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -735,11 +703,10 @@ static int drm_cmdline_test_rotate_180(void *ignored)
 
 static int drm_cmdline_test_rotate_270(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=270",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -761,11 +728,10 @@ static int drm_cmdline_test_rotate_270(void *ignored)
 
 static int drm_cmdline_test_rotate_invalid_val(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=42",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -773,11 +739,10 @@ static int drm_cmdline_test_rotate_invalid_val(void *ignored)
 
 static int drm_cmdline_test_rotate_truncated(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,rotate=",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
@@ -785,11 +750,10 @@ static int drm_cmdline_test_rotate_truncated(void *ignored)
 
 static int drm_cmdline_test_hmirror(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,reflect_x",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -811,11 +775,10 @@ static int drm_cmdline_test_hmirror(void *ignored)
 
 static int drm_cmdline_test_vmirror(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,reflect_y",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -837,11 +800,10 @@ static int drm_cmdline_test_vmirror(void *ignored)
 
 static int drm_cmdline_test_margin_options(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,margin_right=14,margin_left=24,margin_bottom=36,margin_top=42",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -866,11 +828,10 @@ static int drm_cmdline_test_margin_options(void *ignored)
 
 static int drm_cmdline_test_multiple_options(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(!drm_mode_parse_command_line_for_connector("720x480,rotate=270,reflect_x",
-							   &connector,
+							   &no_connector,
 							   &mode));
 	FAIL_ON(!mode.specified);
 	FAIL_ON(mode.xres != 720);
@@ -892,11 +853,10 @@ static int drm_cmdline_test_multiple_options(void *ignored)
 
 static int drm_cmdline_test_invalid_option(void *ignored)
 {
-	struct drm_connector connector = { };
 	struct drm_cmdline_mode mode = { };
 
 	FAIL_ON(drm_mode_parse_command_line_for_connector("720x480,test=42",
-							  &connector,
+							  &no_connector,
 							  &mode));
 
 	return 0;
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index 083f16747369..e946e20c61d8 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -537,7 +537,7 @@ void drm_connector_list_update(struct drm_connector *connector);
 /* parsing cmdline modes */
 bool
 drm_mode_parse_command_line_for_connector(const char *mode_option,
-					  struct drm_connector *connector,
+					  const struct drm_connector *connector,
 					  struct drm_cmdline_mode *mode);
 struct drm_display_mode *
 drm_mode_create_from_cmdline_mode(struct drm_device *dev,
-- 
2.20.0

