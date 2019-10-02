Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1079C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FEE21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gbpUqrW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfJBShy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:37:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39302 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfJBShx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:37:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so143145plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNovxVKu/GraUWwguMxsijijnyMSGCiZNixAkZg3ZPc=;
        b=gbpUqrW6UQVF5gtd6cmjBJQ/FJPxYDkUfiISNx0FtcRl5Wm3TVOxGXqq9/twCLZvHN
         uqzDxdigX8Lk5q1LOKDLSSgATs1g05cM3ScdGLjhCE2OoB3kfisa4qK8TcR66oInxHmr
         iolsTU9QFBNPE5rkDXTFwVAOoFvcsb5g0DF3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNovxVKu/GraUWwguMxsijijnyMSGCiZNixAkZg3ZPc=;
        b=ckCi4Xac5xdKJ1xgYKTsHCwS3trpgfKqWyeXYQJ55UUioy20R580khAkqnDM4M0xJT
         U+Vj6JrU0GOgnwFM/CvhFQV2sDvYlZg4QJdgW0hQv6iTiq90Rc3pJJqVb6tIXBYa+aU2
         IuHMlt2EhpHh/WQx8x8AVlz54pc7+Sr6o6NLWF6YP131/PjCHyb/myMyx39sH6yU/TtQ
         H03BsbzlHjV2ebntWPWLPxkwSu8gs6KmoSt6phyf9CCiOURzZGJ9aAEmVyaztJtaQgVR
         +UNVohihqPoAZr/3u+1podA6pT6AlyM8/eQTw02+mnxLcVnUOJ9wVsPyvzN0x5EdOLY6
         RnhA==
X-Gm-Message-State: APjAAAU6C0oI62EnGZ8RWrnLf9VfP6ALwIvVhCG4OvSG2kY60cqG1aby
        k6r9QoM1+yUBCIYPwd2K0RrSzA==
X-Google-Smtp-Source: APXvYqw5LSPiUMD/zYmaDgpBkxUHpC6NFYfd0t/r6Kfw+63kgfrNAEYNCRQwWP9esOAKitLCeSBsrQ==
X-Received: by 2002:a17:902:bb87:: with SMTP id m7mr5174146pls.179.1570041471486;
        Wed, 02 Oct 2019 11:37:51 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id w6sm192916pfj.17.2019.10.02.11.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:37:51 -0700 (PDT)
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
Subject: [PATCH v2 2/2] PM / Domains: Add trace event for genpd_set_performance_state
Date:   Wed,  2 Oct 2019 11:37:43 -0700
Message-Id: <20191002113736.v2.2.I366ab5442f66ddff643948c6923cc6916ddfd840@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191002113736.v2.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
References: <20191002113736.v2.1.I07a769ad7b00376777c9815fb169322cde7b9171@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracking the performance state can be useful for
debugging/understanding power domain behavior.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- split original patch in two, one for genpd_set_performance_state
  one for genpd_power_on/off
- updated commit message (original subject was "PM / Domains: Add
  tracepoints")

 drivers/base/power/domain.c  |  3 +++
 include/trace/events/power.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 88eff9c4e79a..1130b984808d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -332,6 +332,9 @@ static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
 		goto err;
 
 	genpd->performance_state = state;
+
+	trace_genpd_set_performance_state(genpd);
+
 	return 0;
 
 err:
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index d92cb53c20ed..2c2c7bb5bef0 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -559,6 +559,24 @@ DEFINE_EVENT(genpd_power_on_off, genpd_power_off,
 
 	TP_ARGS(genpd)
 );
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
 #endif /* CONFIG_PM_GENERIC_DOMAINS */
 #endif /* _TRACE_POWER_H */
 
-- 
2.23.0.444.g18eeb5a265-goog

