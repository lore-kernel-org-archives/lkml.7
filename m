Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27025C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A3D222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jIJuwHz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbfIRTPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:15:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45428 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfIRTPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:15:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so599902pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QznQIsPmRQMTWr3DobEVwSUb3hfFyooPIqDVOigxW3s=;
        b=jIJuwHz8AdTaWAM5jnpAzJ02psVnIIc4slG2c/uH5RccAy8CfRpIJanIH4RBdZ/+Si
         Mn/wuxFm/JTNz/xOGFzK/qKIcQD8/JL+6H1BN+qdGp7HFiclukD7wuyDMwkZSOXb6DmR
         7PQ8sZ0wrD8g2jvaht5ukMjhTk/YXFwZz+Tp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QznQIsPmRQMTWr3DobEVwSUb3hfFyooPIqDVOigxW3s=;
        b=OBRWYeaziYHeer+44RvlVFI0zUTMzH3vSfZ/TfEyOIrmOeJ4C1qnY7g07IYRc7yUly
         SHepTCeN9a+gNGnSbfKETD6yAXeYD+atBpeJD569CMZa7PdTDflx6UMTw+r14+t0ANS6
         p/PE5WiWC6niaHumGC5uOdCwCUU+qLWdQR0xPrtp0mO1r2DC/Ufh1tDwYcJDW2SepOtI
         deodZ+I0NlzDep1TKJ432wDnIKSQLRPUdP4RxYHceeXrpe8xGfKvnE511BcMZoWUelgu
         Rv/aRt26/zeWWSduqpNMBfql9YxncTuUUoOAlFs9o9t3WsOhTJXopOyUFqHf6Pa4Itm3
         85+w==
X-Gm-Message-State: APjAAAXaa1nQ36lseGvBG7yTNkAWieb772xfv/hhWORunhYqJ0aoRTB3
        g/w5eaj61730UFS+1cafwA5qNQ==
X-Google-Smtp-Source: APXvYqzIQRCO49+6U77cxewbCNKEeb29tgMkR0EvOQ6K/XWN59+iP3LwRtrnuP6dmDLPhgjsXewdGw==
X-Received: by 2002:a62:7646:: with SMTP id r67mr5940551pfc.116.1568834143043;
        Wed, 18 Sep 2019 12:15:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 195sm8847705pfz.103.2019.09.18.12.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 12:15:42 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] devfreq: Add tracepoint for frequency changes
Date:   Wed, 18 Sep 2019 12:15:37 -0700
Message-Id: <20190918191537.48837-1-mka@chromium.org>
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
 drivers/devfreq/devfreq.c      |  3 +++
 include/trace/events/devfreq.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ab22bf8a12d6..32de1f6ac776 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -317,6 +317,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 
 	devfreq->previous_freq = new_freq;
 
+	if (new_freq != cur_freq)
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

