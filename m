Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5954C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F4B2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554220997;
	bh=BKhyBoIvPS223C6Eu4fPg3tzfr3TOHqzvPnj55IMRuA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cP87C4+LWXgriX6aVtHq7/u/bt8bmsNCFmTvt8GxZFjC/JNWMNqxt+nelZfWXKoyr
	 ejq9zWrWopArP8kV/WGqqKojK1HlfgTIn0jKRYkw9zgaa8yMyUXgZIIn8Lgl4QZtaf
	 nOvSqmOO4XkUbklbYaafE+pT3EhkI/JGB86bnRFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfDBQDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:03:16 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42693 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfDBQCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:02:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id 103so12459446otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=no3P8YqZzLuUKlZPKi6dLq1/FJzt18CpSvEgih7BWFs=;
        b=t1zm1lGEZJTr2wnPQcDPg9hynF3krp0q98Q+BL1nCa/+E09lxHcOA/46coIqEdNLAo
         lT+feBktDloK4pAe+2+DFeMKtfjyb2p3bGoYeRxYuGZydG7D0noD38NpGdWH3J5We2Pt
         I6fsww2D0UtUWPsLeR4s/b4InX7ai4huMpIWHvF3ifo2SNdTONr1ZvJ5I1YGCHTF0ahN
         HryqFb28/SmYDNNnpR0WFBe/2aoAw0o8mcl7GaCEnpOqiGBT0We7Wt5fm+CLfDu4uIQj
         qra0DMkJ4uDHG29h5CuIVmp0fDTAcLkwkwawqqcNVHDhbvrdxjRAg7rB/o+TMOhULgTh
         REzg==
X-Gm-Message-State: APjAAAW7Ca8cgpFs+3hQwLXfIKJOD+jcJK5oKMoRZvf40o5WBpNKLV35
        1ulAoIiUgmKqrWjmff7cyvwNjjxMsd2W6ZOOd2w=
X-Google-Smtp-Source: APXvYqxpMliYwGXerPBNAjnVyppVgthRNJTelR1S0hnklIR0pLD0ih9ydruDb/G9sqP7ScKTF/Ky//1eYhdHf84vuJE=
X-Received: by 2002:a05:6830:11d0:: with SMTP id v16mr28828946otq.159.1554220972013;
 Tue, 02 Apr 2019 09:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190402155914.78166-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190402155914.78166-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 2 Apr 2019 18:02:40 +0200
Message-ID: <CAJZ5v0hCrpyxJzMOQXthHkqLBaYBH44f_XsHy-YUfxxUU_o41w@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: platform: Propagate error from insert_resource()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 5:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since insert_resource() might return an error we don't need
> to shadow its error code and would safely propagate to the user.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/platform.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dab0a5abc391..f93f192891d1 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -438,9 +438,8 @@ int platform_device_add(struct platform_device *pdev)
>                                 p = &ioport_resource;
>                 }
>
> -               if (p && insert_resource(p, r)) {
> +               if (p && (ret = insert_resource(p, r))) {

I would put the assignment here.

>                         dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
> -                       ret = -EBUSY;
>                         goto failed;
>                 }
>         }
> --
> 2.20.1
>
