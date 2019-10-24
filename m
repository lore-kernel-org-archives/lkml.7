Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85841CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ED021906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNUayGyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391701AbfJXOaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:30:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45641 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfJXOaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:30:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so21370996wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Xd96fcNNlZyaGfvlfaTFPC/YwhZnbGysRWz5r50KB7c=;
        b=VNUayGyKjE5xOJ3KEN6KL3CQvzDzQP5HUQfmQ7WS85u8HGzBdZ6n1yWnMQgEq0wqPP
         ca4098XrA8ck+iIJgj+22ipL3+yDnXtJ90R2QmsyrpigcK1nKKb/XH/pgt2T23pDQ1Y+
         /kmZ0UXLQsVVWpUV11DaPYgOQphGT4z+j1v8HK61D2zfOvNYL70sKcslNj7I1YUdxoc8
         dVrAnOxTPfhLXHJq4947+bPv8ORX9iE3SwchpIW+M/K85aNggs2kTotGcxQmKH0A/Zrf
         HzH4ZoZfWMn9zmh+9z6thqCLA7b7wxDyeWTn+2PxBJA9dZK/XwkxK7Bxg2ZeXfHqeTCl
         2twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Xd96fcNNlZyaGfvlfaTFPC/YwhZnbGysRWz5r50KB7c=;
        b=bnO59b2MUsRtWBTWU89ab9vMu6cLs75YBBnG2GcREwhlu8HTVn+hPBCKlv69VQjdHc
         aLr4jcM2qagp70pQeW2jj5qDormaSm0SS0Z4+FatXMvfgoDRi7q0L4NNIze20Od53egU
         UeZzf0ticPgPn7k1M8lnrppnrVn0XjRT0T5ZDgBUpMPlbQ/g+XWV4MGEdOZ9DJuVm01m
         LJyMfVpNUUz8TMyQIeXYdZhr5T/FHQaPVo3V8IAD36u0jCIuStujeZR3H/i5HQT8cqDj
         aQH4MR9eKwb7zxVSu9B/7hJiTjUL1pnzNFrfp3X5N3hwU6IYWbXRVf0rPtUgljKFDYDv
         oKBQ==
X-Gm-Message-State: APjAAAXpEDMrP6EAjuOek70Kt+pSKbErQpkHhhVnE0K9YhAuEO2SVQx8
        pzhiLRieHD+dFM4xjut5Yvo=
X-Google-Smtp-Source: APXvYqz16iztY4TwStCNJMZgZSZDuveS9WIyen6hD6earIdPDua8RgFqYaj4HzRIYqa2cE/rd3v5ZQ==
X-Received: by 2002:adf:e446:: with SMTP id t6mr4084284wrm.7.1571927402366;
        Thu, 24 Oct 2019 07:30:02 -0700 (PDT)
Received: from aherlnxbspsrv01.lgs-net.com ([193.8.40.126])
        by smtp.gmail.com with ESMTPSA id a11sm1702190wmh.40.2019.10.24.07.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 07:30:01 -0700 (PDT)
From:   Andrey Zhizhikin <andrey.z@gmail.com>
X-Google-Original-From: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        andriy.shevchenko@linux.intel.com, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry Trail Whiskey Cove PMIC
Date:   Thu, 24 Oct 2019 14:29:37 +0000
Message-Id: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces additional regulator driver for Intel Cherry
Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
PMIC, which is used to instantiate this regulator.

Regulator support for this PMIC was present in kernel release from Intel
targeted Aero platform, but was not entirely ported upstream and has
been omitted in mainline kernel releases. Consecutively, absence of
regulator caused the SD Card interface not to be provided with Vqcc
voltage source needed to operate with UHS-I cards.

Following patches are addessing this issue and making sd card interface
to be fully operable with UHS-I cards. Regulator driver lists an ACPI id
of the SD Card interface in consumers and exposes optional "vqmmc"
voltage source, which mmc driver uses to switch signalling voltages
between 1.8V and 3.3V. 

This set contains of 2 patches: one is implementing the regulator driver
(based on a non upstreamed version from Intel Aero), and another patch
registers this driver as mfd cell in exising Whiskey Cove PMIC driver.


Andrey Zhizhikin (2):
  regulator: add support for Intel Cherry Whiskey Cove regulator
  mfd: add regulator cell to Cherry Trail Whiskey Cove PMIC

 drivers/mfd/intel_soc_pmic_chtwc.c            |  15 +-
 drivers/regulator/Kconfig                     |  10 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/intel-cht-wc-regulator.c    | 433 ++++++++++++++++++
 .../linux/regulator/intel-cht-wc-regulator.h  |  64 +++
 5 files changed, 521 insertions(+), 2 deletions(-)
 create mode 100644 drivers/regulator/intel-cht-wc-regulator.c
 create mode 100644 include/linux/regulator/intel-cht-wc-regulator.h

-- 
2.17.1

