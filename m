Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06563C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D034120645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gke0wMis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfGCBKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:10:30 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:44979 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfGCBK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:10:28 -0400
Received: by mail-pl1-f202.google.com with SMTP id n1so377361plk.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e9kTi24uB4qma1DS6GLfEd66OjyUuGvajWKOikD47Aw=;
        b=Gke0wMis6E54EMbeMX51d1b4DLg3NQl068tRf9JRRwoyEiiec/5boft2FQO/E182cW
         uoGbqSDHrEW0BfxIj4OxChLfIrwGIcJ/IziKnOHCXvLp36E4FOuiR10Gfrexqp83BIBG
         k2KWFMwUE5pztZQsHB5U1kpLIQ636P5rYZ+iSo+I1q4LGS+u8VlCzht1pOUpr28+RacL
         3bsNezsZYmq9SdcXbeVtcyMwZ6w5XuvSEam+c0LGKZUBTAfwag33F2ozP7CmvpZoAa3l
         8v6gShBaUpRw04xZAmgd8KpxH8XqQ+yC9ZD31FLirq2K0FjF661IsWc8zLppc9P5nWsx
         zIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e9kTi24uB4qma1DS6GLfEd66OjyUuGvajWKOikD47Aw=;
        b=PlW5RIiE0V3lgzpIHGSALUg4HRAZcWShmWM/oIfivSfw36RRJgawjcbuwOmdVdFTER
         O4+X5NBxXr9mYP2z6bQmBESGNQUaTc3knYH2CtD/IhIKPlHJkdMg9nxdTPnNLLriB4Ie
         IH5G3nMH+xb/onppMjBtgdfO5LCIFCflMeKBOHCQPW+gxtsE+cUf0c5YpefnVNNcn3la
         669a6ggD/LRAz1arQ8FASLc3PTN1/93j0e3I8Q4ast/ju8BMccC79J44xR9eRHGyCq3R
         VfdYaVy2Bb/X2wMZHeqU6yBzGm1r4TloY9ERo0QDLbHPS00gPXGHrB3OPVzHOZUPghpB
         LhVw==
X-Gm-Message-State: APjAAAVoZgExcTJQLVtI8eOObTueDAMbEQtnnCP0YWvF9vANKKsuQtbs
        JkrDjihlNhhDdqilTjRAaU2yZC9xGe+ebHE=
X-Google-Smtp-Source: APXvYqyhZ6ewKAXFIwQJJhA1AgdyM3RtUJbdz/u8xIi1sWGVsqHDJ1zCwj5Y4C/wLIAnD3LEbng6V6B5cGYzL9Y=
X-Received: by 2002:a63:6ec4:: with SMTP id j187mr15725095pgc.420.1562116227470;
 Tue, 02 Jul 2019 18:10:27 -0700 (PDT)
Date:   Tue,  2 Jul 2019 18:10:15 -0700
In-Reply-To: <20190703011020.151615-1-saravanak@google.com>
Message-Id: <20190703011020.151615-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 1/6] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, vincent.guittot@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
2.22.0.410.gd8fdbe21b5-goog

