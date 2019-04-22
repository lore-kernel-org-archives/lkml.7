Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3784AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ECB214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwLkvZ2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfDVR2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:28:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34100 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfDVR2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:28:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so391326wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zO+RNWwQbNoca0mKf5ETdBNVWZ7qpW34U6V/nkjkNlw=;
        b=XwLkvZ2nLSo5ns8GCzbqENm4/Kb7LWbiksFxVifZwFSqDyfrKbEulegHOmvohctDhn
         kSxdDmGh6y0EtpeQf/Cc9FFHNIHFZcHttLAz4s+Bv/GefAvo9idBmsD/QCpJKa6asrp7
         cJ/s+Zd+LNtLZ4LQuaT/x41Coo1nStSghXzyu6qWQh6mAlmP4+c7ouyyXIow4lS0OA4/
         Ht4l+E0yWDJfQuHwygUQ1aQa/PwM8/AlhN6Xa1kxcf0bSY6cG+8vLfFtslF3f+AfUqwO
         MV3otcOrVvj8WlnPF8Upiu1CivNcb0p7pYVtSDaWwUDmotKrVd5F2IzGo2wKpKILfROG
         aQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zO+RNWwQbNoca0mKf5ETdBNVWZ7qpW34U6V/nkjkNlw=;
        b=E0cIeyh1VcrNAdFj1h7n67nvyiSlTzaq+QL17jYSdIeYGWQL3baywA2Dcrkf4YSLuY
         iclfda7vPxdZr7ImVGoqA3hk9Npux7FnOzBvL7qp/g9TUPTelbsp09ATHtYiOw/8CRLw
         dhZ+xjiX5d3NDmlnU2/wBXh+e2V6kDP+CMF54RAD+h39BFH7+l3t/zrkuq9PsOjtvsbi
         lctWvvBX8rcptzmsrk+K3A68Agdatp7JyTJ8GscK45kUgohfqnCek35pA3/nbBqR7Eyd
         5Eoj7sJFllWcK+vBJnkZPfhkqp+0J5/lv3KaJyCu4zpMJQOp0x080WFbgyculqFvGD1j
         trnw==
X-Gm-Message-State: APjAAAWej+JOFSEMTDo3Bduz7yGVKEcvZJ0fNuorKbiR8DC3Nv+wXyLF
        vE3QpYMyMyFLuBwdm1ParE1FxA==
X-Google-Smtp-Source: APXvYqxkHVb897/Z92KZwumXpNYwkHgtCf3ExnvZLNXTM9VhBJpE/B7+TlTIupLTo1vWDBYMAx7ckw==
X-Received: by 2002:a1c:9c97:: with SMTP id f145mr13421548wme.139.1555954108686;
        Mon, 22 Apr 2019 10:28:28 -0700 (PDT)
Received: from localhost.localdomain (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id o16sm9033051wrw.10.2019.04.22.10.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 10:28:27 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: [PATCH] regulator: core: simplify return value on suported_voltage
Date:   Mon, 22 Apr 2019 19:28:24 +0200
Message-Id: <20190422172824.13720-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the current clients of this API  assume that 0 corresponds
to a failure and non-zero to a pass therefore ignoring the need to
handle a negative error code.

This commit modifies the API to follow that standard since returning a
negative (EINVAL) doesn't seem to provide enough value to justify
the need to handle it.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 186a37675b50..d872dfe75b63 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3002,7 +3002,7 @@ EXPORT_SYMBOL_GPL(regulator_get_linear_step);
  * @min_uV: Minimum required voltage in uV.
  * @max_uV: Maximum required voltage in uV.
  *
- * Returns a boolean or a negative error code.
+ * Returns a boolean.
  */
 int regulator_is_supported_voltage(struct regulator *regulator,
 				   int min_uV, int max_uV)
@@ -3026,7 +3026,7 @@ int regulator_is_supported_voltage(struct regulator *regulator,
 
 	ret = regulator_count_voltages(regulator);
 	if (ret < 0)
-		return ret;
+		return 0;
 	voltages = ret;
 
 	for (i = 0; i < voltages; i++) {
-- 
2.21.0

