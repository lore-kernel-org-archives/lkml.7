Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D5DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDE72084B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PdSWTevo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbfFTILj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:11:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38628 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:11:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so2003500wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HhWyyUaFjokwwCj2d1/nEx4QjaLwX5bSHXHfoJ/Z1z4=;
        b=PdSWTevoSjMzvE1lmytqcgGP0RPJzKrM/e7aTP+8QeiMu0OnXdcMYmHugWc7jRuWa7
         ODM7F9jtOna23X01M84cHN4WO2ADB1u0UZJNBYff3lcyv9QVEo/1GMvgUI2+cyL151qM
         +wPj/ZlKF+qWkg3KVXqNkgbrOrudX0MFEFXbSRuDgXAmzJP5hxTBy1W0STvDt0CuJDDq
         AZDwcR1lrDCTQs1OlP5QDbQnEib7ttSGqpAgJnSSuagSjwtf+tGh3F2iWGFn4TwW65L5
         Z25fM51nzg6unt1ho3xAOJ7YlMgtCGDSZMpTyvzL5EPtv6x6IPSMW+vnZrXcnsBTr3+G
         NWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HhWyyUaFjokwwCj2d1/nEx4QjaLwX5bSHXHfoJ/Z1z4=;
        b=jeNLbXtgc7X41nIuddbuUlzXOMwTBX4dohSUseOqwtzwnGeuIjOYcRnDuaUAKMHIcK
         9RRDOn3Lm4LkpkNB+iVE92pvirsc1nImrLobVq95F3o6tn1SE/jMG/Mr5uGMv75xFw+t
         6V1aE0Ub2+SVctUxHlGvWm4jZMqa12FueqBqDJoZFTGx26IsQYSNetswBLyV7Kalmewb
         F4t9ryYR0Dkl45Z0W/Y9HC14sPw0uSnz+dXkS3XZ9DFGrmhpHRCu0vr1tS/5yJuxIEXo
         /FQ+c8hTCQRaYzUSgnYaVqjaPIqTkICiDXE3pe912P5YuNcFcB7lGt5j9w+8Wz6Nfq7n
         eHnA==
X-Gm-Message-State: APjAAAVZWTUpabVuoH/4clZ2kwukabiwBp24MGZlExGLYMDWYslOT0zF
        qAasf4SHyDePV1VrzukUBLUM3Q==
X-Google-Smtp-Source: APXvYqzjvw+YuFRfVDg/VKnRQl34K5IFA/EQSugWLkyCXSp67bzfp/MtHssS/iKWK+3hoI6SfOun3A==
X-Received: by 2002:a05:6000:146:: with SMTP id r6mr78481877wrx.237.1561018293930;
        Thu, 20 Jun 2019 01:11:33 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q12sm17559174wrp.50.2019.06.20.01.11.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 01:11:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] slimbus: core: generate uevent for non-dt only
Date:   Thu, 20 Jun 2019 09:11:29 +0100
Message-Id: <20190620081129.4721-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620081129.4721-1-srinivas.kandagatla@linaro.org>
References: <20190620081129.4721-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rely on MODULE_ALIAS() for automatic kernel module loading, rather than
basing it on the OF compatible. This ensures that drivers without
of_device_id table, such as wcd9335, will be automatically loaded.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
[bjorn: Added commit message]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/slimbus/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index b2f07d2043eb..526e3215d8fe 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -98,11 +98,6 @@ static int slim_device_remove(struct device *dev)
 static int slim_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct slim_device *sbdev = to_slim_device(dev);
-	int ret;
-
-	ret = of_device_uevent_modalias(dev, env);
-	if (ret != -ENODEV)
-		return ret;
 
 	return add_uevent_var(env, "MODALIAS=slim:%s", dev_name(&sbdev->dev));
 }
-- 
2.21.0

