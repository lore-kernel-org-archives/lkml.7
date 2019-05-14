Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEFDC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D595E204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVwUvgfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfENSr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:47:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37882 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:47:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so144401wmo.2;
        Tue, 14 May 2019 11:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ebf4WQ/2TN4yCGU2yHyX2G1dlTx/G2hBzOsFW3tcd/g=;
        b=gVwUvgfA2kP0DFQ0doL0kTXzPcwp9UjA15SFX8xX9EYD2ZEfLlNjMUmO0WCVPMJOm+
         Xnw++OtZOobECqgDV4PBjBJxdUN7YEvWU+tOsvvJ2aFoNJd5CPOy8/zZGDZPsiTI7jIL
         j/kzIeIqncAr89vDK3XfGFJbgony0cmQq/ubiNFkRNrRJozjJXE7tcuY26GFEdN4eBHR
         mc2NoPZAroAQfkjM4aVo0JBrxeFoQtsrTKdDzmyGXF4atl6suhCeeLq3um/unFrFOff0
         OVdxIZVk4O2/lxfpV0UofNaCCTb+4eY2uyjdGZu49z2HzWbxQYvHopLPbHRPOck/+a17
         KpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ebf4WQ/2TN4yCGU2yHyX2G1dlTx/G2hBzOsFW3tcd/g=;
        b=H5QrDRedRlNjIl/5vw26WEnlVjPQj/RJNTufugzI3OTwjKhrqx37wM1sdrgILS99UR
         I2m3VftvgKb//h8mvwZ53WAKEiSrvZ5AT6ejU4cJWi8qKHZcpEVBafQEOfqpQy0678dk
         J8kHkqDyw9VbMw/B4vG/Dns3muTINHBLrHdXkzGlf3A3dIsSFlH3mMDqdJFDmgbZJKSA
         wxB+PnkCy9Ej4rEjRo+PRGd6gThgEg5N0JtS8U/QBDcERu89MY+AMYROVJEUizNeEW4P
         QST4ZVWNmC6xGhgI0TzzZUhc4YJeqzqhwQZqG95pE9tb35oUP+FElZC3bmwYeRbz1WgO
         bxVw==
X-Gm-Message-State: APjAAAVoBM8NpmV6QjmPfustv+zL3/+QQTqZ8HqppHHcdXghA01fHsCx
        i01/b35NKFClSdQtzx1AlAAUomGp
X-Google-Smtp-Source: APXvYqwZ/TuhsQQX5g1UTefE8oolZgRcMsjQZN09O6Z0XbT5P29kQ2ksD9VZFuxtVRipjkCc0YNJig==
X-Received: by 2002:a1c:6502:: with SMTP id z2mr19548849wmb.119.1557859646098;
        Tue, 14 May 2019 11:47:26 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id t18sm37501177wrg.19.2019.05.14.11.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:47:25 -0700 (PDT)
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Subject: [PATCH v4 00/13] Support of ASUS TUF Gaming series laptops
Message-ID: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Date:   Tue, 14 May 2019 20:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the fourth version of the patch series. 

Changelog:
v4:
  * Rebase on for-next branch
  * Extract local variable in patch 01
  * Rename new method to "..._method3" and keep comma in struct declaration
    in patch 03 (NOTE: the arg2 does not fit on same line by 1 character)
  * Patch "Improve DSTS WMI method ID detection":
    - sort local variables
    - use dev_info
    - separate changes to wmi module in an own patch
    - rename method ID constants and fix comment capitalization
  * "Support WMI event queue": split into separate refactoring and new
    functionality patches, use dev_info as well
  * "Organize code into sections": split out error handling refactoring
  * "Enhance detection of thermal data": remove unreasonable refactoring
    and just change the currently used condition
  * "Control RGB keyboard backlight": removed, will be posted afterwards.
    I will follow on the status of the multicolor framework, it does look
    promising for this.
  * Mark URL references with "Link:"
  * Minor corrections to commit messages
v3: 
  * Use devm_* function in patch 01
  * Detect DSTS/DCTS using _UID in patch 04
  * Detect event queue by _UID as well in patch 05
  * Rename poll function in patch 05
  * Fix terminology in patches 09 and 10
  * Correct commit messages
v2:
  * Fix logging

INTRODUCTION
The support for this laptop series is currently non-existent, as the
asus-nb-wmi driver (which is essentially configuration for asus-wmi) fails
to load and multiple ACPI errors are logged in dmesg. This patch series
adds pretty comprehensive support for these relatively new laptops, adds
some code organization, and fixes a couple of bugs in the asus-wmi module.

Thread for V1/V2: https://lkml.org/lkml/2019/4/10/973
Thread for V3: https://lkml.org/lkml/2019/4/19/178

Yurii Pavlovskyi (13):
  platform/x86: asus-wmi: Fix hwmon device cleanup
  platform/x86: asus-wmi: Fix preserving keyboard backlight intensity on
    load
  platform/x86: asus-wmi: Increase input buffer size of WMI methods
  platform/x86: wmi: Add function to get _UID of WMI device
  platform/x86: asus-wmi: Improve DSTS WMI method ID detection
  platform/x86: asus-wmi: Refactor WMI event handling
  platform/x86: asus-wmi: Support WMI event queue
  platform/x86: asus-nb-wmi: Add microphone mute key code
  platform/x86: asus-wmi: Refactor error handling
  platform/x86: asus-wmi: Organize code into sections
  platform/x86: asus-wmi: Enhance detection of thermal data
  platform/x86: asus-wmi: Switch fan boost mode
  platform/x86: asus-wmi: Do not disable keyboard backlight on unloading

 .../ABI/testing/sysfs-platform-asus-wmi       |  10 +
 drivers/hid/hid-asus.c                        |   2 +-
 drivers/platform/x86/asus-nb-wmi.c            |   3 +-
 drivers/platform/x86/asus-wmi.c               | 427 ++++++++++++++----
 drivers/platform/x86/wmi.c                    |  19 +
 include/linux/acpi.h                          |   1 +
 include/linux/platform_data/x86/asus-wmi.h    |   5 +-
 7 files changed, 374 insertions(+), 93 deletions(-)

-- 
2.17.1

