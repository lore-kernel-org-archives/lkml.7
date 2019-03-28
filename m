Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7248DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36044206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WEHQ9p9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfC1Vs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 17:48:59 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38434 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfC1Vs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 17:48:59 -0400
Received: by mail-it1-f195.google.com with SMTP id f22so697437ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 14:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POFNTFkXnfglYcZVW5azcTDp6qvbT4UFwDSyy+XrSIQ=;
        b=WEHQ9p9XUGbas9YfuVZrHmf+RAaplfu/Z346Gt9/4TNFEiWvPbwk4wSWstif5ADQYC
         oWA+e11bVGEUehX9T21xyHWEmzsGcOwocO+rScnipZzdFW9zjY1JoSbGNxO1MQVfhTrl
         PVLLF9F0gL+r4GM8UrguwsqBSxSDRq4wZJex8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POFNTFkXnfglYcZVW5azcTDp6qvbT4UFwDSyy+XrSIQ=;
        b=kBlnSPqUzIJS9uX/7QC9WbY3j3ulq9cunn7HXv4/O9qbc0Yl6UX1fT9XHukLxBcTEH
         BUHFrG/YqhGC3FnlZEtsLvBfWJKloiPucATEQfiaKHYLavkWvdmnBgdokxJXE6Qa48TT
         XjfIZa6htowEnFQZssteiIpjMMEwTEt0X3RhdlvwKodbg5d1nYXGIKhcOkHm2qiKWXwt
         waxqaS1bTNCmTENpVEpKhGnJ1w1BjPQ1QFAFHTxUb4iJm59kGqqrkdcWXJpPfGKidPp3
         8Qt9v47DV7Nr5+7I/kqmu2vCk2y7ku4RGq0+ek5awRxC5CMP/C+qJ54ZhNe/iWetXS6V
         qNAg==
X-Gm-Message-State: APjAAAWiD4fLCLH36XUFivFtHAguja0P5xhmhF4yCpFaFAFy7CudQo/5
        4BkIn+StQy5ZZavETe7U58E+TNGL335mZU3CqPXMUw==
X-Google-Smtp-Source: APXvYqz2iJsQ/m8HtAd9iDlc39ZYxg3WLSSDMahu7y/zZY/E+ayxmjVOdGEdHEu2vSQ4jJ9Cg+PSy/GSZTd+ye3tkEM=
X-Received: by 2002:a24:2705:: with SMTP id g5mr1934919ita.120.1553809738113;
 Thu, 28 Mar 2019 14:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUE2usTh3Th8FySCUsbgp_WGEL2k94pxDfwp4GT1uUkksok8w@mail.gmail.com>
 <CAPUE2usMGzQVnL-rSrRoeWm=BHYD6pKkWXGNkaMpDOvFOy0HAQ@mail.gmail.com> <f7e7b21c-60e4-fd38-d836-49550eb55e50@collabora.com>
In-Reply-To: <f7e7b21c-60e4-fd38-d836-49550eb55e50@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 28 Mar 2019 14:48:47 -0700
Message-ID: <CAPUE2ut9MjVuvOxZuVNBnZiFvz9Y2XBgCPSQRrdM=6w+p4Rv1Q@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: cros: Update EC protocol to match current EC code
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 2:31 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal,
>
> Unless my pwclient or patchwork is doing something weird I have some issues
> trying to apply this patch. Could you check that is correctly formatted?
In lore.kernel.org, the first 100 lines of the patch are missing.
Resending.

