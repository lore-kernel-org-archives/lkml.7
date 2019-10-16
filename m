Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3B4ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D480E21928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 19:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w5G4rO6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394461AbfJPThd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:37:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32998 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394413AbfJPThb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 15:37:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so37937578qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mJHOakKVvshLG3Rzud38KEbOaNx+SThGCVNUUHA+c8k=;
        b=w5G4rO6cnoFzj2kF84Hr/GZtHT1Zve5j9WyjVpVK9JFX1mk/AvbZfE6glsJsrQ2bHZ
         d5BOsKSptJU5C1rkmoLn0qoBb/KDjamoVhNZQGaVK8YXrI5KcY4G4SHD3Y4lnNwXm4zd
         NmfTkknFJgHcYV9nVtUW8GTl+JrglpLjDPrfw5xC5bCBkIMICrkq32IqMFGPeZ+Rzc7t
         VZrraGhKRx+Z7vFexQpkgnUDhj+9WXA2uS/1/4J+kd1U2cQhs9M1HOwkxln44HNgMUiW
         GJ/mMZoochmYSU5FNxeRWPETGriXjfl6QqyVWhLFx8gwcRWSDYZb6/Wn+LJrVuDrsRtW
         /v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mJHOakKVvshLG3Rzud38KEbOaNx+SThGCVNUUHA+c8k=;
        b=HfV3yClwCj2nSrNkpRRHt/tJHHi8Nn/82148MgRC+sOiLoL5fAqbvhpBBVUZQEt7U5
         g1WPGWRIRUBJXgawbOTKOeUzTLrptKRG6yqiP9GvA4yC6BmEMoR9+vZIdiKJZFWBgp2E
         g60yMog9drXQ5iYi9xU/kMja1EZf+fs6rjz0OCbQjRGHJBGtOX5iIVkuL34h5m4//guu
         ykE5+uTr/EVCGUNJAzsltbgnGK7JB14opedUBY2L/PaXwVJ8TRI263MtuQ4gwqBHfpsk
         QsmtAvJ4nfYzeYNQpGUexODd4wi4aKJIDxn/nbrZ7ldqZ9VIOF19zHV1beRpSN/FEGCA
         G7wA==
X-Gm-Message-State: APjAAAUe+r69tapTZBJV/hHZnEpb0wx0yBKshmwZlVxgkFM2YC5aBC6j
        I65BMSB/Qb9ikNfQi//EzNHXUg==
X-Google-Smtp-Source: APXvYqxksfg5j666p6bPfX8pfqyE2zz9v/AOGwzl9RkscOjeUr/PexA0qh0wHbZrIjzQkfl9oeTToQ==
X-Received: by 2002:a0c:c10d:: with SMTP id f13mr44317850qvh.88.1571254648443;
        Wed, 16 Oct 2019 12:37:28 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 54sm16246030qts.75.2019.10.16.12.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 12:37:27 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7]Introduce Power domain based warming device driver
Date:   Wed, 16 Oct 2019 15:37:14 -0400
Message-Id: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain resources modeled as a generic power domain in linux kernel
can be used to warm up the SoC (mx power domain on sdm845)
if the temperature falls below certain threshold. These power domains
can be considered as thermal warming devices.
(opposite of thermal cooling devices).

In kernel, these warming devices can be modeled as a
thermal cooling device. Since linux kernel today has
no instance of a resource modeled as a power domain acting as a
thermal warming device, a generic power domain based thermal warming device
driver that can be used pan-Socs is the approach taken in this
patch series. Since thermal warming devices can be thought of as the
mirror opposite of thermal cooling devices, this patch series re-uses
thermal cooling device framework. To use these power domains as warming
devices require further tweaks in the thermal framework which are out of
scope of this patch series. These tweaks have been posted as a separate
series[1].

The first patch in this series extends the genpd framework to export out
the performance states of a power domain so that when a power
domain is modeled as a cooling device, the number of possible states and
current state of the cooling device can be retrieved from the genpd
framework.

The second patch implements the newly added genpd callback for Qualcomm
RPMH power domain driver which hosts the mx power domain.

The third patch introduces late init ops for thermal cooling device that
is called after the cooling device is created and registered but before
binding it to a thermal zone for specific initializations.

The fourth patch introduces the generic power domain warming device driver.

The fifth patch extends Qualcomm RPMh power controller driver to register
mx power domain as a thermal warming device in the kernel.

The sixth patch describes the dt binding extensions for mx power domain to
be a thermal warming device.

The seventh patch introduces the DT entreis for sdm845 to register mx power
domain as a thermal warming device.

v1->v2:
        - Rename the patch series from
        "qcom: Model RPMH power domains as thermal cooling devices" to
        "Introduce Power domain based thermal warming devices" as it is
        more appropriate.
        - Introduce a new patch(patch 3) describing the dt-bindings for
	generic power domain warming device.
        - Patch specific changes mentioned in respective patches.

v2->v3:
	- Changed power domain warming device from a virtual device node
	entry in DT to being a subnode of power domain controller binding
	following Rob's review comments.
	- Implemented Ulf's review comments.
	- The changes above introduced two new patches (patch 3 and 4)

1. https://lkml.org/lkml/2019/9/18/1180
Thara Gopinath (7):
  PM/Domains: Add support for retrieving genpd performance states
    information
  soc: qcom: rpmhpd: Introduce function to retrieve power domain
    performance state count
  thermal: core: Add late init hook to cooling device ops
  thermal: Add generic power domain warming device driver.
  soc: qcom: Extend RPMh power controller driver to register warming
    devices.
  dt-bindings: soc: qcom: Extend RPMh power controller binding to
    describe thermal warming device
  arm64: dts: qcom: Add mx power domain as thermal warming device.

 .../devicetree/bindings/power/qcom,rpmpd.txt       |  10 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   5 +
 drivers/base/power/domain.c                        |  37 ++++++
 drivers/soc/qcom/rpmhpd.c                          |  30 ++++-
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/pwr_domain_warming.c               | 136 +++++++++++++++++++++
 drivers/thermal/thermal_core.c                     |  13 ++
 include/linux/pm_domain.h                          |  13 ++
 include/linux/pwr_domain_warming.h                 |  31 +++++
 include/linux/thermal.h                            |   1 +
 11 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/pwr_domain_warming.c
 create mode 100644 include/linux/pwr_domain_warming.h

-- 
2.1.4

