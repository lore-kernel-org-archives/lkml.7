Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735DEC31E50
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481FD2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdp/0ej3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfFNXPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 19:15:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46649 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfFNXPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 19:15:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so2252575pfy.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 16:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QDDURWlUIkBem+8Px1iuYauus00ZwA+eO174Z2pwlBA=;
        b=sdp/0ej3rTCJaEMMi7NPSSimBJnCnh9meuvszGKdQx0N8fq3z7KoSt9YKiuIzepVam
         khf0r2UBtCtNxVWXPsG1uK4h0gTqPqM1Fh7pX0AJMRQRO3YtkXDpDynnSzt5AsogxRBg
         /OWopd3+QFf5k4B8zzfzfNfz6bZOD4fYeLoTBzCLVaIRrZYxMgQTiqlwo6NA9V0HDf+z
         I/3QR9xV0ycb4dYuEQOIhHpaaQ2iC36wLnF5IWcRZUG/bvsucXQIUIB1oeb77WcgAWF5
         wgSK7zzb1YiPng3iIGf5owzX8dv1t0lxerWQt4TbaViSYzff4vwdrBcSd7ql5bfk89YF
         iwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QDDURWlUIkBem+8Px1iuYauus00ZwA+eO174Z2pwlBA=;
        b=HKUN/9Al7bGEyWBeB8Rcdd/f6d8gSkoGJVjQdQT63pQbaRyiaIvFucgP9lgXyj8qgU
         cvgpVKiQLN8sq3UYaiU5rNrY6FPBrjH5WilzNXLDv+O0VnZ3g4cWLDxP9+rULUrhEer2
         vrOIRs9ZXT2EKrBcXsbgkhCAcOVCf3+m37MQO7Smk7a42Da4mz9GubJpaQSqiCu5dx7X
         7YvxBX7ILfRVvo8GDPeng4fjRoX3MkmgAK7eDzDQTGfZzBggi9o1UbXOVGU9OhrkqVbc
         AG0SilTUdMFeDMR4peVN6QPdzdlR6LGEHmWeKfLSeBO54h62k7QekV5y+z2BpWmTfcZJ
         fqMg==
X-Gm-Message-State: APjAAAWqmPNumCyvdVtzYPzWCsdZU5/JieVC5xL/eyHegGyMR3hceK5R
        bw8Yd+EWFoYr4v7ls1kAi+GwpSxiNE8=
X-Google-Smtp-Source: APXvYqx9jnjWVJBhIcrRWaOSM4DlC1VnTWIPv6OcbVnNMdbv99MXOwW3fuo59oqYVp1rS24CjZVhhQ==
X-Received: by 2002:aa7:956d:: with SMTP id x13mr62314991pfq.132.1560554099521;
        Fri, 14 Jun 2019 16:14:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w187sm4486445pfb.4.2019.06.14.16.14.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 16:14:58 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: qcom: pm8998: Use qcom,pm8998-pon binding for second gen pon
Date:   Fri, 14 Jun 2019 23:14:51 +0000
Message-Id: <20190614231451.45998-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614231451.45998-1-john.stultz@linaro.org>
References: <20190614231451.45998-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes pm8998 to use the new qcom,pm8998-pon compatible
string for the pon in order to support the gen2 pon
functionality properly.

Cc: Andy Gross <agross@kernel.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index d3ca35a940fb6..051a52df80f9e 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -39,7 +39,7 @@
 		#size-cells = <0>;
 
 		pm8998_pon: pon@800 {
-			compatible = "qcom,pm8916-pon";
+			compatible = "qcom,pm8998-pon";
 
 			reg = <0x800>;
 			mode-bootloader = <0x2>;
-- 
2.17.1

