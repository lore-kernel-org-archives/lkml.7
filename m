Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC4FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36E92087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pn1xLF84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfHSKMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:12:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34335 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHSKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:12:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id x18so1213721ljh.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Savk0VYlvDVd8eWat8ONZ2W99qSJkuIV6aH6MqvKuRs=;
        b=Pn1xLF84280o45HYFvVYs53zFRnFDqCTewkxRBsk/zLFhGHmdZhWYM+fkAW20o5JvJ
         kg2UPhDaKJKkkTVLdffVMsBwbSM3k7bqW7UXJ3iSnp/uBcu/Wygj4MT0DEK5u7QovJdI
         SQJf1/GC9Ep3wJo95A6vXTe7/SViCmAvGzuao9YM/NoQsXIw1+A++CDy5O5l0tyv4fJA
         MJ9706V+L9Rx13D77Pbqxxl/Ufx027B2Aj67DJvE+FZWB5BiIZB4FGg7XupGhQRJ9sRN
         fuVTyVS0M+0czwoPZLxCzSSsbpIQOeNL47QTqoc6pWaFQRnN6O/UgrV/4wSo2NXemEq6
         06nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Savk0VYlvDVd8eWat8ONZ2W99qSJkuIV6aH6MqvKuRs=;
        b=UjPpOdXzFIACf0BKMdqb3WIVd8zosldHJM313PD147C79KY3ZEQlmfLgiVuWNwwhLC
         94F130Sq6wdZLcW5U5vnLI/3PoIjfOeu8nJ7Nni+WAgFchOgEXl1ePUyipDtvVOeoxmW
         luIZrzfdEbU2KQ3+DwCRcKXITHtzeAPCVZsFdNzdb1wybzoJ7U8wk9HBTP6MUasvohXd
         JTZlkA6qk6m3uPDmxA94PRcJpewp8kf0G0P8Iv9jc7ylKU/s1AlqQBltJJ8hLXAlKXIk
         SVKOH8A3SVq7dqwmIegP/6FljhJrUxC6o8H39VC+sJUlBwu2LnU3PntSP1tLVc+iLMRx
         efvw==
X-Gm-Message-State: APjAAAXD7nSITYMTNanqlEVeiMneEz7D4dDUHkcPDc4b49qFikZRP8uz
        3EaJmbk13Bohq/7n68DOyqaK8Q==
X-Google-Smtp-Source: APXvYqyiFcQNQzdX10h9XrrGAfeF6gl9PikY/S5BBKh8HJ8rjKXvFjkCPrfJ7k9zHYsC/rPLEYjIMw==
X-Received: by 2002:a2e:87d5:: with SMTP id v21mr12053322ljj.191.1566209562409;
        Mon, 19 Aug 2019 03:12:42 -0700 (PDT)
Received: from localhost.localdomain (ua-84-219-138-247.bbcust.telenor.se. [84.219.138.247])
        by smtp.gmail.com with ESMTPSA id t4sm2512368ljh.9.2019.08.19.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 03:12:41 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/14] dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
Date:   Mon, 19 Aug 2019 12:12:38 +0200
Message-Id: <20190819101238.17335-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-10-niklas.cassel@linaro.org>
References: <20190725104144.22924-10-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom-opp bindings with properties needed for Core Power Reduction
(CPR).

CPR is included in a great variety of Qualcomm SoCs, e.g. msm8916 and
msm8996. CPR was first introduced in msm8974.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Changes since V2:
qcom,opp-fuse-level is really a required property and not an optional
property, so properly define it as such.

 .../devicetree/bindings/opp/qcom-opp.txt      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
new file mode 100644
index 000000000000..32eb0793c7e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
@@ -0,0 +1,19 @@
+Qualcomm OPP bindings to describe OPP nodes
+
+The bindings are based on top of the operating-points-v2 bindings
+described in Documentation/devicetree/bindings/opp/opp.txt
+Additional properties are described below.
+
+* OPP Table Node
+
+Required properties:
+- compatible: Allow OPPs to express their compatibility. It should be:
+  "operating-points-v2-qcom-level"
+
+* OPP Node
+
+Required properties:
+- qcom,opp-fuse-level: A positive value representing the fuse corner/level
+  associated with this OPP node. Sometimes several corners/levels shares
+  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
+  min uV, and max uV.
-- 
2.21.0

