Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F867C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561A0214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCinBtnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbfB1MVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:21:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40793 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfB1MVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:21:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id g20so7957349wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NDmbND9e5ZqG8+uHYhtWAfDXUcra6/i5QSLjwnPDIVU=;
        b=rCinBtncxxIlJik5K2HnrlHXimWlAvYggR3/O4ZFjDclykzA6RvVoKa0Zy7kq6/rDD
         Pf8kYrergfXKjrUTddCozCe89khoYGzNgo1EXo0EEMf5JfZbgAW0YqUzmNWkGJFDlLPI
         6M59YaQm7UmoVIX+j35/K9ZYRtG+umOuSZaI74WB7olE2Ok+UIlA6/k88xiR8c9CTunr
         MwBji94nhWT34aoMrDimuMqYCw80bJvdLxnmm+mS1ynfR9sVZbyY+gLKKf/tfgIj8M3U
         bijGBg3e+e17BefOJVcHbTRRPCzsoARD/jVwcN+WWbPDQOMzw4Ne+bhbNUXVO3P3jJoA
         WR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NDmbND9e5ZqG8+uHYhtWAfDXUcra6/i5QSLjwnPDIVU=;
        b=ozcZetz03jrhKNRt+gZXh4+HfUNuM3yLGhESV/DhM5NYxUglhj/FQYrnbUrnubit9w
         b9JAC7fwCf+5jDhPHk5E0gIhzzAiNQflzjRQZp0Lc0ldw05DYDWQxWd8A0GONIpp/i6e
         g0q/8Rypo0WV1BQKRWuylrxj2RKKS/HrALLKx7TXDnffxJmbU95Lv+UDxCH72h1clgdU
         8fG1/PsHJ8Os5VA2lV19cmVIUiTHupEgdB8M3SZCy+sMbM3QZ93vOs1vxecZdfIXWt6I
         y6ns1b0qTnyy/LaV6/gUdlgj7MrtW6xUn+AMZ5yM8d8YiV7O/mGx2rpMTuRD7EFNQ/Yz
         ckdA==
X-Gm-Message-State: AHQUAubmO266q+joBVgVmQ3r3b0/uTrzlycnfIiiIqoma3/B8L/qDDHj
        UsMKglNMiwCnCFTrfcuMfscjPL+ohxw=
X-Google-Smtp-Source: APXvYqykhW+ij2JMteDCKkfJLkcz57b88iuaGQzTimAAbhQTM150inR84VZ4nCSY42HxtR+Lff19Qw==
X-Received: by 2002:a1c:6342:: with SMTP id x63mr2724034wmb.92.1551356488364;
        Thu, 28 Feb 2019 04:21:28 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id z12sm3654238wmf.31.2019.02.28.04.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:21:27 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 00/24] thermal: tsens: Refactor to use regmap_field
Date:   Thu, 28 Feb 2019 17:50:50 +0530
Message-Id: <cover.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Anything not being throttled in the kernel converted to a hot trip point (no
  cooling-maps)
- Don't print version number of the IP at boot

Changes pending from review of v1:
- Using macros from bits.h as suggested by Eduardo. I'd like to defer this
  change to a separate series where I can convert over all the files (v0.1,
  v1, v2) together. This series is getting quite long as it is.

Short term bandaid fixes to add support for more versions of the TSENS IP
is not proving to be very scalable. Here is a series to finally convert the
driver's core to use regmap_fields so that register addresses and bitfields
can be abstracted away from the code.

This series is posted as one to give a complete view of where I'm going
with this refactor. We can probably split it into smaller sets if required.
Currently it consists of the following parts:

- Patch 01-06: Style changes to make code easier to read (mostly naming
  related). This has no functional change in the driver, it is a series of
  search and replace operations. Ideally this will get merged first,
  otherwise everything else will become painful :-)

- Patch 07-09: Merge the 8916 and 8974 source files into a single one
  called v0_1.c denoting the version of the IP and open up more
  opportunities for reuse.

