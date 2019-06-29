Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68219C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306592054F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhRK+YGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfF2NNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 09:13:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35138 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF2NNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 09:13:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so3842655pgl.2;
        Sat, 29 Jun 2019 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvMYZzTvRn3JBPnqgcTLb5iHAAODpQxbz+FdLrvD3Is=;
        b=HhRK+YGJXOeDaXekatjzL0eqYYo29hMPJeDRjZu+BAEGu5O/SKm6rVc138NxBfGFEW
         mx1WhLC0zr2Ccukyy3tk33GBP0OH90dk04GgxXI5ApG/KiGKvm9XpSOi9WKERNeZ+9VP
         PNqlRKoTFnD6lWTRFDoLZW5C/xVZV0UdWYDIZ49KdnR1Kw3bhlVHas+qDYlPyBTf4BSM
         QQmhGSoefLELeCutwqxHD6IrFjrgZJRMtq5fwK0BO5VGQ95YrOOxtjBGwFx5X1FQirkW
         T1ODlerBY5u81fn7lKTfqYr1rmm5OoY3i870uIF0AG1fbSY7G0HgYAOkfxXsP5ulApAQ
         n94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvMYZzTvRn3JBPnqgcTLb5iHAAODpQxbz+FdLrvD3Is=;
        b=tNLQGZ1ycGwc4OdKRWYak2K73Cn5qeEAdGTtiIubISVSmCP+mDEA5cUD81F/gB+n3s
         Dzgvwca6dTOi628ydVD+kGt7Di9lZR4e9+VNVbIofi3Fd9csy98mJprY6mEC8h7SDgje
         +Yg4epHhAAKjheP744LOdbxIE2VDHXEkEvSooWlY2sil8IwyPBBn7iGCzoDUTmNDOMpH
         /7nRZRoEhHv4vtpIh99wOGxTGTmvd1zySU4hxa2mxX8pXZBSFbI5kbUgUuQEisWGQBDl
         I2rYoBWv0+RLP4CMhF/+8TRdVRV+0iA7+yLLh9tNpCBfr8SO9imFkplVeQ2gPnLeqsqV
         94qw==
X-Gm-Message-State: APjAAAWY3H3GkAOBW+y5F8etAnkayKZ9BlQUkAkgL5UjytljLCRApLKG
        xUgl/fOsZfIKn3QcViWduxLzocDVkSI16ve83+M=
X-Google-Smtp-Source: APXvYqyPOUCTYe9czqwc5cFs5diXN/oQuZGkbrw4ZKfXoMgZs4qDe/dymYHgGTCNg5+AxRmoj+AxsvKH2c/uCPcOG8A=
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr19378072pjb.30.1561814032194;
 Sat, 29 Jun 2019 06:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
In-Reply-To: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 16:13:41 +0300
Message-ID: <CAHp75Vd4mYrwT__DgogRJdSUSOZXU+b6KX_50-O=zS_oSxwE8w@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Support of ASUS TUF Gaming series laptops
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 9:47 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> Hi,
>
> this is the fourth version of the patch series.
>

Pushed to my review and testing queue, thanks!

> Changelog:
> v4:
>   * Rebase on for-next branch
>   * Extract local variable in patch 01
>   * Rename new method to "..._method3" and keep comma in struct declaration
>     in patch 03 (NOTE: the arg2 does not fit on same line by 1 character)
>   * Patch "Improve DSTS WMI method ID detection":
>     - sort local variables
>     - use dev_info
>     - separate changes to wmi module in an own patch
>     - rename method ID constants and fix comment capitalization
>   * "Support WMI event queue": split into separate refactoring and new
>     functionality patches, use dev_info as well
>   * "Organize code into sections": split out error handling refactoring
>   * "Enhance detection of thermal data": remove unreasonable refactoring
>     and just change the currently used condition
>   * "Control RGB keyboard backlight": removed, will be posted afterwards.
>     I will follow on the status of the multicolor framework, it does look
>     promising for this.
>   * Mark URL references with "Link:"
>   * Minor corrections to commit messages
> v3:
>   * Use devm_* function in patch 01
>   * Detect DSTS/DCTS using _UID in patch 04
>   * Detect event queue by _UID as well in patch 05
>   * Rename poll function in patch 05
>   * Fix terminology in patches 09 and 10
>   * Correct commit messages
> v2:
>   * Fix logging
>
> INTRODUCTION
> The support for this laptop series is currently non-existent, as the
> asus-nb-wmi driver (which is essentially configuration for asus-wmi) fails
> to load and multiple ACPI errors are logged in dmesg. This patch series
> adds pretty comprehensive support for these relatively new laptops, adds
> some code organization, and fixes a couple of bugs in the asus-wmi module.
>
> Thread for V1/V2: https://lkml.org/lkml/2019/4/10/973
> Thread for V3: https://lkml.org/lkml/2019/4/19/178
>
> Yurii Pavlovskyi (13):
>   platform/x86: asus-wmi: Fix hwmon device cleanup
>   platform/x86: asus-wmi: Fix preserving keyboard backlight intensity on
>     load
>   platform/x86: asus-wmi: Increase input buffer size of WMI methods
>   platform/x86: wmi: Add function to get _UID of WMI device
>   platform/x86: asus-wmi: Improve DSTS WMI method ID detection
>   platform/x86: asus-wmi: Refactor WMI event handling
>   platform/x86: asus-wmi: Support WMI event queue
>   platform/x86: asus-nb-wmi: Add microphone mute key code
>   platform/x86: asus-wmi: Refactor error handling
>   platform/x86: asus-wmi: Organize code into sections
>   platform/x86: asus-wmi: Enhance detection of thermal data
>   platform/x86: asus-wmi: Switch fan boost mode
>   platform/x86: asus-wmi: Do not disable keyboard backlight on unloading
>
>  .../ABI/testing/sysfs-platform-asus-wmi       |  10 +
>  drivers/hid/hid-asus.c                        |   2 +-
>  drivers/platform/x86/asus-nb-wmi.c            |   3 +-
>  drivers/platform/x86/asus-wmi.c               | 427 ++++++++++++++----
>  drivers/platform/x86/wmi.c                    |  19 +
>  include/linux/acpi.h                          |   1 +
>  include/linux/platform_data/x86/asus-wmi.h    |   5 +-
>  7 files changed, 374 insertions(+), 93 deletions(-)
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
