Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92373C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE7C2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 11:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaU0WMI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfEJLaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 07:30:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44258 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfEJLaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 07:30:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so2883390pgv.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Nowmg4pM+Rb20HCwqnrJE3ir4gOjFPzAF5fVDd2jYag=;
        b=DaU0WMI+essN/z0vje9uyYZ/QVRI5R7wBylNonZJ7l9TcmbGVfnnheCNpFi2rdH/fw
         mm6qF57JD4HFRZHe2mvxcPLnNjjZV2R4QENKZsyWst8gEEkfrIQPduttU4QnYPPQbio1
         y+Sm36/ksNcO6SplI1eUVlQuOG6OxE0lbRjzyL0VOj/S2+ifDUG96gEiHno20zUl+1c7
         qJzgJBWxT46RYiIyccb1qMZ6O0njE6CU/0Mg1N4AMlVJDP0Yve2guyuTSTh2FjVxt1na
         7MEx5uYwviLZCAey4uRmV3Fnc8hV3+jhM3Eq4LS+mryeP8WRwFR0SBhK9idMQNXTK+AG
         HePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Nowmg4pM+Rb20HCwqnrJE3ir4gOjFPzAF5fVDd2jYag=;
        b=psRuDHN8abBu+Es323ovKxkGOGtnp2Yg6e9dor9yELZiVwBcGK0NdyUmKpnmdbLrGo
         18G9yG56DAghYlCxcmFhL5mltNKsHPg2ELYAVK3tTb0Q8pyagFZ7MU/54ggCTuOSTYdX
         Yg+ZXOM8EvBdVzaqfeWI53rGDkWdeEridLoqbwZwtAtQU5QzzDI0JbwDqAruVvHeRDR8
         9HFYHN1NKkq31hG1Z6J2q3j0uXqQTsKgeZ5Hbz5mYW9ltdBagXkoHZUZ7Rhtt6UKVu9a
         ySbU/AWm+WjFelRhSZczPH21+yAF3xCfVxOMX8n852L1nG2V1VFucmn5feB2OHow3/gq
         c1Zg==
X-Gm-Message-State: APjAAAUcy4dfirTGLCsGNQxV2qXVlaoIaOrPTzVYSBg5IOldvkL8rM82
        nK9XBFwEJQ14NpurxQNU1CF89hp116s=
X-Google-Smtp-Source: APXvYqz3aNdA7UVeHCg8AIz0RMXjZdXsJQmzSBKVmpxlKPs/GHjbdV6nMbG5/5VUHxpVMz6YT8nheg==
X-Received: by 2002:a62:87c6:: with SMTP id i189mr13483917pfe.65.1557487800962;
        Fri, 10 May 2019 04:30:00 -0700 (PDT)
Received: from localhost ([103.8.150.7])
        by smtp.gmail.com with ESMTPSA id 9sm5583081pgv.5.2019.05.10.04.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 04:30:00 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org
Subject: [PATCHv1 2/8] Documentation: arm: Link idle-states binding to code
Date:   Fri, 10 May 2019 16:59:40 +0530
Message-Id: <5f25e2b3096fa73f205e1797e355e049ed9f8c9c.1557486950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1557486950.git.amit.kucheria@linaro.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1557486950.git.amit.kucheria@linaro.org>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enable-method needs to be psci for the psci_cpuidle_ops to be
correctly registered.

Add a note to the binding documentation on where to find the declaration
of the enable-method since it is a macro and escapes any attempts to
grep for it.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 Documentation/devicetree/bindings/arm/idle-states.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
index 45730ba60af5..3a42335a6f3d 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.txt
+++ b/Documentation/devicetree/bindings/arm/idle-states.txt
@@ -239,6 +239,10 @@ processor idle states, defined as device tree nodes, are listed.
 			# On ARM v8 64-bit this property is required and must
 			  be:
 			   - "psci"
+			     (This assumes that the enable-method is "psci"
+			     in the cpu node[6] that then uses the
+			     CPUIDLE_METHOD_OF_DECLARE macro to setup the
+			     psci_cpuidle_ops callbacks)
 			# On ARM 32-bit systems this property is optional
 
 The nodes describing the idle states (state) can only be defined within the
@@ -697,3 +701,6 @@ cpus {
 
 [5] Devicetree Specification
     https://www.devicetree.org/specifications/
+
+[6] ARM Linux Kernel documentation - Booting AArch64 Linux
+    Documentation/arm64/booting.txt
-- 
2.17.1

