Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FCFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E6A20652
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YPVYTGQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbfDQP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:27:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44307 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfDQP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:27:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id w18so2388550wrv.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wEn8fXBSZBss5iObsx4KhIm5KoFGCLWDDVJTT2BFY40=;
        b=YPVYTGQqKiWk7pFCY3aT3qPYKYfQSysm7VkcNNdtBLpmLj7PCecNUDa0AnX+ch/tgL
         GT2xYP4NCvjp4tgq0V1ZycHvWC+hQlqj5FDgBxJjptLgNc6mtp4CAAoYTS5oq2OwzIek
         vNzg7oTFbidTdcQa4SpDWOjP/NlzQuDFBzh8lErfQ+ajcHiX6coZakWQ/bE7pXtPGKH0
         /cWDm9X8cndJ0+3UE+Vg/xPQ4N2Iz5hw9M6OMjaAUgyFbIfFz2mo10rjNOBB4MwPphMt
         b4cVezdoeeTkIieyqHUqIl6+rnMQ/rORQSb9GKi5eKdoJG9OiGBuc4tcp2cRpdz0QsKA
         lQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wEn8fXBSZBss5iObsx4KhIm5KoFGCLWDDVJTT2BFY40=;
        b=fz9OQ7gyBnlM1SoJjm/UHSg1qU+1x552ONxTOPXUz0DltdKshLPhPP7zujP6qb4BKc
         N1aR/2RelEq6j9r2w7/IhFjqoa2YPUD2FinHIISkFYF82bBrnB1pQhbUp98p7gZX5/3w
         XzMKqJRxuDvA49AFThtOoIr39V1pnMxcnUjlXs4mKVidRNFaSllPZhqrcb7xFdziBMkV
         6Sf5Eq/smMyqXIWt0cIOypF5s45LfA+CDO10/gNTqD+ZUlCHYcypbmb5tAGuZWjrAmOu
         vPqoxZcInu12zcuHxzQLNk4N8IQU8cTLKN/XkTRTDI9OkkZsO0k96mqcazXPzZhY/edr
         KJeg==
X-Gm-Message-State: APjAAAVtMY6b1Xb8J3nw6KOSt+5yw/kXrnHCI7xwjvPxr2NQcghIIFre
        DRpc+PlS50OUXqrOilV+NStp5w==
X-Google-Smtp-Source: APXvYqwzggXdYzQr2ospevb13Q7iGkkZ6Rfy1VSl0qvgFavdBwmvf5afW5ABSbxz25Pw3mzSXcRvtg==
X-Received: by 2002:adf:f506:: with SMTP id q6mr2823093wro.95.1555514825796;
        Wed, 17 Apr 2019 08:27:05 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-15-216.w90-86.abo.wanadoo.fr. [90.86.218.216])
        by smtp.gmail.com with ESMTPSA id v16sm75478817wru.76.2019.04.17.08.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:27:04 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 0/5] ARM: da850: enable cpufreq in DT mode
Date:   Wed, 17 Apr 2019 17:26:56 +0200
Message-Id: <20190417152701.23391-1-brgl@bgdev.pl>
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

