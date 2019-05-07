Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765A3C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400C720C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="godi/eRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEGPPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:15:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33153 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfEGPP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:15:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so2488358pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:from:to:subject:date:message-id;
        bh=jxvbr3KCxGuFA0UUCE0tn2m+gj1lVeJv2p0ZckpwEOo=;
        b=godi/eRqc9u1IGuhM6qD/GD01ckleD8wICQ7/wytewi8a7HBbzkII3459Dcb5M+5sy
         SFVxVOPrh7oEqVmF4uK8oXWesB2bHmyIkIDNTNkIiFE6aVDQAuMrT+Lhyc7dZjrVGUz3
         OYxlsQzH8MWBzSPmXLdIQNiSbw2MXf7hEu7OfDrD/NCs0oNCRXmxFjIiJhNeiDiPuNi3
         WPOv5roEbMkZgK8sd3IbMVL6LZW1FMNM5rqNKdKe625cMdK66Qm1aU5VhWd0NQHg5Ra3
         0XZSzk+0CYdxAWjOaclyJKyw53FQhY5XIYz5khKa4DFmlAxxdg66yLH1zv2d6LR1LfWo
         kvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=mime-version:x-gm-message-state:from:to:subject:date:message-id;
        bh=jxvbr3KCxGuFA0UUCE0tn2m+gj1lVeJv2p0ZckpwEOo=;
        b=YILXGZHmlEf4iVQMsP1Vg8SeWjBMA0Y12gtmU/D0HRsGup4ap1zd1HuWW11jugMy5U
         N8l0xlkCeiwvNENrfyRSCOqjkRSckQAQ1FpLABva34UR1Wa8h/ua080H81MYi7i/E4zc
         CqxNYeQCEgyHH1mR5VcH4mOEi3bRPMwly7Xdll9wG5mC6e/hnouBu2rEFC2QdROX5Zzk
         AmNvTStqqreKKooiWy67UvedUZd8v1bHCbjVlSlHd9Ls8V2gCCYysTLfaY6cc3LQiPEQ
         QeIcq1FOr2wXFjctJty656/dMxajH/+KJmYiPhV6zXwF1TzOiItzQXDPLyl11C3kqTq9
         BMtw==
MIME-Version: 1.0
X-Gm-Message-State: APjAAAXKs2cm9sN+CDnEO2hB9y2W+d149kRZPu7WrtE3gY3xQ4+kr70D
        52eK4FyZqp92b5tM48RBEvtQUWVShEJ8tlYJAY+gHb+xaYvG3tid+mmkICs0GRc4BrfBo46y/tn
        BowjR1tGmK/KM8GdLxg==
X-Google-Smtp-Source: APXvYqzrXRe5boGKu4+E5H+iFQtt2WKa8IE844ytrYjmvDo2sjKQXZGEQiX+PPyG3XVys162mtMbAQ==
X-Received: by 2002:a65:4649:: with SMTP id k9mr16750621pgr.239.1557242128887;
        Tue, 07 May 2019 08:15:28 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id 2sm5397398pgc.49.2019.05.07.08.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 08:15:28 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 v2 0/3] Extend dt bindings to support I2C on sifive devices and a fix broken IRQ in polling mode.
Date:   Tue,  7 May 2019 20:45:05 +0530
Message-Id: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is based on mainline v5.1 and extends DT-bindings for Opencore based I2C device in FU540 
SoC, available on HiFive unleashed board (Rev A00), and also provides a workaround for broken IRQ
which affect I2C polling mode interface on FU540 chipsets. 

The polling mode workaround patch fixes the CPU stall issue, when-ever i2c transfer are initiated.

This workaround checks if it's a FU540 chipset based on device tree information, and check's for open
core's IF(interrupt flag) and TIP flags to break from the polling loop upon completion of transfer.

To test the patch, a PMOD-AD2 sensor is connected to HiFive Unleashed board over J1 connector, and 
appropriate device node is added into board specific device tree as per the information provided in 
dt-bindings in Documentation/devicetree/bindings/i2c/i2c-sifive.txt.
Without this workaround, the CPU stall's infinitely.

Busybox i2c utilities used to verify workaround : i2cdetect, i2cdump, i2cset, i2cget


Patch History:

V0<->V1:
-Incorporate review comments from Andrew
-Extend dt bindings into i2c-ocores.txt instead of adding new file
-Rename SIFIVE_FLAG_POLL to OCORES_FLAG_BROKEN_IRQ

V0:
-Update dt bindings for sifive i2c devices
-Fix broken IRQ affecting i2c polling mode interface.


Sagar Shrikant Kadam (3):
  dt-bindings: i2c: extend existing opencore bindings.
  i2c-ocore: sifive: add support for i2c device on FU540-c000 SoC.
  i2c-ocores: sifive: add polling mode workaround for FU540-C000 SoC.

 .../devicetree/bindings/i2c/i2c-ocores.txt         | 20 +++++++++++++
 drivers/i2c/busses/i2c-ocores.c                    | 33 +++++++++++++++++++---
 2 files changed, 49 insertions(+), 4 deletions(-)

-- 
1.9.1


-- 
The information transmitted is intended only for the person or entity to 
which it is addressed and may contain confidential and/or privileged 
material. If you are not the intended recipient of this message please do 
not read, copy, use or disclose this communication and notify the sender 
immediately. It should be noted that any review, retransmission, 
dissemination or other use of, or taking action or reliance upon, this 
information by persons or entities other than the intended recipient is 
prohibited.
