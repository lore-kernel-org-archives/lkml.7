Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B08C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD642084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9zr5cFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfKYOZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:25:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36761 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbfKYOZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 09:25:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15so16106749lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLculURoH3BCV7hyS93RpcUM9UKZHxxj8yiEZMlzgFI=;
        b=e9zr5cFEFsYtz8NXh6wk3vUJiorgv8HQAamT1XM5/Vk90Irw61nDfa5wPaYmVwMzqk
         Zud3SpzpmI0iGzF04+2AZv60HTwH4SR1gjdxeDGc2B2BL7ONVj8HgsFJJ85xFeB9Uy3i
         SIBriFaViu/kJ2n5cvhCuu3GnC5cV+Mss1EtXmX2wP1ByKUha9tTCHOmwTiaqs0xZ7EX
         WBRkPnnC6nOtQPYt9OgxSA+DTh1WIcWpotuxit2u6jM2bWGnof3coMDEVy1+ose+1age
         Brx4DclEo7Umjh4JU8Ave451L3cOgdaZr4yTZaZ+PwZ9WyWBaVj9bRresnpboJmK0NTT
         Z7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLculURoH3BCV7hyS93RpcUM9UKZHxxj8yiEZMlzgFI=;
        b=jg+z3a3d3ZVPeMQqAGcGMwOwc1q5skgYxiIRhBUmEQNe0PZ1LK+XBSR6LeRVBy2gCn
         6NBWlTTo1d/cfwoOCgTRv9XTLu0mg8Wv5dDL0uS1skjhJZsHgQ0YMz16PxltFCQGsqgz
         LXYZJNfdHxhxFLb4o0yr1WW4uTo88TFgXnvfKHbJ7KNAbcZNhEIyYWMbliV4atCNkKzz
         kN9uY0OCyffD8ldwqbv5fu+m42fgYr73LvxdWxgwO6KlKSjh6cX+X8ar1wNK0C2zvAAb
         EMM+yLrj5lOk/EGwUahr7JQphbrhqZ0SpXDcrsF+jWrO5/h3bPQ7rfN9lsKbv4u8e/wu
         d12A==
X-Gm-Message-State: APjAAAX8x/+hqHZBMoj7cCS3hdDPex+KXa9GtKNgM/9PPD8sxtrk12gh
        miBz5UlK5WgJd+YtIfk+0Gtk7A==
X-Google-Smtp-Source: APXvYqxzruuMyNSCsHenp3VVyLy99hYliqQex3TauCdVPMev/vQosO5w0vBVcQdHh1R5S2l9zyaGPw==
X-Received: by 2002:a2e:8e27:: with SMTP id r7mr23143728ljk.101.1574691914559;
        Mon, 25 Nov 2019 06:25:14 -0800 (PST)
Received: from centauri.lan (ua-84-217-220-205.bbcust.telenor.se. [84.217.220.205])
        by smtp.gmail.com with ESMTPSA id b28sm4595260ljp.9.2019.11.25.06.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 06:25:14 -0800 (PST)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] arm64: dts: qcom: msm8916: Add the clocks for the APCS mux/divider
Date:   Mon, 25 Nov 2019 15:25:06 +0100
Message-Id: <20191125142511.681149-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191125142511.681149-1-niklas.cassel@linaro.org>
References: <20191125142511.681149-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Specify the clocks that feed the APCS mux/divider instead of using
default hardcoded values in the source code.

The driver still supports the previous bindings; however with this
update it we allow the msm8916 to access the parent clock names
required by the driver operation using the device tree node.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v1:
-Swapped order of "pll" and "aux" clocks, in order to not break DT
backwards compatibility. (In case no clock-names are given, "pll" still
has to be the first clock).

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 8686e101905c..9ec41b24a51f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -429,7 +429,8 @@
 			compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
 			reg = <0xb011000 0x1000>;
 			#mbox-cells = <1>;
-			clocks = <&a53pll>;
+			clocks = <&a53pll>, <&gcc GPLL0_VOTE>;
+			clock-names = "pll", "aux";
 			#clock-cells = <0>;
 		};
 
-- 
2.23.0

