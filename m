Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0172C5B57F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8836208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 05:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/mPOGsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF3FlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 01:41:25 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38042 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3FlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 01:41:25 -0400
Received: by mail-vs1-f68.google.com with SMTP id k9so6754344vso.5;
        Sat, 29 Jun 2019 22:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=clQOczYwEsKKHOAzZidWMeMT4c+c0AdrHLZADibcT5I=;
        b=W/mPOGsWnmXShX2vqkfncaWdrS7qRg6/Q1NYGxtqgZ+SH3up6HKAvKzs4/qYdRi0V/
         RtZ4Z0HjgZOXP/27vA3bqMvIWO3SdEKlE1e91Nu4ZsBBKdQgGNCP+Farh/ROc609Hgwd
         7qz2w6v31iNrCop4m4nqiFmmWxY/X5H0XGr/aWlBlxIb7wHIvqd4PY+8TanEkcZli+bV
         mCHk4OPRyEqLUICPQWH3DpkTLeWsLu9e9uY/JKdqudig/8mFzRox7F0Iq7DEfru/QgKu
         /4ipuPi4+b7lnC72+O7hEVeEQL91yFZuXR+b4cuCTIgJDHxmOlYa/7JRW4gvcJPU9K+w
         xcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=clQOczYwEsKKHOAzZidWMeMT4c+c0AdrHLZADibcT5I=;
        b=DYrNZmLOtA7fs5RJMfJLPwC08rR3W/AR59UWv1ZCBVbIswY07cUQDzsRY/mvqZmDob
         dP+cj+g7xZVMRlHZ4hs0IxMyqV2ITX30QBkqDZjE301gXPdCiPfbU8TycM9hwXLokQ8P
         JtxuS1CQj7QdyvVIiTgnpNgXm6NWbir0m8UjwTU4IU5uxBHkPnOTwj9/C7YoQY5/rXlW
         qJ5KBVW1TgWw1mYa8Z7Jy5Hpo7qXEWM9mdF+OdSvxKDkmITqPkF2KhPm/rjhGVJvTwNc
         oquhM2JDTTU2nhl+/FpVkqW1Yv1EjGjJS0nqye1ue447eIkFVX2apHWLsgQebbYXR/kz
         Xy4A==
X-Gm-Message-State: APjAAAXr7NBoNgWZiyK1olkJjIukZaVZh+Ekzt2ezGFHnJCka7glYpA5
        Ra6NTeh8Jj3oPOWF/IZZ1w==
X-Google-Smtp-Source: APXvYqw9LJGr9ejHAdvNsQ9iGU8WklErdwKaLxgXTbnEBJ8pZKaD42ZyLSYN5Fo7+9QPSAezcArV+Q==
X-Received: by 2002:a67:ff0b:: with SMTP id v11mr10657498vsp.14.1561873283358;
        Sat, 29 Jun 2019 22:41:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id r136sm1926676vke.46.2019.06.29.22.41.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 22:41:22 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [RFC 0/9] platform/x86: Huawei WMI laptop extras driver
Date:   Sun, 30 Jun 2019 01:40:59 -0400
Message-Id: <20190630054108.19205-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce changes to huawei-wmi driver that includes:
* Move to platform driver
* Implement WMI management interface
* Add micmute LED support through WMI
* Add battery charging protection support through WMI
* Add fn-lock support through WMI
* Implement driver quirks and parameters
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

Ayman Bagabas (9):
  platform/x86: huawei-wmi: rename guid and driver name
  platform/x86: huawei-wmi: move to platform driver
  platform/x86: huawei-wmi: implement huawei wmi management interface
  platform/x86: huawei-wmi: add quirks and module parameters
  platform/x86: huawei-wmi: control micmute led through wmi interface
  platform/x86: huawei-wmi: add battery charging thresholds
  platform/x86: huawei-wmi: add fn-lock support
  platform/x86: huawei-wmi: add sysfs interface support
  platform/x86: huawei-wmi: add debugfs support

 drivers/platform/x86/huawei-wmi.c | 710 ++++++++++++++++++++++++++----
 1 file changed, 629 insertions(+), 81 deletions(-)

-- 
2.20.1

