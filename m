Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85DDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797B0216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhdXMvF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfK1QuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46277 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK1QuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:09 -0500
Received: by mail-pf1-f196.google.com with SMTP id 193so13355019pfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3gfqS5lOXPiWWEEMhIxCyyS+fLBSJCNPeR6VbsvmT98=;
        b=jhdXMvF7E8/2RYD6Amz40/5Dec9vo4TrYTFm/r6nKztuLd4EU47wPRpIEnVGukrPq9
         6KJX/Lx31gcsN472LKTKhC9qqVht7WRMvzIuEkgW84gnYt1Q1V5qsybFpoRhsKZYSaZk
         D8zz/gLD9NiXIi51FQrr8I1tiAgYXwIfUVNtoINE4E40elNOWuicMEf8RRSLfBou5lMD
         21OIJW3h2SLpS3astqaYv2D1m65ILNsIQBe50CNQUvHJ8zlw4lYds5HZrqh88S3ZtnkY
         pMwWQeWqjtQaCpV7SrSyzXfsgvRuVQTusIn9jJ9kHRDKOfFhlkKAT3ImyVmHC6nCcJWO
         XvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3gfqS5lOXPiWWEEMhIxCyyS+fLBSJCNPeR6VbsvmT98=;
        b=LmRb/57HaUKdKqZlzyOwspPzeNuktlcDnwHcIPlwGfZQSTPxE6/L9om5bVfFdsl/rz
         +Hb3V0NM4PPSIDI3A/X81p7XF8rbCVR05THSUCmTWrLhWChAVTDqoZE/4zf7ruilIa+9
         LKSRUavqNCJdFXj0mOuOCyOdWoFANRzJEN0dv5g7fKnCb0kot7lEIYGeGAh2kR/PFHB/
         n9xGh99/GCiDV/CJuiw14V+JgcsepxzcuzfmgTf4CY139V6YdeUPbc35LF6sv4EYw62m
         6rmJ4iOXC7hPPi95IvWYtAygE3SYp5Z2L8EdrlOplyLCbcRfzgY8lt6WfUKbe/DlM7ke
         IN+A==
X-Gm-Message-State: APjAAAXVm9PL7B2RniS2xG5usrydx2fUjZ0hmq1EoqjmctHPtayGlU4U
        5K9j0spKJUwXdiFQRYXtscv8oA==
X-Google-Smtp-Source: APXvYqx6xtWr8g9E9T/1JwgyO6jqtT8i4Z+88FKARM8SdyHi8DyEUM3pVBEuVW/Q2yGOKIuP1ovK8A==
X-Received: by 2002:a63:e84d:: with SMTP id a13mr1089909pgk.193.1574959808249;
        Thu, 28 Nov 2019 08:50:08 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:07 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 04/17] media: stm32-dcmi: fix check of pm_runtime_get_sync return value
Date:   Thu, 28 Nov 2019 09:49:49 -0700
Message-Id: <20191128165002.6234-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugues Fruchet <hugues.fruchet@st.com>

commit ab41b99e7e55c85f29ff7b54718ccbbe051905e7 upstream

Start streaming was sometimes failing because of pm_runtime_get_sync()
non-0 return value. In fact return value was not an error but a
positive value (1), indicating that PM was already enabled.
Fix this by going to error path only with negative return value.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index d86944109cbf..18d0b5641789 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -584,9 +584,9 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	int ret;
 
 	ret = pm_runtime_get_sync(dcmi->dev);
-	if (ret) {
-		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot get sync\n",
-			__func__);
+	if (ret < 0) {
+		dev_err(dcmi->dev, "%s: Failed to start streaming, cannot get sync (%d)\n",
+			__func__, ret);
 		goto err_release_buffers;
 	}
 
-- 
2.17.1