- Patch 10: This is the core patch that adds IP-specific data based on two
  data structures: tsens_features has bit flags to identify if a certain
  feature is available in a version or not and an array of reg_field
  pointers.

  regfield_ids list the important fields across IP versions and are used as
  an index.

  This patch converts over all platforms except 8960 which currently
  doesn't use DT data for tsens and has custom functions for everything. We
  will get to it eventually, but it's conversion is not necessary for this
  series to be merged.

- Patch 11-16: Clean ups and new functionality based on regmap_field

- Patch 17-19: Refactor the get_temp routine. We expect to have a single
  get_temp routine once all the conversion is finished.

- Patch 20-23: Introduce qcs404 support using new regmap infrastructure.

Testing
-------

Since these changes affect every platform using TSENS, it should be
clarified that I have only been focussing on developing/testing this on
sdm845, msm8916, qcs404.

Future work
-----------

a. Get rid of get_temp_common in favour of get_temp_tsens_valid
b. irq support
c. Convert over 8960 to use regmap_field and as a result common functions

Amit Kucheria (24):
  drivers: thermal: tsens: Document the data structures
  drivers: thermal: tsens: Rename tsens_data
  drivers: thermal: tsens: Rename tsens_device
  drivers: thermal: tsens: Rename variable tmdev
  drivers: thermal: tsens: Use consistent names for variables
  drivers: thermal: tsens: Function prototypes should have argument
    names
  drivers: thermal: tsens: Rename tsens-8916 to prepare to merge with
    tsens-8974
  drivers: thermal: tsens: Rename constants to prepare to merge with
    tsens-8974
  drivers: thermal: tsens: Merge tsens-8974 into tsens-v0_1
  drivers: thermal: tsens: Introduce reg_fields to deal with register
    description
  drivers: thermal: tsens: Save reference to the device pointer and use
    it
  drivers: thermal: tsens: Don't print error message on -EPROBE_DEFER
  drivers: thermal: tsens: Track IP version
  drivers: thermal: tsens: Add new operation to check if a sensor is
    enabled
  drivers: thermal: tsens: change data type for sensor IDs
  drivers: thermal: tsens: Introduce IP-specific max_sensor count
  drivers: thermal: tsens: simplify get_temp_tsens_v2 routine
  drivers: thermal: tsens: Move get_temp_tsens_v2 to allow sharing
  drivers: thermal: tsens: Common get_temp() learns to do ADC conversion
  dt: thermal: tsens: Add bindings for qcs404
  drivers: thermal: tsens: Add generic support for TSENS v1 IP
  arm64: dts: qcom: qcs404: Add tsens controller
  arm64: dts: qcom: qcs404: Add thermal zones for each sensor
  drivers: thermal: tsens: Move calibration constants to header file

 .../bindings/thermal/qcom-tsens.txt           |  14 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi          | 272 ++++++++++++++
 drivers/thermal/qcom/Makefile                 |   4 +-
 drivers/thermal/qcom/tsens-8916.c             | 105 ------
 drivers/thermal/qcom/tsens-8960.c             |  84 ++---
 drivers/thermal/qcom/tsens-common.c           | 165 ++++++---
 .../qcom/{tsens-8974.c => tsens-v0_1.c}       | 158 +++++++-
 drivers/thermal/qcom/tsens-v1.c               | 194 ++++++++++
 drivers/thermal/qcom/tsens-v2.c               | 124 ++++---
 drivers/thermal/qcom/tsens.c                  | 100 ++---
 drivers/thermal/qcom/tsens.h                  | 346 ++++++++++++++++--
 11 files changed, 1232 insertions(+), 334 deletions(-)
 delete mode 100644 drivers/thermal/qcom/tsens-8916.c
 rename drivers/thermal/qcom/{tsens-8974.c => tsens-v0_1.c} (58%)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c

-- 
2.17.1

