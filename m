Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F98C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0152063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwm/QQvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfCGKNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:13:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44965 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfCGKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:13:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so16701087wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tIvmnq/sBI2toQzFNBq1UWBjHh7Rzax6iQto5A1QPn4=;
        b=jwm/QQvVT820lCl/gDoXVSyfY49C96sNHRAx6goCkxIRuQjhbxGY2YzDjLN/Phxihs
         pDGD0+vlMvxsVVnqPvV0oQfLnTgAt36yCGbbRJm59/802ESMlGNwaEHwiGRyTUVPd9dN
         VGNu3Y0xoGzaDTqXeuSQFpmY+okIlsdT/8KKWjqH0GhNtg8DclT/umfe7k4RV2mXJw2k
         r+5RNAYi1CtNhPJXyQg3BLyHyiyVABjpQJ/9W86jfQNBn00k7zpQzQf9Pcv9bANIXLkX
         Qx0tH9023PoEG9eUMZXYCNyVeKcafnbeItRGu00II2U231wYij/5rW7RMdzmqaMMgDS/
         31Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tIvmnq/sBI2toQzFNBq1UWBjHh7Rzax6iQto5A1QPn4=;
        b=LhzZGGJ1K8U7zkRwcxkdIHRjQ1zhv76uQ24Jx/1oxJdgEeWNcB99LjT8kOIXx7BdJb
         k7e8A9K8TDsXjOuOyRGfBYfYBK57HvGF+RrhBJeHMu3JJaDJF9JcoYPdkKe60/DDEOBb
         Kk0xsxJZXa76E/y+u2Q/2dXAo0jJ8XlNwW+X5RpuYc7j14s8kLME/f35oLef5GNRN3ji
         Da7/dkMJll22+g5swV+ZE2Ket4DRe8NCRkMZ1jEfxLBn6CbQFJB9Az4rkecL8JOr9hz6
         xWOMKXGhTSAVSdj9wYan8L4Uxx/NU8e0dzW04Dj9IboyH8BSu3dfu8UsOtc+iMwMIb4r
         QUbg==
X-Gm-Message-State: APjAAAV/dbvwWMYecuRaE6jZjua7mVoNhHkRIlr3t04UwyO/Uqe17Q/q
        t1sTUUzS6NS6pmRtG/hwXu5omQ==
X-Google-Smtp-Source: APXvYqy2aAkZJBhpznOXDFapiFZtCEtsFJs2EXG2wBhgWuXQcZmJGVQlsZBbRqy+O46tm/IBclZ0bw==
X-Received: by 2002:adf:e949:: with SMTP id m9mr6640281wrn.1.1551953598190;
        Thu, 07 Mar 2019 02:13:18 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n9sm3529767wmi.33.2019.03.07.02.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 02:13:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        ktadakam@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/8] misc: fastrpc: make sure memory read and writes are visible
Date:   Thu,  7 Mar 2019 10:12:24 +0000
Message-Id: <20190307101229.7856-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
References: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_alloc_coherent buffers could have writes queued in store buffers so
commit them before sending buffer to DSP using correct dma barriers.
Same with vice-versa.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8fbcc607a77e..753d62ceb1fb 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -792,6 +792,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		if (err)
 			goto bail;
 	}
+
+	/* make sure that all CPU memory writes are seen by DSP */
+	dma_wmb();
 	/* Send invoke buffer to remote dsp */
 	err = fastrpc_invoke_send(fl->sctx, ctx, kernel, handle);
 	if (err)
@@ -808,6 +811,8 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		goto bail;
 
 	if (ctx->nscalars) {
+		/* make sure that all memory writes by DSP are seen by CPU */
+		dma_rmb();
 		/* populate all the output buffers with results */
 		err = fastrpc_put_args(ctx, kernel);
 		if (err)
-- 
2.21.0

