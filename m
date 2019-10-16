Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51382C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E47B2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CZiMrOj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391092AbfJPDfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:35:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39880 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403803AbfJPDdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:33:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id p12so4069847pgn.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 20:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=t2p37ay5nCl2I96qOVhX0P3NjGh9D6Cr7Q7PF/xIWq4=;
        b=CZiMrOj22KpXig6mUpaY9hbB9sHO+MhThVOQ64XRj3wpJWeBR+AJrWQuPn1sQz1fTo
         9Ji4ZiOWf/zF8m8UU3517d0lQfbwTLvOxMsLwiIO/O5U/9w0WerrI6nsDQRwscldQTl9
         jefXLMtsGdYavyw1U08uI6lZCGJoViEYfYmkqWJvhXNORoitZg2tfhFahziV9Vlid/0q
         7/Cv3cpjUDo0h6vJHGhCyfqSX6njRAsocdpPread36r9t0TypKcUxpF4pSimCu2KMS0p
         w5r4WFQOKbyWDUnh0GiqHq71y6j8bubKR3lzjPFPvZHkC9GGQTsAmpBbkcw9XPlAVwbP
         qTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t2p37ay5nCl2I96qOVhX0P3NjGh9D6Cr7Q7PF/xIWq4=;
        b=QCaZZfIffHO0yQMaZv0RL/UAM8WSHPNNo2EosLN3XtniZZGmFt/B3FcUKj8cCJvv3c
         vgVcFYfFLUk7xyfaR+9OoTTiIQL3pm7L9Fw2ZoLT9NJmLChGnRm0LEDjiQDUpt0ZPGvA
         i8asUdRXFNdnsDztnKhrHRDAhmyRS/Fl6FV11Qv59MFkh0TQ2O6u4AbYFnu7iu0uCmKf
         8urUoRdfGtMZ7IyzN0sx3lMU1M5qpC8MXb/531XYAIEsb5NG3mGyhZh2vLsMUiAQfp+L
         rz/QAlw3OhUxv4KEsRufIp+t5qTwSArYubkvmE5SK0hsd0fQmNeX5ouFy0Q4gSINWrnV
         HTAw==
X-Gm-Message-State: APjAAAW5Uzp/R1Uer1Y/N3uqL30feBnmfUvUeGDVsqTjJFNbq7Sf4CO/
        RuH+yNYaI/dj4PCOkuZptB2tkqhwffw=
X-Google-Smtp-Source: APXvYqzq0GZIVD2ew73AOT8Th33vq83I60KpAorY2062fa7GN5oPZBwvcUv/DhrYc1lqYdEHwGgmGw==
X-Received: by 2002:a62:685:: with SMTP id 127mr40218403pfg.227.1571196823357;
        Tue, 15 Oct 2019 20:33:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id l23sm748356pjy.12.2019.10.15.20.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 20:33:42 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RFC][PATCH v3 00/11] HiKey960 USB support
Date:   Wed, 16 Oct 2019 03:33:29 +0000
Message-Id: <20191016033340.1288-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just trying to pick up a patch series submitted previously
by Yu Chen to get HiKey960 dev-board's USB functionality
working.

The current full patchset can be found here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?id=305b332b46901c82d762e44d2ef8c96107a0c94e

Previously I sent this series out as two separate series, to
try to make the review a little easier. However, the partial
series was causing some confusion as well, so this time I've
sent almost all of it in one go.

NOTE: I unfortunately don't have any deep knowledge of the
hardware other then the previously submitted code  and what I
can intuit from testing, but I tried to document the previously
undocumented bindings as best I could, fixed up a few minor
checkpatch issues and tried to address previous feedback as best
I could.

I'd greatly appreciate feedback or thoughts!

thanks
-john

New in v3:
* Avoiding adding a hisi specific dwc3 binding and instead
  trying to make the dwc core binding more flexible as suggsted
  by Rob Herring.

* Made the GCTL soft reset unconditional as suggested by
  Jack Pham.

* Given the negative feedback on the usb class role-switch
  notifier method for the hub logic to hook into, I've reworked
  the hub logic to be an usb-role-switch intermediary.

* Lots of minor fixups and cleanups, some reported by the
  kbuild test robot <lkp@intel.com>


Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org

John Stultz (6):
  dt-bindings: usb: rt1711h: Add connector bindings
  dt-bindings: usb: dwc3: Allow clock list & resets to be more flexible
  usb: dwc3: Rework clock initialization to be more flexible
  usb: dwc3: Rework resets initialization to be more flexible
  dt-bindings: usb: generic: Add role-switch-default-host binding
  usb: dwc3: Add host-mode as default support

Yu Chen (5):
  usb: dwc3: Execute GCTL Core Soft Reset while switch modes
  usb: dwc3: Increase timeout for CmdAct cleared by device controller
  usb: dwc3: Registering a role switch in the DRD code.
  dt-bindings: misc: Add bindings for HiSilicon usb hub and data role
    switch functionality on HiKey960
  misc: hisi_hikey_usb: Driver to support usb functionality of Hikey960

 .../bindings/misc/hisilicon-hikey-usb.txt     |  40 ++++
 .../devicetree/bindings/usb/dwc3.txt          |   5 +-
 .../devicetree/bindings/usb/generic.txt       |   5 +
 .../bindings/usb/richtek,rt1711h.txt          |  29 +++
 drivers/misc/Kconfig                          |   6 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/hisi_hikey_usb.c                 | 178 ++++++++++++++++++
 drivers/usb/dwc3/Kconfig                      |   1 +
 drivers/usb/dwc3/core.c                       |  38 ++--
 drivers/usb/dwc3/core.h                       |   6 +
 drivers/usb/dwc3/drd.c                        |  78 +++++++-
 drivers/usb/dwc3/gadget.c                     |   2 +-
 12 files changed, 369 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
 create mode 100644 drivers/misc/hisi_hikey_usb.c

-- 
2.17.1

