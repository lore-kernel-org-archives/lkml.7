Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C29DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E77208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B7prBGnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFNERy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 00:17:54 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:33766 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFNERv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 00:17:51 -0400
Received: by mail-oi1-f202.google.com with SMTP id h67so403031oic.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 21:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yAz3k7OzPjxwzR5iBZENxEm1ewgrxin9ITMqtF0yTXk=;
        b=B7prBGnC/4Vibzh1aRMKAwrh4wPptRavvQYdcbMm4wH18w6FJ+mN2XrQWOTokqNNE1
         2YQEPr15HP9wSksf1WcGXsHnVfqqqegk1AI4eEiroIavNFnRETAd2J8oE0N+RDr4nh6n
         AmmAr7cJQDsTXFqCR3AJrrk/CmgU6adsljmLmVCSPy0Y0sYMKMcgVM3kHNlj+tUdSMD/
         BPjdbxJNKW2RflGqJzrpzuZ7sMm8HwAor8bGvpDaFEBr23p78S/TZxhHyFUjGMyT61Ng
         WGTkhSqWIQLHWc8uOIJGFcDV9ynqnhDOGqTgQwDVWczkizWy5FMQN2ha/gtdILPLq3uB
         rbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yAz3k7OzPjxwzR5iBZENxEm1ewgrxin9ITMqtF0yTXk=;
        b=f6vhxPG+bom19QR+/iPGGjznY+9vlTcCG/mi3EeUbSmJ3TxbhLQLA6QsyObhHNTuzv
         /FO+6yH5IL1cB3pYzTFkwB6rRaBbNxPXNPVjDL8pufDG7Yt43J1YCF75eD32quKne5BA
         rNtshjjzbIBWLD6eoFRnIQiWi0IUaB7umcXBwlmY8GkJu6j4/j4nNSPciwseR6vvy0OB
         DoZPxJns8pr67Sbg9mII2VEfNsauPfbM9CNULrOF6ezblGMXCcMw57OVLns4OK7HBgQQ
         uNXrxPrI6pp+L3a3FGZ5qIQNZR4XcFzxwTOCojWrk8Vij9PcVslHbP6rgm/ykk6mzCYV
         tlgA==
X-Gm-Message-State: APjAAAUUI7Ux5Q43zldybAMPGkPBSrmp5OHY8+KtsbYbgppq1DcDn3YA
        SYRxjhLbn6auhWoeW2CfU8Job5FGpbHCb0A=
X-Google-Smtp-Source: APXvYqxpQN0vGQmlYfHsDs37QAiaPht93jr4MuA/NrskO8HXbTJIyWknXV3GfSjQiUsAjTLL2awJ0YqhP7X0mIc=
X-Received: by 2002:aca:b8d7:: with SMTP id i206mr618247oif.25.1560485870342;
 Thu, 13 Jun 2019 21:17:50 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:26 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-5-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 04/11] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interconnects often quantify their performance points in terms of
bandwidth. So, add opp-peak-KBps (required) and opp-avg-KBps (optional) to
allow specifying Bandwidth OPP tables in DT.

opp-peak-KBps is a required property that replace opp-hz for Bandwidth OPP
tables.

opp-avg-KBps is an optional property that can be used in Bandwidth OPP
tables.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/devicetree/bindings/opp/opp.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 76b6c79604a5..c869e87caa2a 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -83,9 +83,14 @@ properties.
 
 Required properties:
 - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
-  required property for all device nodes but devices like power domains. The
-  power domain nodes must have another (implementation dependent) property which
-  uniquely identifies the OPP nodes.
+  required property for all device nodes but for devices like power domains or
+  bandwidth opp tables. The power domain nodes must have another (implementation
+  dependent) property which uniquely identifies the OPP nodes. The interconnect
+  opps are required to have the opp-peak-bw property.
+
+- opp-peak-KBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
+  big-endian integer. This is a required property for all devices that don't
+  have opp-hz. For example, bandwidth OPP tables for interconnect paths.
 
 Optional properties:
 - opp-microvolt: voltage in micro Volts.
@@ -132,6 +137,10 @@ Optional properties:
 - opp-level: A value representing the performance level of the device,
   expressed as a 32-bit integer.
 
+- opp-avg-KBps: Average bandwidth in kilobytes per second, expressed as a
+  32-bit big-endian integer. This property is only meaningful in OPP tables
+  where opp-peak-KBps is present.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

