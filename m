Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51352C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F74206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0YTY/qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfITQDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:03:20 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46958 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbfITQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:03:20 -0400
Received: by mail-yb1-f194.google.com with SMTP id t2so2805274ybo.13;
        Fri, 20 Sep 2019 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uf8TUqP7EYlLwV20qdPvpJcwERJyBXGKd4AgAHrl2p0=;
        b=S0YTY/qiLC+vt0AhlB24j9SXlB5qQANaiZ7IgOv7gKjdnkoWuHf4dGtC0BdEWSLDgd
         bPbiDUGqppVuqMF0cFnHvd0X3XUu7cakbWL4gn7wNyo4FTrVTN2Yu2YdxPqcfdDXQ5BI
         /JeGcvcC3fw0BaoUiCoKLrSwPgPlI0Xtu4AXaaASuSeR3ZFoGCMKBR3aoU2rYpGxO4jR
         lghl5orMDYR1lE1kYRCQHc0ekknAtvpsnR37s34+b6D2x9HlW727aNHp7SDBWtTOtGNG
         1KFSTc1ZmSqj8eRXrBj5vnIwiZ98F8SPntU69qce2I0LIoPpDI1uY50Hmcm3OvzVlRFY
         r0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uf8TUqP7EYlLwV20qdPvpJcwERJyBXGKd4AgAHrl2p0=;
        b=BXed1s8DwnUtaK9+NFGm47KiRf6xzjFC5ESmIUW94i0Dh08vvxvTBsjc3g7tokpd1J
         UdFWvpufuPw9VK3nri5TKUc/D9m4eypARPYeZORrL5NeAbGvGSBXUMFHddlRigUGZiza
         3M6qSFeUf/RiH+ItJZY6V43c3zsTw6cyHq+Af9eIbAzY/G4UJlJrmmBAk5TjiUnuRTKl
         ZKi69tb+X7vpv2GS7UrCY12zm2PUTdjbxNfclLIBw5IhgWE0wLajA/x273MB7m4ncCss
         32CplpWWWrGHdJt1qSz7kfRCR7oua19EM23TH2QiW628hgedfexELqdvj+85cMgbOfnr
         o9Dw==
X-Gm-Message-State: APjAAAV83/96mtgyn+TujNhNXDnTA31ilLvh7HNDxQgF7WiLUIS1wdRP
        vZUmDLPoeHC81hlJx+lYyQ==
X-Google-Smtp-Source: APXvYqxd0Ha1HvHrCr+lz/dx9T0Eq8M4K/ZmObuDOU8PNAwZ9iWTpLNYlf9vcMWeUlkwhya03kwvTQ==
X-Received: by 2002:a25:4dc2:: with SMTP id a185mr11177731ybb.209.1568995398504;
        Fri, 20 Sep 2019 09:03:18 -0700 (PDT)
Received: from localhost.localdomain ([12.156.111.130])
        by smtp.gmail.com with ESMTPSA id 207sm518086ywu.106.2019.09.20.09.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 09:03:17 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] platform/x86: Huawei WMI laptop extras driver
Date:   Fri, 20 Sep 2019 12:02:33 -0400
Message-Id: <20190920160250.12510-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
* Use int and bint for module params.

Changes in v3:
* Kconfig changes
* Fix NULL cast to int warning.
* Add ACPI_BATTERY as a dependency.

Changes in v2:
* Use battery charge control API.

This patch series introduce changes to huawei-wmi driver that includes:
* Move to platform driver
* Implement driver quirks and parameters
* Implement WMI management interface
* Add micmute LED support through WMI
* Add battery charging protection support through WMI
* Add fn-lock support through WMI
* Add a debugfs interface to WMI

# Move to platform driver

The current driver offers hotkeys and micmute led support only. With
these changes, a platform driver makes more sense since it handles these
changes pretty nicely.

# Implement WMI management interface

