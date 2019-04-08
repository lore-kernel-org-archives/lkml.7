Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B3AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF59320B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="b9Ky3uHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfDHH7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:59:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38754 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHH7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:59:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so15133833wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 00:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHapcR7l3a/Py79YDzyEmK8SvOuoZT5a5WbVpTBwyls=;
        b=b9Ky3uHrqJujYuh2FP80gbtICBxMrnPrfI83+49MmrhDMauEScALytS/HFmDLztFD8
         h2TZSQV753mA3vucc8CYt4hKIGuVjsLR+GmkYJYpe8fsQhUAWnR6HBS5V4WHj/oQboip
         ip0m/UAvI8dH7MU5ZAUbqwH6i9+jkzLJUe77o9oatFpJSp4+lvs6+b7RyyuFQVuG0Pk4
         Spb3ue6QKLfmbOkbKSOKkfUXqFWw7970LBY1VnMzGUBH4iHnuCRPniT7S7egFOJUfahK
         YDjml/Fd0vxGE98v7gUUH7CICRk8rbB9V0NcvqX0SGFO9LvpXiy6mHFYfEe9+PlwZbCJ
         SoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHapcR7l3a/Py79YDzyEmK8SvOuoZT5a5WbVpTBwyls=;
        b=JYHY2nmOt3rdJV94SwarNfxGfIrGgelA5l8l6oRKD58wmcOdmcxmlWdIsPkloj4GCe
         BDnGbbyh0uf4gFotrjKpqt95bbwwShshtzgtvem8uUar21lSZykTq3+hyak/gKvz4ly5
         wJiPPER9kijPjrwc9Aa36S/1z+j8HbR6c0MkeQ4MHNbtZ/13EgeqwkfA8teLYj6r2/5C
         tCu3qaYotlWX4jBe37FUCxDUwU21r8rHembsVTtMrJmrUefu1JY3lzU4YnsFTTuEA88S
         TcUgR7cZ1afKRRAMT/rVB53SzcleDwM6+nHagE+TIdZb9x1X2RUvIKWN0dV5xQeDlCzn
         2ntQ==
X-Gm-Message-State: APjAAAV1oE+W0Z+Mub5W8tJgnWMJoL7EhrtJssYpihA6lmcox/6rw+z7
        dxrLqZ//fBBPDXi7YMHtA7Lb3A==
X-Google-Smtp-Source: APXvYqxBW1QNNVbkMa32QxUrZndaKMINo6ap33NoWplVLC4FgjGYcicndl+tSle26OEFZl+n1iXv0Q==
X-Received: by 2002:adf:e288:: with SMTP id v8mr12526132wri.7.1554710372846;
        Mon, 08 Apr 2019 00:59:32 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-12-194.w90-86.abo.wanadoo.fr. [90.86.215.194])
        by smtp.gmail.com with ESMTPSA id o17sm31658711wrw.73.2019.04.08.00.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 00:59:32 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 0/3] ARM: da850: enable cpufreq in DT mode
Date:   Mon,  8 Apr 2019 09:59:21 +0200
Message-Id: <20190408075924.2284-1-brgl@bgdev.pl>
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

Bartosz Golaszewski (1):
  ARM: dts: da850-evm: enable cpufreq

David Lechner (2):
  ARM: dts: da850: add cpu node and operating points to DT
  ARM: davinci_all_defconfig: Enable CPUFREQ_DT

 arch/arm/boot/dts/da850-evm.dts        | 13 ++++++
 arch/arm/boot/dts/da850-lcdk.dts       | 31 ++++++++++++++
 arch/arm/boot/dts/da850-lego-ev3.dts   | 30 ++++++++++++++
 arch/arm/boot/dts/da850.dtsi           | 56 ++++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig |  1 +
 5 files changed, 131 insertions(+)

-- 
2.21.0

