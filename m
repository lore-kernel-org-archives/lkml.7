Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F602C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA4F222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OzNuBYgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfDSS0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:26:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41940 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfDSSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:25:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so1679864wrt.8;
        Fri, 19 Apr 2019 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=J0AacS0VXB9Digb/uS8wUCrW1a/KxZR4Mwk025xF7BE=;
        b=OzNuBYgBB4lkqAok0CpNjN+8GtTd7Liuv1XeFq4msEIQGtIsjd6xO4liGRXOk5dmFB
         Axt1nyfu+eX+oy0PePKjpVni2MUW8oj/KC59/Gjtk/wlLNhrM1D9JYSP8KklJunNVkVf
         jFG+OE5/0p10I5SfOjnbh147w4XOwU13fK2p4CmgbARcT0PzxQ4iOqwywn4qZZyiGgoF
         B+ki+PKONXWWXBv4NWt2/ZR9XjpE5BuM1a9uko8oSWxDODLjAaVXOqTeQ8+j6AbXP0TC
         JTfYu4N/ub5vj9IHtZRZ4P9wa9ikHqkJ03mRyGFijbHY7UDhizo26TLYh3DRQZNR5tjw
         MEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=J0AacS0VXB9Digb/uS8wUCrW1a/KxZR4Mwk025xF7BE=;
        b=iMXOnBRnNKNKX2VFG0sfK+q7ezDrj6m/onwFjWN9RGIB4RSDLvBAr7AzdtuuQP1TJe
         rTp2RDiMiVj2jYM7b9vMLzaARlKMwBanAalZ5tiPdXs0Ru3puWQUKXDNZKBDYNp6hzMv
         De2ayx5yavUD3dGqgirNJ+hS10ijSgFNlD7mzQ5hfc+eP5mwAGt49tSZYH5dOBRU+nim
         /8hD8BG9anchdb0+P5j0KIreY0NGhrYBPjCJ9epcNg4g/S/UuPJd/gQmRuWbJ1pdg2MA
         nsY1k2ad2gELUP6214xrySrCtMl6NcMRF9FwQrMa3XPVbD5vf51gpL7SWsAaQmYZ8Vb8
         TOww==
X-Gm-Message-State: APjAAAVfLqb1Enx5Icc4UViXscP7hKZ5eu0o77GCpKvtLFWRu8WpN9DR
        m5ofj6iB0le3kinHLpg5aHHem+NeJ0c=
X-Google-Smtp-Source: APXvYqzRlwioNMs6CaQDgnPLYOk66EdYjEgsxgYHBimb5QUql9eblV6e0ELRwP6VIAkjdaPp+hQ3cw==
X-Received: by 2002:adf:dcca:: with SMTP id x10mr2304668wrm.57.1555667843090;
        Fri, 19 Apr 2019 02:57:23 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id 192sm5791849wme.13.2019.04.19.02.57.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 02:57:22 -0700 (PDT)
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Subject: [PATCH v3 00/11] asus-wmi: Support of ASUS TUF Gaming series laptops
Message-ID: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
Date:   Fri, 19 Apr 2019 11:57:20 +0200
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

this is the third version of the patch series. 

Changelog:
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

Original message from V1/V2:
https://lkml.org/lkml/2019/4/10/973

It is really long, so I will not copy it completely here, please refer
to the original for notes on design decisions and existing minor issues
(other than quirks, which should be hopefully solved now).

Yurii Pavlovskyi (11):
  platform/x86: asus-wmi: Fix hwmon device cleanup
  platform/x86: asus-wmi: Fix preserving keyboard backlight intensity on
    load
  platform/x86: asus-wmi: Increase the input buffer size of WMI methods
  platform/x86: asus-wmi: Improve DSTS WMI method ID detection
  platform/x86: asus-wmi: Support WMI event queue
  platform/x86: asus-nb-wmi: Add microphone mute key code
  platform/x86: asus-wmi: Organize code into sections
  platform/x86: asus-wmi: Enhance detection of thermal data
  platform/x86: asus-wmi: Control RGB keyboard backlight
  platform/x86: asus-wmi: Switch fan boost mode
  platform/x86: asus-wmi: Do not disable keyboard backlight on unloading

 .../ABI/testing/sysfs-platform-asus-wmi       |  71 ++
 drivers/platform/x86/asus-nb-wmi.c            |   3 +-
 drivers/platform/x86/asus-wmi.c               | 797 +++++++++++++++---
 drivers/platform/x86/wmi.c                    |  19 +
 include/linux/acpi.h                          |   1 +
 include/linux/platform_data/x86/asus-wmi.h    |   7 +-
 6 files changed, 797 insertions(+), 101 deletions(-)

-- 
2.17.1