Huawei Matebook laptops come with two WMI interfaces. The first being
WMI0 which is considered "legacy" and AFAIK only found on the Matebook X
released in 2017. The second has a UID of "HWMI" and is found in pretty
much all models with a slight difference in implementation except for
the Matebook X (2017). Since this model has two interfaces, some aspects
are controlled through the legacy interface and some through the other
interface. Currently, the legacy interface is not fully implemented and
is only used for hotkeys and further debugging has to be done.

The WMI interface takes a 64 bit integer, although uses 32 bits most of
the time, and returns a 256-260 bytes buffer consists of either one ACPI
buffer of 260 bytes, in the case of Matebook X (2017), or one ACPI
package of two buffers, one with 4 bytes, and the other with 256 bytes.
We only care about the latter 256 buffer in both cases since the 4 bytes
always return zeros. The first byte of this 256 buffer always has the
return status where 1 indicated error. Some models require calling the
WMI interface twice to execute a command.

# Add micmute LED support through WMI

After implementing the WMI interface, micmute LED can be controlled
easily. Models with the legacy interface fall back to ACPI EC method
control since the legacy interface is not implemented.

# Add battery charging protection support through WMI

Most models, that has the WMI interface, are capable of battery
protection where it can control battery charging thresholds and limits
charging the battery to certain values.

# Add fn-lock support through WMI

The behavior of hotkeys is not the same among all models. Some models
require fn-lock to do things like `Ctrl-Ins` or `Alt-PrtSc`. By default,
hotkeys behave as special keys (media keys, Ins, etc), but if a modifier
is used (ctrl, alt, shift) these keys behave as F1-F12 keys. If the Fn
key is toggled on, the hotkeys with or without a modifier, behave as
F1-F12 keys. This makes it impossible to use a modifier and `PrtSc` or
`Ins`.

Now, some models fix this by excluding `PrtSc` and `Ins` keys from being
treated as F11 and F12 keys with the use of a modifier. However, some
models do not, and fixes this by the so called fn-lock.

Fn-lock inverts the behavior of the top row from special keys to F1-F12
keys. So a modifier and a special key would be possible which make
things like `Alt-Ins` possible. Now, with fn-lock we would have 4 modes:

* Fn-key off & fn-lock off - hotkeys treated as special keys using a
  modifier gives F1-F12 keys.
* Fn-key on & fn-lock off - hotkeys treated as F1-F12 keys and using a
  modifier gives F1-F12.
* Fn-key off & fn-lock on - hotkeys are treated as F1-F12 keys and using
  a modifier gives special keys.
* Fn-key on & fn-lock on - hotkeys are treated as special keys and using
  a modifier gives special keys.

# Implement driver quirks and parameters

The driver introduces 3 quirks and 2 parameters that can change the
driver's behavior. These quirks being as:
1. Fixes reporting brightness keys twice since it's already handled by
   acpi-video.
2. Some models need a short delay when setting battery thresholds to
   prevent a race condition when two processes read/write.
3. Matebook X (2017) handles micmute led through the "legacy" interface
   which is not currently implemented. Use ACPI EC method to control
   this led.

and the 2 parameters can enforce the behavior of quirk 1 & 2.

# Add a debugfs interface to WMI

An interface to the WMI management interface that allows easier
debugging.

Ayman Bagabas (6):
  platform/x86: huawei-wmi: Move to platform driver
  platform/x86: huawei-wmi: Add quirks and module parameters
  platform/x86: huawei-wmi: Implement huawei wmi management
  platform/x86: huawei-wmi: Add battery charging thresholds
  platform/x86: huawei-wmi: Add fn-lock support
  platform/x86: huawei-wmi: Add debugfs support

 drivers/platform/x86/Kconfig      |   8 +-
 drivers/platform/x86/huawei-wmi.c | 874 ++++++++++++++++++++++++++----
 2 files changed, 786 insertions(+), 96 deletions(-)


base-commit: 288b9117de5cc1b7fb80f54b7c17deed6f018641
-- 
2.21.0

