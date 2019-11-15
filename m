Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D13C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EA120723
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfKOJNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:13:16 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:38583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfKOJNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:13:15 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M2gt5-1iRxQb0tsV-004DzZ for <linux-kernel@vger.kernel.org>; Fri, 15 Nov
 2019 10:13:14 +0100
Received: by mail-qk1-f174.google.com with SMTP id 205so7562981qkk.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 01:13:14 -0800 (PST)
X-Gm-Message-State: APjAAAUWRlajfIXjUroZZXQ9DT+cKsWCYGVGnXXAK3r+qd96B2bvoKFh
        NbmhZOUNeai3CXkmshs4b0J7CtHabeOjhy01Ono=
X-Google-Smtp-Source: APXvYqzK+NKPtBnVDtMTSq9zbDtIp+PZVJO4gYi0S3FpsNJw5m1Rcv8OlP3fb54XVLc70eCZF0Y/3pqQhF8s4wE4tr8=
X-Received: by 2002:a37:58d:: with SMTP id 135mr11602050qkf.394.1573809193077;
 Fri, 15 Nov 2019 01:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20191115084931.77161-1-andriy.shevchenko@linux.intel.com> <20191115084931.77161-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191115084931.77161-2-andriy.shevchenko@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Nov 2019 10:12:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2D1eks7dirbX=LrdQy6w0HeA7-x8jb1=qkxfatPuc51w@mail.gmail.com>
Message-ID: <CAK8P3a2D1eks7dirbX=LrdQy6w0HeA7-x8jb1=qkxfatPuc51w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: syscon: Switch to use devm_ioremap_resource()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nnxmebc/kXufC0ty12KF24qspF0zJpIqxv+SECWV65tXJ97sUSx
 cqRCyC0zPrPnGoWS0x/aQ9LHfKK7X918Q7WJcFsNKuakF9oYA6cDLxNGslWNsjlPer29H+4
 yFPeNEWvWvI6q6AZLAfk1MEJtudQvfTzgcc6ZU+JpRTT4MhrQ5iX8fes91VZ8v8kBgVBqUF
 6EBTji5uLgoedgp7wKEig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cTtqdKeQ+Zo=:cFBn8/MVmuV+ki0GZdCuv+
 WplatiUbK3PtGuYi01UiLkfVmz5s5Vt7zE2ejxc+ZelQo94Q7nPg5elNuyIxPO5iK76qlpBsj
 I8UIca7vztGPTuRgOE68AVeCbPvjR0/QqPcofolhQi15Auw/voLMNY+dxuQWzjXq4YydGxp+v
 VWmn42h5mnoZHlKzVGBRV/qBpFiM0bvRqYd0EMuZkWXsVqwtxZWq8F/p09hTvh8YVQCxN4DFP
 SGCzTwkEz2GTp/zyQBHvHnjXnLUIY93ZCNB507DwrstBz9CFsIYAbLlPbrcgyZs6MUmBmrOkR
 R6OIZkVx3R6Dr+qKnUwxeHbGFJqKrjQ4l8ScWCmobp1etXjarItpw5rB6teler1qe0Yviddw/
 3S6HHvhTsrvOTIbE4xjDUPbsXESzq3pXHLeeFaCCcD5pNwe0g5eMnQ0RC+x9fqoHnHd8IzGHQ
 BDEBB77i2Jql+BseO9CXsrXKGsmI6t9InCK8GRb7lCRjpWxIDR558/d1HEHtFTIrBkTM7lvFA
 v++2jZLxYaxWBijkTMwJe45gYpBj1H+w+OmfojoTQ+HBXbo3AJsZlVHEteJZdjJSUAHKs6lLo
 blHRVoG1Br/WNdAhU8S+B4C0rUj2fTmhabLcMWLpOJn58LEySb/Gba3unO813tBOKkajzn/Qy
 riUJZAbXQQ/E/zNUPF/KcoEaE7XXEMgUZo/5vcSoLuMtsThkDDRaxkiaRFeGk2B9o+OMyUUQK
 xUOhL5kpA+Qc320rxZ7bXteFDR+p7PuipG3Awu/ILfw5bYOfAg0Rio9T5u+w8PAjpUKWqIRjf
 76158AUU5QX12zMNHyehEop5Lk+k5Pjg4LDskrHbUcgXXUknNNLsAm6AZ6a/Ayey4v8Y/xVgT
 vtxQ7OU2FzP2jsfPxu+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 9:49 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Instead of checking resource pointer for being NULL and
> report some not very standard error codes in this case,
> switch to devm_ioremap_resource() API.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

IIRC there are some slightly odd uses of syscon that rely on on us not calling
devm_request_mem_region here, which is implied by devm_ioremap_resource()
but not devm_ioremap().

A patch to add a comment about this might be helpful though.

    Arnd

> ---
>  drivers/mfd/syscon.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 13626bb2d432..fad961b2e4a5 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -238,12 +238,9 @@ static int syscon_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res)
> -               return -ENOENT;
> -
> -       base = devm_ioremap(dev, res->start, resource_size(res));
> -       if (!base)
> -               return -ENOMEM;
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
>
>         syscon_config.max_register = resource_size(res) - 4;
>         if (pdata)
> --
> 2.24.0
>
