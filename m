Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5A3C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB9120721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxUvCC+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgAIPO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:14:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40019 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbgAIPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:14:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id s21so2681134plr.7;
        Thu, 09 Jan 2020 07:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9xo3Z+N4tPUCqhrAfSBGF7r5Z2K9ZGhUqfbuVV8hoM=;
        b=lxUvCC+0RKw0b94T4bdUZl2bCXjAbELX4jtycsNEKXKXe39s+s8Gn0W8hHuXNDIbh+
         6Oe8+l47CS+TtdK89ej4lAOrxSyiOmLgu0aG1uUl8564KXhuEOT3wGvHSau5cMpDtytA
         sKkMSoSPUJ5+x4JS4M2o0OCJ0Z7Ob14Xt/z5tdB/Ej9RF5cEw6PP+EWg8bE9v5vpPgNd
         ZqAYXcT45N1lSuwoR9NZ43+tX2KS33TDcwy3ZJ0ozSzJNTBOznmzww8ybKc0evHtQ8fy
         Z8i2Z07MIooxsDv8jaAwjclqmTyV3rMO7UcwzdP4E/71M4U+kJiSaLnxkxgVC098wj7F
         LMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9xo3Z+N4tPUCqhrAfSBGF7r5Z2K9ZGhUqfbuVV8hoM=;
        b=uQjSaKwIHWg/vodCJJREvxaAwu28iTFvYhga8vJ5abi2C+djrjAdibbwU7yn8BzyjX
         k1wlOzASC17ix1VgJeRohYWxa20IILOOtYrvt0L4mHKM1AC9oQbzgvKs0sHaSnjO+KL2
         j089MnEqw8IuQZlopdPfp6bWOwpM9JvMjuKSg7xIMXdOcUtK58ARSWvaABFxlFadDhRb
         rKSWd5dvuNMeAD+IrudouE746zxbz/T4kRbBMTL2GKSeMWwnoJP0WyPszb98uWl4ep8z
         A6wA2IIsdiEMNyuJcZ6DGu3mojDL/Ou0UBT4Mxu8mxnlrVw2tVq6b8FTT3Dh2RSdx0QB
         20Nw==
X-Gm-Message-State: APjAAAVb0B4RBqotIWkCiK6LYrclgW6Eft/p4gPkadHLPpouYlyHRs43
        mNJ5uzRYX/oKWsCn156pkiMvgWtPBhnnnrwEjVQ=
X-Google-Smtp-Source: APXvYqykijgPqZap77w/ss1b1SSCYYIK5P/tUErVqhYhvsUty2ugVwFAiZtifCQmVXeKw/CLfz65q2TF0/9P8NLU6KA=
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr5972285pjq.132.1578582867271;
 Thu, 09 Jan 2020 07:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20191231102917.24181-1-vadimp@mellanox.com> <20191231102917.24181-3-vadimp@mellanox.com>
In-Reply-To: <20191231102917.24181-3-vadimp@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jan 2020 17:14:18 +0200
Message-ID: <CAHp75Veu7PhR0FiufXM2R=dU4vLmeL5sf3kuVi2g=NZSw3L6OA@mail.gmail.com>
Subject: Re: [PATCH platform-next v1 2/9] Documentation/ABI: Fix attributes
 for mlxreg-io sysfs interfaces
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 12:29 PM Vadim Pasternak <vadimp@mellanox.com> wrote:
>
> Fix attribute name from "jtag_enable" to "cpld3_version" and
> extend description for "cpld3_version" attribute.
>
> Add missed "cpld4_version" attribute.
>

From this commit message it's still unclear if we have had the ABI
change or Documentation inconsistency.

> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> ---
>  Documentation/ABI/stable/sysfs-driver-mlxreg-io | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> index 8ca498447aeb..fe30fe505c9b 100644
> --- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> +++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> @@ -29,13 +29,13 @@ Description:        This file shows the system fans direction:
>
>                 The files are read only.
>
> -What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/jtag_enable
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld3_version
>
>  Date:          November 2018
>  KernelVersion: 5.0
>  Contact:       Vadim Pasternak <vadimpmellanox.com>
>  Description:   These files show with which CPLD versions have been burned
> -               on LED board.
> +               on LED or Gearbox board.
>
>                 The files are read only.
>
> @@ -121,6 +121,16 @@ Description:       These files show the system reset cause, as following: ComEx
>
>                 The files are read only.
>
> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld4_version
> +
> +Date:          November 2018
> +KernelVersion: 5.0
> +Contact:       Vadim Pasternak <vadimpmellanox.com>
> +Description:   These files show with which CPLD versions have been burned
> +               on LED board.
> +
> +               The files are read only.
> +
>  Date:          June 2019
>  KernelVersion: 5.3
>  Contact:       Vadim Pasternak <vadimpmellanox.com>
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
