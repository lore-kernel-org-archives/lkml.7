Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6846CC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A28218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yF9Y4TXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfGEJ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:59:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39595 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfGEJ6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:58:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so8673502ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VUCWK2MsD9fKCW5H56U5T5vRzO2k7QDz1z157zPKgz4=;
        b=yF9Y4TXdbukUm95Tym+SSRRKXOgy30rcUTY/I/w2ob/pI2Xk6mM2EFws9z/z9Jy5cn
         5yH51ejAX7BSHtxlej6Sietfapi0cefT59q9jJN1ifMQjBqWA/apLst7ul9igPrQzDk2
         drpnxdar+aTtUDEWi3y8Cvaxy3V5c8w9TqANXQggoaL7EEGMCiDWenolNKnmfMlIz6hF
         LA7dy1MeKgwm/taneDq3mE/Cww1ynKWrGI+PksCPx8K3tIZOtjsxbHUhCVxP0us659eW
         TmBrcMnTRQnSIVFZY+/4qysi0crgRy02/xmt3FLPdAsn0bXiaXQyjMv1jXGLbzNsj4go
         eyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUCWK2MsD9fKCW5H56U5T5vRzO2k7QDz1z157zPKgz4=;
        b=QGPDMyYtZThJf5mQI5UC3IaFxMe5Yvu3iwJf7bt6s/wJrUgtswkYRpKU3BOfvPryzg
         5HA0ARpQo7UMvpnV+35egqz33CQMXwn+RO8ldWepohjcj32ROtlMIPkrJo6SRbSpFS5v
         zH1OsA2NvADMh3kExqPjaaN0ppxgBTmYE1X7jBQrRO1XxwV5xUcZaqdZ6JZogZMleBmc
         Yjaw2UtRE5jBrSqpF6wsSVWTNFZvNSZgEanygGx3Nd2wWTAjT5KUkJ+d9cOZeI4oHRCi
         YBriTFvU/WZ/iqCul1Xk7NFAQBWuJC1/DeMAKHS+hMEBBqxN/PgnJhF0Ulx4Q4z4c2LQ
         YcMA==
X-Gm-Message-State: APjAAAVwJ7HHvjYuEJUnBashl3/lvSG8l/fm4gyg2XF5U7nynodAHgkb
        KOXd8QJRSPKNUZ2MgpFf/lI4aQ==
X-Google-Smtp-Source: APXvYqx0ZiI7NUTcCSAcDJg+m43On7JBoo/yMllTvC1H2ViTfIYfM/r31p51tmof/TzmGg/DplB8aw==
X-Received: by 2002:a2e:9758:: with SMTP id f24mr1723330ljj.58.1562320683615;
        Fri, 05 Jul 2019 02:58:03 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id 25sm1692704ljn.62.2019.07.05.02.58.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:58:02 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] dt-bindings: cpufreq: qcom-nvmem: Make speedbin related properties optional
Date:   Fri,  5 Jul 2019 11:57:14 +0200
Message-Id: <20190705095726.21433-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705095726.21433-1-niklas.cassel@linaro.org>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all Qualcomm platforms need to care about the speedbin efuse,
nor the value blown into the speedbin efuse.
Therefore, make the nvmem-cells and opp-supported-hw properties
optional.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index 198441e80ba8..c5ea8b90e35d 100644
--- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
@@ -20,6 +20,10 @@ In 'cpus' nodes:
 In 'operating-points-v2' table:
 - compatible: Should be
 	- 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
+
+Optional properties:
+--------------------
+In 'operating-points-v2' table:
 - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
 		efuse registers that has information about the
 		speedbin that is used to select the right frequency/voltage
-- 
2.21.0

