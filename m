Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961DCC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B252085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEdbAftA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFYVdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:33:43 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:44974 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfFYVdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:33:42 -0400
Received: by mail-pl1-f202.google.com with SMTP id n1so15522plk.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 14:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c6hAycyMlxz47CFouFEVRVMQfFzVdquweZ4JkxM8rHY=;
        b=vEdbAftA62D7XRgIji4W8EBitFBZHh3LfoDOdtCDkUr/sLgCAReon/sLsp2TZCVwbg
         CkxOVs5hdloQkhFG/hMcJUpfmAmNc4IASleRLhQvbRZYIY++XI5FkjwlcmMn4PbIeVdg
         QKax3rsPgT6Skrr+8OIOif2cEWoB1PWxiMHrR4KinqV9JS1Hk7peMVLptfltiFvxWp2J
         Ux8LQQtZMShxqosksrqcue6KtFLfTRODveLJm3Clzv5UcDmSJL1YhVnwj9htFjezFvxU
         ROAUBKalSsVqLlFjvE9DrUeRs+j9SCuNFKlJMEEPs9J+tUU+7+/PmI90QnQRgLx17odv
         CMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c6hAycyMlxz47CFouFEVRVMQfFzVdquweZ4JkxM8rHY=;
        b=n7Cameo0LNtGyq4Vn5TVzpr5fHDPunvo5Dl9X3t8//ihPyyROlR6zUjTnK/WjJr/m2
         LzfVOV4o1gK3Vg+02LKz2a/4vKCaOsVMqxMME7HhNkOFekcCoqom6IfsS87UbbGVMjSZ
         blEZ+EWMxx8FdEYJ4TcOWkYO50hKup6jWPX+pW42yS0ys5OrJahMm2I95xDoggkWK9s7
         HqI07kSGbv6jRtSN5GJYf+vjpug400aB+z2eRJIuqsoUZXNScjkdCbLomxUHvjs6+5Rw
         EUMDQawBVYSCwOb9zFwm19kfS45eKbvvmo+xp9+DM3meVaUXimhbecTw3BqPS6pPWZYf
         dCxw==
X-Gm-Message-State: APjAAAVpCEfucqFZwIL7lZgY8OSSgMZ01atFuvtuwCEEC77AMJV8sbk8
        3Ah4a54oyyAphtHBAYMuIrEdHc0+Rl3I3mQ=
X-Google-Smtp-Source: APXvYqzdDqdZcIyyTCQpfYliTXh2485VcU9QWV+U4gKElHjTn2Njkd1hjk1Yn51n6lFbcANWiKh2qE7vcWUFtYc=
X-Received: by 2002:a63:dd53:: with SMTP id g19mr39414633pgj.3.1561498421863;
 Tue, 25 Jun 2019 14:33:41 -0700 (PDT)
Date:   Tue, 25 Jun 2019 14:33:33 -0700
Message-Id: <20190625213337.157525-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 0/4] Add required-opps support to devfreq passive gov
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq passive governor scales the frequency of a "child" device based
on the current frequency of a "parent" device (not parent/child in the
sense of device hierarchy). As of today, the passive governor requires one
of the following to work correctly:
1. The parent and child device have the same number of frequencies
2. The child device driver passes a mapping function to translate from
   parent frequency to child frequency.

When (1) is not true, (2) is the only option right now. But often times,
all that is required is a simple mapping from parent's frequency to child's
frequency.

Since OPPs already support pointing to other "required-opps", add support
for using that to map from parent device frequency to child device
frequency. That way, every child device driver doesn't have to implement a
separate mapping function anytime (1) isn't true.

Some common (but not comprehensive) reason for needing a devfreq passive
governor to adjust the frequency of one device based on another are:

1. These were the combination of frequencies that were validated/screened
   during the manufacturing process.
2. These are the sensible performance combinations between two devices
   interacting with each other. So that when one runs fast the other
   doesn't become the bottleneck.
3. Hardware bugs requiring some kind of frequency ratio between devices.

For example, the following mapping can't be captured in DT as it stands
today because the parent and child device have different number of OPPs.
But with this patch series, this mapping can be captured cleanly.

In arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi you have something
like this with the following changes:

	bus_g2d_400: bus0 {
		compatible = "samsung,exynos-bus";
		clocks = <&cmu_top CLK_ACLK_G2D_400>;
		clock-names = "bus";
		operating-points-v2 = <&bus_g2d_400_opp_table>;
		status = "disabled";
	};

	bus_noc2: bus9 {
		compatible = "samsung,exynos-bus";
		clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
		clock-names = "bus";
		operating-points-v2 = <&bus_noc2_opp_table>;
		status = "disabled";
	};

	bus_g2d_400_opp_table: opp_table2 {
		compatible = "operating-points-v2";
		opp-shared;

		opp-400000000 {
			opp-hz = /bits/ 64 <400000000>;
			opp-microvolt = <1075000>;
			required-opps = <&noc2_400>;
		};
		opp-267000000 {
			opp-hz = /bits/ 64 <267000000>;
			opp-microvolt = <1000000>;
			required-opps = <&noc2_200>;
		};
		opp-200000000 {
			opp-hz = /bits/ 64 <200000000>;
			opp-microvolt = <975000>;
			required-opps = <&noc2_200>;
		};
		opp-160000000 {
			opp-hz = /bits/ 64 <160000000>;
			opp-microvolt = <962500>;
			required-opps = <&noc2_134>;
		};
		opp-134000000 {
			opp-hz = /bits/ 64 <134000000>;
			opp-microvolt = <950000>;
			required-opps = <&noc2_134>;
		};
		opp-100000000 {
			opp-hz = /bits/ 64 <100000000>;
			opp-microvolt = <937500>;
			required-opps = <&noc2_100>;
		};
	};

	bus_noc2_opp_table: opp_table6 {
		compatible = "operating-points-v2";

		noc2_400: opp-400000000 {
			opp-hz = /bits/ 64 <400000000>;
		};
		noc2_200: opp-200000000 {
			opp-hz = /bits/ 64 <200000000>;
		};
		noc2_134: opp-134000000 {
			opp-hz = /bits/ 64 <134000000>;
		};
		noc2_100: opp-100000000 {
			opp-hz = /bits/ 64 <100000000>;
		};
	};

-Saravana

v1 -> v2:
- Cached OPP table reference in devfreq to avoid looking up every time.
- Renamed variable in passive governor to be more intuitive.
- Updated cover letter with examples.

Saravana Kannan (4):
  OPP: Allow required-opps even if the device doesn't have power-domains
  OPP: Add function to look up required OPP's for a given OPP
  PM / devfreq: Cache OPP table reference in devfreq
  PM / devfreq: Add required OPPs support to passive governor

 drivers/devfreq/devfreq.c          |  6 ++++
 drivers/devfreq/governor_passive.c | 20 ++++++++---
 drivers/opp/core.c                 | 56 +++++++++++++++++++++++++++++-
 drivers/opp/of.c                   | 14 --------
 include/linux/devfreq.h            |  1 +
 include/linux/pm_opp.h             | 11 ++++++
 6 files changed, 88 insertions(+), 20 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

