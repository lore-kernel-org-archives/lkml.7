Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8051ECA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AB820862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHGo5PEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfJaMXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:23:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38683 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfJaMXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:23:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id w8so2646963plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3EOM5oayeFhI5olpubTkJZc1yJ+pE3t3ormYT5/k2xU=;
        b=yHGo5PELukGJE9+DlmbPU9ub+QasVUdgD0N6BsJWeVaWMmn7fCQNlwxtZgV/XnQLOz
         Qlo5JOuq8hYX2/7b1uW0HABZKfHq4/zHXVp2aKGUEPdQpOwBU7Jy0X4iKRwplLfgg9Uy
         j2TnRv6GlHf5qJDXpiA2SviX4bypaq5Co22dQcrH34GYKMIQmUqatwcUCGhoCsMQR3d+
         zXwrI0zu23eKq11aQOybq4T9cYaTEE+PNGNiHafUL+cwmpZGePBZXwVQE3ffFNrHJf0T
         vvaD8KMx34m14qG4r0mnvV1Ply8Y+jnVM2OnpQeYEwGf0nnMnkNDcGNqPUVGT/CIL9/f
         uegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3EOM5oayeFhI5olpubTkJZc1yJ+pE3t3ormYT5/k2xU=;
        b=dVfcl3Ww3wW5LO21kdhpnGZh1P4UGy/JG+1LtoIOoQGzvl6WjmAlLD/5EqIszipAGL
         0msejib3UN+zY4QcM5yCjKshlmyTWLOBw8yd3ZaY3Uj6h4sTFVD4BuPw53bVoujdZYdq
         zalZ3YgZNxyc1WVCAhEhcqDwiE7ni2gxC8MFA5YFlZsEJGnr1zdn9nz1K3hGB4Tkv8HT
         CQpKM3VjxQcgJ0Br5bW78VDV1votUOmSkWnFliJ0ASMjmZTsKy7nTcXiSk3yY1mjobFt
         eQYz7WCtisvs9+SvArOs//DwTgSa3yrvjIRulPyvF9u151NUa7UUZF/WQpk//l7Re2kQ
         t2Hg==
X-Gm-Message-State: APjAAAVmgfvBObD2BsrBg0g2LKYo836qfZWcddq6tbFnyTc6ZJRACm0m
        UwqKzKV7GmCKOKs6DNV+tS5/fw==
X-Google-Smtp-Source: APXvYqy0sQWQsq3P05Z6/6dlN/93R29tNMFf04jiOPWv8Lea7d+o47gaynahZnK3SBLKKCee8StoBg==
X-Received: by 2002:a17:902:fe89:: with SMTP id x9mr6340644plm.62.1572524620180;
        Thu, 31 Oct 2019 05:23:40 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm2983077pfi.113.2019.10.31.05.23.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 05:23:39 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v2 1/5] dt-bindings: power: Introduce one property to describe the battery resistance with temperature changes
Date:   Thu, 31 Oct 2019 20:22:40 +0800
Message-Id: <c9a1357628bb091aff5e54f60a2600b129388f19.1572523415.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572523415.git.baolin.wang@linaro.org>
References: <cover.1572523415.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the battery internal resistance can be changed as the temperature
changes, thus add one table to describe the battery resistance percent
in different temperatures to get a accurate battery internal resistance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/power/supply/battery.txt   |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 5c913d4c..3049cf8 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -35,6 +35,10 @@ Optional Properties:
    for each of the battery capacity lookup table. The first temperature value
    specifies the OCV table 0, and the second temperature value specifies the
    OCV table 1, and so on.
+ - resistance-temp-table: An array providing the temperature in degree Celsius
+   and corresponding battery internal resistance percent, which is used to look
+   up the resistance percent according to current temperature to get a accurate
+   batterty internal resistance in different temperatures.
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -61,6 +65,7 @@ Example:
 		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
 		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
 		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
+		resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
 	};
 
 	charger: charger@11 {
-- 
1.7.9.5

