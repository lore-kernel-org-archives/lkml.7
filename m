Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED33C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D04217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVJb8P57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFNESH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 00:18:07 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40126 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfFNESD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 00:18:03 -0400
Received: by mail-pf1-f202.google.com with SMTP id z1so847832pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 21:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nYfthp2AfyfO7B9ZHl8Ammgshm5FNB69pWC4uzGdWTs=;
        b=GVJb8P57i8A8s2Q/xPGtRuqGml/T3Dc0WEw/F17bY2Wsfnclfx3eGoWReG2O2lx7Gg
         UqqGqa+5rSPj1HwW/apFO4TKxeR038gAsdmdb24fPQ1J2xlKNO3SQeHYcojtHMumKBTM
         WTe4FG2V1nSEKJ40YNvaiKOND86UFZPcLh+rhoVLkd9aaSK+qGkN6VsEgJZOwSN1d40U
         kCje8mYmJlqqIbPjDs7c3lcHZh5KyfWT17dG7WEjxtFaIU9RkqXXN1EbHmC4Jgfj5ia0
         7vwvk2Tq6R5fIrgtS/V+ak2yQ4QVpk9qGxaCPye+fr3NR5F5nC1yY5k/l8BM9BA+quEd
         R3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nYfthp2AfyfO7B9ZHl8Ammgshm5FNB69pWC4uzGdWTs=;
        b=diaMFxEoLGuraa9cWx+1EDTK/V5RGmuKUB9zaXztcHfeeLR8X/f9vISwMtB3gi/r/z
         XeRAQrBfe/FvhxBWyuVZVjpQbLkABfaz6K/feTOwxv1rhzv2PWHBVDyxakgkOb2ANl45
         RFNy2ypPBI7l2okL/uX9shO90yvLQcuGJZcgMK1gAIFQi9BxWtHXjqY0Emw/RRTkSzwe
         p4JnXTAdlEH7yC0o9wUUfe4TiLkIMNKClthg2Xnqy6UN//lxK+4HXn5TQq8gGMXWSq/w
         S5zCfhhb9UTitCXY38m+ETPNuO47+nGjirprUx0+KhboX9Mom3PbgImjM8ALWjxW5vHE
         /ffw==
X-Gm-Message-State: APjAAAV/1ncBaEzhyKabjYgMTOqNaIX7qddsGgXfb+xNTtS3t+bsZhwS
        nKjzDwJe62PvbtVNUc63aBJorMa5oC6JlDA=
X-Google-Smtp-Source: APXvYqzUC9HlFhAxNmIuXsO0mETwrQGfBv0aMuyKBFgTaDc2h9LrsQyWa5pzvaoE3ygZQW3W2VXMmmglbK9s5ko=
X-Received: by 2002:a63:1919:: with SMTP id z25mr34405308pgl.440.1560485882676;
 Thu, 13 Jun 2019 21:18:02 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:30 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-9-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 08/11] dt-bindings: interconnect: Add interconnect-opp-table
 property
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

Add support for listing bandwidth OPP tables for each interconnect path
listed using the interconnects property.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../devicetree/bindings/interconnect/interconnect.txt     | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
index 6f5d23a605b7..fc5b75b76a2c 100644
--- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -55,10 +55,18 @@ interconnect-names : List of interconnect path name strings sorted in the same
 			 * dma-mem: Path from the device to the main memory of
 			            the system
 
+interconnect-opp-table: List of phandles to OPP tables (bandwidth OPP tables)
+			that specify the OPPs for the interconnect paths listed
+			in the interconnects property. This property can only
+			point to OPP tables that belong to the device and are
+			listed in the device's operating-points-v2 property.
+
 Example:
 
 	sdhci@7864000 {
+		operating-points-v2 = <&sdhc_opp_table>, <&sdhc_mem_opp_table>;
 		...
 		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
 		interconnect-names = "sdhc-mem";
+		interconnect-opp-table = <&sdhc_mem_opp_table>;
 	};
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

