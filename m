Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A93DC5AE5C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BBD217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjmYkULy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436787AbfIJROk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:14:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35043 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394162AbfIJROj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:14:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id k10so21691598qth.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HbUIStHt9W/VIVERFYwcoKZrgnGZv23yOnmmJWnfWUc=;
        b=FjmYkULyMuJcFn7OokF8bYWgJVx6OD7aYCYCSC4Dqpj2ITrv4r5yGTCwjVijbaDYUu
         We/YcdS0ku60UXpQrNszmQVVnDD79Ay70tiYuCT3+S4VSUQV3DmyKfeifQHF4HU8S03J
         GD0OaCoNlipM/xrnjeL1Cqxx490vIOr1y3FICsO/9bPIeazxhgb8bRjQOD1SPoNBX2Yc
         WvY8JpScsb04OvYCiw0AxSgJLN0hPOOVYQuykM1XIBmppbJUdl7xKJs0QlqX2n+pK2xP
         S1ec721gVt9+qSGz+RiuI42Jjz41w8LxB+2VxEVYOVhytvSgi+CywF8UpAjALOYAZae2
         GDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HbUIStHt9W/VIVERFYwcoKZrgnGZv23yOnmmJWnfWUc=;
        b=JUv4A3tfFe1jj2+zYYHV4Gwm6mhWTx8t0p8ary1rzE12eAAdSEKfdW/sQl31eBK4Bm
         xRZtoEQLytHNnXl57aH9xMjrkOxdPGynznoD7JpYiFLwIKnNEPHg7xjc76pLXWHL61d4
         cJQ3HNzwFLlpEZqMcJdVIOIvBbQ/Xbp4DZwWTJs+Je1jGcJdPQ1kasGgdVPEWWVEyoV+
         KWlDhkPRY96KfRnse9HpEyc8m6DvymH8zlkZPPYh1GQwYwAjgFOUo7GQ7YRnyDTN7nAK
         WEFyC40eS1VKgm6ctDPfwe8r+LtrLbfhcde49imYIHEBqSPLP0vKG8cxD+1/gjvlURzB
         +MVw==
X-Gm-Message-State: APjAAAXGRJwaXs8RDORoz/gtTcLrwIFbGOXHJdXBYcUPXqwa/CKnc+Rr
        i6i6sqSwzgCjguNZthRPgUAOJg==
X-Google-Smtp-Source: APXvYqygj73ABNv7vOyOOorsAJk5oGGfIsSa/ouC8yqhBl2cKmgH+hBRVUAQ4JHsBlgT4pb76Bt4fg==
X-Received: by 2002:ac8:647:: with SMTP id e7mr9928642qth.78.1568135678393;
        Tue, 10 Sep 2019 10:14:38 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id g45sm3400713qtc.9.2019.09.10.10.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Sep 2019 10:14:37 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Introduce Power domain based warming device driver
Date:   Tue, 10 Sep 2019 13:14:31 -0400
Message-Id: <1568135676-9328-1-git-send-email-thara.gopinath@linaro.org>
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
thermal cooling device. In fact, since linux kernel today has
no instance of a resource modeled as a power domain acting as a
thermal warming device, a generic power domain based thermal warming device
driver that can be used pan-Socs is the approach taken in this
patch series. Since thermal warming devices can be thought of as the
mirror opposite of thermal cooling devices, this patch series re-uses
thermal cooling device framework. To use these power domains as warming
devices require further tweaks in the thermal framework which are out of
scope of this patch series.

The first patch in this series extends the genpd framework to export out
the performance states of a power domain so that when a power
domain is modeled as a cooling device, the number of possible states and
current state of the cooling device can be retrieved from the genpd
framework.

The second patch implements the newly added genpd callback for Qualcomm
RPMH power domain driver which hosts the mx power domain.

The third patch describes the dt binding required for a generic
power domain based warming device

The fourth patch introduces the generic power domain warming device driver

The fifth patch introduces the DT entreis for sdm845 to register mx power
domain as a thermal warming device

v1->v2:
	- Rename the patch series from
	"qcom: Model RPMH power domains as thermal cooling devices" to
	"Introduce Power domain based thermal warming devices" as it is
	more appropriate.
	- Introduce a new patch(patch 3) describing the dt-bindings for generic power
	domain warming device.
	- Patch specific changes mentioned in respective patches.

Thara Gopinath (5):
  PM/Domains: Add support for retrieving genpd performance states
    information
  soc: qcom: rpmhpd: Introduce function to retrieve power domain
    performance state count
  dt-bindings: thermal: Add generic power domain warming device binding
  thermal: Add generic power domain warming device driver.
  arm64: dts: qcom: Add node for RPMH power domain warming device on
    sdm845.

 .../bindings/thermal/pwr-domain-warming.txt        |  32 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   7 +
 drivers/base/power/domain.c                        |  37 +++++
 drivers/soc/qcom/rpmhpd.c                          |   9 ++
 drivers/thermal/Kconfig                            |  11 ++
 drivers/thermal/Makefile                           |   2 +
 drivers/thermal/pwr_domain_warming.c               | 174 +++++++++++++++++++++
 include/linux/pm_domain.h                          |  13 ++
 8 files changed, 285 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/pwr-domain-warming.txt
 create mode 100644 drivers/thermal/pwr_domain_warming.c

-- 
2.1.4