Gwendal.
>
> $ pwclient git-am 1055029
>
> Applying patch #1055029 using u'git am'
> Description: [v2] mfd: cros: Update EC protocol to match current EC code
> Applying: mfd: cros: Update EC protocol to match current EC code
> error: patch fragment without header at line 11: @@ -105,15 +120,24 @@
> Patch failed at 0001 mfd: cros: Update EC protocol to match current EC code
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 'git am' failed with exit status 128
>
> Also if I try to apply the patch directly I got:
>
> $ git am --show-current-patch | patch -p1
> patching file include/linux/mfd/cros_ec_commands.h
> patch: **** malformed patch at line 5615: (8-bit) */
>
> On 26/3/19 18:21, Gwendal Grignou wrote:
> > Chromebook Embedded Controller protocol is defined in the kernel at
> > cros_ec_commands.h.
> > The source of trust for the EC protocol is at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> >
> > Only needed changes have been picked up from this file to the kernel
> > include file leading to gaps between the upstream version and what the
> > latest ECs can do.
> >
> > Fill the gaps to ease future integrations. Changes from the original
> > files is header/footer for license and include files for alignment.
> >
> > Check this include file works on ChomeOS kernel 4.14 and 4.19 on eve.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> > Changes in v2:
> > - Replace 1 << with BIT()
> > - Check checkpatch warning/errors are outside kernel scope.
> > - Update .h with latest changes.
> >
> >  include/linux/mfd/cros_ec_commands.h | 3723 +++++++++++++++++++++-----
> >  1 file changed, 2992 insertions(+), 731 deletions(-)
> >
> > diff --git a/include/linux/mfd/cros_ec_commands.h
> > b/include/linux/mfd/cros_ec_commands.h
> > index fc91082d4c35..5c4764e3db6f 100644
> > --- a/include/linux/mfd/cros_ec_commands.h
> > +++ b/include/linux/mfd/cros_ec_commands.h
>
> [snip]
>
> > @@ -33,7 +46,7 @@
> >  #define EC_PROTO_VERSION          0x00000002
> >
> >  /* Command version mask */
> > -#define EC_VER_MASK(version) (1UL << (version))
> > +#define EC_VER_MASK(version) BIT(version)
> >
> >  /* I/O addresses for ACPI commands */
> >  #define EC_LPC_ADDR_ACPI_DATA  0x62
> > @@ -59,13 +72,13 @@
> >  #define EC_HOST_CMD_REGION_SIZE 0x80
> >
> >  /* EC command register bit functions */
> > -#define EC_LPC_CMDR_DATA     (1 << 0)  /* Data ready for host to read */
> > -#define EC_LPC_CMDR_PENDING  (1 << 1)  /* Write pending to EC */
> > -#define EC_LPC_CMDR_BUSY     (1 << 2)  /* EC is busy processing a command */
> > -#define EC_LPC_CMDR_CMD              (1 << 3)  /* Last host write was a command */
> > -#define EC_LPC_CMDR_ACPI_BRST        (1 << 4)  /* Burst mode (not used) */
> > -#define EC_LPC_CMDR_SCI              (1 << 5)  /* SCI event is pending */
> > -#define EC_LPC_CMDR_SMI              (1 << 6)  /* SMI event is pending */
> > +#define EC_LPC_CMDR_DATA     BIT(0)  /* Data ready for host to read */
> > +#define EC_LPC_CMDR_PENDING  BIT(1)  /* Write pending to EC */
> > +#define EC_LPC_CMDR_BUSY     BIT(2)  /* EC is busy processing a command */
> > +#define EC_LPC_CMDR_CMD              BIT(3)  /* Last host write was a command */
> > +#define EC_LPC_CMDR_ACPI_BRST        BIT(4)  /* Burst mode (not used) */
> > +#define EC_LPC_CMDR_SCI              BIT(5)  /* SCI event is pending */
> > +#define EC_LPC_CMDR_SMI              BIT(6)  /* SMI event is pending */
> >
> >  #define EC_LPC_ADDR_MEMMAP       0x900
> >  #define EC_MEMMAP_SIZE         255 /* ACPI IO buffer max is 255 bytes */
> > @@ -85,13 +98,15 @@
> >  /* Unused 0x28 - 0x2f */
> >  #define EC_MEMMAP_SWITCHES         0x30      /* 8 bits */
> >  /* Unused 0x31 - 0x33 */
> > -#define EC_MEMMAP_HOST_EVENTS      0x34 /* 32 bits */
> > -/* Reserve 0x38 - 0x3f for additional host event-related stuff */
> > -/* Battery values are all 32 bits */
> > +#define EC_MEMMAP_HOST_EVENTS      0x34 /* 64 bits */
> > +/* Battery values are all 32 bits, unless otherwise noted. */
> >  #define EC_MEMMAP_BATT_VOLT        0x40 /* Battery Present Voltage */
> >  #define EC_MEMMAP_BATT_RATE        0x44 /* Battery Present Rate */
> >  #define EC_MEMMAP_BATT_CAP         0x48 /* Battery Remaining Capacity */
> > -#define EC_MEMMAP_BATT_FLAG        0x4c /* Battery State, defined below */
> > +#define EC_MEMMAP_BATT_FLAG        0x4c /* Battery State, see below (8-bit) */
> > +#define EC_MEMMAP_BATT_COUNT       0x4d /* Battery Count (8-bit) */
> > +#define EC_MEMMAP_BATT_INDEX       0x4e /* Current Battery Data Index
> > (8-bit) */
>
> Complains about this malformed line, but even after fix this I got other issues.
>
> Thanks,
>  Enric
