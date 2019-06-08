Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E16DC468C4
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384F820840
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h16Y4HD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfFHEnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 00:43:51 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:41507 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfFHEnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 00:43:50 -0400
Received: by mail-vk1-f202.google.com with SMTP id w124so1569634vkd.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 21:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yAz3k7OzPjxwzR5iBZENxEm1ewgrxin9ITMqtF0yTXk=;
        b=h16Y4HD/UPQ8Qdd8puBUJX6swjYiLioJGWRuDvWtjxgSH5taeUQyhOx79lWt1tEXh9
         WP5jLzggF4W2BJI+QMCOkRsdE+R1jjdoA/MyslRnGDBrarPhPv3O8V8nQTinkxBX78O2
         1u0gp3xytA+oINw+NizDSVapwgPCn8UIlQOweBTlg/DxloT62xhbeR2/KfYcCT+CR5n5
         FoD1m0WGw4gEanoi/kzNuz3zX9MzXvrhLeBaEwvfiV/uRWD+3BXr7MVff/SrZVEp99DR
         PApeHHYPaL01eGLGrhz5jFMOkLLYRpS4qdRTDJpXZ3wAWpZH4ZBZ7YEA8XQwMnCpnccL
         1ZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yAz3k7OzPjxwzR5iBZENxEm1ewgrxin9ITMqtF0yTXk=;
        b=b8Ee5mDFGArodcOiRAHt8eIBxDA/SNFsIwRUUVTinrQddkqjXm2jWjOrqhjwNohw3q
         49vLvBhs5Jc54NjZyGGKkud9rmHoqVrjnP8gjiiaZ1AbZlrB6X1wQMigdu0acUhUOfZY
         bqwSmL9TK4miUC5YpbmnLK5hI0M11udWFMCI5mrJHmaw3BPyTRfqnwIht6ISvJlJY4S1
         OtmhDFT4tRsrshub8es6xVDLhATktmSmQE7B8yzte7NSPKQKtiXvijQHHvZe35MqqiIV
         oh0PjaK853sRurYy3CujamWT9mfmqGtXpcYhxpyZ1WYtI9hPmWKdZr+cjBnyI1LMEM5M
         wpcw==
X-Gm-Message-State: APjAAAVUbthWK3CIXmDatqjMuoCZ6MDOhbDvPVnA2rTS622lBp2df0dO
        NFJx/E0fA9kxZJyctr/jsBpIkgFU7RNh3YE=
X-Google-Smtp-Source: APXvYqzgoCdbmtERP8lXY/RLG0ooX+4jcXs9QIN2JZHB94tDUDQbpKEPFjga7MoFGI0pHJDoAp7O7S8tT1TDM6M=
X-Received: by 2002:a67:1ec1:: with SMTP id e184mr19214210vse.83.1559969029067;
 Fri, 07 Jun 2019 21:43:49 -0700 (PDT)
Date:   Fri,  7 Jun 2019 21:43:31 -0700
In-Reply-To: <20190608044339.115026-1-saravanak@google.com>
Message-Id: <20190608044339.115026-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190608044339.115026-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v1 1/9] dt-bindings: opp: Introduce opp-peak-KBps and
 opp-avg-KBps bindings
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
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

