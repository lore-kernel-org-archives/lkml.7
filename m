Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E36EC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD83218D0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3muGD5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfDOQJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:09:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35605 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfDOQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:09:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so8799844plp.2;
        Mon, 15 Apr 2019 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rbroc0TcCejxHzqpYCEDaZApUY9GFl+pj5V6z3KiYE0=;
        b=V3muGD5dyYhrPtI8I5K0oPQtdoq3nPFfCwjPXHo4rJ64vqA7eWgif+U76ahmWKmti9
         fUJUrv4FQfOe5Sytf9GBZj/0mghTibf4jLpqKD+O/XfRsWgMVyu4BKxXoYx9XQDeGb1K
         rTclSwJgmrcyll/U63Lz42Yi/F5CkCX55tcq5ngk4bfoMsi2JoH1gmJSOEjFpBQ1HQIw
         zLP2OcHbzRFNZbbjKjpjjkyxU1zASjcA8cCAXSxzX3/fYgrSZNenycLWUdKUDCkbGRG0
         I+gCINcxX+xohd9HSuV+Y3KwD01mbE3N7PmYL2uXNV8WcvuizG0TKtPnwhlgH8/7DAWt
         vzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rbroc0TcCejxHzqpYCEDaZApUY9GFl+pj5V6z3KiYE0=;
        b=SILLt/zNCQMSL5CNlr4DRgqdvI4tkB1Rv3wIPe3IJp0ULBnyxqg09XJQaJmvWfGOwG
         NLDSfe33C8u+OfesV5VJzLaywR0/03LNAlmZj0+DX6KaMc44Zn2YD9m14kALq+Ld8E/O
         rfn8vpQJvMshwS0YaB7v8cJenO4KkjVioSOpLRvjatZXuco7QxbhWpjJSnadFph/tTUT
         xRFo0/u3IWIV5n1otCsR+Go8i/lTUtlthDP2+dxpYyz8AO6J4R+9Uk6pN0ta8v/2a9AW
         WHJROPIqlkfyrzHrDFAvYC4pFarFRWy0i2gknrUqqhU/1lUbTOtMiOzYAFHYQPkK/T1h
         kxlA==
X-Gm-Message-State: APjAAAXBCayY8LQ3+9DXrXEcS6thzeReAFJE6ROy3JAfek5ZlxG8jhLx
        aAby+H8zgvGRsKOfqEnhlJY=
X-Google-Smtp-Source: APXvYqwuLLTEf8MmfxM1ZnBlFNwMwxsI6II3y7CPBEo4TXaGLapU7yCgAmlx0ymvbuy2JWZ78rceeA==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr47926844pld.52.1555344563225;
        Mon, 15 Apr 2019 09:09:23 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id h65sm125396567pfd.108.2019.04.15.09.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 09:09:22 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     lee.jones@linaro.org, bjorn.andersson@linaro.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v3 0/3] Basic DT support for Lenovo Miix 630
Date:   Mon, 15 Apr 2019 09:09:15 -0700
Message-Id: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Miix 630 is one of three ARM based (specifically Qualcomm
MSM8998) laptops that comes with Windows, and seems to have a dedicated
following of folks intrested to get Linux up and running on it.

This series adds support for the basic functionality this is validated
towork using devicetree.  Although the laptops do feed ACPI to Windows,
the existing MSM8998 support in mainline is DT based, so DT provides a
quick path to functionality while ACPI support is investigated.

The three devices are very similar, but do have differences in the set
of peripherals supported, so the idea is that the vast majority of the
support for all three can live in a common include, which should reduce
overall duplication.  Adding support for the other two devices as a
follow on should involve minimal work.

The bleeding edge work for these laptops and work in progress can be
found at https://github.com/aarch64-laptops/prebuilt

v3:
-Changed "clam" to "clamshell"
-Defined a dt binding for the combo Elan keyboard + touchpad device
-Adjusted the HID quirk to be correct for dt boot
-Removed extranious comment in board dts
-Fixed board level compatible

v2:
-Changed "cls" to "clam" since feedback indicated "cls" is too opaque,
but
"clamshell" is a mouthfull.  "clam" seems to be a happy medium.

Jeffrey Hugo (3):
  dt-bindings: input: add Elan 400 combo keyboard/touchpad over i2c
  HID: quirks: Fix keyboard + touchpad on Lenovo Miix 630 for DT
  arm64: dts: qcom: Add Lenovo Miix 630

 .../bindings/input/elan,combo400-i2c.txt      |  11 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-clamshell.dtsi      | 278 ++++++++++++++++++
 .../boot/dts/qcom/msm8998-lenovo-miix-630.dts |  30 ++
 drivers/hid/hid-quirks.c                      |   3 +-
 5 files changed, 322 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts

-- 
2.17.1

