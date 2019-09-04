Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C9EC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734E223400
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 05:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfIDFrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 01:47:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDFrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:47:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F23FE10C6973;
        Wed,  4 Sep 2019 05:47:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1319B6092D;
        Wed,  4 Sep 2019 05:47:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CA12831E8D; Wed,  4 Sep 2019 07:47:40 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/7] drm: add drm_print_bits
Date:   Wed,  4 Sep 2019 07:47:34 +0200
Message-Id: <20190904054740.20817-2-kraxel@redhat.com>
In-Reply-To: <20190904054740.20817-1-kraxel@redhat.com>
References: <20190904054740.20817-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Wed, 04 Sep 2019 05:47:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New helper to print named bits of some value (think flags fields).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_print.h     |  3 +++
 drivers/gpu/drm/drm_print.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 112165d3195d..12d4916254b4 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -89,6 +89,9 @@ __printf(2, 3)
 void drm_printf(struct drm_printer *p, const char *f, ...);
 void drm_puts(struct drm_printer *p, const char *str);
 void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset);
+void drm_print_bits(struct drm_printer *p,
+		    unsigned long value, const char *bits[],
+		    unsigned int from, unsigned int to);
 
 __printf(2, 0)
 /**
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ad302d71eeee..dfa27367ebb8 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -185,6 +185,39 @@ void drm_printf(struct drm_printer *p, const char *f, ...)
 }
 EXPORT_SYMBOL(drm_printf);
 
+/**
+ * drm_print_bits - print bits to a &drm_printer stream
+ *
+ * Print bits (in flag fields for example) in human readable form.
+ * The first name in the @bits array is for the bit indexed by @from.
+ *
+ * @p: the &drm_printer
+ * @value: field value.
+ * @bits: Array with bit names.
+ * @from: start of bit range to print (inclusive).
+ * @to: end of bit range to print (exclusive).
+ */
+void drm_print_bits(struct drm_printer *p,
+		    unsigned long value, const char *bits[],
+		    unsigned int from, unsigned int to)
+{
+	bool first = true;
+	unsigned int i;
+
+	for (i = from; i < to; i++) {
+		if (!(value & (1 << i)))
+			continue;
+		if (WARN_ON_ONCE(!bits[i-from]))
+			continue;
+		drm_printf(p, "%s%s", first ? "" : ",",
+			   bits[i-from]);
+		first = false;
+	}
+	if (first)
+		drm_printf(p, "(none)");
+}
+EXPORT_SYMBOL(drm_print_bits);
+
 void drm_dev_printk(const struct device *dev, const char *level,
 		    const char *format, ...)
 {
-- 
2.18.1

