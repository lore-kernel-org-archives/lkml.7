Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951B9C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECD82089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="OM2ocL11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfJNUVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:21:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41116 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbfJNUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:21:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id v52so27201936qtb.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 13:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=adO3s5rQ80FSe9QoQi3APfXKvpPGONNAIqngjG3oV3o=;
        b=OM2ocL11y852dXCVsBTTpuenXy1lATvJseKhiuvI5VqKrW3eLE0ylQgP0sVpJYLMqj
         V+5p0nSCH5rtm5LMxJzk63qUpR9mCtXx/XbgvaoScxUOnwO1xOeUhezLjlq9KtPDfKhp
         vZt862J+CI1qdnKRiqLlUUFrbhGYwtFxs9oqYKQNKoI2lXWl7HSZKymNsU/OF/Bfc7+x
         BsWoW55x/FwsLR7uau3VLSwUPAbwkHiJS4+jHjDuNNCHRSOwePUqK9KYfadOZ6LEp7xE
         tuL3rbh5/VA/0sWCOxYlL7n3oaUiY26/ltdD2omqJQqg0Y3NHy1m5E1Fnd29cPO8IvcU
         tuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=adO3s5rQ80FSe9QoQi3APfXKvpPGONNAIqngjG3oV3o=;
        b=GIHBIoUEeg8iZ2Y5TlxzB0B0JsZbIES235mfCeodW9RswBWvBEUyS706bDtFfjEaT5
         nipVQ9VxOhgGsdW39IBwIoBoi+DtfNHFOSU5xDvKLd5z+DeskDxGC4s8mOEm1heHLBUE
         WF+W1MbU0A3N7JS5zFkV6n2Otvir/MtKAmy1TB66bzTT3TyRMJkVcoQY4nYTmvSbxAm+
         eIMBK/CCN7+3S75dCFm6Rk2LRvI4LBViGFRS0DYqrXIYLnEowoR8tEoYOy8RWbGUEkP8
         E+RFzH7tL7F/bpdFeIHM5MBxKMrgmyNkNUOd4B9ZwxVoUVw3JcoHhUm8qsRV1ai9NeUK
         fVXw==
X-Gm-Message-State: APjAAAUlsVdOg8O2i1YPQ07X5zIfl2vlzRldusMw8D6qmgiMDo+hNyow
        Y4/i/Cdvop0G6BU6VV/CeZ+uUQ==
X-Google-Smtp-Source: APXvYqyIGxVirj24b/z7N8sIuYFghEnsbiFVPx5jPEWYM5oEfLgLlBoX9K22BMNQM88asTUBLjrE6A==
X-Received: by 2002:aed:3e45:: with SMTP id m5mr3983673qtf.268.1571084497370;
        Mon, 14 Oct 2019 13:21:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id y58sm11111472qta.1.2019.10.14.13.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 13:21:36 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@microsoft.com,
        thiruan@microsoft.com, bryankel@microsoft.com,
        tee-dev@lists.linaro.org, ilias.apalodimas@linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: [PATCH v2] tpm/tpm_ftpm_tee: add shutdown call back
Date:   Mon, 14 Oct 2019 16:21:35 -0400
Message-Id: <20191014202135.429009-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add shutdown call back to close existing session with fTPM TA
to support kexec scenario.

Signed-off-by: Thirupathaiah Annapureddy <thiruan@microsoft.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/char/tpm/tpm_ftpm_tee.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 6640a14dbe48..ad16ea555e97 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -328,6 +328,19 @@ static int ftpm_tee_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/**
+ * ftpm_tee_shutdown - shutdown the TPM device
+ * @pdev: the platform_device description.
+ */
+static void ftpm_tee_shutdown(struct platform_device *pdev)
+{
+	struct ftpm_tee_private *pvt_data = dev_get_drvdata(&pdev->dev);
+
+	tee_shm_free(pvt_data->shm);
+	tee_client_close_session(pvt_data->ctx, pvt_data->session);
+	tee_client_close_context(pvt_data->ctx);
+}
+
 static const struct of_device_id of_ftpm_tee_ids[] = {
 	{ .compatible = "microsoft,ftpm" },
 	{ }
@@ -341,6 +354,7 @@ static struct platform_driver ftpm_tee_driver = {
 	},
 	.probe = ftpm_tee_probe,
 	.remove = ftpm_tee_remove,
+	.shutdown = ftpm_tee_shutdown,
 };
 
 module_platform_driver(ftpm_tee_driver);
-- 
2.23.0

