Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47552C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5C9206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 05:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rxt8FGjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfK1FKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 00:10:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38268 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfK1FKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 00:10:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so6715372pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 21:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mH3WwLWJKCS7M5Q+lMxyNp1TtLh/YyHOg0YBxMxQmqU=;
        b=Rxt8FGjTZyXeKY17A8C892aaFMnfChP85whFt4zWuuIkEp3vXW+myDE5HfgzbNFsPk
         bCvfT3AqMKDLfsRkYoiqgRwnd1OAutKgcU0Sb0rJpiaUr5EG4dbLUhwjAZCQbvkWBH1E
         xmu/vTCIEPLsMwZTbLbda63OQ3fsifQ2ar2wdZqoSB63vMOPC6ufQmnsT/iFt8z/n0+/
         l0Yx+T4FDRlDR46booI12g122lfF8eU+9A2+xjyrmNqhdnXJo7g6olJMiebYYnLLgmo8
         GFGyY9Ehnayo3wm+B8z0JiN1CjH1PEYh3wRUxWRaIvxMhISKyZd6MWWRMWhlvd34Czlm
         /KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mH3WwLWJKCS7M5Q+lMxyNp1TtLh/YyHOg0YBxMxQmqU=;
        b=NkC0JnVceh634Ig27nURFW29WfzBo0UsNCO/Tm1dliSI8wPv/kyFUZJJdSA+h/vNXd
         aWyw/Nt3n1avlMdNs0QvKjgAP3GJ/JcsGLHDVxlmO94lMixOZ9fGXxtthzMxgO7K9IqA
         cklsClU8QurBlzKPWUlq+C6DASOy4ajGGrkC7FNr2Ekldh8pP06siHDSoX+8LP7rM7+7
         P55kh3Z/Frgw6ZAaBI0YyekEsG477H10fce2GS5Nv/B9rlSkGWHygqiYqBUfuVj1I68o
         g9mnKgpN3H3z+3hJlWW9kjdR3KKEpcLQtaMcrEOrAw1nCJI4/oPfrzO+mmRzAYnqDT5o
         +M0A==
X-Gm-Message-State: APjAAAVoUmRoaK0ABdEWjjBUIuuwFhjyUGRngfueON3mc3rjeDDo6oqy
        fiIQ5puzYjLKLOpjGhUweiNhE9Em+Us=
X-Google-Smtp-Source: APXvYqwVV0ALMAo/FMoz3Zicqfg8le83VSU6rFEDuilREl15IOPdjEeh3rGGqhVl5mRazcMs2qFoBQ==
X-Received: by 2002:a17:90a:ab0c:: with SMTP id m12mr10177433pjq.69.1574917804019;
        Wed, 27 Nov 2019 21:10:04 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j20sm17799838pff.182.2019.11.27.21.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 21:10:03 -0800 (PST)
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
Subject: [PATCH v6 0/8] HiKey960 USB support
Date:   Thu, 28 Nov 2019 05:09:53 +0000
Message-Id: <20191128051001.18995-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just another round here trying to push forward a patch series
submitted originally by Yu Chen to get HiKey960 dev-board's USB
functionality working.

The full patchset (including dts changes not submitted here) can
be found here:
https://git.linaro.org/people/john.stultz/android-dev.git/log/?id=950276ae1baab3a22836d1f89aeadbb08adf41e0


NOTE: I unfortunately don't have any deep knowledge of the
hardware other then the previously submitted code  and what I
can intuit from testing. I tried to document the previously
undocumented bindings, fixed up a few minor checkpatch issues
and tried to address previous feedback as best I could.

I'd greatly appreciate any feedback or thoughts!

thanks
-john

New in v6:
* Felipe previously had disliked extending the dwc3 binding
  to allow for more flexible clock and resest lists, so in
  the last series I switched back to the dwc3-simple-of.c 
  approach, but Rob pushed back on the last series, and with
  no reply from Felipe, I've switched back to this appraoch.
  Clear guidance would be appreciated here!
* Fixed build issue Reported-by: kbuild test robot <lkp@intel.com>


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

John Stultz (5):
  dt-bindings: usb: generic: Add role-switch-default-mode binding
  usb: dwc3: Add support for role-switch-default-mode binding
  dt-bindings: usb: dwc3: Allow clock list & resets to be more flexible
  usb: dwc3: Rework clock initialization to be more flexible
  usb: dwc3: Rework resets initialization to be more flexible

Yu Chen (3):
  usb: dwc3: Registering a role switch in the DRD code.
  dt-bindings: misc: Add bindings for HiSilicon usb hub and data role
    switch functionality on HiKey960
  misc: hisi_hikey_usb: Driver to support usb functionality of Hikey960

 .../bindings/misc/hisilicon-hikey-usb.txt     |  40 ++++
 .../devicetree/bindings/usb/dwc3.txt          |   5 +-
 .../devicetree/bindings/usb/generic.txt       |   6 +
 drivers/misc/Kconfig                          |   6 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/hisi_hikey_usb.c                 | 178 ++++++++++++++++++
 drivers/usb/dwc3/core.c                       |  22 +--
 drivers/usb/dwc3/core.h                       |   6 +
 drivers/usb/dwc3/drd.c                        |  96 +++++++++-
 9 files changed, 341 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
 create mode 100644 drivers/misc/hisi_hikey_usb.c

-- 
2.17.1

