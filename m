Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347B9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C4821897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfICUr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfICUr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:47:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD6543018FC5;
        Tue,  3 Sep 2019 20:47:55 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-34.bss.redhat.com [10.20.1.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DEA11001B02;
        Tue,  3 Sep 2019 20:47:54 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/27] drm/print: Add drm_err_printer()
Date:   Tue,  3 Sep 2019 16:45:43 -0400
Message-Id: <20190903204645.25487-6-lyude@redhat.com>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 03 Sep 2019 20:47:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A simple convienence function that returns a drm_printer which prints
using pr_err()

Changes since v1:
* Make __drm_printfn_err() more consistent with DRM_ERROR() - danvet

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_print.c |  6 ++++++
 include/drm/drm_print.h     | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index a17c8a14dba4..ad302d71eeee 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -147,6 +147,12 @@ void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf)
 }
 EXPORT_SYMBOL(__drm_printfn_debug);
 
+void __drm_printfn_err(struct drm_printer *p, struct va_format *vaf)
+{
+	pr_err("*ERROR* %s %pV", p->prefix, vaf);
+}
+EXPORT_SYMBOL(__drm_printfn_err);
+
 /**
  * drm_puts - print a const string to a &drm_printer stream
  * @p: the &drm printer
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index a5d6f2f3e430..112165d3195d 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -83,6 +83,7 @@ void __drm_printfn_seq_file(struct drm_printer *p, struct va_format *vaf);
 void __drm_puts_seq_file(struct drm_printer *p, const char *str);
 void __drm_printfn_info(struct drm_printer *p, struct va_format *vaf);
 void __drm_printfn_debug(struct drm_printer *p, struct va_format *vaf);
+void __drm_printfn_err(struct drm_printer *p, struct va_format *vaf);
 
 __printf(2, 3)
 void drm_printf(struct drm_printer *p, const char *f, ...);
@@ -227,6 +228,22 @@ static inline struct drm_printer drm_debug_printer(const char *prefix)
 	return p;
 }
 
+/**
+ * drm_err_printer - construct a &drm_printer that outputs to pr_err()
+ * @prefix: debug output prefix
+ *
+ * RETURNS:
+ * The &drm_printer object
+ */
+static inline struct drm_printer drm_err_printer(const char *prefix)
+{
+	struct drm_printer p = {
+		.printfn = __drm_printfn_err,
+		.prefix = prefix
+	};
+	return p;
+}
+
 /*
  * The following categories are defined:
  *
-- 
2.21.0

