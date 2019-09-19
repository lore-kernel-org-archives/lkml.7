Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42D2C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C7F2196E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dvxGSeR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391038AbfISRod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:44:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45134 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389644AbfISRoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:44:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so2752064pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3My5rPHh+xjcOd2l7pqQvZ2Y4vTncIcNiQ5r2gPD9Zs=;
        b=dvxGSeR8Ydg/dXnySlo3RetI39tG54muvsHUyHd7LFJKCB59cubtut29fvPNR+xy7z
         FpjXlSf7grkgv+cJYFmDlqdmgD3RzdNgNSyNj7od0wEFrnTQ9CXInAUt50ADRikLbnxx
         9ObXnDj1dVEdrT+KayscSK+rFgSJ55natJrXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3My5rPHh+xjcOd2l7pqQvZ2Y4vTncIcNiQ5r2gPD9Zs=;
        b=P1EBAfZlUtAacbsmnKNaF94YIHKpolmWiz/XHsw/R9gnPktEQ6E7/dxwRIp7hoteeY
         z3KbM+1eg8Nhd8fGpS0yKitYBlhmvhwQjpVdXpvSardh8+zAm/BXwxYXHAVco1HQUmPI
         1UF5CwacBo5XYe0zZkLn4CMhEf+uoE+VeafoIV0bwxy7Vs4w+7fTLGqzCNz39Jugui2W
         jcif5V9nHvHznH207REA1FP113VekmjlKlOAeip6iXkSrH4zVdKIQdnYoy4DrbWuVHd6
         dUOF8uuqrFT15Lx3AsdlkEjgPbalU56OEChuPHUnpI1vVRJCrMw/WqGgK6HaQ/oFpdZX
         O1xA==
X-Gm-Message-State: APjAAAW5rP+43n+TLAH9lbLqIJCFyjqU0+zjMHuoFnrDDPRpeHfeS60w
        OhShMPrjk1P5VHJfXn2vfDmv5g==
X-Google-Smtp-Source: APXvYqyxoKXWC6PHbldInz20DTbKVvT5kKbs3tnLgXGeHJzM8Oj3iP1ra/anhoDfCzgz801+ueFjGg==
X-Received: by 2002:a17:90a:a6e:: with SMTP id o101mr5103405pjo.71.1568915072106;
        Thu, 19 Sep 2019 10:44:32 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x68sm10451453pfd.183.2019.09.19.10.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:44:31 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] devfreq: Add tracepoint for frequency changes
Date:   Thu, 19 Sep 2019 10:44:23 -0700
Message-Id: <20190919174423.105030-1-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a tracepoint for frequency changes of devfreq devices and
use it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
(sending v2 without much delay wrt v1, since the change in devfreq
 probably isn't controversial, and I'll be offline a few days)

Changes in v2:
- included trace_devfreq_frequency_enabled() in the condition
  to avoid unnecessary evaluation when the trace point is
  disabled
---
 drivers/devfreq/devfreq.c      |  3 +++
 include/trace/events/devfreq.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ab22bf8a12d6..e9f04dcafb01 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 
 	devfreq->previous_freq = new_freq;
 
+	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
+		trace_devfreq_frequency(devfreq, new_freq);
+
 	if (devfreq->suspend_freq)
 		devfreq->resume_freq = cur_freq;
 
diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
index cf5b8772175d..a62d32fe3c33 100644
--- a/include/trace/events/devfreq.h
+++ b/include/trace/events/devfreq.h
@@ -8,6 +8,24 @@
 #include <linux/devfreq.h>
 #include <linux/tracepoint.h>
 
+TRACE_EVENT(devfreq_frequency,
+	TP_PROTO(struct devfreq *devfreq, unsigned long freq),
+
+	TP_ARGS(devfreq, freq),
+
+	TP_STRUCT__entry(
+		__string(dev_name, dev_name(&devfreq->dev))
+		__field(unsigned long, freq)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name(&devfreq->dev));
+		__entry->freq = freq;
+	),
+
+	TP_printk("dev_name=%s freq=%lu", __get_str(dev_name), __entry->freq)
+);
+
 TRACE_EVENT(devfreq_monitor,
 	TP_PROTO(struct devfreq *devfreq),
 
-- 
2.23.0.237.gc6a4ce50a0-goog

