Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DF3C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC162147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aStCg4Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfF1NAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:00:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46016 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfF1NAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:00:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so6174709wre.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GDdYN5kQt5oodJg9h0fQ+PGqnlQ6057Y5ThAbiMCFHE=;
        b=aStCg4HrF6BmAN5ZprxLweMHT3TIAHKj9unAhcfV7uHqCXxK/8cTWppGWhbH6ZIp28
         X1QPv8tS/qz0Nlfbj4S7cWYVVp7LxyG+w+c6yBHwIHX3raV4D1AfsFzmFUuBghwvbcFv
         b+W4geq0zgQs+TlGDuYDGhYHSWbOaXWX1d35Ijn1iH7mZcWV8bjjBoQo3AFPPkWcg1eW
         24QBV7tmPeX4wF/K953B6FL5UGulav6XLBmO+/XtUGvPCh42HQObW993Q35MrOM2mhxa
         7fHSc/28OoOlsMRatKMoqX1LuISEQ6/3YoixCLbhReBc7C4wC8aX16RVtlAOmpCJEZha
         30IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GDdYN5kQt5oodJg9h0fQ+PGqnlQ6057Y5ThAbiMCFHE=;
        b=fnt7VYx0I+waOMOlyI+Fz/3eKKgxBM2ZNgfEWBPwLdzP0kRacme+JIQtFyOGAlTwcg
         XQ18inWA1yuS8tNaWMh9+3pubtA9QR+IqLcw00iAmmSeBewxXPwcfRgkd+uGyj6CZOgA
         5UhH+3g5g2RWTXBbgryDdf6mGoFgBXlNgZmvRWCc41/TcVtd+aJ7tSROsc+QzxVwQxSB
         lfVf0xesJ9dVy+HBpmG9YWgAU9VXLZ6TSossbrorxgVhsEWJ16GEtRBc1fRaazg7745v
         QpdF+r0hi3xW3ZH6xq+l0Q5TTeYeBdCZY/3BLBG5jvIzQQurR3MOUWDTm3gYOeLcs1lU
         yyHg==
X-Gm-Message-State: APjAAAUiZc/gMMLSoVmQKeoxTO5CdnyB4cHFnxUMTBFSN8UUk+KCLEa5
        TV+GlVILNAEgT7eskbvhr16hsQ==
X-Google-Smtp-Source: APXvYqzAMjgfvkBAsqsXR2nTrtCLwi+m0gA4PqiKPkXUxBqR7O8NMRf7ciY88v3cOTrTAD5w1d/2nw==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr7602029wrj.272.1561726832700;
        Fri, 28 Jun 2019 06:00:32 -0700 (PDT)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id w20sm3717174wra.96.2019.06.28.06.00.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 06:00:32 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 05/11] venus: hfi: return an error if session_init is already called
Date:   Fri, 28 Jun 2019 15:59:56 +0300
Message-Id: <20190628130002.24293-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628130002.24293-1-stanimir.varbanov@linaro.org>
References: <20190628130002.24293-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes hfi_session_init to return an error when it is
already called without a call to hfi_session_deinit.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index 82eb889ab541..3d8b1284d1f3 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -198,6 +198,9 @@ int hfi_session_init(struct venus_inst *inst, u32 pixfmt)
 	const struct hfi_ops *ops = core->ops;
 	int ret;
 
+	if (inst->state != INST_UNINIT)
+		return -EINVAL;
+
 	inst->hfi_codec = to_codec_type(pixfmt);
 	reinit_completion(&inst->done);
 
-- 
2.17.1

