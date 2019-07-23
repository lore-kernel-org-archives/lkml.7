Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC059C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9271022387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XU4E26h8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbfGWWfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:35:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44032 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbfGWWfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:35:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so19821657pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BaDjXD/RG0kyUThXx34ExLwb9nVm9t9Qz5HyHcuaCuk=;
        b=XU4E26h8825oOZUQmz4kbSqxedrUdNsyKDmDiQsMbLg6pw7auVMAtsRu03LejgQ56J
         tFpYlWDrQVv0NOtgBqFxgxvRvP39mlEoLRwpVpH189VNdu4MA2CRblZW4bAkICmxxU8d
         cTlOGMH36GlIZnkAjRuNg24F93lggpVYRdewrczApUM1I3GqDS5Dxfv4lcBjDr7QgGwi
         4NWeC+mw9uxYNS+A+nyG3Qew8V2SQkjbg9nepj4Vfehg7MAnHAC2zLPrfPwOSe9X9rlR
         FZj/k25TgdO7Wa96kn7IMSyfu+nk1xDn8osBlF/nbPOJ76Ua87y/ZsSsBmwOIhUr8G0H
         1tUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BaDjXD/RG0kyUThXx34ExLwb9nVm9t9Qz5HyHcuaCuk=;
        b=pEDZhtdj+Lyj2V9B4P3m00GrAWEifPqQTt94j5B/4a99+eD7+jrNjsfaURHatFE3CW
         XFh6YMZnzK8nhc4qOkqb5t2z9ckWDvNUtg3/yFS1igTjY+D0LKSshIDYX4uc1Hm+3V59
         ypLqqzIDWA49roYTIB4pqXc6sgdBeZYrP6wKV/vZTHu5Vs7b0JIs/tTIcbxz9khRo8Wc
         uaWd+b6tmYXwW1EladaOgvjDt8KKV/rHH5/3mkXWDFs2itus4QYhlgc1CcamN7nCZEIw
         CENUg39qIadYG/AIAQJYSzb/QASe2ehDERg510EE5KwyNO32lsxbpaufkmcAls+I4WV+
         kEuA==
X-Gm-Message-State: APjAAAWi07kabuoE+1FmxPSFpDLzv/Jf9yi77z4FWVYJJzdT2Zkei9EG
        ZatNFXCYJEcMlhqQRnxXkWwUhA==
X-Google-Smtp-Source: APXvYqxGklNuxBHWG/GtaQWMvTSDu9V41SozepAGSY3TA8rYq22Bm5hZOIEHU+MHeNVO0dpeqGfbCQ==
X-Received: by 2002:a17:90a:970a:: with SMTP id x10mr85475018pjo.12.1563921322290;
        Tue, 23 Jul 2019 15:35:22 -0700 (PDT)
Received: from localhost.localdomain ([115.99.187.56])
        by smtp.gmail.com with ESMTPSA id h16sm49036917pfo.34.2019.07.23.15.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 15:35:21 -0700 (PDT)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     agross@kernel.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v6 0/5] soc: qcom: Add SoC info driver
Date:   Wed, 24 Jul 2019 04:05:10 +0530
Message-Id: <20190723223515.27839-1-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds SoC info driver which can provide information
such as Chip ID, Chip family and serial number about Qualcomm SoCs
to user space via sysfs. Furthermore, it allows userspace to get
information about custom attributes and various image version
information via debugfs.

The patchset cleanly applies on top of v5.2-rc7.

Changes since v1:
        - Align ifdefs to left, remove unnecessary debugfs dir
          creation check and fix function signatures in patch 3
        - Fix comment for teh case when serial number is not
          available in patch 1

Changes since v2:
        - Reorder patches [patch five -> patch two]

Changes since v3:
        - Add reviewed-bys from Greg
        - Fix build warning when debugfs is disabled
        - Remove extra checks for dir creations in patch 5

Changes since v4:
	- Added Reviewed-bys in multiple patches
	- Bunch of nitpick fixes in patch 3
	- Major refactoring for using core debugfs functions and
	  eliminating duplicate code in patch 4 and 5 [detailed info
	  can be found under --- in each patch]

Changes since v5:
	- No code changes, fix diff.context setting for formatting
	  patches. Version 4 was adding context at the bottom of
	  the file with 'git am'. 

Vaishali Thakkar (5):
  base: soc: Add serial_number attribute to soc
  base: soc: Export soc_device_register/unregister APIs
  soc: qcom: Add socinfo driver
  soc: qcom: socinfo: Expose custom attributes
  soc: qcom: socinfo: Expose image information

 Documentation/ABI/testing/sysfs-devices-soc |   7 +
 drivers/base/soc.c                          |   9 +
 drivers/soc/qcom/Kconfig                    |   8 +
 drivers/soc/qcom/Makefile                   |   1 +
 drivers/soc/qcom/smem.c                     |   9 +
 drivers/soc/qcom/socinfo.c                  | 468 ++++++++++++++++++++
 include/linux/sys_soc.h                     |   1 +
 7 files changed, 503 insertions(+)
 create mode 100644 drivers/soc/qcom/socinfo.c

-- 
2.17.1

