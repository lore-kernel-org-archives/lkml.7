Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284CEC33CA4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE1E2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDYbUtGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgAIKcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:32:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36772 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgAIKcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:32:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so6828756wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZiyT8hwvH3cU7wQHlzEyrwouYDKnzGuvicSuE25MKEE=;
        b=kDYbUtGvtpoqFjdUiPy/Qs+FxsV+7IrisdZ1CN4ZtVeUMF0Qr8yloG0sEfVd77Jyrp
         ZinMo3r9p0JZnO1AZybj77R0K5pf96++LO+0WodXA/155//yNUIKY8ktawiqGkjPCeyU
         UVdnbPfFbmp8lL8ak0bMEwr5LP1hzwiuIcsA1Bd56U/lFBnRZclDNWEDebgSWx8I540G
         BT+9YuzrHH71OmSCqRkjPcmm34f18Fy897LBxsXoPZ3/fP8SHmKNkoJ13JjQbmaWttmK
         GfPRMcNYBgE9sSRr7OeT2OzRYCLQqDeOY1nlZ466AfdmCYpEUBcc+Q2tUUGjuCd8gvAZ
         URZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZiyT8hwvH3cU7wQHlzEyrwouYDKnzGuvicSuE25MKEE=;
        b=DWhhyCSTiteY0wtK5mJopWRzTjSC3tf+62PgNENtf3S09b55dmweWy/zctbUzI6VYT
         z4QjlYImXfpDljG9+yLTfWXm4eSO121OquDKB6g+TwjONondwwwSIcaHnJIA/p6Iv7WX
         y0PLSZu1rMNQ8LfnnfMRm7JbJWuNw3V3WvPQkcuZ40vTFVfhDoIpjRKUBQ/+4GozBMaI
         252HF5fjjTLy3padC7JVw0GJtJZTU8YQI5bjZruZ8QXyga/EEes1y1GbB9EAE8OzM9xD
         uUd+/zJrAm8MMvZBULgD4HVlKSlBvw8Pkd8/svxkWlFxlbbEp56Xz3slDk1b+L60BAom
         +fpQ==
X-Gm-Message-State: APjAAAVPkuWJtEhq2gdBO4D/SGyG2Uddx6pcDDOmddefL09kNWZ1uygR
        9sJbyAXq1R9/idY1aylXXTskPA==
X-Google-Smtp-Source: APXvYqzVJu0yS1smPrcIKa/S/XC2ZAl7Oi98yjPRNSdY+O8HRcZBxqK3CaskQy1Wa6EHH7ZKPHqgGQ==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr10286093wrm.48.1578565926637;
        Thu, 09 Jan 2020 02:32:06 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z83sm2473830wmg.2.2020.01.09.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:32:05 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Joe Perches <joe@perches.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] slimbus: Use the correct style for SPDX License Identifier
Date:   Thu,  9 Jan 2020 10:31:47 +0000
Message-Id: <20200109103148.5612-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200109103148.5612-1-srinivas.kandagatla@linaro.org>
References: <20200109103148.5612-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishad Kamdar <nishadkamdar@gmail.com>

This patch corrects the SPDX License Identifier style in
header file related to SLIMbus driver.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/slimbus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index b2f013bfe42e..c73035915f1d 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2011-2017, The Linux Foundation
  */
-- 
2.21.0

