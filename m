Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B66BC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D328D21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9kxtIzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfGKVj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:39:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37739 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfGKVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:39:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so3696042plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9mZ61KKydl7XtmWNflo6S6ZKEPWBoobMC4o1X6705JE=;
        b=Q9kxtIzMG+/cHPtBtK5ej7nEkTudPoiCgAxJCQ905E8q15MRjvpJyoLePOq5w2Rh9e
         N2Ki7Q9fEiPGECS399LS7Yu/ysSUP2OYQiWCKg/JHR0b7877DTTWD0mPR5rKWSxbRlgU
         EJXC09ODygN6Jz3uTqkC13VMVqbT+2I3oKyMwKTkzuoUANWfQ7VDuU0zH1Wp79jU0YGt
         1ivqHiuzBXYy7HIw1yygbcFjG0EFSAAws/HWOSVa3XE423YZLx/MrahGIWGJ5axSI0e2
         GE/vvqX3qaPw5vfa1+QPeX6m0csee/jdp697Ge7lc5fgiU0E7UBoqgDSHP9PpPkcdLNt
         ULlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9mZ61KKydl7XtmWNflo6S6ZKEPWBoobMC4o1X6705JE=;
        b=XfRozl2YQvcDuqocAC1hW6xV/P/q3jfa0B5v6qF7ACD4ijQORwDfy5DqqKBl+3O6Tf
         aVvM47UC5oI4s/C3pyLe5gkID0DvDdeGZ4oHhkDhHBNRFLbdny/2Q0z251mtvEumV4Ec
         i7Qd+97d98Aowc4qUWLcStHaNllM7oewqO2OsGpZhfAigfqsqndnnWmSS2d4qQKfiFfF
         8opfwIjrasmXSg3n8Scv7bNbkPPBp/VOk3jUFlaG5ELrLCvS2VMzXNNJKRtgdgjr+gmu
         FCchKxEjep3r/PgKslCkDRAbS9/on7dTNlaFB1Jf2cwmho559KYK8NecSVD3aXSOIMxX
         xYig==
X-Gm-Message-State: APjAAAVGU7nKM2gpONnEMHLUjLcoHfOEpGLI93pHZcCSEg0pSWBCoXQr
        SgzdIPSzEY+T7uuH6A6YJfCm4Q==
X-Google-Smtp-Source: APXvYqwL0nczS205xDEJNOlUUIT7zzmK2cRm2lBMSSkHuuMfPKrktn8f73KVC66YmoAasygLkvCQEw==
X-Received: by 2002:a17:902:a606:: with SMTP id u6mr6497067plq.275.1562881166311;
        Thu, 11 Jul 2019 14:39:26 -0700 (PDT)
Received: from localhost.localdomain ([27.7.91.104])
        by smtp.gmail.com with ESMTPSA id w3sm5709795pgl.31.2019.07.11.14.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 14:39:25 -0700 (PDT)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     agross@kernel.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v5 2/5] base: soc: Export soc_device_register/unregister APIs
Date:   Fri, 12 Jul 2019 03:09:08 +0530
Message-Id: <20190711213911.23180-3-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711213911.23180-1-vaishali.thakkar@linaro.org>
References: <20190711213911.23180-1-vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Qcom Socinfo driver can be built as a module, so
export these two APIs.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v4:
	- Add Bjorn and Stephen's Reviewed-by
Changes since v3:
        - Add Greg's Reviewed-by
Changes since v2:
        - None
Changes since v1:
        - Make comment more clear for the case when serial
          number is not available
---
 drivers/base/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index b0933b9fe67f..7c0c5ca5953d 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -166,0 +167 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
+EXPORT_SYMBOL_GPL(soc_device_register);
@@ -175,0 +177 @@ void soc_device_unregister(struct soc_device *soc_dev)
+EXPORT_SYMBOL_GPL(soc_device_unregister);
-- 
2.17.1

