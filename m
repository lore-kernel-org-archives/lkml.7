Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E001C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243DE2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 13:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="hU1Mn+ip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbgAINw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 08:52:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42398 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgAINw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:52:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so7442479wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 05:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vmHw6Rztk1LgVkwramcXLwEMbfT/KPvyudxKdtElSqM=;
        b=hU1Mn+ipMihLL4KLrkeIpBebma65ax6OVx/CZ7BMWMJ7lkiVPGfRvuGNDb+rOkVZlT
         CMhcMe9oKcneUvShrYwP0MqHMcHPUdR1UY0XrSxfYU8lwwqgfCZkOQuaAaHfHRHu72Su
         HNOoSVZDaEq+nyADGyYORh3MddsE2t/0JeQyV8dN6e7ouM4cmVGC+CH/wyF7r8qZBYmf
         Z5UdGMTNB9eHuDxiZpopOpMID3V4bttz7E5u6m37m1ira7tSHyhMOnYHsd14XiEQRNqr
         x7gKpM4AxlEpWENMj1rNooOmhT0Z8vfkEO5rzzCFgXp+UrRkzpaxEIABkJ2BPdzdLh1+
         EAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vmHw6Rztk1LgVkwramcXLwEMbfT/KPvyudxKdtElSqM=;
        b=QosA5FFRgx+DsAOQY6SON1R9/X2i++QLnYqNke4JcKmkD+U3egVg5FHmmCrLriPAbD
         cwFt5QSlmGXxIPSWWXsZw1cKNMjSPIQvjrL5QjYo+7Sr9pDXwKTbOfLPcTYmOrFzpt0n
         Lo42YDJyymumPyXh9cCNpUDghxGxjA0ioQYtWTQpmISPFsNCwdhX8ao1nFme/hxSLHfr
         OlKL5X5naWiAKyb3vPD5I4o+iwErOUwyBbf3ZhrXqEB5o+fU+NDV82lA5/2NhrTXpSfv
         LC26ik9fA1728nBtStzC+j8TmV0aWxZJz7OemRuSUqSqC+x41vOYwWSFFeY3MQQCsARQ
         QLDQ==
X-Gm-Message-State: APjAAAX2j4XHahDvczAaeGPBVl4U5N3kOnxXIJae0GwU93Xvhy8MATPL
        xpwYeFnsAKJ8q0i2S6gXti1b9Q==
X-Google-Smtp-Source: APXvYqz+VUgDWR5JboQ+8bL+OdFFBBWwy95DgHFHZ12Ed6yWxa7cNlhqpM6SgsefPSWzNDnk6l65FA==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr10759562wrn.251.1578577944116;
        Thu, 09 Jan 2020 05:52:24 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j12sm8350363wrt.55.2020.01.09.05.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 05:52:23 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-arm-kernel@lists.infradead.org, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] arm64: zynqmp: Various DT fixes
Date:   Thu,  9 Jan 2020 14:52:14 +0100
Message-Id: <cover.1578577931.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am sending various DT fixes which have been found over the xilinx
release.
1-2 patches are fixing reported description issues
3-8 patches are actual fixes.

Thanks,
Michal

Changes in v2:
- Add missing patch
- Add missing patch

Michal Simek (7):
  arm64: zynqmp: Use ethernet-phy as node name for ethernet phys
  arm64: zynqmp: Remove addition number in node name
  arm64: zynqmp: Fix address for tca6416_u97 chip on zcu104
  arm64: zynqmp: Turn comment to gpio-line-names
  arm64: zynqmp: Setup clock-output-names for si570 chips
  arm64: zynqmp: Remove broken-cd from zcu100-revC
  arm64: zynqmp: Setup default number of chipselects for zcu100

Venkatesh Yadav Abbarapu (1):
  arm64: zynqmp: Fix the si570 clock frequency on zcu111

 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  2 +-
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  6 +--
 .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  2 +-
 .../dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |  2 +-
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    |  3 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 47 +++++--------------
 .../boot/dts/xilinx/zynqmp-zcu102-revB.dts    |  4 +-
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  6 +--
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  4 +-
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  6 ++-
 10 files changed, 32 insertions(+), 50 deletions(-)

-- 
2.24.0

