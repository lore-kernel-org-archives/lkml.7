Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33202C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEFC208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrrAenEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfGKWTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 18:19:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46562 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfGKWTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:19:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id c73so3373336pfb.13;
        Thu, 11 Jul 2019 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P7pNfwqlW6YLuTKu3MTf0+gYs6dX2k9OVTcZOQqJt3M=;
        b=lrrAenEYYCG+HAWH+KZlLMziX7Z3WBDlrdAvWY5Phyv7t6SWZMsV6iR3B+cxY8KAWz
         uGzZiVHJ7Okqunl8bcHJC35GlG0zc9i/Sevwb4hd6TakXQB4jUaBPqzGccw7EEwmGsWX
         bDT4oE3f4y+SZ0YuMW9K3nAr1zxUztY26rO/g4zB0uLbAloYlR2KU4sw/ViZW1ZtHpxU
         EFpxzERmlrSAHqwJVmHHhRTJ83WS1BT8lEs9V6gp1PM5LiwSiK+hTsssNP4nlCmTgeAJ
         36l+8v1DXmpFVASIwjju/OgbqUlqn0SC9UuttJAMUBbGZ8009UC4ixT/D+uY/ShmYnTh
         04nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7pNfwqlW6YLuTKu3MTf0+gYs6dX2k9OVTcZOQqJt3M=;
        b=gnSNnikqRESTQixC/0c7Hr704Q7YfwEAzmlKwGYuoTlEL3wAztNaCxmRZbSRD3jOtf
         vKv3VveZlRzFQVPQXqaven3jXu0hZc4H9J/cvqDXZF7j0bF9N1SWIXDNGPnR6hAWKcZu
         13dl1Bb2Aqf1ha2ID+JucJSf//alzKsjUEWQLH0+POelWvu1aalphywhP8mlS6A7xdKr
         FjwH+sMlvDa2ryK6dCnGZlFX+BTXZHD4CycVbuEGz4COeN/2sMXCku3zxfcO7J2KAIXg
         kM2CZeSI9nN58B/ZgEtX+RRmugsWsSy+bDuLQhkiutiakrlvlvMf27DjPJF7jS4U79ix
         G2ww==
X-Gm-Message-State: APjAAAWDuDLL6EaJibypRi1HUzWThVG5/rrxd/3EiKRY2Xrs5qElC/zd
        Lir7hS7A6bER+zdHmdkT+0M=
X-Google-Smtp-Source: APXvYqyhntgiVSSRjRWnzsA8i+ol5GHlGi4tuKq9N9YYYQL3f26mIDIPI7qRvtfeWjH2gfLSElmLvQ==
X-Received: by 2002:a17:90a:d14b:: with SMTP id t11mr7426674pjw.79.1562883591348;
        Thu, 11 Jul 2019 15:19:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q36sm5875213pgl.23.2019.07.11.15.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 15:19:50 -0700 (PDT)
Date:   Thu, 11 Jul 2019 15:19:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] hwmon updates for hwmon-for-v5.3
Message-ID: <20190711221948.GA16140@roeck-us.net>
References: <1562696588-26554-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562696588-26554-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 11:23:08AM -0700, Guenter Roeck wrote:
> Hi Linus,
> 
> Please pull hwmon updates for Linux hwmon-for-v5.3 from signed tag:
> 
I have been sending out those odd messages ever since v5.1 because
my script was checking for v4.x, not for v5.x. Oh well.
Should I resend with better subject and text ?

Guenter

