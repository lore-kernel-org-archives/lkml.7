Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B003C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AA321D82
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KA9WXGnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfJBShv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:37:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42378 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJBShu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:37:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so10926979pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msZHjsSYlLs6Ks/lSk6Cls6E9XwP4bQAmPYAwQ4RSb4=;
        b=KA9WXGnWyvYQ0+Jk9Id79fcsK7FcOgUmszbFxbn5riioMVv8C5XKkKTwo6SSXpRsEG
         2WkvbSKkbKi5o1qMgLpv6uO85W7UZhpypbkQF6ZOHs4xGTOf2E9P1gjZEJ3Zv6/X7rWj
         +KPdK0fJ4QMCONqIQW9nGkyAZ06O4uX0QJ6X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msZHjsSYlLs6Ks/lSk6Cls6E9XwP4bQAmPYAwQ4RSb4=;
        b=tkklACgq8eZO7ZZ7fQMZSac+uNrgMN2uVG5QhsF8cwI0U36RgQX9xirSErRulAm5rf
         d2AdbL4zbzS3LPwBoRJHk1IKfktxcJRTn82KqABN263TsPNv4W26o/yAQhywGtd2K9bI
         wo6fcj36s/gmyD10tki107EXfxJIKxoWXedBR8/D1ZfjAVVlMCD5UkrnqcrjAq7rXiuQ
         2cYY+jZYME6AyAPqnmiv7Vf73nb39BTs7FJDqaZMEkL4t5U/i2nmEY8AUaDbpKHrp9a7
         uEzF/LcF3Jy1m+MiNvlSzaAjQPPygUwfIIbWx4/CmyNcWXFW9vcvylAIU8Cfuww1/8sw
         Tt5A==
X-Gm-Message-State: APjAAAWvXL9JA/uZrPy60/FkFtklu8uKFo8/T4Ag/EwSCKZ2tVAQNL+z
        o92WWZqYxUHSlud1VhFtHnYJJg==
X-Google-Smtp-Source: APXvYqxrdq/DjyPBBw0ZZ94XLn4NJoJn104fjLVNvokgfYmb1DzqmGGdeKJUxrjeBhmnAohoGkSJ/Q==
X-Received: by 2002:a65:4145:: with SMTP id x5mr5131467pgp.321.1570041470068;
        Wed, 02 Oct 2019 11:37:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id o15sm3501pjs.14.2019.10.02.11.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:37:49 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] PM / Domains: Add genpd_power_on/off trace events
Date:   Wed,  2 Oct 2019 11:37:42 -0700
Message-Id: <20191002113736.v2.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The events can be useful for power analysis/optimization, e.g.
to track the state of power domains during suspend/resume on
battery powered devices.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- split original patch in two, one for genpd_power_on/off and
  one for genpd_set_performance_state
- use trace_genpd_power_on/off_enabled macros to eliminate
  branches when the tracepoints are disabled
- updated commit message (original subject was "PM / Domains:
  Add tracepoints")

 drivers/base/power/domain.c  | 26 ++++++++++++++++++++++----
 include/trace/events/power.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 584cf7a60f57..88eff9c4e79a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/suspend.h>
 #include <linux/export.h>
+#include <trace/events/power.h>
 
 #include "power.h"
 
@@ -422,14 +423,22 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_on)
 		return 0;
 
-	if (!timed)
-		return genpd->power_on(genpd);
+	if (!timed) {
+		ret = genpd->power_on(genpd);
+
+		if (trace_genpd_power_on_enabled() && !ret)
+			trace_genpd_power_on(genpd);
+
+		return ret;
+	}
 
 	time_start = ktime_get();
 	ret = genpd->power_on(genpd);
 	if (ret)
 		return ret;
 
+	trace_genpd_power_on(genpd);
+
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
 		return ret;
@@ -452,14 +461,23 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_off)
 		return 0;
 
-	if (!timed)
-		return genpd->power_off(genpd);
+	if (!timed) {
+		ret = genpd->power_off(genpd);
+
+		if (trace_genpd_power_off_enabled() && !ret)
+			trace_genpd_power_off(genpd);
+
+		return ret;
+	}
 
 	time_start = ktime_get();
 	ret = genpd->power_off(genpd);
 	if (ret == -EBUSY)
 		return ret;
 
+	if (trace_genpd_power_off_enabled() && !ret)
+		trace_genpd_power_off(genpd);
+
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 	if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
 		return ret;
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index f7aece721aed..d92cb53c20ed 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -7,6 +7,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/ktime.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/tracepoint.h>
 #include <linux/trace_events.h>
@@ -529,6 +530,36 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
 	TP_ARGS(name, type, new_value)
 );
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS
+DECLARE_EVENT_CLASS(genpd_power_on_off,
+	TP_PROTO(struct generic_pm_domain *genpd),
+
+	TP_ARGS(genpd),
+
+	TP_STRUCT__entry(
+		__string(name, genpd->name)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, genpd->name);
+	),
+
+	TP_printk("name=%s", __get_str(name))
+);
+
+DEFINE_EVENT(genpd_power_on_off, genpd_power_on,
+	TP_PROTO(struct generic_pm_domain *genpd),
+
+	TP_ARGS(genpd)
+);
+
+DEFINE_EVENT(genpd_power_on_off, genpd_power_off,
+	TP_PROTO(struct generic_pm_domain *genpd),
+
+	TP_ARGS(genpd)
+);
+#endif /* CONFIG_PM_GENERIC_DOMAINS */
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.23.0.444.g18eeb5a265-goog

