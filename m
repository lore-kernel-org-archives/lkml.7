Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A06EC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E700C20645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p95qrKiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfF1NAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:00:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36665 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfF1NAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:00:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id u8so8903075wmm.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oUEPxm1s2pNTl1RMVnFyWLgDVOKHDfwRN3bZ9Ot2lWE=;
        b=p95qrKiI3YOtkKudIPDQzpYO0O8PwTpqopnFAPDzfuMoxL6E+QWqQZJTaA7IQgDchm
         IJvhMeIvK2D8JQNVKzS/XZfyvmG51tzoyitRRjUnU2Yi4GPt+Eg42bzmgnNH9zk4w7Pv
         zryeAsHfYaWKaClc0kzoe5NpVZvy9pCNHjbQuHtJv5ySqmzhV1FfIlBMp+asnAmK2RBT
         t7+I+3zwoNuDOdr3sIwGJR5TSWtC6+MFGZqTQnBY/LcTil7YVtKmFmjzxLPVGofUoWHc
         zpKZRrg7MjqcNXJWk2uPVz2tmwZ5OAILBuo5mRQszKgqx+L6mIR1HkvjaUX0R8a9WcAz
         O+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oUEPxm1s2pNTl1RMVnFyWLgDVOKHDfwRN3bZ9Ot2lWE=;
        b=F/fsdZuroqNX1PjvCEMDImVr53q3Khxh/LwIeMe8w3kNXXc9DiHeU/T9xP69W/r2U6
         nODghVbHRqUuXbjUwzYzt7JsYCdkJqjatmKwsB2MfAi2NJV3MqbuVr+a3xsON+OXRBdN
         3LQeEhVWVk35Wprh5kclxNrwY3ljyLWqH43BmwkSQAI2XfmduzdqSRG+dnKNEmxtyche
         jV4En08u96xNAgALn/eWPUlSn/SxFqWhKZkt3sS3sBMZoPM7ech3kbJLG9CTau5ZvMT0
         E7h0kOu674JkyGLuTvDiFOh0E138tj44fmMtWPyx/Nd+Ubg2wQOu8gDzKSnWZKBfP9U5
         7X/A==
X-Gm-Message-State: APjAAAWy5u+Z7DzBD9mAcSHPZu8KOpsbsmiposGwOP1fiwtrpSqfvpVK
        OrrD9/i7/BY3/xfYJNmuG50P3A==
X-Google-Smtp-Source: APXvYqxEDUdOTSqSptts47Vg24TP63DKgXAsYBkhomnbpcBEDLwA21cDhnmoGAsTxyrmq1s+NbQnLQ==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr7373902wmc.95.1561726842636;
        Fri, 28 Jun 2019 06:00:42 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id w20sm3717174wra.96.2019.06.28.06.00.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 06:00:42 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 10/11] venus: helpers: handle correctly vbuf field
Date:   Fri, 28 Jun 2019 16:00:01 +0300
Message-Id: <20190628130002.24293-11-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628130002.24293-1-stanimir.varbanov@linaro.org>
References: <20190628130002.24293-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct handling of OUTPUT buffers field and make v4l2-compliance
happy.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 176facdd415d..c948c4e809b5 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -998,6 +998,17 @@ int venus_helper_vb2_buf_prepare(struct vb2_buffer *vb)
 {
 	struct venus_inst *inst = vb2_get_drv_priv(vb->vb2_queue);
 	unsigned int out_buf_size = venus_helper_get_opb_size(inst);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+
+	if (V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type)) {
+		if (vbuf->field == V4L2_FIELD_ANY)
+			vbuf->field = V4L2_FIELD_NONE;
+		if (vbuf->field != V4L2_FIELD_NONE) {
+			dev_err(inst->core->dev, "%s field isn't supported\n",
+				__func__);
+			return -EINVAL;
+		}
+	}
 
 	if (vb->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
 	    vb2_plane_size(vb, 0) < out_buf_size)
-- 
2.17.1

