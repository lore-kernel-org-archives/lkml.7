Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8239CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985C9208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukToVhLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfJ3PHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:07:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55805 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfJ3PHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:07:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id g24so2483136wmh.5;
        Wed, 30 Oct 2019 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IVhb82hZKy3JKoMCSWoDHfXIpFlhHoV+nkQ7avEsjo8=;
        b=ukToVhLSujgmB9Tsiif4JAXcvd0xOODNlntL+1C3r/lc/f58KQACTRUGKbG5qP2hAw
         U74Ix2ccXLUAiQWVrbAwUPMFq+yEXzkjX3nQIYGl6metluaAOkyl/5hiXQL/H4zKuJDB
         WAK5Tbh2E2k0bvw6+aqmI9jZsOPu0Zk5/LfRcfrdUiSiHzP5FtUzqWAUddDJQovDB5Af
         jhIDrBoTrTYtoKg3WrsnRBAZEAlanmnC0/BI7G0643ST2BUk7yyQzjCRVZjDUGq0MDQT
         mm7VogHOeHMAOW74rp7Gw+/SyULbZD673Cah1FKY4JUzC3K8h6yfL4mt/m6L7tsHPq9+
         +iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IVhb82hZKy3JKoMCSWoDHfXIpFlhHoV+nkQ7avEsjo8=;
        b=Y1APl4FXHfnxQHkRzYDIcsEXVSnkPUu8DuwNXVYh4Tm7wztF1x/4zT83JJRH3V4yRe
         6xTUHQc50ukOHEzbS1mSX9p8Byso3P8y1Pnb8X08tAqouxarSbakSYSDbqWcHu3H7PBb
         o8r6FLGkS/Ul029TNb8nBeJUGuG2MtODFaJOjq3ED+wizyDBVsP1NXt3CdhSyeaf9i+Q
         ArDm9ZQjUpI2Z2FHwUKKLTZvdhWTfSQ4XnJA+qXjGIodppYT33kcKV2Os/UxrITl0FsR
         /WrMIidS2FRGurCZdspRHEhu7dtCdlYjXO+AHgKNCpuHUHO65yMoSwUfxJ2IIfJSMgwF
         zHXg==
X-Gm-Message-State: APjAAAWkHumqEl9JnUEFMglz5RCFRhIs+ghJiLljO6m7/JBrtVBLSR+h
        5jTsAtsk2C/pjhugdBQeHLY=
X-Google-Smtp-Source: APXvYqxbS22vg9ni+tcUXA1fmRlwnTOErKtdg+KUUsw6WFM4XaT+NAQHuQDlB3SGcH30V/QKToPdFA==
X-Received: by 2002:a05:600c:254:: with SMTP id 20mr8704020wmj.123.1572448067972;
        Wed, 30 Oct 2019 08:07:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id 11sm278074wmg.36.2019.10.30.08.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 08:07:47 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v7 0/2] Allwinner H6 Mali GPU support
Date:   Wed, 30 Oct 2019 16:07:40 +0100
Message-Id: <20191030150742.3573-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Proper iommu patches has been merged[0].

There is still work to do to make it works with panfrost
but all modules can be probed and removed smoothly.

These bindings could be used also for out-of-tree modules.

[0]: https://lore.kernel.org/linux-iommu/cover.1569851517.git.robin.murphy@arm.com/

Change since v6:
 - Remove iommu patches
 - Rebase on 5.4-rc4

Clément Péron (2):
  arm64: dts: allwinner: Add ARM Mali GPU node for H6
  arm64: dts: allwinner: Add mali GPU supply for H6 boards

 .../boot/dts/allwinner/sun50i-h6-beelink-gs1.dts   |  6 ++++++
 .../boot/dts/allwinner/sun50i-h6-orangepi-3.dts    |  6 ++++++
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi     |  6 ++++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      |  6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       | 14 ++++++++++++++
 5 files changed, 38 insertions(+)

-- 
2.20.1