>     git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.3
> 
> Thanks,
> Guenter
> ------
> 
> The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:
> 
>   Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.3
> 
> for you to fetch changes up to 9f7546570bcb20debfaa97bcf720fa0fcb8fc05a:
> 
>   hwmon: (ina3221) Add of_node_put() before return (2019-07-08 18:11:32 -0700)
> 
> ----------------------------------------------------------------
> hwmon updates for v5.3
> 
> New drivers for Infineon PXE1610 and IRPS5401
> Minor improvements, cleanup, and fixes in several drivers
> 
> ----------------------------------------------------------------
> Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
>       hwmon: (pmbus/adm1275) support PMBUS_VIRT_*_SAMPLES
> 
> Alexander Soldatov (1):
>       hwmon: (occ) Add temp sensor value check
> 
> Arnd Bergmann (1):
>       hwmon: (max6650) Fix unused variable warning
> 
> Boyang Yu (1):
>       hwmon: (lm90) Fix max6658 sporadic wrong temperature reading
> 
> Christian Schneider (2):
>       hwmon: (gpio-fan) move fan_alarm_init after devm_hwmon_device_register_with_groups
>       hwmon: (gpio-fan) fix sysfs notifications and udev events for gpio-fan alarms
> 
> Greg Kroah-Hartman (1):
>       hwmon: (asus_atk0110) no need to check return value of debugfs_create functions
> 
> Guenter Roeck (17):
>       hwmon: (gpio-fan) Check return value from devm_add_action_or_reset
>       hwmon: (pwm-fan) Check return value from devm_add_action_or_reset
>       hwmon: (core) Add comment describing how hwdev is freed in error path
>       hwmon: (max6650) Use devm function to register thermal device
>       hwmon: (max6650) Introduce pwm_to_dac and dac_to_pwm
>       hwmon: (max6650) Improve error handling in max6650_init_client
>       hwmon: (max6650) Declare valid as boolean
>       hwmon: (max6650) Cache alarm_en register
>       hwmon: (max6650) Simplify alarm handling
>       hwmon: (max6650) Convert to use devm_hwmon_device_register_with_info
>       hwmon: (max6650) Read non-volatile registers only once
>       hwmon: (max6650) Improve error handling in max6650_update_device
>       hwmon: (max6650) Fix minor formatting issues
>       hwmon: (pmbus/adm1275) Fix power sampling support
>       hwmon: Convert remaining drivers to use SPDX identifier
>       hwmon: (lm90) Cache configuration register value
>       hwmon: (lm90) Introduce function to update configuration register
> 
> Masahiro Yamada (1):
>       hwmon: (smsc47m1) fix (suspicious) outside array bounds warnings
> 
> Nishka Dasgupta (1):
>       hwmon: (ina3221) Add of_node_put() before return
> 
> Robert Hancock (1):
>       hwmon: (pmbus) Add Infineon IRPS5401 driver
> 
> Vijay Khemka (2):
>       hwmon: (pmbus) Add Infineon PXE1610 VR driver
>       hwmon: (pmbus) Document Infineon PXE1610 driver
> 
> Wolfram Sang (1):
>       hwmon: (lm90) simplify getting the adapter of a client
> 
> amy.shih (3):
>       hwmon: (nct7904) Fix the incorrect value of tcpu_mask in nct7904_data struct.
>       hwmon: (nct7904) Add error handling in probe function.
>       hwmon: (nct7904) Changes comments in probe function.
> 
>  Documentation/hwmon/pxe1610    |  90 ++++++
>  drivers/hwmon/adm1029.c        |  10 -
>  drivers/hwmon/asus_atk0110.c   |  23 +-
>  drivers/hwmon/gpio-fan.c       |  22 +-
>  drivers/hwmon/hwmon.c          |   6 +
>  drivers/hwmon/ina3221.c        |   4 +-
>  drivers/hwmon/lm90.c           | 106 +++---
>  drivers/hwmon/max6650.c        | 710 +++++++++++++++++++++--------------------
>  drivers/hwmon/nct7904.c        |  81 ++++-
>  drivers/hwmon/occ/common.c     |   6 +
>  drivers/hwmon/pmbus/Kconfig    |  18 ++
>  drivers/hwmon/pmbus/Makefile   |   2 +
>  drivers/hwmon/pmbus/adm1275.c  | 105 +++++-
>  drivers/hwmon/pmbus/irps5401.c |  67 ++++
>  drivers/hwmon/pmbus/pxe1610.c  | 139 ++++++++
>  drivers/hwmon/pwm-fan.c        |  10 +-
>  drivers/hwmon/scpi-hwmon.c     |  10 +-
>  drivers/hwmon/smsc47m1.c       |   2 +
>  18 files changed, 954 insertions(+), 457 deletions(-)
>  create mode 100644 Documentation/hwmon/pxe1610
>  create mode 100644 drivers/hwmon/pmbus/irps5401.c
>  create mode 100644 drivers/hwmon/pmbus/pxe1610.c
