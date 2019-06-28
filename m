Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038E6C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0489208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOqIunXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfF1NAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:00:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51656 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfF1NAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:00:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so9031874wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/R2v+8TpXScwDvoUwTQ+DYnf6CWYu7956kORYsc7udM=;
        b=MOqIunXyl2CU/i32HIF3+ixSLh9DS96LVGO5I+JmUdbfMibDIDbmg+sRsWopc8cgCE
         9qtE+tC7H6BydqLvfRkmzFaNO/ol+OmjNzlNZXWudGpw6l7n46EHluju0TVVqqbDiO5+
         aKma7viTE1x6DUn5NOFpD/X1hliLP5Je23Y7x7S2p2zKo29VdrQ2YP4diZzxjp+LkYrp
         nPAHlRoSTOGRaTPpFKWlYdSvzMC2IPFSb9gx9u3kaoi8lUSmXstXQbcQxwE5FyS/SLo9
         4y/qCLg/ijGyWWGzyioBt83WGDxsnTvLsT1FrzEO5w36K2bQglWkh3sWUB3ueot2hDwX
         hkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/R2v+8TpXScwDvoUwTQ+DYnf6CWYu7956kORYsc7udM=;
        b=CGanxm5uduYvztlkSMD4BOPJkoRKjv2MHFlTRWQjJbXoAWM8Ve8BAgO+yLGLlqfJOk
         GJ7iKfIJ4rEG4VtXUa11DV/wKqTHcQ1QS9Ay+46ooN74NcLRe3DCYZvPI6y2sj6UOvmL
         6Qnf8WOGrgWdNeJXDaGUBuzSF0moxx2v47gXOpiUJVxBu/tSCN97Y0eOqqLP9Ef6MoPa
         OhCH4fLLymocpTnYlPmMNXPWKx/TKZQ2vjsfw5d20UKNvnGrPkhejALldOnRa1/d/AUS
         R1KQx5TFhqyW/r7kvAbJRagmL7BKXYlZ/HLphmKS/uLNN7IgowF3dWCfPzHouFNzrjem
         efOg==
X-Gm-Message-State: APjAAAWPsMbX8/Y9NE+0Aj2tHQfnjwnUlPwgS2tCsBNWF71/2Mi3Toem
        oBvUaRM8VyIsP5htjcoQuzqtWA==
X-Google-Smtp-Source: APXvYqzjUM9HPfSq1Rl5vK8m3SrIQAbqkdvVWKrAMIcQ1R9Y0NuwqXMn990yjFW21GfpYI4dun5zUQ==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr7006239wme.157.1561726835808;
        Fri, 28 Jun 2019 06:00:35 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id w20sm3717174wra.96.2019.06.28.06.00.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 06:00:35 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 07/11] venus: vdec_ctrls: get real minimum buffers for capture
Date:   Fri, 28 Jun 2019 15:59:58 +0300
Message-Id: <20190628130002.24293-8-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628130002.24293-1-stanimir.varbanov@linaro.org>
References: <20190628130002.24293-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now we returned num_output_bufs set during reqbuf but
that could be wrong when we implement stateful Codec API. So
get the minimum buffers for capture from HFI. This is supposed
to be called after stream header parsing, i.e. after dequeue
v4l2 event for change resolution.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec_ctrls.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c b/drivers/media/platform/qcom/venus/vdec_ctrls.c
index 300350bfe8bd..3a963cbd342a 100644
--- a/drivers/media/platform/qcom/venus/vdec_ctrls.c
+++ b/drivers/media/platform/qcom/venus/vdec_ctrls.c
@@ -7,6 +7,7 @@
 #include <media/v4l2-ctrls.h>
 
 #include "core.h"
+#include "helpers.h"
 #include "vdec.h"
 
 static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
@@ -38,7 +39,9 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct venus_inst *inst = ctrl_to_inst(ctrl);
 	struct vdec_controls *ctr = &inst->controls.dec;
+	struct hfi_buffer_requirements bufreq;
 	union hfi_get_property hprop;
+	enum hfi_version ver = inst->core->res->hfi_version;
 	u32 ptype = HFI_PROPERTY_PARAM_PROFILE_LEVEL_CURRENT;
 	int ret;
 
@@ -62,7 +65,9 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 		ctrl->val = ctr->post_loop_deb_mode;
 		break;
 	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
-		ctrl->val = inst->num_output_bufs;
+		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
+		if (!ret)
+			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
 		break;
 	default:
 		return -EINVAL;
-- 
2.17.1

