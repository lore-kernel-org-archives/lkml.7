Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171FAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C5520693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IE8Ds0UE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfDSSxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:53:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53601 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfDSSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:53:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id q16so7103150wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ce+xsHXl4yFXBVy1VUWq5FJ/Ala/Os2pJsWh4xCgH2Q=;
        b=IE8Ds0UEUpH1f+3I6uwelgIIq26MWuAaBjFXVFvqp0hUyWENlu7GgR+VSATdjFczq+
         a7vz1MIpVKHX767N8pRQovw7XNRECSOx5GUUC+8Ca/lQaopQ2l258H1JlwxoabzPtM8b
         grZPsuCzCqTQF7t2RnZrdh8zLjlUzal5b64UHYh7ZMwl1LxFjB6ZosWOkyJKEtlp0cYD
         GhKmw5IPZdB2ParXTexHcEYHUyrFVQEREIvKrUg2pDiJFmMfodtZ+ViIbxGt9J0dZpYl
         3/Yl22r1W6/FAQdxpWIqafuO0evAhh6vdcygaSDBnqr4LbmAW7iFzUBtA1L89XigRGW/
         /i9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ce+xsHXl4yFXBVy1VUWq5FJ/Ala/Os2pJsWh4xCgH2Q=;
        b=aKiSzYXAAm08ctZS+MDhHTq0qmluNhDtZYsO1FpvfbMJeUh7LbG1LAuzXVcPkaJxfJ
         0f0AgTwPyjc2QHfQeAfmU75tC8vAtH0sJR5j1P2eGqsyPRJYEu++yU40cXQU4yW00GBx
         EHMt7nFFX78etAveMF+pdAS24s8lfVB0V9ApPBw/B8G7mLaDM0KBnYzT/4CcStnaNv0U
         YlRmZ4pazG0dUKZ/Debc95At2CW2KFPZFRm1b44J2ZE3YpGqZyr9SG4E2p1roRoBNuXG
         IQQBD4YpReeAUo/0FAQGOPzCLDWWZMFhI2U3tobLgX7X0DmPjFsT4/v3lGMciyGCM/gV
         uk+g==
X-Gm-Message-State: APjAAAW1R8cEV0Fx5zd6tQ5OjEPmiPrBh1r4y8RH6zxANahN0dS6tKmK
        lpNk1CDS7y2ekaqd4OJN/3FB8D2bbJs=
X-Google-Smtp-Source: APXvYqxHCiejcT6tfcxtXdLG5uPOoyx8wHXcYqizHu+I/8l6MFuXaHqJKEsT1gnEHkdZKqtfL7vAoQ==
X-Received: by 2002:a1c:185:: with SMTP id 127mr1758875wmb.145.1555662910901;
        Fri, 19 Apr 2019 01:35:10 -0700 (PDT)
Received: from localhost.localdomain (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id t76sm5700147wmt.8.2019.04.19.01.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 01:35:10 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de,
        xuwei5@hisilicon.com, mturquette@baylibre.com, sboyd@kernel.org,
        yuq825@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, lima@lists.freedesktop.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 6/6] drm/lima: handle shared irq case for lima_pp_bcast_irq_handler
Date:   Fri, 19 Apr 2019 09:33:01 +0100
Message-Id: <1555662781-22570-7-git-send-email-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
References: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Hikey board all lima ip blocks are shared with one irq.
This patch avoids a NULL ptr deref crash on this platform
on startup. Tested with Weston and kmscube.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Qiang Yu <yuq825@gmail.com>
---
 drivers/gpu/drm/lima/lima_pp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index d29721e..8fef224 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -64,7 +64,13 @@ static irqreturn_t lima_pp_bcast_irq_handler(int irq, void *data)
 	struct lima_ip *pp_bcast = data;
 	struct lima_device *dev = pp_bcast->dev;
 	struct lima_sched_pipe *pipe = dev->pipe + lima_pipe_pp;
-	struct drm_lima_m450_pp_frame *frame = pipe->current_task->frame;
+	struct drm_lima_m450_pp_frame *frame;
+
+	/* for shared irq case */
+	if (!pipe->current_task)
+		return IRQ_NONE;
+
+	frame = pipe->current_task->frame;
 
 	for (i = 0; i < frame->num_pp; i++) {
 		struct lima_ip *ip = pipe->processor[i];
-- 
2.7.4

