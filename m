Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0560DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C393C20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQusTV+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfDDFKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:10:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46350 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfDDFKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:10:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so714553pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 22:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5f+kkMUgvOOpOd6cTF9Ie+6FOr6453kj1E1ya/v5Za8=;
        b=OQusTV+sLzBgbuQim/aJBTk/xjcBPTqYlFT9scR6O8fYzA0i29sdhhV5Jnxg81dPHL
         MwAFl+bs31OrLE9iQXLisbdttm0uhX7lBVJOLlI3joGVjmPJ6uPi0qF4Tt8gAR7JbWdZ
         SvVAnPMZu0ZxSSXF9Ap7xv/YSNby0tIJIqwSeSjlSl6zskXvNpgv5CAofOoQf3BRztZ+
         y+LYNuu4+wmQ32CfLWWUzCnFzLJPWclgKOPHXyxiwJitkTI8+9f8jv37IfGfhgQLMUIV
         k+yDCnbs4xXT2c2ttyqaycOFf5Kt5efXpoxaXHPnnFSUnBRN+2LZ034sjgPgD3U0wydF
         FwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5f+kkMUgvOOpOd6cTF9Ie+6FOr6453kj1E1ya/v5Za8=;
        b=bBn4t+RfkOTx1QMJ5NGEihDZLj0flCg290pRnFJYSqb+MbnKzV0nF2XTbgtMFxkGog
         G8NkPobCzkgyLvli0nXxv/VEn1MfQCDADAUju69vFu8dkRYgGgv8IVfCbQE2RMF3yaVX
         2U5aB7mfi9oJ23wFSceBsfT3+1EhbgrUXZVwKsmBArgk2lFw6wP2u3z0kOd28xcZm+Bx
         3z6UqOe3HcX37rqrjqoiG9xOhSMV81AjkPoo4K1lrZjaw+NAwJeuRqld1IBTFS+nhZnQ
         K2qZ5PzOodXazj8ZFGOlWYfail27SJiWztkhOBe7QtENXUSaZSh/qogTS+QAx3p3bvns
         L/5w==
X-Gm-Message-State: APjAAAUG2SqebSh3k/g33XerAAwQ/ErxAjkzvxyTcnKvbWc3e/TsJ/T+
        AfDpgm+JXB9/zTt6xk3w1w4xng==
X-Google-Smtp-Source: APXvYqw74PUpVJSwVuvWlGLT47IEyHp+tLAw/NzY+y0YXokm/P1+rW7kGVyLoErD4bt5pU5wxB0X0A==
X-Received: by 2002:a63:1064:: with SMTP id 36mr3772475pgq.155.1554354640554;
        Wed, 03 Apr 2019 22:10:40 -0700 (PDT)
Received: from centauri.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id g64sm43254361pfg.13.2019.04.03.22.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 22:10:40 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/9] dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
Date:   Thu,  4 Apr 2019 07:09:27 +0200
Message-Id: <20190404050931.9812-7-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404050931.9812-1-niklas.cassel@linaro.org>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom-opp bindings with properties needed for Core Power Reduction (CPR).

CPR is included in a great variety of Qualcomm SoC, e.g. msm8916 and msm8996,
and was first introduced in msm8974.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 .../devicetree/bindings/opp/qcom-opp.txt      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
new file mode 100644
index 000000000000..d24280467db7
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/qcom-opp.txt
@@ -0,0 +1,24 @@
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
+- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. Even
+  though a power domain doesn't need a opp-hz, there can be devices in the
+  power domain that need to know the highest supported frequency for each
+  corner/level (e.g. CPR), in order to properly initialize the hardware.
+
+- qcom,opp-fuse-level: A positive value representing the fuse corner/level
+  associated with this OPP node. Sometimes several corners/levels shares
+  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
+  min uV, and max uV.
-- 
2.20.1

