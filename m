Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF24CFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B810E218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7ysRnFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394522AbfJPThu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:37:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38283 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394488AbfJPThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:37:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id p4so3368435qkf.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/EfPfS/rzayptMKHYVpYurUSNAbaOippVZDRNzUE4k=;
        b=F7ysRnFJGgjboY0XKIl3CtLjZJFKjN3OJG4bCNjVjWav0TojjT7TlmD3PaAM6iQR9u
         GcS1Z5nBswY2DKOKvyJO/RvfLfj7i0rWvBNgLB88JfwDCy5oYNpt7b3atBSY+sipZjr/
         bF5X2OMqJwz/Ou9jLpokuEH3QARY+FUTC2MiGwgqv9Gde2DlexNMDXUSZgQdneRlaFB6
         lqGBlMzHG+5HX+EN8CN0rrN6Hfi+wrfQBnR00tko+t/VJLtGGAEm6fvdThSOJikYa+wi
         /vD0th1bPwVwJYlguPu+7gbN0zL9mEjngSxc6XxE+EeeqafD4MbtcpRxcc50fYQdkQNM
         iyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/EfPfS/rzayptMKHYVpYurUSNAbaOippVZDRNzUE4k=;
        b=edV+2zNH61KcN7C5nxJKLJH7JyZMmh+hGmp+nqeE2jrm1N9t1MIEdoxCgkX73L3cvr
         lbMmmfHdv12DRT6DbLdD1kPFLos2TGD4zYaHSK/hH5YKiG+zUDppQqw3NVG1Zn6vD+Fr
         xcG/YZQF8/1g314+/9KJ9K940XIUDvsVYJUqyehWupcTPlrqbETYplhA9LOf0KrDmC6Y
         6E8UdBMI3qdQ9Zi14WsjuS/ANC7XqVjssXTAfxUEgEW+yJpxyPS89NfuInUWAThTSDnb
         Zz1cldLg5gCT7mS39rIDor83NDZ7ek07X4nkY7cwpV2pNT9Hw4+aVe4+lBQBP8uWL+v3
         ULXw==
X-Gm-Message-State: APjAAAV5HmNp6Q3LdslYSZEQ2lqwWp+ewb9IlfUIL2JbuOvcpe6h5Iy8
        sxPKRgkbx+/ypJf/C92PAmmRTg==
X-Google-Smtp-Source: APXvYqysYd7L9p+e4+IwwD6T7cSHsFrZy5H/RVDaOTydJlo6DwCvGscuYB6HjYK4z+zLYTb2qhRraA==
X-Received: by 2002:a37:907:: with SMTP id 7mr43233321qkj.129.1571254657726;
        Wed, 16 Oct 2019 12:37:37 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 54sm16246030qts.75.2019.10.16.12.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 12:37:37 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power controller binding to describe thermal warming device
Date:   Wed, 16 Oct 2019 15:37:20 -0400
Message-Id: <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPMh power controller hosts mx domain that can be used as thermal
warming device. Add a sub-node to specify this.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
index eb35b22..fff695d 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -18,6 +18,16 @@ Required Properties:
 Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
 various OPPs for different platforms as well as Power domain indexes
 
+= SUBNODES
+RPMh alsp hosts power domains that can behave as thermal warming device.
+These are expressed as subnodes of the RPMh. The name of the node is used
+to identify the power domain and must therefor be "mx".
+
+- #cooling-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: must be 2
+
 Example: rpmh power domain controller and OPP table
 
 #include <dt-bindings/power/qcom-rpmhpd.h>
-- 
2.1.4

