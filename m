Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E6BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FBF2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 22:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EGMA1Inp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfIZWE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 18:04:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35042 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfIZWE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 18:04:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id y10so214923plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FyI5Ob9ZI7/mzKeLeISYFxnQEPANV+hWHjQ4mCtD6v0=;
        b=EGMA1InpKl0N7i7io7mlYWg64F5h4NsR4AZywCxMiEWXPB2wDUxjwzE5bGdAUVotqJ
         vj4aWqmmPJxfXupZCcWK0zhSnC2JTWtItUJZZZpHux8pyEwBkata5jS/WHH7oEHCsq5K
         hvbQwKJIHPIHEbUrdIA8o56johVCCqA+m9pZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FyI5Ob9ZI7/mzKeLeISYFxnQEPANV+hWHjQ4mCtD6v0=;
        b=PNymCsiuFAZMXdHYO4h8Th1tMOE8ErTpoiFOodhL0uS66HsH56FzirInUd5aoLd015
         Vj/lAk7HTuwyg6oX5UrO7o7jkOPxsvjcPK7DPAaw8ZCvCuC0+PQJ8Y10GB196nN3qL3f
         zUIj/QmVWE/6Ro8brZZAEukYQnBidXL8OBs2BaFdfc/68Mr+9yF/7Z26ddp+aYsXbQTv
         PPeyxDKCycS5yWSqbYZUnxds+NRnBS8Lzg7Bn5QVn2PqFPPQFRGwVNbP3shJtivBMat6
         CAbi0mK7tn7kKOzj1n8t6kMCvfLqKw8JmxfOkmD3gZWyiMywdghhFytIFIDSkfF+ZOmU
         6geQ==
X-Gm-Message-State: APjAAAUsXU9dp1A7CjxbLYaCfJOluH82N1T6gBe2FfZ7hfHpNgUy+btq
        ukoCVkI481LOoQebfn4H3VlG0g==
X-Google-Smtp-Source: APXvYqzUAHtK2cPMT4htbHMczPwuIQ44aVHsSlSiREiRUU2arpNMe6WceNA3tLjbmoinVkIv4AHtfA==
X-Received: by 2002:a17:902:5a01:: with SMTP id q1mr852910pli.335.1569535495418;
        Thu, 26 Sep 2019 15:04:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n3sm248418pff.102.2019.09.26.15.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 15:04:54 -0700 (PDT)
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
        Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] PM / Domains: Add tracepoints
Date:   Thu, 26 Sep 2019 15:04:38 -0700
Message-Id: <20190926150406.v1.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define genpd_power_on/off and genpd_set_performance_state
tracepoints and use them.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/base/power/domain.c  | 27 +++++++++++++++++---
 include/trace/events/power.h | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cc85e87eaf05..aee988c112e5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -21,6 +21,7 @@
 #include <linux/suspend.h>
 #include <linux/export.h>
 #include <linux/cpu.h>
+#include <trace/events/power.h>
 
 #include "power.h"
 
@@ -329,6 +330,9 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 		goto err;
 
 	genpd->performance_state = state;
+
+	trace_genpd_set_performance_state(genpd);
+
 	return 0;
 
 err:
@@ -418,14 +422,21 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_on)
 		return 0;
 
-	if (!timed)
-		return genpd->power_on(genpd);
+	if (!timed) {
+		ret = genpd->power_on(genpd);
+		if (!ret)
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
@@ -448,14 +459,22 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_off)
 		return 0;
 
-	if (!timed)
-		return genpd->power_off(genpd);
+	if (!timed) {
+		ret = genpd->power_off(genpd);
+		if (!ret)
+			trace_genpd_power_off(genpd);
+
+		return ret;
+	}
 
 	time_start = ktime_get();
 	ret = genpd->power_off(genpd);
 	if (ret)
 		return ret;
 
+	if (!ret)
+		trace_genpd_power_off(genpd);
+
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 	if (elapsed_ns <= genpd->states[state_idx].power_off_latency_ns)
 		return 0;
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 7457e238e1b7..de56cd1e8d0d 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -7,6 +7,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/ktime.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/tracepoint.h>
 #include <linux/trace_events.h>
@@ -525,6 +526,54 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
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
+
+TRACE_EVENT(genpd_set_performance_state,
+	TP_PROTO(struct generic_pm_domain *genpd),
+
+	TP_ARGS(genpd),
+
+	TP_STRUCT__entry(
+		__string(name, genpd->name)
+		__field(unsigned int, state)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, genpd->name);
+		__entry->state = genpd->performance_state;
+	),
+
+	TP_printk("name=%s state=%u", __get_str(name), __entry->state)
+);
+#endif /* CONFIG_PM_GENERIC_DOMAINS */
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
2.23.0.444.g18eeb5a265-goog

