Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E78C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B671A21883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbfICKMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:12:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfICKMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:12:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E07B67EB89;
        Tue,  3 Sep 2019 10:12:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DE26196AE;
        Tue,  3 Sep 2019 10:12:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 164CD31F38; Tue,  3 Sep 2019 12:12:49 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/6] drm: add drm_print_bits
Date:   Tue,  3 Sep 2019 12:12:43 +0200
Message-Id: <20190903101248.12879-2-kraxel@redhat.com>
In-Reply-To: <20190903101248.12879-1-kraxel@redhat.com>
References: <20190903101248.12879-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 03 Sep 2019 10:12:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New helper to print named bits of some value (think flags fields).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_print.h     |  3 +++
 drivers/gpu/drm/drm_print.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index a5d6f2f3e430..8658c1da1c7d 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -88,6 +88,9 @@ __printf(2, 3)
 void drm_printf(struct drm_printer *p, const char *f, ...);
 void drm_puts(struct drm_printer *p, const char *str);
 void drm_print_regset32(struct drm_printer *p, struct debugfs_regset32 *regset);
+void drm_print_bits(struct drm_printer *p, unsigned int indent,
+		    const char *label, unsigned int value,
+		    const char *bits[], unsigned int nbits);
 
 __printf(2, 0)
 /**
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index a17c8a14dba4..7f7aba920f51 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -179,6 +179,42 @@ void drm_printf(struct drm_printer *p, const char *f, ...)
 }
 EXPORT_SYMBOL(drm_printf);
 
+/**
+ * drm_print_bits - print bits to a &drm_printer stream
+ *
+ * Print bits (in flag fields for example) in human readable form.
+ *
+ * @p: the &drm_printer
+ * @indent: Tab indentation level (max 5)
+ * @label: field label.
+ * @value: field value.
+ * @bits: Array with bit names.
+ * @nbits: bit name array size.
+ */
+void drm_print_bits(struct drm_printer *p, unsigned int indent,
+		    const char *label, unsigned int value,
+		    const char *bits[], unsigned int nbits)
+{
+	bool first = true;
+	unsigned int i;
+
+	for (i = 0; i < nbits; i++) {
+		if (!(value & (1 << i)))
+			continue;
+		if (!bits[i])
+			continue;
+		if (first) {
+			first = false;
+			drm_printf_indent(p, indent, "%s=%s",
+					  label, bits[i]);
+		} else
+			drm_printf(p, ",%s", bits[i]);
+	}
+	if (!first)
+		drm_printf(p, "\n");
+}
+EXPORT_SYMBOL(drm_print_bits);
+
 void drm_dev_printk(const struct device *dev, const char *level,
 		    const char *format, ...)
 {
-- 
2.18.1

