Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AFCC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1220420645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gD1H9uju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfGCBK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:10:27 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46057 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbfGCBKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:10:25 -0400
Received: by mail-pf1-f202.google.com with SMTP id i27so392053pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+/NgGwFACy34LZMNgdF6kK1NINvGCtP2Z/MvjjI7Ew8=;
        b=gD1H9ujuBDHYxyQRM/QxbAM3l52LJlazN/k0bex99R3tQl+EKLtZtPVAAE3Y7PRS83
         so+dRF8C5h0z3U2iTRMh+m0UC9PJQGeEpO4BN2p1AG2qg08y9u8qsKrA3a473FdvYzDQ
         9o+1ImEqm49Ba4/rIxrNfFQ5a6gQtJ+MHqIL+IhQBci2U/KwaQwea/xCfZC4wGCQLv/A
         sJtLlgV5jRHx+WJoNEd5sJJvcr1P38owycNXEwhnHsiAUfil7US4V3sb0+0GfyeU08PO
         rlOg/95z7CY5CPeeNzBD6+wNSiJc9qFlzW/OXrkzUe8es9PaWmzgRcmL1CeX1BeGeC4Z
         mCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+/NgGwFACy34LZMNgdF6kK1NINvGCtP2Z/MvjjI7Ew8=;
        b=HtBb6cPtBbJ9+T7tjYPwjRbBsO3ssND0kL18R7LeIEd0tM3hePIZ4xU98lyR7oOt8F
         B1Y6mWW9668RWYuPhBPPycAc0KZe4qjl2k8T2kjtq2tfF7rC/SVXBJtg0rAJedS5l3az
         pZNVeEOdhMA2xIdc4tSnLs9akBwUh9IN+U14UfaVbMT53jBW+UErWgaZ8GsrobBhB4xF
         l+F+81/mztb+W1tuJWAEZWIvZ4bDlWifZAXGSGHetCKVV0UkKsXKkxrbQqCP/h3S8G0A
         geLQaejGGzSY+gyAqGPbXQE0/0dxkiW9JaJSaWik6aU9TasDBlGpcaTXsPg2QJ170Rfe
         s/tw==
X-Gm-Message-State: APjAAAUdDF4xU71HZFbKyeyamMPDwXAGAA3QTWhE3R7H9iRbZ4TJFO+X
        sJmzTspe4jZwAl/7XEMWl+fE0m7dE6mLPY8=
X-Google-Smtp-Source: APXvYqxjLAm5FeB4krGVnJ8xrlNX//iGRKhBSPNoeTp221sbsHnxh0Xh8hiTM1YF3feQVjQjV1Qr19ueNgCNDpo=
X-Received: by 2002:a63:7c0e:: with SMTP id x14mr33166685pgc.65.1562116224469;
 Tue, 02 Jul 2019 18:10:24 -0700 (PDT)
Date:   Tue,  2 Jul 2019 18:10:14 -0700
Message-Id: <20190703011020.151615-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
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

Interconnects and interconnect paths quantify their performance levels in
terms of bandwidth and not in terms of frequency. So similar to how we have
frequency based OPP tables in DT and in the OPP framework, we need
bandwidth OPP table support in the OPP framework and in DT. Since there can
be more than one interconnect path used by a device, we also need a way to
assign a bandwidth OPP table to an interconnect path.

This patch series:
- Adds opp-peak-KBps and opp-avg-KBps properties to OPP DT bindings
- Adds interconnect-opp-table property to interconnect DT bindings
- Adds OPP helper functions for bandwidth OPP tables
- Adds icc_get_opp_table() to get the OPP table for an interconnect path

So with the DT bindings added in this patch series, the DT for a GPU
that does bandwidth voting from GPU to Cache and GPU to DDR would look
something like this:

gpu_cache_opp_table: gpu_cache_opp_table {
	compatible = "operating-points-v2";

	gpu_cache_3000: opp-3000 {
		opp-peak-KBps = <3000>;
		opp-avg-KBps = <1000>;
	};
	gpu_cache_6000: opp-6000 {
		opp-peak-KBps = <6000>;
		opp-avg-KBps = <2000>;
	};
	gpu_cache_9000: opp-9000 {
		opp-peak-KBps = <9000>;
		opp-avg-KBps = <9000>;
	};
};

gpu_ddr_opp_table: gpu_ddr_opp_table {
	compatible = "operating-points-v2";

	gpu_ddr_1525: opp-1525 {
		opp-peak-KBps = <1525>;
		opp-avg-KBps = <452>;
	};
	gpu_ddr_3051: opp-3051 {
		opp-peak-KBps = <3051>;
		opp-avg-KBps = <915>;
	};
	gpu_ddr_7500: opp-7500 {
		opp-peak-KBps = <7500>;
		opp-avg-KBps = <3000>;
	};
};

gpu_opp_table: gpu_opp_table {
	compatible = "operating-points-v2";
	opp-shared;

	opp-200000000 {
		opp-hz = /bits/ 64 <200000000>;
	};
	opp-400000000 {
		opp-hz = /bits/ 64 <400000000>;
	};
};

gpu@7864000 {
	...
	operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
	interconnects = <&mmnoc MASTER_GPU_1 &bimc SLAVE_SYSTEM_CACHE>,
			<&mmnoc MASTER_GPU_1 &bimc SLAVE_DDR>;
	interconnect-names = "gpu-cache", "gpu-mem";
	interconnect-opp-table = <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>
};

Cheers,
Saravana

Saravana Kannan (6):
  dt-bindings: opp: Introduce opp-peak-KBps and opp-avg-KBps bindings
  OPP: Add support for bandwidth OPP tables
  OPP: Add helper function for bandwidth OPP tables
  OPP: Add API to find an OPP table from its DT node
  dt-bindings: interconnect: Add interconnect-opp-table property
  interconnect: Add OPP table support for interconnects

 .../bindings/interconnect/interconnect.txt    |  8 ++
 Documentation/devicetree/bindings/opp/opp.txt | 15 +++-
 drivers/interconnect/core.c                   | 27 ++++++-
 drivers/opp/core.c                            | 51 +++++++++++++
 drivers/opp/of.c                              | 76 ++++++++++++++++---
 drivers/opp/opp.h                             |  4 +-
 include/linux/interconnect.h                  |  7 ++
 include/linux/pm_opp.h                        | 26 +++++++
 8 files changed, 199 insertions(+), 15 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

