Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BB0C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA5B2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SurNPXVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfE0IXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:23:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54489 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0IXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:23:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id i3so15183573wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 01:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1HoTg11CiJSEjSyfyiy7/iq8y5KaaqCfsxPsdKYjw8=;
        b=SurNPXVNqG3MD6k/IbxKijckX/KQpH0i865vfJvUR4F33jMDcZcJTOP++T+VxU7S72
         +/64GbUB4mjTZSI7lMJLp0vqVF85Km0w9iYYbjYScIT5AVLIuQpRCROcsO1ozXWTI3H4
         V7GxNjJsvsA/UiihdCpizY2dRRgJKkZx4FIw1D8gxkXYqxEFjGHq9mwiFfEWf9z0zmdW
         TfKEmanefRTayv8ppg3yxGppqaU5lxGDmOk+z9g6B4uQYoH83tu554De3JOKH1JxulEq
         68M1PtWdiFDd5pzBe+0qJriwqnTl7KDECPGRABQvDyeS5fYMYrgogepV4K1Ya8yC76u2
         Lsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M1HoTg11CiJSEjSyfyiy7/iq8y5KaaqCfsxPsdKYjw8=;
        b=c4u5zRapMQzpNsTMJkNx4FulO0tFmaI1/7oos4mX4BLFpKS1im+905HNsT2t1QuX+N
         r+X49JwoLFAJxxQgFeE+zI069l0YhwnYcyTpsgr19OwMAaPqvTm5AUqEyR5e5eH3wXpx
         ty1Uk8TZwj7iG+b1RuWMrhNDBzX3PdgYBv7r4BZ1x4FD2txwbfhsN7AdKseu4A9Vm5K8
         /zXb6DQSj9OWx/cv3TDblnEa/aBSL02EVQTJslddlWlbWoZFw3+fAj/t6W3oDNT8IQ/8
         g2gdhDVd9h3vinDxXYqEb77kSzARtXpHPMfudj7GqepgZ8UipnClw41YIUmM3ZcE0e2J
         xjXA==
X-Gm-Message-State: APjAAAV5fYZcr1F4mhiKWMOQVJgLJYvLPt2OjUYHYdGQQv4J7/nepowp
        jsETrpaKu5RVBBHZNfLgBS3YhQ==
X-Google-Smtp-Source: APXvYqz5G9osnUZUYi4yhJKpYIwouvHJ855I3B3nClb2YmknYiniuVlhjaFoR9HDfUiAM1uTJoNDBQ==
X-Received: by 2002:a05:600c:1109:: with SMTP id b9mr4076225wma.107.1558945383865;
        Mon, 27 May 2019 01:23:03 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id n5sm14482754wrj.27.2019.05.27.01.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 01:23:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v5 0/5] ARM: da850: enable cpufreq in DT mode
Date:   Mon, 27 May 2019 10:22:54 +0200
Message-Id: <20190527082259.29237-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Note: resending rebased on top of v5.2-rc2

===

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

v4 -> v5:
- only enable a single OPP for da850-lcdk due to the problem with the OHCI
  controller becoming unresponsive after cpufreq transitions
- fix the name of the pmic on da850-evm

Bartosz Golaszewski (1):
  ARM: dts: da850-evm: enable cpufreq

David Lechner (4):
  ARM: dts: da850: add cpu node and operating points to DT
  ARM: dts: da850-lego-ev3: enable cpufreq
  ARM: dts: da850-lcdk: enable cpufreq
  ARM: davinci_all_defconfig: Enable CPUFREQ_DT

 arch/arm/boot/dts/da850-evm.dts        | 13 +++++++
 arch/arm/boot/dts/da850-lcdk.dts       | 36 +++++++++++++++++++
 arch/arm/boot/dts/da850-lego-ev3.dts   | 30 ++++++++++++++++
 arch/arm/boot/dts/da850.dtsi           | 50 ++++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig |  1 +
 5 files changed, 130 insertions(+)

-- 
2.21.0

