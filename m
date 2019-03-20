Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C31C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E582175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCFcVg/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfCTIbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:31:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42280 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCTIbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:31:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id w139so1110466oie.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L/t7ijf9ey/1rUgx6swGc/ZJCfH3ZpxRkYd1HfGBRrw=;
        b=tCFcVg/w9oU+vqz1HjqYUztEuejVM340ryCK8ujnOP4RQQtCR8TYFd0pgxJMqjnRuJ
         Ft3NQrEhbAS2BMfjJ1gRC+l54gfNnc3G36QSiCkYwOeISin2+UVTw9G+rZ5Xx25foMxO
         OcWZzn9WxciTZQmo4dXAgjgl/HkZmN+o6tp78kAITM9jUCs7aItcgbxdCYjfDzLScihT
         Y4Ri2ZRdZ+smKmpenbpALz9mKw8OAdLwhOx9fXpVsORuF1mIfvFeHwSpj4LJx/eCYQGP
         rwCw2kRXCNUZqfm2mJZfikH3D2oyniApwzPetcdSCuFw0fL81k5czjUIuinUQsCmT9+1
         5E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L/t7ijf9ey/1rUgx6swGc/ZJCfH3ZpxRkYd1HfGBRrw=;
        b=kWr//rpDTPtKO0E+F7XRRLdbWLbgA8rpahdDkOyDeQy1dQY23YK0bbpspoWlHZsCIc
         Qgafya5/X9fYVmVYT9bGRNPk01gD7JULoJn32xr0nTS2aoDrrHADMMxALLq8+SfyzRM+
         ytBpD6/PRgQzCAZakcdeduQw9/7sPUviE4ANilIbpfUY2wvGQ1kVlGBmew8OSSK6e17o
         iqDSItlh5rJINLQp1ec6t07hw368/CBwk0mWc4fFCZptoLPBqz02nk4rdH79kwBkW9D9
         NvFvuGUM7x72Nxw61xZSngo+qb5LvXvIli2IHbWezhR62AQZXEGatF8tjrXlGpS/MJPR
         m83Q==
X-Gm-Message-State: APjAAAUXdeWcyAvRCKKC6htICilNDRYu/Q0aIBX0ywmYUfm5+UFjzzQR
        ScPUpI5W+4IVN4Q3xzj84gQfEw==
X-Google-Smtp-Source: APXvYqztkHQvuvCUcWBOlzcHRqQirwPlf2/NFq/tGqYSPmV5tjSrDDbmKjmPIfDD+E79PpuJgf0sRA==
X-Received: by 2002:aca:abce:: with SMTP id u197mr4430167oie.67.1553070682333;
        Wed, 20 Mar 2019 01:31:22 -0700 (PDT)
Received: from localhost.localdomain (li808-42.members.linode.com. [104.237.132.42])
        by smtp.gmail.com with ESMTPSA id u201sm534704oiu.2.2019.03.20.01.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 01:31:21 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] arm64: dts: juno: Enable smmu_pcie for Juno r1/r2
Date:   Wed, 20 Mar 2019 16:31:05 +0800
Message-Id: <20190320083105.8954-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though PCIe controller has been enabled on Juno r1/r2, but it misses to
enable its connected SMMU.  From the testing, even without set this SMMU
status property to 'okay', the PCIe NIC device still works well.  Since
the SMMU is not enabled in DT binding and its iommu_groups is not
created properly, finally this prevents to enable vfio-pci for NIC
device with KVM.

After reviewing the code in dts, Juno r1/r2 both have enabled PCIe
controller but Juno r0 board (in juno.dts) doesn't contain PCIe
controller; hence this patch only change SMMU status property to 'okay'
for Juno r1/r2 dts files for the sake of only enabling it for Juno r1/r2
and avoiding touching Juno r0.

Committer testing on Juno r2:

Before:

  root@debian:~# tree /sys/kernel/iommu_groups/
  /sys/kernel/iommu_groups/
  ├── 0
  │   ├── devices
  │   │   ├── 7ffb0000.ohci -> ../../../../devices/platform/7ffb0000.ohci
  │   │   └── 7ffc0000.ehci -> ../../../../devices/platform/7ffc0000.ehci
  │   ├── reserved_regions
  │   └── type
  └── 1
      ├── devices
      │   └── 20070000.etr -> ../../../../devices/platform/20070000.etr
      ├── reserved_regions
      └── type

  7 directories, 4 files

After:

  root@debian:~# tree /sys/kernel/iommu_groups/
  /sys/kernel/iommu_groups/
  ├── 0
  │   ├── devices
  │   │   ├── 0000:00:00.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0
  │   │   ├── 0000:01:00.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0
  │   │   ├── 0000:02:01.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0
  │   │   ├── 0000:02:02.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:02.0
  │   │   ├── 0000:02:03.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:03.0
  │   │   ├── 0000:02:0c.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:0c.0
  │   │   ├── 0000:02:10.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:10.0
  │   │   ├── 0000:02:1f.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:1f.0
  │   │   ├── 0000:03:00.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:01.0/0000:03:00.0
  │   │   └── 0000:08:00.0 -> ../../../../devices/platform/40000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/0000:02:1f.0/0000:08:00.0
  │   ├── reserved_regions
  │   └── type
  ├── 1
  │   ├── devices
  │   │   ├── 7ffb0000.ohci -> ../../../../devices/platform/7ffb0000.ohci
  │   │   └── 7ffc0000.ehci -> ../../../../devices/platform/7ffc0000.ehci
  │   ├── reserved_regions
  │   └── type
  └── 2
      ├── devices
      │   └── 20070000.etr -> ../../../../devices/platform/20070000.etr
      ├── reserved_regions
      └── type

  19 directories, 6 files

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-r1.dts | 4 ++++
 arch/arm64/boot/dts/arm/juno-r2.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index b2b7ced633cf..67e161a6272a 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -226,6 +226,10 @@
 	status = "okay";
 };
 
+&smmu_pcie {
+	status = "okay";
+};
+
 &pcie_ctlr {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index ab77adb4f3c2..0e1c5c814b01 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -226,6 +226,10 @@
 	status = "okay";
 };
 
+&smmu_pcie {
+	status = "okay";
+};
+
 &pcie_ctlr {
 	status = "okay";
 };
-- 
2.17.1

