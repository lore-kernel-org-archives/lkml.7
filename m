Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EB9C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1B1207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAu/85UD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408040AbfIXCsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:48:35 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35548 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389572AbfIXCse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:48:34 -0400
Received: by mail-vs1-f66.google.com with SMTP id s7so319598vsl.2;
        Mon, 23 Sep 2019 19:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrnVl/JP+FSVSFO0Nh+ZZK89v309f2SPuCxTTcoUpLk=;
        b=kAu/85UDnqmOr3wBZGcPCS46fP7iP/5eBSM+l7uUoodXIPsvAfzgnrM5KoGINT/+kv
         1/jF2Uz8i9gOdRTdxfHgGkeTPp9fGV3eqnkX98PviPaIQRtJ/RXzhMfGV6Wo2CFNiGwe
         jSmAopAA4+F67/rL0KbnG8JlqsiuKRb8hF03Yvq8r2uk79hJRlXruE1lEvVYBmTJOQl0
         vRP/TD32E/690jeqMexXWGwpRSM7C3fTiXwNvCh/ePmSbSxk7LEIJLKYYMc7+EAHLCKf
         FV8a2Hxe0zHu6uVXF+kPV1Nz+GNYMtgTVeGLlDlUiTu3vdBXT0SZ2wG4B5OwaT9zJS3e
         Gx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrnVl/JP+FSVSFO0Nh+ZZK89v309f2SPuCxTTcoUpLk=;
        b=OD7YiSKpOMYrPpt70YvX//TFxEvGz1U9d2dnPaP1h5pS8BmQJBvGNe7mY4eEeihL0D
         h83tB0wVZkyCigSHaQM8R0HeEDjw3pmMBBaJLk1ImuZ4l5D4HHdJqR0wtAQYMDsF4GT7
         se8KKzuaWAf8Yni5K1ax8Fo0x+JIo9tsKkAwmvg+o2XJnboGTZkUSQsYgfHQSRc5q4W3
         TSIIHbILviq6yS1Mv4hoI73u7mXowct5d8xdOapMKB/u+imUFHt5zLkduhHIey/kBqu6
         S4Zij3WYSh6il+L/dcPiKc0QTh7py3d4ho2eOQzzS/8Rn+1OPG3a12w8g/l+4h6hO0Do
         mOPA==
X-Gm-Message-State: APjAAAXCIfYTyHoZnFoi5yrfIgKWbQR9cbbkwtV2chp6X7mafCGIGbRA
        sdses7VjTDl3NLHD254uOA==
X-Google-Smtp-Source: APXvYqx29FkFh2Ca9pzeZ5oPtUy+j4maAiblZ2AlG7jqUtJw4TSqnIYpXAlAjgeYR08iFLVhvj6qHA==
X-Received: by 2002:a67:d40a:: with SMTP id c10mr301356vsj.188.1569293313184;
        Mon, 23 Sep 2019 19:48:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:901:202:18cc:820:670:dd1:f572])
        by smtp.gmail.com with ESMTPSA id o16sm46547uar.2.2019.09.23.19.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 19:48:32 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sinan Kaya <okaya@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] platform/x86: Huawei WMI laptop extras driver
Date:   Mon, 23 Sep 2019 22:48:05 -0400
Message-Id: <20190924024821.497-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
* Fix a possible buffer overflow error.

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


base-commit: b5b3bd898ba99fb0fb6aed3b23ec6353a1724d6f
-- 
2.21.0

