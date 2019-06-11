Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61BEC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9189212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404603AbfFKPRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:17:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37298 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfFKPRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:17:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id y57so14996576qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 08:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8EQNdlfEKMSd2en3pkgledmujjaJiojIo3h1kmvnOQ=;
        b=ckIs0ZQT0ZQTyavRyAxo1zsbS8aSMUP6pda4+gSHZC7pv6edOFGv8rB1mPTeSovZPx
         +3X3sHrMhro7Pb/LTaaag0dK95CohY6m4y52C43+GGxrcpNH66FlmaZK+KeQcIpB9Nju
         29G0mDHn0OzOqjCE67invoF6pHTgkAyVRLJCYhCEHzE9lOXhi+yuFYIkzORZ6Gh/sBfh
         zn+FeWKUSAofC7ycMQJhlbwQ4U+wGic2TniEqzOPHtVvMW2y/JkOS6b7qYkZK0YJvSGK
         AP+eMmg8U5d+qfUaCB0T125XTNveyVYzx9++5Mgmv/XyK+fG6PxMTmsnN78haXGoYNvP
         3ldQ==
X-Gm-Message-State: APjAAAVwnANJg/I+OomvTUiHrmBzi4mE0m0u3c9EnZjvyi/R2YRphvIy
        WB7IRWMqlnrvtiA87D/VeTrOYXvQ6+az80ftTr76WQ==
X-Google-Smtp-Source: APXvYqxTwhCXjUiYOLjzsXDsnhv8C1o60LWTFhRLJ28dtwbw6MnKs2gpVUwymuiiAZ8b1O+X+RMvu9It7qiwHlxTQk8=
X-Received: by 2002:ac8:2998:: with SMTP id 24mr62676416qts.31.1560266230100;
 Tue, 11 Jun 2019 08:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 11 Jun 2019 17:16:58 +0200
Message-ID: <CAO-hwJ+qSXwZ-5sAiZ55-r_PXp9pvnE1XEaE_v3SBnxzQQNH4g@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] I2C IRQ Probe Improvements
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, mika.westerberg@linux.intel.com,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Jim Broadus <jbroadus@gmail.com>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 2:31 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> This series attempts to align as much IRQ handling into the
> probe path as possible. Note that I don't have a great setup
> for testing these patches so they are mostly just build tested
> and need careful review and testing before any of them are
> merged.
>
> The series brings the ACPI path inline with the way the device
> tree path handles the IRQ entirely at probe time. However,
> it still leaves any IRQ specified through the board_info as
> being handled at device time. In that case we need to cache
> something from the board_info until probe time, which leaves
> any alternative solution with something basically the same as
> the current handling although perhaps caching more stuff.

Hmm, I still haven't pinpointed the issue, but I wanted to give a test
of the series and I have:
[    5.511806] i2c_hid i2c-DLL075B:01: HID over i2c has not been
provided an Int IRQ
[    5.511825] i2c_hid: probe of i2c-DLL075B:01 failed with error -22

So it seems that there is something wrong happening when fetching the
IRQ and providing it to i2c-hid.

That was on a Dell XPS 9360.

Bisecting is starting.

Cheers,
Benjamin

>
> Thanks,
> Charles
>
> See previous discussions:
>  - https://lkml.org/lkml/2019/2/15/989
>  - https://www.spinics.net/lists/linux-i2c/msg39541.html
>
> Charles Keepax (7):
>   i2c: core: Allow whole core to use i2c_dev_irq_from_resources
>   i2c: acpi: Use available IRQ helper functions
>   i2c: acpi: Factor out getting the IRQ from ACPI
>   i2c: core: Make i2c_acpi_get_irq available to the rest of the I2C core
>   i2c: core: Move ACPI IRQ handling to probe time
>   i2c: core: Move ACPI gpio IRQ handling into i2c_acpi_get_irq
>   i2c: core: Tidy up handling of init_irq
>
>  drivers/i2c/i2c-core-acpi.c | 58 ++++++++++++++++++++++++++++++++-------------
>  drivers/i2c/i2c-core-base.c | 11 +++++----
>  drivers/i2c/i2c-core.h      |  9 +++++++
>  3 files changed, 56 insertions(+), 22 deletions(-)
>
> --
> 2.11.0
>
