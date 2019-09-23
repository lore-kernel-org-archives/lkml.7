Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5DFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39142196E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405152AbfIWG6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 02:58:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60183 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405033AbfIWG6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF627308FF23;
        Mon, 23 Sep 2019 06:58:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2722A5C207;
        Mon, 23 Sep 2019 06:58:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id F322C17535; Mon, 23 Sep 2019 08:58:14 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     seanpaul@chromium.org, jani.nikula@linux.intel.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm: tweak drm_print_bits()
Date:   Mon, 23 Sep 2019 08:58:14 +0200
Message-Id: <20190923065814.4797-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 23 Sep 2019 06:58:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is little reason for the from/to logic, printing a subset of
the bits can be done by simply shifting/masking value if needed.

Also use for_each_set_bit().

Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
---
 include/drm/drm_print.h              |  5 ++---
 drivers/gpu/drm/drm_gem_ttm_helper.c |  4 ++--
 drivers/gpu/drm/drm_print.c          | 20 +++++++++-----------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 12d4916254b4..89d38d07316c 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -89,9 +89,8 @@ __printf(2, 3)
 void drm_printf(struct drm_printer *p, const char *f, ...);
 void drm_puts(struct drm_printer *p, const char *str);
 void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset);
-void drm_print_bits(struct drm_printer *p,
-		    unsigned long value, const char *bits[],
-		    unsigned int from, unsigned int to);
+void drm_print_bits(struct drm_printer *p, unsigned long value,
+		    const char * const bits[], unsigned int nbits);
 
 __printf(2, 0)
 /**
diff --git a/drivers/gpu/drm/drm_gem_ttm_helper.c b/drivers/gpu/drm/drm_gem_ttm_helper.c
index 9a4bafcf20df..a534104d8bee 100644
--- a/drivers/gpu/drm/drm_gem_ttm_helper.c
+++ b/drivers/gpu/drm/drm_gem_ttm_helper.c
@@ -23,7 +23,7 @@
 void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
 			    const struct drm_gem_object *gem)
 {
-	static const char const *plname[] = {
+	static const char * const plname[] = {
 		[ TTM_PL_SYSTEM ] = "system",
 		[ TTM_PL_TT     ] = "tt",
 		[ TTM_PL_VRAM   ] = "vram",
@@ -40,7 +40,7 @@ void drm_gem_ttm_print_info(struct drm_printer *p, unsigned int indent,
 	const struct ttm_buffer_object *bo = drm_gem_ttm_of_gem(gem);
 
 	drm_printf_indent(p, indent, "placement=");
-	drm_print_bits(p, bo->mem.placement, plname, 0, ARRAY_SIZE(plname));
+	drm_print_bits(p, bo->mem.placement, plname, ARRAY_SIZE(plname));
 	drm_printf(p, "\n");
 
 	if (bo->mem.bus.is_iomem) {
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index dfa27367ebb8..52cc7b38eb12 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -189,28 +189,26 @@ EXPORT_SYMBOL(drm_printf);
  * drm_print_bits - print bits to a &drm_printer stream
  *
  * Print bits (in flag fields for example) in human readable form.
- * The first name in the @bits array is for the bit indexed by @from.
  *
  * @p: the &drm_printer
  * @value: field value.
  * @bits: Array with bit names.
- * @from: start of bit range to print (inclusive).
- * @to: end of bit range to print (exclusive).
+ * @nbits: Size of bit names array.
  */
-void drm_print_bits(struct drm_printer *p,
-		    unsigned long value, const char *bits[],
-		    unsigned int from, unsigned int to)
+void drm_print_bits(struct drm_printer *p, unsigned long value,
+		    const char * const bits[], unsigned int nbits)
 {
 	bool first = true;
 	unsigned int i;
 
-	for (i = from; i < to; i++) {
-		if (!(value & (1 << i)))
-			continue;
-		if (WARN_ON_ONCE(!bits[i-from]))
+	if (WARN_ON_ONCE(nbits > BITS_PER_TYPE(value)))
+		nbits = BITS_PER_TYPE(value);
+
+	for_each_set_bit(i, &value, nbits) {
+		if (WARN_ON_ONCE(!bits[i]))
 			continue;
 		drm_printf(p, "%s%s", first ? "" : ",",
-			   bits[i-from]);
+			   bits[i]);
 		first = false;
 	}
 	if (first)
-- 
2.18.1

