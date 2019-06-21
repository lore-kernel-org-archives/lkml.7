Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DADC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928E321655
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujArdU0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFUKdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:33:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37985 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfFUKda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:33:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id g4so2790721plb.5;
        Fri, 21 Jun 2019 03:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpskMPE9OKTdD4zPuyxeU/1TLb1myVFguUVGtb+4nAs=;
        b=ujArdU0ao9KvztpXXnIF0b/LNyDio8E3uB+CEa6q3s6SF2q7uWFkyxZY6K0BXkYkaT
         gQuZ9M1xYi+7pvPv4JV9S2nhknsMNsPkAZodbNReTUOeyXwkW0lC40jbjeKJq0wOJINA
         F0aJl7OpQvlaL9qlVodOPkymvBUwtWP9uWxQv9Qr6JFcfL5DA4XAkH3AzK7GSvML1JlM
         GlkVBpYFyFdR892j3FBITgAEDKil0/4jyy7lTJipYEwOrUH64iKgYCK9//ocU0fmf2Xq
         Mm5nySCfdafySz/P8ePI1hzYDozeoW6xqmwpCZgeJlWXoROtDiqQnILkpP7pMOvcV2PI
         jaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpskMPE9OKTdD4zPuyxeU/1TLb1myVFguUVGtb+4nAs=;
        b=uf54tpppuHkwdL/mKRYonQITYKfyWmjEUrTla8KW5JTWetZByOkRPNC6zUlaXxgWrw
         nJCHLV0pU1AkaKeDtFWOSGIky6zOuAox91iiORlxYHJIgQKCvC7LiKoqs4F5MkPjf0sY
         nVUNqrwsAfaEL72yvXByn2hL39qOlEnoW/sFe0aJRF2NuYcfxfCCFYYPEnLSXX0QPhzz
         pQYrD+ad9ltWM/ynqQQ1J8kjJFZxjWvPrtZ8d0HFsJVrixGTL5atvxflXlIGSACpsQBa
         9Wr2RVeNg5Y6vzds0W920LJuq7MjfEcPJOndJLUsw9Y3QxKXbyJBfUXLSnlB48PFNqXd
         41lA==
X-Gm-Message-State: APjAAAXMSl4xJ63wAxx6ehsIwGwRmppoLiL1Fc3jORQCn4UKVJs3oxi4
        GECBSQ8nYXpx0f5hU8PJDY3ZuGzPHv+/Mr8k9khtAQVi
X-Google-Smtp-Source: APXvYqzb+KJiyIP1rR7QPFyAhavPjo+cePP7gRZEkDElAYTtlI9UER2Pl2DUjFOEtLobLb9SP7kV+lUXmfBBLlZLhvM=
X-Received: by 2002:a17:902:ab90:: with SMTP id f16mr127848301plr.262.1561113209896;
 Fri, 21 Jun 2019 03:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <4cd2ece080041d8545cc2f3e86cb1ff7c8a91f5b.1561110859.git.mchehab+samsung@kernel.org>
In-Reply-To: <4cd2ece080041d8545cc2f3e86cb1ff7c8a91f5b.1561110859.git.mchehab+samsung@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Jun 2019 13:33:18 +0300
Message-ID: <CAHp75VdSWMzPCEogUMwkjwSx4e=fhd2a6Mu8RkczEaFhwO=rRw@mail.gmail.com>
Subject: Re: [PATCH] ABI: sysfs-driver-mlxreg-io: fix the what fields
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 12:54 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> The author of this file should be given an award for creativity:
> the What: fields on this file technically fulfills the description
> at README. Yet, the way it is, it can't be parsed on a script,
> and if someone would try to do something like:
>
>         grep hwmon*/jtag_enable
>
> It wouldn't find anything.
>
> Fix the What fields in a way that it can be parseable by a
> script and other search tools.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks, Mauro, for fixing this.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../ABI/stable/sysfs-driver-mlxreg-io         | 45 ++++++++-----------
>  1 file changed, 19 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> index 156319fc5b80..3544968f43cc 100644
> --- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> +++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> @@ -1,5 +1,4 @@
> -What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
> -                                                       asic_health
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/asic_health
>
>  Date:          June 2018
>  KernelVersion: 4.19
> @@ -9,9 +8,8 @@ Description:    This file shows ASIC health status. The possible values are:
>
>                 The files are read only.
>
> -What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
> -                                                       cpld1_version
> -                                                       cpld2_version
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld1_version
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld2_version
>  Date:          June 2018
>  KernelVersion: 4.19
>  Contact:       Vadim Pasternak <vadimpmellanox.com>
> @@ -20,8 +18,7 @@ Description:  These files show with which CPLD versions have been burned
>
>                 The files are read only.
>
> -What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
> -                                                       fan_dir
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/fan_dir
>
>  Date:          December 2018
>  KernelVersion: 5.0
> @@ -32,8 +29,7 @@ Description:  This file shows the system fans direction:
>
>                 The files are read only.
>
> -What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
> -                                                       jtag_enable
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
>
>  Date:          November 2018
>  KernelVersion: 5.0
> @@ -43,8 +39,7 @@ Description:  These files show with which CPLD versions have been burned
>
>                 The files are read only.
>
> -What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
> -                                                       jtag_enable
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
>
>  Date:          November 2018
>  KernelVersion: 5.0
> @@ -87,16 +82,15 @@ Description:        These files allow asserting system power cycling, switching
>
>                 The files are write only.
>
> -What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
> -                                                       reset_aux_pwr_or_ref
> -                                                       reset_asic_thermal
> -                                                       reset_hotswap_or_halt
> -                                                       reset_hotswap_or_wd
> -                                                       reset_fw_reset
> -                                                       reset_long_pb
> -                                                       reset_main_pwr_fail
> -                                                       reset_short_pb
> -                                                       reset_sw_reset
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_aux_pwr_or_ref
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_asic_thermal
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_hotswap_or_halt
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_hotswap_or_wd
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_fw_reset
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_long_pb
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_main_pwr_fail
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_short_pb
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_sw_reset
>  Date:          June 2018
>  KernelVersion: 4.19
>  Contact:       Vadim Pasternak <vadimpmellanox.com>
> @@ -110,11 +104,10 @@ Description:      These files show the system reset cause, as following: power
>
>                 The files are read only.
>
> -What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
> -                                               reset_comex_pwr_fail
> -                                               reset_from_comex
> -                                               reset_system
> -                                               reset_voltmon_upgrade_fail
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_comex_pwr_fail
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_from_comex
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_system
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_voltmon_upgrade_fail
>
>  Date:          November 2018
>  KernelVersion: 5.0
> --
> 2.21.0
>


-- 
With Best Regards,
Andy Shevchenko
