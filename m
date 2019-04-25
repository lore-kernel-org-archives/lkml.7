Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F8FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5AC214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lNlQ6QVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfDYFzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:55:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40384 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfDYFzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:55:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so10544407pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Pd8JWArOp7QBWH4Bz/BLcKRsri2NYRWh9cFvMPJbnHM=;
        b=lNlQ6QVaAEpyYH2CPaJ6RUlfaSfjAwgodzgq+pAVNfA0tbkP5hZ7C3t1c1eJyooyOj
         Ee1wD/thz31u6JB/1/GCbRpL07j18kHBOYFnZPosuNjxKCda1/1tSdlfsX33g0Pm9aq4
         yTVscZ07fTY9rt9wJ8Tp2KCWcPDOOS8/uiefc3/6g+8AvErpO4YMl0dUCsA0gmvG5ztc
         8fQb/xmEF30hSgCENaGKTZV+DnGvmbygm9FMA2OWM2rn3UuPwruCSmSjFqsC2VprR33c
         M3cnJT220ekvzOiVRxvpBXPSp77aNV3O1NgbZ9BXAftFP8ENiOci1oGZWsK9Hnm+pxhq
         xPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pd8JWArOp7QBWH4Bz/BLcKRsri2NYRWh9cFvMPJbnHM=;
        b=LzfkuULx+uM/cDm7/gH2P0qlZ0fXPzdP5+CSqqUr/LAOFuYFzI8bkRNf8FIyThKPj3
         rwk48OchZOQChmlXiVpx4eLONEC1x3TeG9FX9ENQtKWjvNsQ+cfOH0SAByFd0XtYngsU
         8SfkL+TJ0ebracVKIYJ2T1bxFZlFPoMo6M33i+59fZZswUQ6GBa2oOT3OvFkQufENCcH
         YIPX9Pm9IrK63VwMrjcM8xm91WDk4BucdieO+Hl1puUXnSWRhreD/+ZC4wiBr4w4/IvJ
         vlFVqZYkO9o7Zc/MFB432GRdwMRotwn8v7PU2ysDL8Rd1yT35Kddm3m1LD+W54BNshY3
         2+dw==
X-Gm-Message-State: APjAAAUmY3rqdKBdQRNrNPzWDr2t+YEAbQo+DUzOtl1AXKRrvLC46dGT
        584355pvwVs4UVNJTbyzr36AgA==
X-Google-Smtp-Source: APXvYqzEyeNbWc8N7QcxEBLojkHQZOeGrYW8IOEn/1nRGuk/+U1H5bQn33IW4Xd/qK0vfFh8AJ5nHA==
X-Received: by 2002:a65:484a:: with SMTP id i10mr35166470pgs.408.1556171716673;
        Wed, 24 Apr 2019 22:55:16 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id m16sm46332170pfi.29.2019.04.24.22.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Apr 2019 22:55:15 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        palmer@sifive.com
Cc:     paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, mark.rutland@arm.com, robh+dt@kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/2] L2 cache controller support for SiFive FU540
Date:   Thu, 25 Apr 2019 11:24:54 +0530
Message-Id: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds an L2 cache controller driver with DT documentation
for SiFive FU540-C000.

These two patches were initially part of the patch series:
'L2 cache controller and EDAC support for SiFive SoCs'
https://lkml.org/lkml/2019/4/15/320
In order to merge L2 cache controller driver without any dependency on EDAC,
the L2 cache controller patches are re-posted seperately in this series.

The patchset is based on Linux 5.1-rc2 and tested on HiFive Unleashed
board with additional board related patches needed for testing can be
found at dev/yashs/L2_cache_controller branch of:
https://github.com/yashshah7/riscv-linux.git

Yash Shah (2):
  RISC-V: Add DT documentation for SiFive L2 Cache Controller
  RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive
    SoCs

 .../devicetree/bindings/riscv/sifive-l2-cache.txt  |  53 +++++
 arch/riscv/mm/Makefile                             |   1 +
 arch/riscv/mm/sifive_l2_cache.c                    | 224 +++++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 arch/riscv/mm/sifive_l2_cache.c

-- 
1.9.1

