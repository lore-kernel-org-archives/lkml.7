Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53902C41517
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2894422BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGeUakeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfGZXQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:16:05 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:55303 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfGZXQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:16:04 -0400
Received: by mail-pl1-f201.google.com with SMTP id q11so29243327pll.22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cpXw17kbjpY+4NI0A8ywBRzRbBcUV30TBmJ29JFZSu8=;
        b=lGeUakeOQjQpoRbjD3eQTccJQgPrsvuP1WdT/liYx7Tq4s/KNjmGm7SiRV+T/GO/9u
         YWiGATr1gNWtXgVWidLbG4uLV5w27wVYiH72EFZ5EBpetALJZMJotGMiioYxzJ/7QXF4
         D3WPjrZ/bGa2vn4yHXpsDyijYQuJOgC8gJw3ebo9oU9IAzsEP+O84JwPlOy8yym3io0s
         OVIMEsVaCh7+brCgiFB87+mCAMmIs3QEmHlxASphKIK2SPhxWBgiNl9AhSiPneEENtWn
         cXwtId0Hz9cKJG0NRap3E9lfm4x0wdY+ycCU+1qZ5uEmAKpZyjh/uW242uPqyM4DaIet
         iY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cpXw17kbjpY+4NI0A8ywBRzRbBcUV30TBmJ29JFZSu8=;
        b=A2GXo/e8UdIYlJeu7aDumvWD/jDOUZdLTHO7DuBJ9xMnxd0V3G5/LodZ9Dcjm5Ipr6
         lvFCg4w9wU4QqXMPMCX2PmUm4nHzxVyjZBHUKyPw+54C2mAhOXGkhK6CA9fN8hkb6DDK
         NRK5vHNz/Y5vPpmySUvKA1nwZlUm55HPuki1qSHBqJj8POYa3CiwcAo4ybyXgdPxOyC2
         VoXRuFu3E9+SFL/oBznNM40t8OIMh2UQaXO8qIHAsHvncH9MC/gQKihQB9JG16rhUjWJ
         ijIHQn65boYT2TxYF0DLrzFurnEpyPfPtP1HHlg46Ff/zVW2nhLbL1I61ENKrrJio1n4
         TiDA==
X-Gm-Message-State: APjAAAXUl5A1o6Z6GTgfSyjS4Kg2Raj6qOXcdBLNDCAHbnSPf1CUYQd2
        coMA7g376It/CjHV+hY3/GrW9BWRNL/DW9Y=
X-Google-Smtp-Source: APXvYqyLFXzg7wzzQqNVNsI8TFZ+iafyw/A7sv3S5RiRtNoVmsGtyF3JmmM3anWSx8u0e6UhM5jUYxwYZmhQdZo=
X-Received: by 2002:a63:c442:: with SMTP id m2mr95101718pgg.286.1564182963590;
 Fri, 26 Jul 2019 16:16:03 -0700 (PDT)
Date:   Fri, 26 Jul 2019 16:15:54 -0700
Message-Id: <20190726231558.175130-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
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

Interconnects and interconnect paths quantify their performance levels in
terms of bandwidth and not in terms of frequency. So similar to how we have
frequency based OPP tables in DT and in the OPP framework, we need
bandwidth OPP table support in DT and in the OPP framework.

So with the DT bindings added in this patch series, the DT for a GPU
that does bandwidth voting from GPU to Cache and GPU to DDR would look
something like this:

gpu_cache_opp_table: gpu_cache_opp_table {
	compatible = "operating-points-v2";

	gpu_cache_3000: opp-3000 {
		opp-peak-KBps = <3000000>;
		opp-avg-KBps = <1000000>;
	};
	gpu_cache_6000: opp-6000 {
		opp-peak-KBps = <6000000>;
		opp-avg-KBps = <2000000>;
	};
	gpu_cache_9000: opp-9000 {
		opp-peak-KBps = <9000000>;
		opp-avg-KBps = <9000000>;
	};
};

gpu_ddr_opp_table: gpu_ddr_opp_table {
	compatible = "operating-points-v2";

	gpu_ddr_1525: opp-1525 {
		opp-peak-KBps = <1525000>;
		opp-avg-KBps = <452000>;
	};
	gpu_ddr_3051: opp-3051 {
		opp-peak-KBps = <3051000>;
		opp-avg-KBps = <915000>;
	};
	gpu_ddr_7500: opp-7500 {
		opp-peak-KBps = <7500000>;
		opp-avg-KBps = <3000000>;
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
	...
};

v1 -> v3:
- Lots of patch additions that were later dropped
v3 -> v4:
- Fixed typo bugs pointed out by Sibi.
- Fixed bug that incorrectly reset rate to 0 all the time
- Added units documentation
- Dropped interconnect-opp-table property and related changes

Cheers,
Saravana

Saravana Kannan (3):
  dt-bindings: opp: Introduce opp-peak-KBps and opp-avg-KBps bindings
  OPP: Add support for bandwidth OPP tables
  OPP: Add helper function for bandwidth OPP tables

 Documentation/devicetree/bindings/opp/opp.txt | 15 ++++--
 .../devicetree/bindings/property-units.txt    |  4 ++
 drivers/opp/core.c                            | 51 +++++++++++++++++++
 drivers/opp/of.c                              | 41 +++++++++++----
 drivers/opp/opp.h                             |  4 +-
 include/linux/pm_opp.h                        | 19 +++++++
 6 files changed, 121 insertions(+), 13 deletions(-)

-- 
2.22.0.709.g102302147b-goog

