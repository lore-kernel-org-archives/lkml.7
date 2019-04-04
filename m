Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D06C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F69A2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sd+S/WBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDDDft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:35:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40425 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDDft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:35:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so497914pgo.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SzMmPvMQAmPO6BOEfaZSK+hLAqRvRp/TykXUpsX/htk=;
        b=Sd+S/WBjBW0/zkvWyEjUQr1HXyWBW2CBK3x4N8FkSYQ/cJIBSvklAI7NQvLim3QY9R
         dVzaw6G7nALCDc3k6zFCn7+I5FbEQl1FZz6y6OxcmcKogIEf89nxZf/AHlBc/3cfhsTu
         g1MydHc9mfIu+oa6Tb2C4dbKEbNNtSGauZJQ+iKp0yQPuggV/xm/jvJKBIEIX2WMd7AB
         cttd8FyykfSxLp1UIg6wc2UARRcsYv7vumYeoVwbAMhKQwyji2SGz5+b2eE1Jn6xsMGP
         vxn+lLztzA5YLLXI4QmzERgfHlQJrisE6SvHkAPQYpVuUnnRw1kPTZIt0Y4G5YdTvLbm
         GYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SzMmPvMQAmPO6BOEfaZSK+hLAqRvRp/TykXUpsX/htk=;
        b=Bcgd1G582vZjr4GAEQrlDPBgXSKfAtjAETQuIKzVHx5PfNZASVNHGqQjphvSIJTLGq
         qf9ZqdMUlJQ64yrbadq22dgUEHwH64/2AcMC81syY9uUjPVYqaCBdqkHUyZCNYaJvNbB
         UJvD5ueMJJ6KgXN79bsco8S8AQfD5DTj0OG4wViTC5lEuA9atPv9XruCeNXoCalAQvMh
         wGejEXFgrQ+wZ/bqh3R+6GX0c9d1+y2jGDh6r7DIbD3+TR8bRooG+o0zfdfuziH/EafG
         UnEyRWV0xQ1MEVgWnexZfSfe4xDP1Qujm6G+ycipMpiKuMommd+YukQbEmkeXqxnUVzZ
         aUOA==
X-Gm-Message-State: APjAAAVLTu7up0eJZdef6cokaPw94YGubu3wP8wSw+vslxZRaA+x2q+t
        t7a6RQGY2H6EQkiK6OEE+Ewgfw==
X-Google-Smtp-Source: APXvYqzkYAvDWxUQc601PlsEgyTKMKWB74DkuSdVcjL3JTE6FDkbsjGXXuCYU2y+2Qw8vT8yuOWJdA==
X-Received: by 2002:a62:4d43:: with SMTP id a64mr3341616pfb.157.1554348948423;
        Wed, 03 Apr 2019 20:35:48 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:35:47 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/20] coresight: Add support for CPU-wide trace scenarios 
Date:   Wed,  3 Apr 2019 21:35:21 -0600
Message-Id: <20190404033541.14072-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third revision of a patchset that adds support for CPU-wide
trace scenarios and as such, it is now possible to issue the following
commands:

        # perf record -e cs_etm/@20070000.etr/ -C 2,3 $COMMAND
        # perf record -e cs_etm/@20070000.etr/ -a $COMMAND

The solution is designed to work for both 1:1 and N:1 source/sink
topologies, though the former hasn't been tested for lack of access to HW.

Most of the changes revolve around allowing more than one event to use
a sink when operated from perf.  More specifically the first event to
use a sink switches it on while the last one is tasked to aggregate traces
and switching off the device.

This is the kernel part of the solution, with the user space portion to be
released in a later set.  All patches (user and kernel) have been rebased
on v5.1-rc3 and are hosted here[1].  Everything has been tested on Juno, the
410c dragonboard, and hikey620 platforms.

Regards,
Mathieu

[1]. https://git.linaro.org/people/mathieu.poirier/coresight.git (5.1-rc3-cpu-wide-v3) 

== Changes for v3 ==
* Added review-by tags (some were dropped due to patch refactoring).
* Split IDR and reference counting patches.
* Moved IDR to struct tmc_drvdata to support 1:1 source/sink topologies.
* Enhanced code comments related to design choices.
* Renamed ETR buffer allocation functions to have a stronger perf semantic.
* Rebased to v5.1-rc3.

== Changes for V2 ==
* Using define ETM4_CFG_BIT_CTXTID rather than hard coded value (Suzuki).
* Moved pid out of struct etr_buf and into struct etr_perf_buffer (Suzuki).
* Removed code related to forcing double buffering (Suzuki).
* Fixed function reallocarray() for older distributions (Mike).
* Fixed counter configuration when dealing with errors(Leo).
* Automatically selecting PID_IN_CONTEXTIDR with ETMv4 driver.
* Rebased to v5.1-rc2.

Mathieu Poirier (20):
  coresight: pmu: Adding ITRACE property to cs_etm PMU
  coresight: etm4x: Add kernel configuration for CONTEXTID
  coresight: etm4x: Skip selector pair 0
  coresight: etm4x: Configure tracers to emit timestamps
  coresight: Adding return code to sink::disable() operation
  coresight: Move reference counting inside sink drivers
  coresight: Properly address errors in sink::disable() functions
  coresight: Properly address concurrency in sink::update() functions
  coresight: perf: Clean up function etm_setup_aux()
  coresight: perf: Refactor function free_event_data()
  coresight: Communicate perf event to sink buffer allocation functions
  coresight: tmc-etr: Refactor function tmc_etr_setup_perf_buf()
  coresight: tmc-etr: Create per-thread buffer allocation function
  coresight: tmc-etr: Introduce the notion of process ID to ETR devices
  coresight: tmc-etr: Introduce the notion of reference counting to ETR
    devices
  coresight: tmc-etr: Introduce the notion of IDR to ETR devices
  coresight: tmc-etr: Allocate and free ETR memory buffers for CPU-wide
    scenarios
  coresight: tmc-etr: Add support for CPU-wide trace scenarios
  coresight: tmc-etf: Add support for CPU-wide trace scenarios
  coresight: etb10: Add support for CPU-wide trace scenarios

 drivers/hwtracing/coresight/Kconfig           |   1 +
 drivers/hwtracing/coresight/coresight-etb10.c |  83 ++++--
 .../hwtracing/coresight/coresight-etm-perf.c  |  37 ++-
 drivers/hwtracing/coresight/coresight-etm4x.c | 113 +++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  82 ++++--
 .../hwtracing/coresight/coresight-tmc-etr.c   | 261 ++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.c   |   6 +
 drivers/hwtracing/coresight/coresight-tmc.h   |  12 +
 drivers/hwtracing/coresight/coresight-tpiu.c  |   9 +-
 drivers/hwtracing/coresight/coresight.c       |  28 +-
 include/linux/coresight-pmu.h                 |   2 +
 include/linux/coresight.h                     |   7 +-
 tools/include/linux/coresight-pmu.h           |   2 +
 13 files changed, 546 insertions(+), 97 deletions(-)

-- 
2.17.1

