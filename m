Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8645BC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC8820868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAFnSfoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfFFMUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:20:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52911 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfFFMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:20:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so2216535wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=asAJiQP/IRl4DeWZX6k748CTJJdoYx8udJBOLV1Qu14=;
        b=FAFnSfoHFNgsixRqn8BM4LpuZR443gi3P1TMe4mOnjMtbxPSA0DAqDbBelJucokp7O
         jTWLWkxV1KWYZaWI5O+7PyQpW20xAsLNSDJkciZ51m3t0W6ozQ+LSE6PmSWh/izKLTmk
         YD8uwd8U30wje7/57CfWJzjmTToMDwxCn7XeDXjqQOg+r48oZDct9jhcL3uB8YM7XlGg
         +VKVjfm2IcJIadn+FtqcKLpq57aPNSiKXZ+1D+/3IxOkHaYAokUd1ok5KhuRddSztNfZ
         jsyHaIIp108v5hga6IpYA4AsIlNbPmYBNKeSYwetfx4ZDRuodcLW68d+b+DGhfVxJJ3t
         f0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=asAJiQP/IRl4DeWZX6k748CTJJdoYx8udJBOLV1Qu14=;
        b=uQhooZ4A5l29sD7eL6iCs7xzgqO1ohT+BOn5wfoKYOcGQ8CWb2HfE2heqVtYwq41Zh
         Yni0WcEzAxj1qHIXHYCa/kpkw7ZaT2opVtaVPGeVAkVpypUaKPDTfRZZ+EWMKAkOeTpQ
         9LY5+98EV+hfNli8WlA8z9iUceov7eS9SuBbIvKczDL04mXBMJ+EPfVku1kBvHuQwe28
         UEDBxL0zloAWQw1O7tGQNtcRAngkC8buQj5V/lq+SL9VlYAq/I8PC7wwd+vZg+OELOoD
         8F71o7vGkOKNro3kcEPl8RVcLfFXrc/Hb+lQA9luLfVjm2v+wUA7FPUspzzBYlPOq9wa
         RIaA==
X-Gm-Message-State: APjAAAVzfKmOsQbVU0NvJiGk/rdE8XZJBm3VN6wNFu3jNMd77N3bFrbT
        dKt7rZapyIdrXUOaxeg5/e+XUxd1c7w=
X-Google-Smtp-Source: APXvYqyiWv36u2FeKd4s0MJmms6q2VUQdbDdYxc5pE1f64DyJWu2qpzKMPNLwl2mEKwYLQXNmZHAXQ==
X-Received: by 2002:a1c:2004:: with SMTP id g4mr24910633wmg.173.1559823611524;
        Thu, 06 Jun 2019 05:20:11 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id a139sm1785899wmd.18.2019.06.06.05.20.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 05:20:10 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] habanalabs: add rate-limit to an error message
Date:   Thu,  6 Jun 2019 15:20:08 +0300
Message-Id: <20190606122009.12471-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the print of an error message about mis-configuration
of the debug infrastructure to be rate-limited, to prevent flooding of
kernel log, as these configuration requests can come at a high rate.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index c5f7ecabef0a..cbc5fa1ffe11 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -255,7 +255,7 @@ static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
 	case HL_DEBUG_OP_SPMU:
 	case HL_DEBUG_OP_TIMESTAMP:
 		if (!hdev->in_debug) {
-			dev_err(hdev->dev,
+			dev_err_ratelimited(hdev->dev,
 				"Rejecting debug configuration request because device not in debug mode\n");
 			return -EFAULT;
 		}
-- 
2.17.1

