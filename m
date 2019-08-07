Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317A4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A84214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuZtBdB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389444AbfHGWbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:31:16 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:43466 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389284AbfHGWbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:31:16 -0400
Received: by mail-vs1-f74.google.com with SMTP id w76so23475097vsw.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 15:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cO1gXGOyS0gi4TQ5Wq0NWKmVpQwgP9l+EbKlT+h4gHU=;
        b=uuZtBdB/7qm120Nq4qybmRvPR+I9q9Ixj2SEs5qLEw7hCnWKJaIX7nHfzN05S8Vy4N
         epZt1M0q+U54DDnq2jYdBwqpJyjE0IPSPk29QdW4rpPRMHTSevRMRaNO3InbE5rrVdAt
         t3axTnksX9aJake09fiFXBtGmaOWP277JThdHw8b4/gR8nb/0UoWf06gDjhQcqBRK2Ml
         QuFI9Kv7ZSiPp9tnwhKBRXIo0rSrKFKp86U8aVh+u316HgpJmZ2j5OiG+DVtheQqEqeW
         bADKCYVbMb6k+xyfjFFIMI86n4ofrnNOKXzvwf3M9loIElQpTlHmu9VjWQUyx72b8yee
         6Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cO1gXGOyS0gi4TQ5Wq0NWKmVpQwgP9l+EbKlT+h4gHU=;
        b=qB9GMuTQtNwnvn7H/EHelBZxycr0aAum/vNxFY7qTJ8RTS3cJohGIKVOVbp4UkUqGP
         OR74mMdDJlKxlq4l1k1ZEqkP4pecRLR+xXi2c8ojG9DP2WrzC/HWRBM8yhND6rI3YmhO
         q3vHIqoPEIgDZYW/FeMilcxu+nNWb14qsiZGKvF4l2YA6jnVzsOF0BScQ/XMLLY0y6ip
         Li1pKsIy19TIP6wiQ1YtGWjUm6etYFiLrpoQtEZPIHLCq10lX/ov2BX34v4ZYCA4x/R1
         ktguAKCcDOLvy8zzw2HhvI8tsMYavc5sD0smG+2l//7P+FQdPxCW/tKDj3Jy6iX6d/Ym
         lrWg==
X-Gm-Message-State: APjAAAXcLw/JivVK25SOGEsakOsX0sT8EglTNr6smcoaINpQKhEN/2xH
        V4BddvtolD9+fL3wuEpYmjXZ2CllrJwQFoQ=
X-Google-Smtp-Source: APXvYqya79a8mTDjLu2/eYtzqZNc/blOum2HVA6RIc6UOhuB5YGHpARfWsXtxe4HrnBdTDDJj7wdN9IHAnOOlF8=
X-Received: by 2002:ac5:c4cc:: with SMTP id a12mr4618231vkl.28.1565217074937;
 Wed, 07 Aug 2019 15:31:14 -0700 (PDT)
Date:   Wed,  7 Aug 2019 15:31:08 -0700
Message-Id: <20190807223111.230846-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v5 0/3] Introduce Bandwidth OPPs for interconnects
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
v4->v5:
- Replaced KBps with kBps
- Minor documentation fix

Cheers,
Saravana

Saravana Kannan (3):
  dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
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
2.23.0.rc1.153.gdeed80330f-goog

