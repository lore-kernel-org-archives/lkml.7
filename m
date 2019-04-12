Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2675CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CF62171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="H3PCBYxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDLNoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:44:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37705 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfDLNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:44:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so12051543wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVWt61LATsJuUzmWIubC6Tl2rf06ea7oKZOms1boxoY=;
        b=H3PCBYxjxiBiatGlOoFUhMPLDtATPWLDAmMWfD9gxZXeEY9qsj7D/WwqpTaeIF4Rqa
         7HhGM5yWdWsroxWqv3kFxL2GZtiMDCEVnowurESNH46sC+/f0UcafzYZTSe2wMlfeabX
         NaU5LCcU2J7cX312gA8OPCHYdp9hDlBTPIG0UBuJQkrIN0ssylHanTue1EKrBc9Dw0iY
         XegRI/8UGVryDm7rdNiS28fb2vXyaJr/nC5QKZAJOsp5eyTIv/9y3lLJBdi7k7ptmwls
         WXw1nOyh4YFPVIsfA3M+ZYs+g9IeNn+7DKSX8bu2gb0ZwOqNac5uqDjTpwH1kFc5BlWp
         lmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aVWt61LATsJuUzmWIubC6Tl2rf06ea7oKZOms1boxoY=;
        b=BJejDNNWnp44Il1DuymOriX4+fhT5egQVSaNnxDxJm1K1MEqeSpZRThk4zXlMKsYLQ
         IhXyyddo2t7rzlD4po/bue1UiJCEK3vwjWGEFAbIe4KSLcMxVd1m0LR/WELG3TnF10R/
         PZ9ooRWnTTSSp9TkyDeUUL3snkyitcQgVVWRG+t57UeyNqfG6X/ULeNF71YqOBWhcyjA
         D9IoBCavTDB3guYgkxVSt4KM8JsIZbjJJO5NehWHo7WcZlpQhIPUDfAgmBoNGXfc7v7y
         +oI2mUvTddsh552BGBJRpLEaHBjkPqL+n/EGz4tUfOR9Yt9Mbk4ZZRV3GjnaUexCM6RK
         7NOA==
X-Gm-Message-State: APjAAAV+5DFXKIYKll7z0OriCgu3Ayc0lBHtr/9Yzz9zFDVtg0tuPQ8V
        lE7/i88j8xIZAOhAcB9Mn/bBUw==
X-Google-Smtp-Source: APXvYqxYxp4O7/IW+5bc6PlX6sWeZsFQS2i952HO21NK5VqgZpoh88BCka6rZMmFvOV8nuUfBRGvOw==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr34663665wrx.32.1555076682006;
        Fri, 12 Apr 2019 06:44:42 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-35-248.w90-86.abo.wanadoo.fr. [90.86.90.248])
        by smtp.gmail.com with ESMTPSA id s18sm9964672wmc.41.2019.04.12.06.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 06:44:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 0/5] ARM: da850: enable cpufreq in DT mode
Date:   Fri, 12 Apr 2019 15:44:32 +0200
Message-Id: <20190412134437.14864-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series adds cpufreq-dt operating points for da850 boards supported
with device tree (da850-lcdk, da850-lego-ev3, da850-evm).

Last patch enables CPUFREQ_DT in davinci_all_defconfig.

v1 -> v2:
- use the VDCDC3_1.2V regulator as cpu-supply on da850-evm

v2 -> v3:
- drop patch 1, as the revision tag is in fact correctly passed to the kernel
  by u-boot
- only enable the 375 operating point for da850-evm as this is the standard
  frequency for this board

v3 -> v4:
- split the first patch into three separate changesets: one adding the
  operating points to the main dtsi and two enabling cpufreq on da850-lego-ev3
  and da850-lcdk
- remove the operating point not mentioned in the datasheet (415 MHz)
- fix commit message in patch 4/5

Bartosz Golaszewski (1):
  ARM: dts: da850-evm: enable cpufreq

David Lechner (4):
  ARM: dts: da850: add cpu node and operating points to DT
  ARM: dts: da850-lego-ev3: enable cpufreq
  ARM: dts: da850-lcdk: enable cpufreq
  ARM: davinci_all_defconfig: Enable CPUFREQ_DT

 arch/arm/boot/dts/da850-evm.dts        | 13 +++++++
 arch/arm/boot/dts/da850-lcdk.dts       | 31 ++++++++++++++++
 arch/arm/boot/dts/da850-lego-ev3.dts   | 30 ++++++++++++++++
 arch/arm/boot/dts/da850.dtsi           | 50 ++++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig |  1 +
 5 files changed, 125 insertions(+)

-- 
2.21.0

