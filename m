Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECDEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A527216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="c6d0ZkgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbfETOMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:12:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37107 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730344AbfETOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:12:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id n27so4270954pgm.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id;
        bh=nGtttgXFEJ1HOgo8bh4Lp5/Nmp2dywuBtKSOZng5Qbc=;
        b=c6d0ZkgL2saozGONzGCnFEQjAWNRdRLaTLfi3lW4z4qkcqrrTV7g5av3Ok3O7OECou
         3yYApsOiPp7tG5FkOQ4PPTJtiqNcJPVlgF1cEAycAO5AY8GaRxqh8qTbxNUu8X33kc6a
         eFXxuJ89V7opU+5GNVeMDSpmGQL3B+H+HegVtp2eTgUqOiBmZT7NteugVeFGYIXw5vOI
         7m/RrnkVU9PGZTgK4NPef0DQ8yWtFqG45q+90e5F+UhN1mRxdUO5qcHnDzAfon4dxER7
         Uuau/plRmvrgjj99S1LjTivrRsQo14Qx6dL9uWaBjimH9GPvRY+mD4WUFuyAHY8euVap
         ethQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=nGtttgXFEJ1HOgo8bh4Lp5/Nmp2dywuBtKSOZng5Qbc=;
        b=TGqXgpLkwpGmTeadauVIuQNPBKKD+uQx0yV5Foc4Z8D2yBoPN9UYN+zTxpkkc9hpEa
         +IgNgzaAoq17PeMNVNBQXTDwc9wKR8n7YvHsD3i28qx7VyiWtEMTu3UOV3iKRqX8pG6F
         4xD6IZQiGPft2M5MiX7Sa763erKMFsZT4jreH6ajHinGvCiujmJolcmGqY9GEq6WAA/u
         rURE3fNuvlc2scorggv0BVsGd73rGvFwJnNCiDyfk/if4yKk2Bzl53oO5yOgAJIScsjV
         JZPBlXLX6aNpWcfD11b2ekODZvyqmSVi2Y/1MGH+mTe0vYr5ZXmYdvLd2VffJTXPlngK
         qmQQ==
X-Gm-Message-State: APjAAAXcv7VyP8yPZLKpzztK2GojmfB88s0HopWdXoX2e7WwCedrBEkN
        AU0ffEYnKzm10oc6X7r/xnV/uw==
X-Google-Smtp-Source: APXvYqzDhGlszACUDMjZoW+0B0CqS1xGBQilzDwKmDvbLOxQ7SIgyDw30Jflw2tbu6Wq1eYPuirj4w==
X-Received: by 2002:a62:6341:: with SMTP id x62mr79597104pfb.63.1558361535563;
        Mon, 20 May 2019 07:12:15 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id a9sm26388248pgw.72.2019.05.20.07.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:12:14 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Extend dt bindings to support I2C on sifive devices and a fix broken IRQ in polling mode.
Date:   Mon, 20 May 2019 19:41:15 +0530
Message-Id: <1558361478-4381-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is based on mainline v5.1 and extends DT-bindings for Opencore based I2C IP block reimplemented 
in FU540 SoC, available on HiFive unleashed board (Rev A00), and also provides a workaround for broken IRQ
which affects the already available I2C polling mode interface in mainline, for FU540-C000 chipsets. 

The polling mode workaround patch fixes the CPU stall issue, when-ever i2c transfer are initiated.

This workaround checks if it's a FU540 chipset based on device tree information, and check's for open
core's IF(interrupt flag) and TIP flags to break from the polling loop upon completion of transfer.

To test the patch, a PMOD-AD2 sensor is connected to HiFive Unleashed board over J1 connector, and 
appropriate device node is added into board specific device tree as per the information provided in 
dt-bindings in Documentation/devicetree/bindings/i2c/i2c-sifive.txt.
Without this workaround, the CPU stall's infinitely.

Busybox i2c utilities used to verify workaround : i2cdetect, i2cdump, i2cset, i2cget


Patch History:
v4<->V5:
-Removed un-necessary checks of OCORES_FLAG_BROKEN_IRQ.

V3<->V4:
-Incorporated suggestions on v3 patch as follows:
-OCORES_FLAG_BROKEN_IRQ BIT position rectified.
-Updated BORKEN_IRQ flag checks such that if sifive device (Fu540-C000) is identified,then use polling mode as IRQ is broken.

V2<->V3:
-Incorporated review comments on v2 patch as follows:
-Rectified compatibility string sequence with the most specific one at the first (dt bindings). 
-Moved interrupts and interrupt-parent under optional property list (dt-bindings).
-Updated reference to sifive-blocks-ip-versioning.txt and URL to IP repository used (dt-bindings).
-Removed example for i2c0 device node from binding doc (dt-bindings).
-Included sifive,i2c0 device under compatibility table in i2c-ocores driver (i2c-ocores).
-Updated polling mode hooks for SoC specific fix to handle broken IRQ (i2c-ocores).


V1<->V2:
-Incorporate review comments from Andrew
-Extend dt bindings into i2c-ocores.txt instead of adding new file
-Rename SIFIVE_FLAG_POLL to OCORES_FLAG_BROKEN_IRQ

V1:
-Update dt bindings for sifive i2c devices
-Fix broken IRQ affecting i2c polling mode interface.



Sagar Shrikant Kadam (3):
  dt-bindings: i2c: extend existing opencore bindings.
  i2c-ocores: sifive: add support for i2c device on FU540-c000 SoC.
  i2c-ocores: sifive: add polling mode workaround for FU540-C000 SoC.

 .../devicetree/bindings/i2c/i2c-ocores.txt         |  7 ++++-
 drivers/i2c/busses/i2c-ocores.c                    | 31 ++++++++++++++++++++--
 2 files changed, 35 insertions(+), 3 deletions(-)

-- 
1.9.1

