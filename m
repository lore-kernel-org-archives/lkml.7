Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E6EC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78E3214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSiqMpq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389498AbfHGWbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:31:20 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:47331 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389454AbfHGWbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:31:19 -0400
Received: by mail-qk1-f202.google.com with SMTP id x17so80674070qkf.14
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 15:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ckpmb+TNBKBpyxo3hmHEyu4vxqKi6Nk6GzLW2/f2keU=;
        b=BSiqMpq6HoHNp0p49Nzkyt13lkHVX/6GuQpF8Kr8KnGBApx+sMX49a0LJvr8MGIUjS
         EdPDbkfgrECeizFLqhMGngAXCxcAZ0cTnWpnR65ROBYXP/G7QR3LGE2rbLw2Cra4ThiM
         7rrCINPrbNFIOy+XrgB+T0lBNam/8Wac5k3l2IFjBBu8MdAwOmsgFSWKndSDyYHrO1Xh
         TtHur7MsUe0HOzKF/E4BPURvDt23OGElVYq5r9NgKsaDuiEsW3bR35MH3nXQTNGrTwwV
         sFaHapXc6X2Nv71ho23ujXWOM4Y10idK1WOQOJmoGP/BzLFZzboUCloJTqNyBnSILmLE
         VprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ckpmb+TNBKBpyxo3hmHEyu4vxqKi6Nk6GzLW2/f2keU=;
        b=Fon+wgXxZJ60x2oJprCbwlfRE6tE5dRx7ndvVFjhHTqTBFylo2Xe4re2XrhefeCDGY
         fROFIxNlZUICaBG/MJXt7tm75RZJJ7xrw+wS+nyzTXprq/bRDkbbNNjS01Oq8uKY6n4y
         Lf1XD8KZNVfKFXiFHN73YYT1GugtaQG/aiDYqdYayiyC+GXo4kBOyweNPfDatQd8HsRS
         b7Dcu1Qe8niKrgJ8yohtc6/dcZcGxvKZ/auHeokeKhLtNwvwhLv6kqdei02y8u7BF6kF
         90YAob0QsBUYrN1wM02s6HqM2MkoACCGwkbxDBpnLqeB1FI+xB9MXiwSEqIOp0nDx/Ed
         olvg==
X-Gm-Message-State: APjAAAUhgTNOSHYJORlmuLKx0hZHDXfJRQdY6S5jPcOIvih49yQYzFhC
        xI/6TSiyBO6ZWI1xssj5gQ3wYU6ialxqIXo=
X-Google-Smtp-Source: APXvYqxDhQTeMZ27YhUXhV335PAv5RzZgLceI6C81MqWo0wkCxeUetGuTCa6PoXaTHbL84zYlcM32MoiII/dMXk=
X-Received: by 2002:a37:be87:: with SMTP id o129mr10537574qkf.31.1565217078090;
 Wed, 07 Aug 2019 15:31:18 -0700 (PDT)
Date:   Wed,  7 Aug 2019 15:31:09 -0700
In-Reply-To: <20190807223111.230846-1-saravanak@google.com>
Message-Id: <20190807223111.230846-2-saravanak@google.com>
Mime-Version: 1.0
References: <20190807223111.230846-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v5 1/3] dt-bindings: opp: Introduce opp-peak-kBps and
 opp-avg-kBps bindings
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
bandwidth. So, add opp-peak-kBps (required) and opp-avg-kBps (optional) to
allow specifying Bandwidth OPP tables in DT.

opp-peak-kBps is a required property that replaces opp-hz for Bandwidth OPP
tables.

opp-avg-kBps is an optional property that can be used in Bandwidth OPP
tables.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/devicetree/bindings/opp/opp.txt     | 15 ++++++++++++---
 .../devicetree/bindings/property-units.txt        |  4 ++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 68592271461f..dbad8eb6c746 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -83,9 +83,14 @@ properties.
 
 Required properties:
 - opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. This is a
-  required property for all device nodes but devices like power domains. The
-  power domain nodes must have another (implementation dependent) property which
-  uniquely identifies the OPP nodes.
+  required property for all device nodes except for devices like power domains
+  or bandwidth opp tables. The power domain nodes must have another
+  (implementation dependent) property which uniquely identifies the OPP nodes.
+  The interconnect opps are required to have the opp-peak-kBps property.
+
+- opp-peak-kBps: Peak bandwidth in kilobytes per second, expressed as a 32-bit
+  big-endian integer. This is a required property for all devices that don't
+  have opp-hz. For example, bandwidth OPP tables for interconnect paths.
 
 Optional properties:
 - opp-microvolt: voltage in micro Volts.
@@ -132,6 +137,10 @@ Optional properties:
 - opp-level: A value representing the performance level of the device,
   expressed as a 32-bit integer.
 
+- opp-avg-kBps: Average bandwidth in kilobytes per second, expressed as a
+  32-bit big-endian integer. This property is only meaningful in OPP tables
+  where opp-peak-kBps is present.
+
 - clock-latency-ns: Specifies the maximum possible transition latency (in
   nanoseconds) for switching to this OPP from any other OPP.
 
diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
index e9b8360b3288..c80a110c1e26 100644
--- a/Documentation/devicetree/bindings/property-units.txt
+++ b/Documentation/devicetree/bindings/property-units.txt
@@ -41,3 +41,7 @@ Temperature
 Pressure
 ----------------------------------------
 -kpascal	: kilopascal
+
+Throughput
+----------------------------------------
+-kBps		: kilobytes per second
-- 
2.23.0.rc1.153.gdeed80330f-goog

