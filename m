Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE45C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891E422BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPjlq6A2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbfGYKmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:42:52 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38297 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388076AbfGYKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:42:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id h28so34144042lfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCZt3kPOpetUJel0mQo8gQ4T9AKw5U16SpvhhYzlabk=;
        b=dPjlq6A2lvWvgrMNJdWXllzHpmLL0eSjAKl3p11X8gAO1Yvl99cnY+xirJks9vbb13
         6nCvLEzGEA+2Mg8BA/VSM4x4lPIC4J3FPTKrWy/NmUUST4mSkbSrrw4h/Htc1lt3k9wG
         c2E2gKHIQKGr6YPf5me3iOR9WO3A3pxO2gOPg7kQqbJpotHyCEZ065jJ9upAazCdKAa+
         Hkv6dhJkQvDN6NIXUh+c8CnF1I9EDZW0xg4Y1ThnQCMHCW7nXjOdeN8YAjOSI7FDKZyz
         HwGJ+jvUU2QgFbEP+6Kxw6TmQYkwHxlRRLRuwVPtdM5ifpOujExT0iq02CSofXx4/moQ
         SRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCZt3kPOpetUJel0mQo8gQ4T9AKw5U16SpvhhYzlabk=;
        b=YRRlnmk8MeUD7lNUqptAwxTzDluSgtZlVuj5x1uslrvG2faJkkzFPyLdlC8vyULcuH
         3Ow6ps6tUDn/xt3xxoelSS8/o/RS59MCcf7F5CTnThMGBtiL6AQCNmYWXzfUGgBhVnvY
         pJSLSOZQ0gub+L9WiaSlMJuWGbhx6KHf2rXKqSAZ06+4952BjXClAkkTlv7BcMVtb3Rg
         dHAE51vKwR45YU51RQ0FHR37c2IphcZ0SfbN2fkWW5+cnh69KGcUevaKQIb1VjmFTHn4
         OIX8e1kKJvQ6tRIy3d+lJKkQWoy8sFK/ghzLK8yyLLFUmvl/oi9lyYWDd25YY0oU170R
         Rfwg==
X-Gm-Message-State: APjAAAUytQNICeuekiWuPgT1RJ5yZ8Q3ZLUPaihMZNKRiH/WmieehE7w
        H6QswxaDsOB7QDuomCQoHQ06ww==
X-Google-Smtp-Source: APXvYqyHYEAnKCQigACGznav4uCxvOKhm8HycAN3Cp3gSen5Bex3GSkUOUEJni/ors317BJHT6r5Mw==
X-Received: by 2002:ac2:59c6:: with SMTP id x6mr5914293lfn.169.1564051369379;
        Thu, 25 Jul 2019 03:42:49 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-44-230.bbcust.telenor.se. [83.226.44.230])
        by smtp.gmail.com with ESMTPSA id e62sm9035045ljf.82.2019.07.25.03.42.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:42:48 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
Date:   Thu, 25 Jul 2019 12:41:37 +0200
Message-Id: <20190725104144.22924-10-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
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
 .../devicetree/bindings/opp/qcom-opp.txt      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
new file mode 100644
index 000000000000..f204685d029c
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
+Optional properties:
+- qcom,opp-fuse-level: A positive value representing the fuse corner/level
+  associated with this OPP node. Sometimes several corners/levels shares
+  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
+  min uV, and max uV.
-- 
2.21.0

