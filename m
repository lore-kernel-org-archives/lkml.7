Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B420C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BEF218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTlYUPxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfDWN22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:28:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39672 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfDWN22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:28:28 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so13518300ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=az2eewAoUAngKwYt3jfUJjVHvJWsoW9KqfbViPSA1zI=;
        b=KTlYUPxcIs3ky4JbfVSD7KmOrUfwPu7Z/zzH+LBPE5xcoxjc4UTDtlcJGkUpxxTc94
         7J4duCMd4H1oL4V/yEidAePnFeX6P8plqYrhoKnwNABDfBBoIrKw01RHcapFmNmRplIX
         2vOJEHJCDuhuTIw+7uNgBmImpPAnWc51EGCx1nVW5/3y252uDNmr9vpFPqSd22va2LKX
         Xwv//ZWgyDBXYznEsSv/xUyDweXdfE814lxNhO5sXs67kLBmmu8QaxcAjESil7GzZP/3
         uQSEiftQnCWcWgkqVfRB//NHlVlk6RpyMGor/Grl6X5KvyD7VtZlj1FXEihhYHDyqaBy
         8uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=az2eewAoUAngKwYt3jfUJjVHvJWsoW9KqfbViPSA1zI=;
        b=eSUZ01QNS3Zjk/bbL+N0PilFTZ7XyZ9Rf9qntbULZmZSis7iJRiPcon9TRYPwJoFSA
         QLv8AsDoEo31RaaLezYNd3yrR6Hhx1tUqrPDuGXm+vHs+jFB358GBi5WKi770tukV1+E
         aPc1HpXCIsaRtq1MDyY0SR0l1ujGimN3UCJZFxgbFmZZRJxFtSS+OAevlafq0t9Dbql/
         ox9fLhXwUYJfSJ/4q0fiNnvDsqFJnnTaN0+Id+6N9onZ1LS2wU4hRRq55Y0jgw4ixFaG
         yld/s5FKkGgkrAQ1RfYG9csYRgwqHBrEqMoqe7lX2u4qdLXRsjF2KOF3C0/wHg1KyBWa
         gcUA==
X-Gm-Message-State: APjAAAWwsWy7er76HQgDsmhL2UYjSWOOgp5iTaWFa67FlTHznBZ+Ieu/
        I7L3LP5TqpqR4wutA71Hphu1eA==
X-Google-Smtp-Source: APXvYqzBTitnnonpNVjFVrddoATE+fSypgI47AVPg8DBxZ+/QkoW8EzffmP5F89P4Vje4/ROxrMywg==
X-Received: by 2002:a2e:a0c9:: with SMTP id f9mr3304999ljm.62.1556026106182;
        Tue, 23 Apr 2019 06:28:26 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y206sm4617107lfc.72.2019.04.23.06.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:28:25 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v2 0/5] Introduce OPP bandwidth bindings
Date:   Tue, 23 Apr 2019 16:28:18 +0300
Message-Id: <20190423132823.7915-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a proposal to extend the OPP bindings with bandwidth based on
a previous discussion [1].

Every functional block on a SoC can contribute to the system power
efficiency by expressing its own bandwidth needs (to memory or other SoC
modules). This will allow the system to save power when high throughput
is not required (and also provide maximum throughput when needed).

There are at least three ways for a device to determine its bandwidth
needs:
	1. The device can dynamically calculate the needed bandwidth
based on some known variable. For example: UART (baud rate), I2C (fast
mode, high-speed mode, etc), USB (specification version, data transfer
type), SDHC (SD standard, clock rate, bus-width), Video Encoder/Decoder
(video format, resolution, frame-rate)

	2. There is a hardware specific value. For example: hardware
specific constant value (e.g. for PRNG) or use-case specific value that
is hard-coded.

	3. Predefined SoC/board specific bandwidth values. For example:
CPU or GPU bandwidth is related to the current core frequency and both
bandwidth and frequency are scaled together.

This patchset is trying to address point 3 above by extending the OPP
bindings to support predefined SoC/board bandwidth values and adds
support in cpufreq-dt to scale the interconnect between the CPU and the
DDR together with frequency and voltage.

[1] https://patchwork.kernel.org/patch/10577315/

Changes in v2:
* Added support for configuring multiple interconnect paths per each device
and changed the way we describe it in DT. (Viresh)
* Rename the DT property opp-bw-MBps to bandwidth-MBps. (Viresh)
* Document MBps in property-units.txt. (Rob)
* New patch to add of_icc_get_by_index() helper function.
* Add _of_find_paths() to populate OPP tables with interconnect path data
from DT. (Viresh)

v1: https://lore.kernel.org/lkml/20190313090010.20534-1-georgi.djakov@linaro.org/


Georgi Djakov (5):
  dt-bindings: opp: Introduce bandwidth-MBps bindings
  interconnect: Add of_icc_get_by_index() helper function
  OPP: Add support for parsing the interconnect bandwidth
  OPP: Update the bandwidth on OPP frequency changes
  cpufreq: dt: Add support for interconnect bandwidth scaling

 Documentation/devicetree/bindings/opp/opp.txt |  38 +++++++
 .../devicetree/bindings/property-units.txt    |   4 +
 drivers/cpufreq/cpufreq-dt.c                  |  27 ++++-
 drivers/interconnect/core.c                   |  45 ++++++--
 drivers/opp/core.c                            |  96 ++++++++++++++++-
 drivers/opp/of.c                              | 102 ++++++++++++++++++
 drivers/opp/opp.h                             |   9 ++
 include/linux/interconnect.h                  |   6 ++
 include/linux/pm_opp.h                        |  14 +++
 9 files changed, 327 insertions(+), 14 deletions(-)

