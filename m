Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F3DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7115820857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyMBb/WR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCSQOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:14:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45688 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSQOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:14:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id 5so2861316lft.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDMxXgo0eVAtSrDg7SeO+qv8r/MSb+PeMGzIW9OaYbA=;
        b=fyMBb/WRe1vN63Trs5ZnAJE5pgGjJdY6T6feBivzEyVlf8ieRmD6P72+BmoGZ2pLtL
         tSd/ED+dfYn/qp1+ji7yrDfa7ek7Go3HX55iTKagJCssCDRtGSlx78IXrjoKb/ijRkZL
         kGsX4qHuGEvrHXE4bz7R8enBNqj1s1du5K1heEvBLRCbpAa0Q3lfq3vJgv2LR/CedW01
         s/G+0ZG5ZUpc+mLxKDvSNcigQdHw+42STmdsQTJzP7tcRQoeosRlYyjd0RDN9Gj42D9y
         BtjoAMo3IedI244UKNtoq53u3iek3p+PZzd3n2DL+sSM4uNJ8d+ave/vx7bxZbw7twp8
         Lb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDMxXgo0eVAtSrDg7SeO+qv8r/MSb+PeMGzIW9OaYbA=;
        b=CyVzBzYseb/iNtCLWNSYDSMnlVslX6bK7W5DwRedh/9+H5/HZKYS17OWn8kAwGaW1A
         vihJxsgLMOn+tSa7siZOoBX3Hu05TjZr7jvvXWQ1ZfcKUmUklc7auSH3KfpuDH1YYV7z
         V2DH+K42chUyVj2IR5vgOXuJLx6BR6Rto3cBHdQggQH0JQ0kgwW7od7xffHviGvsnwLI
         6gUHOwmrc50i4pC5E4sFcAWOEPz+gfpJBzkY3UqgRwTR1kt/akZWgmx2K7p2MnMntCxz
         Bc/M3avOclpubDIzEbZ2ozFIdqUwIv2fc4QpThXlKjRxzr28cvIf/Po51qBb7KiKu5fQ
         DuVQ==
X-Gm-Message-State: APjAAAWNa/pEPGm3i5FuDwGfhXfztTx1MWMg0Zzj3qy3yC9AuraJr7Np
        0G88ze82NnGFKGgdi1KTqRAL1sPAvQDSAPDaZvTMUw==
X-Google-Smtp-Source: APXvYqzBXS6UZ0gdyPGcRrJOJJ2OOp/SAAYjxhy5Y7m1hu6S0ckWsuIwTzv+m6RwFfDCbYwmPWweTWuA7CMRLhifODk=
X-Received: by 2002:a19:6a0b:: with SMTP id u11mr14003332lfu.13.1553012084167;
 Tue, 19 Mar 2019 09:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1903191529010.2537@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903191529010.2537@nanos.tec.linutronix.de>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 19 Mar 2019 09:14:32 -0700
Message-ID: <CAOGAQepj=yW4uQSRHpvnQz71+D8a7+H71XtrApp8YGU65XgoqA@mail.gmail.com>
Subject: Re: [PATCH] drivers: power: supply: goldfish_battery: Fix bogus SPDX identifier
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am sorry for this warning. I remember I checked all changes I
sent, maybe missed this one.

At the bottom the file says

MODULE_LICENSE("GPL");

and

// SPDX-License-Identifier: GPL-2.0

makes it inconsistent.

Regards,
Roman.

On Tue, Mar 19, 2019 at 7:51 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> spdxcheck.py complains:
>
>  drivers/power/supply/goldfish_battery.c: 1:28 Invalid License ID: GPL
>
> which is correct because GPL is not a valid identifier. Of course this
> could have been caught by checkpatch.pl _before_ submitting or merging the
> patch.
>
>  WARNING: 'SPDX-License-Identifier: GPL' is not supported in LICENSES/...
>  #19: FILE: drivers/power/supply/goldfish_battery.c:1:
>  +// SPDX-License-Identifier: GPL
>
> Which is absolutely hillarious as the commit introducing this wreckage says
> in the changelog:
>
>   There was a checkpatch complain:
>
>     "Missing or malformed SPDX-License-Identifier tag".
>
> Oh well. Replacing a checkpatch warning by a different checkpatch warning
> is a really useful exercise.
>
> Use the proper GPL-2.0 identifier which is what the boiler plate in the
> file had originally.
>
> Fixes: e75e3a125b40 ("drivers: power: supply: goldfish_battery: Put an SPDX tag")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> diff --git a/drivers/power/supply/goldfish_battery.c b/drivers/power/supply/goldfish_battery.c
> index ad969d9fc981..c2644a9fe80f 100644
> --- a/drivers/power/supply/goldfish_battery.c
> +++ b/drivers/power/supply/goldfish_battery.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Power supply driver for the goldfish emulator
>   *
