Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93827C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DA2205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duv0hVS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbfDYTxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:13 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46766 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfDYTxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:13 -0400
Received: by mail-pf1-f178.google.com with SMTP id j11so417287pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4wTPIP01Eutm4pSRisUovUG4tLZPXcoyncmF8Dtkr/o=;
        b=duv0hVS9q4PL0nUb959Sy54iqO1TJyKiwiwvNvaNb31Lym2cv9PIsIp/lsmWasxgob
         OVMlSKRsticqdmUBZFyVRkjlEbvrD4gW8FftQaKWqSWByfiG1uu/xu2HvaD+vI9GRQ9f
         vj3yAN9hbDpY5gO/k+N52FadAafE6SFgLfTHL78qW9jHVqO9z8abEu204Zd/gqyMKXNU
         d/yjjit05QU53UpWp7+u+uQaRjg5AFdNdKiTZ9cZJRmegI5ugovc/hSCSYhigMfezJk8
         wF/I+NEgckW116A8ykHwiHdsw5jQ4vm4gvHnEqWOULo9+K5lO/n9leuNMSFS85uZ8U7U
         5B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4wTPIP01Eutm4pSRisUovUG4tLZPXcoyncmF8Dtkr/o=;
        b=XKDt7ptCWlMVmfnhm4DPhv68DFzvka/wouwgEcfZ4rhehrJN4fEQpKOtEuN49hcESr
         3ZqviIMixu0dOdP+4pJmlasbiiqZcUnEUg7weppCvVJbuT2V4ygyWcWOB9ZMRgn2uyvp
         a63Izn/pDYmccbtf89TXfXuX/20M+5m4pZijh+ys8PvYsB3+aW/z3WpXXh2E2joLkVSZ
         om74+5lA4KOnTT5hdig5O2710CF3g18d3IZUU1F77YKI9w1YXrxlDK7/F8YhVILuSLcx
         dduKhMIBXt7An5Otlpwe7XWInYM/Y4kvEV20Ygum9OPsHYEWJHWvNtSWYqHcC9bnERda
         g40g==
X-Gm-Message-State: APjAAAUGklmL1Llj79al3ldb8o+1HQV9ZEkrwCGGJp9FLMir/OS4hsFv
        LM3xYVaXSsCPlU2dtKQWPOtq/A==
X-Google-Smtp-Source: APXvYqwbYTHEgzrD9YgKi9QqSPTxhwDPOSUGaiEmhd54m1LZsH2huYDY7+fxQ3Tuv80Hk2F2sDNQgg==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr39268398pgi.123.1556221992626;
        Thu, 25 Apr 2019 12:53:12 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:11 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/32] coresight: next v5.1-rc6 
Date:   Thu, 25 Apr 2019 13:52:38 -0600
Message-Id: <20190425195310.31562-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day Greg,

Please consider the following for inclusion in the 5.2 cycle when you have
the time.

Regards,
Mathieu 

Arnd Bergmann (1):
  coresight: catu: fix clang build warning

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

Suzuki K Poulose (10):
  coresight: tmc: Report DMA setup failures
  coresight: dynamic-replicator: Clean up error handling
  coresight: replicator: Prepare for merging with dynamic-replicator
  coresight: dynamic-replicator: Prepare for merging with static
    replicator
  coresight: Merge the static and dynamic replicator drivers
  coresight: Fix freeing up the coresight connections
  coresight: etb10: Cleanup power management
  coresight: tpiu: Cleanup power management
  coresight: catu: Cleanup power management
  coresight: tmc: Cleanup power management

YueHaibing (1):
  coresight: catu: Make catu_helper_ops and catu_ops static

 drivers/hwtracing/coresight/Kconfig           |   9 +-
 drivers/hwtracing/coresight/Makefile          |   1 -
 drivers/hwtracing/coresight/coresight-catu.c  |   7 +-
 drivers/hwtracing/coresight/coresight-catu.h  |   5 -
 .../coresight/coresight-dynamic-replicator.c  | 255 -----------------
 drivers/hwtracing/coresight/coresight-etb10.c |  97 +++++--
 .../hwtracing/coresight/coresight-etm-perf.c  |  37 ++-
 drivers/hwtracing/coresight/coresight-etm4x.c | 114 +++++++-
 .../coresight/coresight-replicator.c          | 232 +++++++++++++--
 .../hwtracing/coresight/coresight-tmc-etf.c   |  82 ++++--
 .../hwtracing/coresight/coresight-tmc-etr.c   | 266 +++++++++++++++---
 drivers/hwtracing/coresight/coresight-tmc.c   |  17 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |  12 +
 drivers/hwtracing/coresight/coresight-tpiu.c  |  18 +-
 drivers/hwtracing/coresight/coresight.c       |  29 +-
 include/linux/coresight-pmu.h                 |   2 +
 include/linux/coresight.h                     |   7 +-
 tools/include/linux/coresight-pmu.h           |   2 +
 18 files changed, 774 insertions(+), 418 deletions(-)
 delete mode 100644 drivers/hwtracing/coresight/coresight-dynamic-replicator.c

-- 
2.17.1

