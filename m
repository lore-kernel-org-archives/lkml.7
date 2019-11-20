Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB217C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD572251E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m8Dcg7cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfKTM4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:56:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44288 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfKTM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:56:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id m16so21100005qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VNlZ/FAha3iKWfOhIc4DYO2pJ9QefE2nLob44SiCntU=;
        b=m8Dcg7cpqnDtL5rhRGExV+fgeA7iO2Gwq0VxT5xB/ugruHtNtExvdqZYHlEwjx5Xqq
         nzHy0TuXEEXJZL6DN7e+xvQIj4UaBePSaQ1P21paHUf9uaGFDbH3acXMl1Td3ufZNGBP
         1vjxK4TGIFHRiVWtc32RW4X/ezDJC7aahvg7wpqG5B0GaxXDcqFgHDsg3edDhp5uTlq2
         5DOpjO8fu27p3K0YdsjlQhaxffYNXHuCpCcBSteBBbTWKvuuHMBIjILSiLiGLRXyOhRf
         hfQZumVuwLZlacHZbVnEpb9vZVcFvLAItwiqLnCwVIYGIT7QXAC7rlWhAumk92zHEMug
         Y9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VNlZ/FAha3iKWfOhIc4DYO2pJ9QefE2nLob44SiCntU=;
        b=CDdpfB2XtCv12KHXYIZAUZNgT4qJXO2yPlV3lpLrzT1gZm/u4GrzlybMwDDQInADuI
         cS7210MmkiWR+SNtedurHR3cbO5Vgdb4xUkl9AEjSp1NAx6uxH0BcFiVAzrhfDhOaD3X
         V0doRez8SmUVB5cf88qBKkq4q21NrQw7UKRd3xWJlwWKC/c7I086+1VEiyo09l+SQ39R
         nPzLl7lm/UYX504JT/2BBKa0NU0WXySd6w0Vfyxb/2mS8JaEkCK/nxSfV4aow/bfE+3G
         8p65YMJyT8+dEwMkacpJ+sWxxRxV8VLOdHJF0/Ac6iie8CcLAECzSf05iJqHyUOyFnnE
         svRg==
X-Gm-Message-State: APjAAAWzqglNT2UuPjZvY9of30H34I8oUekKr5w50pkaEkwglFnclLbq
        FyCNoGynZD11BtqQoCrhnWTAKw==
X-Google-Smtp-Source: APXvYqzVdnLKCTQuz42URSFlj8vvD4cR9tivufHNr/dclj9E8ApdhZDS2EsED/hEVq4k8S9GyrRzLA==
X-Received: by 2002:a37:7f02:: with SMTP id a2mr2101242qkd.111.1574254598759;
        Wed, 20 Nov 2019 04:56:38 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r2sm14109637qtc.28.2019.11.20.04.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 04:56:36 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v4 0/7] Introduce Power domain based warming device driver
Date:   Wed, 20 Nov 2019 07:56:26 -0500
Message-Id: <1574254593-16078-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain resources modeled as a generic power domain in linux kernel can be
used to warm up the SoC (mx power domain on sdm845) if the temperature
falls below certain threshold. These power domains can be considered as
thermal warming devices.  (opposite of thermal cooling devices).

In kernel, these warming devices can be modeled as a thermal cooling
device. Since linux kernel today has no instance of a resource modeled as
a power domain acting as a thermal warming device, a generic power domain
based thermal warming device driver that can be used pan-Socs is the
approach taken in this patch series. Since thermal warming devices can be
thought of as the mirror opposite of thermal cooling devices, this patch
series re-uses thermal cooling device framework. To use these power
domains as warming devices require further tweaks in the thermal framework
which are out of scope of this patch series. These tweaks have been posted
as a separate series[1].

The first patch in this series extends the genpd framework to export out
the performance states of a power domain so that when a power domain is
modeled as a cooling device, the number of possible states and current
state of the cooling device can be retrieved from the genpd framework.

The second patch implements the newly added genpd callback for Qualcomm
RPMH power domain driver which hosts the mx power domain.

The third patch introduces a new cooling device register API that allows
a parent to be specified for the cooling device.

The fourth patch introduces the generic power domain warming device
driver.

The fifth patch extends Qualcomm RPMh power controller driver to register
mx power domain as a thermal warming device in the kernel.

The sixth patch describes the dt binding extensions for mx power domain to
be a thermal warming device.

The seventh patch introduces the DT entreis for sdm845 to register mx
power domain as a thermal warming device.

v1->v2:
	- Rename the patch series from "qcom: Model RPMH power domains as
	  thermal cooling devices" to "Introduce Power domain based
thermal warming devices" as it is more appropriate.
	- Introduce a new patch(patch 3) describing the dt-bindings for
	  generic power domain warming device.
	- Patch specific changes mentioned in respective patches.

v2->v3:
	- Changed power domain warming device from a virtual device node
	  entry in DT to being a subnode of power domain controller
binding following Rob's review comments.
	- Implemented Ulf's review comments.
	- The changes above introduced two new patches (patch 3 and 4)
v3->v4:
	- Dropped late_init hook in cooling device ops. Instead introduced
	  a new cooling device register API that allows to define a parent
for the cooling device.
	- Patch specific changes mentioned in respective patches. 

1. https://lkml.org/lkml/2019/9/18/1180

Thara Gopinath (7):
  PM/Domains: Add support for retrieving genpd performance states
    information
  soc: qcom: rpmhpd: Introduce function to retrieve power domain
    performance state count
  thermal: core: Allow cooling devices to register a parent.
  thermal: Add generic power domain warming device driver.
  soc: qcom: Extend RPMh power controller driver to register warming
    devices.
  dt-bindings: soc: qcom: Extend RPMh power controller binding to
    describe thermal warming device
  arm64: dts: qcom: Add mx power domain as thermal warming device.

 .../devicetree/bindings/power/qcom,rpmpd.txt       |   5 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   5 +
 drivers/base/power/domain.c                        |  37 ++++++
 drivers/soc/qcom/rpmhpd.c                          |  47 ++++++-
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/pwr_domain_warming.c               | 138 +++++++++++++++++++++
 drivers/thermal/thermal_core.c                     |  22 +++-
 include/linux/pm_domain.h                          |  13 ++
 include/linux/pwr_domain_warming.h                 |  29 +++++
 include/linux/thermal.h                            |  15 +++
 11 files changed, 319 insertions(+), 4 deletions(-)
 create mode 100644 drivers/thermal/pwr_domain_warming.c
 create mode 100644 include/linux/pwr_domain_warming.h

-- 
2.1.4

