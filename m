Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0389DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBB5208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0RLeb0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfF1NBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:01:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53959 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfF1NAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:00:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so9039988wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pjpd4K5w40M9bgj2qf6kIU4rY0+8OHMdLQZZ7HAbvAY=;
        b=K0RLeb0OmILRaH2CZ+NQFp02nyKniVlM0wUXuTGYUTj+zax4tEho2JvJW3/T01SUPx
         E5QrmXbqe84laPUyXe3tFGvHWR5jKQdSThO2E8iNKBWQj/6m13MzrmrPk7iITNXTwbOx
         EYyAkQMKHi35A4uQEFbKCTX+Itj2KxIzLXrIIn0x0q6qG1ogfhATMC6wlE1jDpeeyz33
         C4jxqJsdTAfj5XrSgKL+5cLnL4oCp2PLxYW1G4MQ3AJ07kEVPW1HaEKJn3fass68vqi8
         E7DWLucOE8629dR6yzWVjXUt4B2Edr74iH4SZVbZ0LWt7fyfSYz40G5NN9sx7gBMHE9J
         t8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pjpd4K5w40M9bgj2qf6kIU4rY0+8OHMdLQZZ7HAbvAY=;
        b=nDl7N/8NtxGrw23XuL3sWOWyTrjCYnReX7CHGOjM4ScptjuDIRsf0iJPVREWA0pg0y
         HvhBVzUw4SuCRb0kmNvsb7lBTB/u74xwGbxJud1faxTQB7cO/2tcG3OiPxeENREsU5IJ
         RTJylVor3JAmx92Fc3mGhAyUc2QODncq/7Jt30BKUnuq7PlGd5oRmBHKr9tKjEJhq903
         R/co23umdLVHmk781v8HGfCX2AFruMo8+FOdJHxiGqLM0Ykk42ELbnn98wk3bJELFq5q
         Rm9YGLjJmQ/oWoTMN+dWZufquq9aIIASOjODb+w65ZBvBtq2N8oAjRPM73iHg22Gn0uS
         tLcQ==
X-Gm-Message-State: APjAAAVTz0rIQZodwi5sYjkc9CtUAd3F5DEE1E41hqmrL5p5XiFyVwsj
        BdoJKeuPcdScdiFF651RftVkZQ==
X-Google-Smtp-Source: APXvYqwiD1+HA+YiR3PauDB2BVEkQbp/tG13oPtpSqmsWbQNggDtHs29UDbrroOkGgyTVCI9AuVCUA==
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr7577395wmg.164.1561726829402;
        Fri, 28 Jun 2019 06:00:29 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id w20sm3717174wra.96.2019.06.28.06.00.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 06:00:28 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 03/11] venus: hfi: add type argument to hfi flush function
Date:   Fri, 28 Jun 2019 15:59:54 +0300
Message-Id: <20190628130002.24293-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628130002.24293-1-stanimir.varbanov@linaro.org>
References: <20190628130002.24293-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make hfi_flush function to receive an argument for the type
of flush.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi.c | 4 ++--
 drivers/media/platform/qcom/venus/hfi.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index 6ad0c1772ea7..7c5bf5cb32de 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -375,14 +375,14 @@ int hfi_session_unload_res(struct venus_inst *inst)
 	return 0;
 }
 
-int hfi_session_flush(struct venus_inst *inst)
+int hfi_session_flush(struct venus_inst *inst, u32 type)
 {
 	const struct hfi_ops *ops = inst->core->ops;
 	int ret;
 
 	reinit_completion(&inst->done);
 
-	ret = ops->session_flush(inst, HFI_FLUSH_ALL);
+	ret = ops->session_flush(inst, type);
 	if (ret)
 		return ret;
 
diff --git a/drivers/media/platform/qcom/venus/hfi.h b/drivers/media/platform/qcom/venus/hfi.h
index b121cb1427ac..855822c9f39b 100644
--- a/drivers/media/platform/qcom/venus/hfi.h
+++ b/drivers/media/platform/qcom/venus/hfi.h
@@ -161,7 +161,7 @@ int hfi_session_continue(struct venus_inst *inst);
 int hfi_session_abort(struct venus_inst *inst);
 int hfi_session_load_res(struct venus_inst *inst);
 int hfi_session_unload_res(struct venus_inst *inst);
-int hfi_session_flush(struct venus_inst *inst);
+int hfi_session_flush(struct venus_inst *inst, u32 type);
 int hfi_session_set_buffers(struct venus_inst *inst,
 			    struct hfi_buffer_desc *bd);
 int hfi_session_unset_buffers(struct venus_inst *inst,
-- 
2.17.1

