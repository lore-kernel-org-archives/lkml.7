Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE18C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7041720693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms3frB+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfDWQFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:05:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33288 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:05:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so7730195pfo.0;
        Tue, 23 Apr 2019 09:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=78BOuIzqON+UuxVKqi/13NbLjtCWEIe/AgLLLes6Wqc=;
        b=Ms3frB+LxqSPTw0yQ1abZw2bNuDE28yYVRb+ElO5ibwlw2guCbhFgPbZwOiq9tE4Fy
         U8GhtpthQ5ZZk5oSrUD7R6rwCVexlXF59Kj9Qe5RiP/0LindLC38/RawaXXSGwGR9UED
         Aupsmyq9sL0vErEqLNsNpsKMj8TDXMJ4Dd89ENWgTIVV720icTWuzMqYxQRfyoDVZfVp
         PjnOfYkx5DVKOBwikwO0LS6BMSUXfgwFzngRBgTRZsTCg8eGSYt0iNoSMsJNeCI/CtiI
         f72ptTzCBnJA/OOHsqY2X/yXUQj+bCIvUc01ApM+d0J2fDkzfuECp7fl2zEm28KyW+AQ
         QeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=78BOuIzqON+UuxVKqi/13NbLjtCWEIe/AgLLLes6Wqc=;
        b=cIzUkfsG0I7CflRPT1trZU+QMn/HiVrQwyw9AAMkyKNTHIxho0LKSj0ewBk+jxGCeG
         ItAqYCDYnWJoFB8y8HZQWtRRpdjUtsVihj4NOsrstRFtPipuInXGtMvoPEWR91A+B1x9
         vWFMe/1cbTl1Iptpc+cQPaCZ29eDaJ/ozuTQH5vS3hW3BaHnscwifI3cUGQsWBTzoxOc
         3z5oQUeg2gnOA+vOaF0eFcfQUzW+2qfEgD5DEKynb1pan00l4WKMk63DF1Zo4Safm/iy
         /9KdhAKhEyKwb5DCYaHEu7tNKfKe941ogS+eH182BX9PN4mE7vyGZMUs3A+wkuyy/Hje
         yiFQ==
X-Gm-Message-State: APjAAAVECvXUzPoQ9THLixqXUrSZpxSyHHiOCR8DSCGpDg/5qjtKej32
        OzUBixLc6bxMb4LFMgVyE3s=
X-Google-Smtp-Source: APXvYqzvYECMP9RIFYrEUhdhrN2LS2LApYkQoaXN7K+kZdyXVvCQGMX6kegSpIfSXexD8f0+HPp+6A==
X-Received: by 2002:a65:60ca:: with SMTP id r10mr25327032pgv.64.1556035549597;
        Tue, 23 Apr 2019 09:05:49 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id c3sm21561166pfo.2.2019.04.23.09.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:05:48 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     lee.jones@linaro.org, bjorn.andersson@linaro.org,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, agross@kernel.org, david.brown@linaro.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        hdegoede@redhat.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v4 0/2] Basic DT support for Lenovo Miix 630
Date:   Tue, 23 Apr 2019 09:05:43 -0700
Message-Id: <20190423160543.9922-1-jeffrey.l.hugo@gmail.com>
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

v4:
-Changed the hid-quirks ELAN handling around per Benjamin Tissoires
-Dropped new DT binding

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

