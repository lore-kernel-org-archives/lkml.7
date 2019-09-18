Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1E7C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D8421920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S31B2pEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfIRRTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:19:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39138 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732142AbfIRRT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:19:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so219361pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o8jBbFMTRVOLRjVfPalAAvaLLhvjkkI5HoxGIVyvU8o=;
        b=S31B2pEsbk+z279WHVu2T3GrmYwNDVVVEi/rj5HIvyV6nVgECY/7RfHJ/xSGEt3k8s
         xShPMHY9cudQDZP2dH2wQvi5BLCnKKfojyVvVTmE40etR2gvyyljlHoYoi6uumzoghtX
         w9Z9vYHDU4Nr8o77x/MECD8F0zYjEGM0wGFN0W6SV4mPq4kePFnte+jMuBjO+V9Mk2y0
         PAcA8IRjRYXTcc9rvtEv5ImAlwMDeEupI6jzInysqLqlG72aANz/bomMqQVVysMA8gZM
         P5q4KvZmbHFyFK1W4gXjZrIhbNXctmumsmzN1F3DphKi2qR0jlIHMwLf4SO12NlkfTlY
         7LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o8jBbFMTRVOLRjVfPalAAvaLLhvjkkI5HoxGIVyvU8o=;
        b=EVpkrskpxYwMaXm+C9HFz4nkfGJYg+Mb3qYNnEPxVDYtNJN3b0iIf9sJNkHzCKqhER
         fQSiok5uV/+MNj9IquOexTlxPZkLqfnUfvZB/uPCfVktTT1dXpw8L0hrfWIg8qOTb2iF
         1rvZGuhepjCpueRd6xSv2VYNdzB3hzMiOtSP8wFdpW5IA8npflLPy2CFachbHBc5S8Hd
         lrp3HCzjZooaRgKjZXLZLElRA0UNDCPW4sSToljMkj4DeurZMavtkLVZUBYQNxRdoBPK
         R+4yEiUsPIyDFXeI5jiKdXE+fdqMplDwolFiFvr68aCj/VM4QMnjP46K8IW9MgeLEzeh
         VRJA==
X-Gm-Message-State: APjAAAWnrAwO66A/3e8NdzaNogHjOFEjVQlToPQXcrT5W46MEeUpAj9j
        KtlnKALVH/MWumpG9UiQfdhgWw==
X-Google-Smtp-Source: APXvYqz2NwfyeZRXxm7dgiBTjnJCh8SRsdzqxi1i88kaJsXr+YupiSXjV/8iuycHgXoZ1FvOMMG8Fw==
X-Received: by 2002:a63:34cb:: with SMTP id b194mr4926065pga.446.1568827167913;
        Wed, 18 Sep 2019 10:19:27 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y4sm2614981pjn.19.2019.09.18.10.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:19:27 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 6/6] rpmsg: glink: Free pending deferred work on remove
Date:   Wed, 18 Sep 2019 10:19:16 -0700
Message-Id: <20190918171916.4039-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190918171916.4039-1-bjorn.andersson@linaro.org>
References: <20190918171916.4039-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By just cancelling the deferred rx worker during GLINK instance teardown
any pending deferred commands are leaked, so free them.

Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_glink_native.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 0d7518a6ebf0..5920432e697a 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1562,6 +1562,18 @@ static void qcom_glink_work(struct work_struct *work)
 	}
 }
 
+static void qcom_glink_cancel_rx_work(struct qcom_glink *glink)
+{
+	struct glink_defer_cmd *dcmd;
+	struct glink_defer_cmd *tmp;
+
+	/* cancel any pending deferred rx_work */
+	cancel_work_sync(&glink->rx_work);
+
+	list_for_each_entry_safe(dcmd, tmp, &glink->rx_queue, node)
+		kfree(dcmd);
+}
+
 struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 					   unsigned long features,
 					   struct qcom_glink_pipe *rx,
@@ -1640,7 +1652,7 @@ void qcom_glink_native_remove(struct qcom_glink *glink)
 	unsigned long flags;
 
 	disable_irq(glink->irq);
-	cancel_work_sync(&glink->rx_work);
+	qcom_glink_cancel_rx_work(glink);
 
 	ret = device_for_each_child(glink->dev, NULL, qcom_glink_remove_device);
 	if (ret)
-- 
2.18.0

