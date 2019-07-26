Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52959C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2548022BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJDXZIgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbfGZXQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:16:10 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41191 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbfGZXQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:16:08 -0400
Received: by mail-pg1-f202.google.com with SMTP id b18so33954475pgg.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 16:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KA0H2FQCKfPlRFALsSxO8aZCLEoa2YLftLw47C413O4=;
        b=sJDXZIgKg9OcRmohvvHtcgRd9n6H04cbduCDpZ+j2ttvA72wyN1yFoZs12chqGY8Lk
         tGQ5uUqwVG8PkUGAqlrvrJ/wj5CEAP6YEMLE+xzEzwJgBSVkd+ez7gcDk++waKbJiis2
         IVU28mJGOUEFAr8wsHcultT5x1jzeBvKq2/4LbJT6JvRAubkU3lrSB6jUyaLsSx0OhvZ
         AheGdZ+7mwa/WhYtUkWUtbFgmP4D2xwcZqzsaTTfjU1vW0hFKLc+4ZpFtkC08F8Ej3QP
         +mCdy2ufEU3VUfryLY43xGe525YhCCPwbT+hcTvEk1xciA+vco77QQTPNbMztD7R6Am0
         RKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KA0H2FQCKfPlRFALsSxO8aZCLEoa2YLftLw47C413O4=;
        b=mNuJGULp9W51ejQub+sxPwebmQh5WaoERjiqzRntbzdE8yjCd/7VCpBKgvctPnKtIl
         bCaDIsc6RXDovjIOERWgMkxF5x0PclylBzDUzczkWr0PmJoWBwDI0sVrAjzM/cN9/eqy
         bUQpyD7RHDO3Zn4l7S92UQ9lFTffRQtdp1/cjKDeZxsqeIRr2yj+MgCYuQC945pftZiC
         FGN104xIQz4CQO6MZhhiwRA7NC7tg3P3/WYeXOdn2krp1rw2vf3lik5ZEyRmdsRjcs61
         LA4HPKjSny3kiJeqIhCVFsAtIbirJ4JD14uNe0iNBhqf4kRXh4ro6mM+Y9sPbs1LLmp9
         LiMg==
X-Gm-Message-State: APjAAAXt3Vxd4N7DkIAZfVmG5o9BLgyRDOEkbas/JJrRGV7udhHryHYa
        J4z4JPfLGPBh+d4wJFffMLBeD+/kyP1BmOQ=
X-Google-Smtp-Source: APXvYqyGkZZFPN5EuIGupnn4DHO9UuijX2q5nto5Gkvcpzm3LokCNz3qgpWL2igfgyGgYQq8DTJ+LSIaiKvPEB4=
X-Received: by 2002:a63:f959:: with SMTP id q25mr93212062pgk.357.1564182967047;
 Fri, 26 Jul 2019 16:16:07 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:15:55 -0700
In-Reply-To: <20190726231558.175130-1-saravanak@google.com>
Message-Id: <20190726231558.175130-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190726231558.175130-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 1/3] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
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
 Documentation/devicetree/bindings/opp/opp.txt     | 15 ++++++++++++---
 .../devicetree/bindings/property-units.txt        |  4 ++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 76b6c79604a5..b1eb49d6eab0 100644
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
+  opps are required to have the opp-peak-KBps property.
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
 
diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index e9b8360b3288..ef4c4a199efa 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -41,3 +41,7 @@ Temperature
 Pressure
 ----------------------------------------
 -kpascal	: kilopascal
+
+Throughput
+----------------------------------------
+-KBps		: kilobytes per second
-- 
2.22.0.709.g102302147b-goog

