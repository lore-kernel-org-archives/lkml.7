Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CD0C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8563321019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBmE7w7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfELRqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:46:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36175 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELRqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:46:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so11558733wmj.1;
        Sun, 12 May 2019 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVZfv1XrlSfCBKYSGVa1+qErP5NlTniZ7Uw0fXhDRsM=;
        b=nBmE7w7P+u/frCbPSdZZa0Xz+mMQkcFFkWsU3I6Hta0YBTEF9DDgCHpCIVFXrcFstD
         CEvhmQNCSykn2g8xZMk77WWw626Ia3fV1rSp5z1dYf6OVEkMUXY/QD5FRaZ2qY8VVstE
         m5OJQirNJgPgxvv28WYnq8sJXVTdvAmynUI37JIyuZY8Sb/1XxRABptKzWNvbjmnJlnV
         DOwj5L1QUQOvOzZarMkEh80NzOQX8/f1msKgmIyc/ms/1s2dhTxCPcptMh/feRm+rBsI
         QpSQD6JEXJzk1T5/RbL472yHbo/VkcuOMhf15pXbJKuBPmBJ7uTDTF4QBpCLjtJbyZf9
         iXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QVZfv1XrlSfCBKYSGVa1+qErP5NlTniZ7Uw0fXhDRsM=;
        b=o1XknW6Tzvr6gpMwQD6NJC18PzsOy8z8a1akUhRTXyGRAqdL1c//31lt5WZLVDCj3/
         bYWCOt/wIJ5D6dwCTh8Ic3hRK7iC/+i2+7MBQvbHXgzrHMqRM7wABWT6Q98FewpZ9VMh
         t3iMFGO/g30stb7jr84WpSEiOl7MMEo/UwLEIDpUqPyqRydGWsQDPkKJItToO297zHXI
         yXOr8yKkBjNIsYEJgZJ/0F/N6QNkSPjAgs5m2V1c7+YpsVoImFtx1lqEWekk4z5Lg4Ho
         nnEvTK2ccfN2jZm0pOSau0/UtqLaUPTCXrp9Bfemc46zE8tJZXZbE2L5LwLVDqOSo2z9
         6i+g==
X-Gm-Message-State: APjAAAWbh/KvSFAJAqhshAQ9zt+9RpYqMQayho8zSej8i0jQhPVZaS4H
        hhUmFBDvpKcmXQcig+3zs7E=
X-Google-Smtp-Source: APXvYqxhWeqE2lBh2k5a4dTcV7sEJ2M9qqkT8DQ/tBHx1rAhg4yUak6CGFAClz0i/26Aef9LHqGtXw==
X-Received: by 2002:a05:600c:254e:: with SMTP id e14mr1830396wma.70.1557683175358;
        Sun, 12 May 2019 10:46:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id d14sm9090558wre.78.2019.05.12.10.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 10:46:14 -0700 (PDT)
From:   peron.clem@gmail.com
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 0/8] Allwinner H6 Mali GPU support
Date:   Sun, 12 May 2019 19:46:00 +0200
Message-Id: <20190512174608.10083-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Péron <peron.clem@gmail.com>

Hi,

The Allwinner H6 has a Mali-T720 MP2. The drivers are
out-of-tree so this series only introduce the dt-bindings.

The first patch is from Neil Amstrong and has been already
merged in linux-amlogic. It is required for this series.

The second patch is from Icenowy Zheng where I changed the
order has required by Rob Herring.
See: https://patchwork.kernel.org/patch/10699829/

Thanks,
Clément

Changes in v4:
 - Add Rob Herring reviewed-by tag
 - Resent with correct Maintainers

Changes in v3 (Thanks to Maxime Ripard):
 - Reauthor Icenowy for her patch

Changes in v2 (Thanks to Maxime Ripard):
 - Drop GPU OPP Table
 - Add clocks and clock-names in required

Clément Péron (6):
  dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
  arm64: dts: allwinner: Add ARM Mali GPU node for H6
  arm64: dts: allwinner: Add mali GPU supply for Pine H64
  arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
  arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
  arm64: dts: allwinner: Add mali GPU supply for OrangePi 3

Icenowy Zheng (1):
  dt-bindings: gpu: add bus clock for Mali Midgard GPUs

Neil Armstrong (1):
  dt-bindings: gpu: mali-midgard: Add resets property

 .../bindings/gpu/arm,mali-midgard.txt         | 27 +++++++++++++++++++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  5 ++++
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  5 ++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  5 ++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 ++++++++++
 6 files changed, 61 insertions(+)

-- 
2.17.1

