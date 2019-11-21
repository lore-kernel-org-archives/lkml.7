Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA954C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC792206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfKUPE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:04:29 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:51765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUPE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:04:28 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mj831-1htG3T0SLF-00fDgi; Thu, 21 Nov 2019 16:04:26 +0100
Received: by mail-qk1-f172.google.com with SMTP id d13so3315183qko.3;
        Thu, 21 Nov 2019 07:04:25 -0800 (PST)
X-Gm-Message-State: APjAAAUlPN1Lq6sxvsjQfmesJDrJ6lW5aQoDVDHxXM8nXrBwac7SzXeP
        M5F83oBREua77wyFEJHjFV+VKDQ2oCsbexNo6vc=
X-Google-Smtp-Source: APXvYqyKi1bjGD9V5jw0jYZO+PgaEqczJ4t4Xv5pzShABtw676P8Qa8gAvgbUqdcgqKctBUGG1V+UI4RVHvp7MQ7yqo=
X-Received: by 2002:a37:58d:: with SMTP id 135mr8315195qkf.394.1574348664813;
 Thu, 21 Nov 2019 07:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20191120154148.22067-1-orson.zhai@unisoc.com> <20191120154148.22067-3-orson.zhai@unisoc.com>
In-Reply-To: <20191120154148.22067-3-orson.zhai@unisoc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Nov 2019 16:04:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0x83ueAiCjLg30csc9t7VtZLEbvTp1SsbNDnwCXmWRGA@mail.gmail.com>
Message-ID: <CAK8P3a0x83ueAiCjLg30csc9t7VtZLEbvTp1SsbNDnwCXmWRGA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mfd: syscon: Find syscon by names with arguments support
To:     Orson Zhai <orson.zhai@unisoc.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kevin.tang@unisoc.com, baolin.wang@unisoc.com,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:i7Fi3jqb2oWyL7zm58QewHygSnGhbG/TkqObcIm8ys8w/XUj1e6
 k2A89BmcSlkolo+eiTl7TwnyM6wNC6tTul9r2b0pkzI2BoWpq1K5xnYaifcTcg3EpOOSwFg
 UYOgbT0E3uKw4j4AdEJNmM+PJziGmMLe0a8jZZH+qxKyHzkWuuGjZpy7XcqVxr8+LavEdJv
 lJVZ+9GlhvKMmTseAhEYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7r2uaGhLX64=:HiwjsKZV/xP1P/3hzz3JgO
 LHGXHQAj3b0pOn5eJdGIR1gBzFP7iviCRoxLZhnBGhgxxpddRYqd5xuhyreUweRIBvcEiu1zd
 TeaHEQINoAEmBKAGTcFUDbqC+0wzhOR8ICCOgLkUnc4EfkqR2o5dylXoMGQK1WNlzEQI2gy5P
 UQA3WWBNtLkEM7UIzFdaRYlIb/wAcvXyMVCNvKd6gOBd+tnybxT7/B707/unlfffWH+AAoCuD
 zsiZZa1/+E1bhS2DWh+q6MuBKbr6CCabUM7jTIrUqFclgeWZZ4ZrknMyTYDs5Q/fB9YjmV8CF
 OPmgA8TiK6MxVx+86qjUajLGnEX9YIHQHWuFJt5OaMb2/jr+yhyo+q0t0a2LJ87TXgc2gsjf2
 7pyeVd9bhzrTrtPs8TXB8HKnY+QmL30DkG8Xyutwz0hrqMvP33vajZuSNW8PO3pn+gBb8mFlD
 MwpH1VeiKDY8imHYQ0RQNJaH0XOfJcVWW3+J8pfww6gLfgIxPbPCWcF/XmqK10uRnEoy8ajRW
 UhVLZThf5m9lJDEHiY5JGf1EikAT8X/7DLdQZPyT4IssmsS0wUXZI1LnWYt+AGs9Nfz6+653K
 yhLm3UssnK1pEx4z3xxD/wbcOu4+JYtOOR5lvmavSvVLz6Fkco6OPeFoi3FefVUctw+ZBerb8
 bLva1+3TGVhQ7wjC9yxQPcT/Y7KR1YVL2uPYdkbK7iN0s4mgHwkhIcThKEubvxe/E3y2j4AKn
 FBtG2gflWJemHLOz8skEHQVf8QmtIQepMtafHL+uqqhkJ7/6L/cCPSlk+1X+UjJ3oJ17v3KjE
 yI/CUpCQwc0PQK9k6FWmCLQD3IkKZ4tuU7ynZRQm06d8Bx67M3DTJRMeeoEIJXMxhKFcINTDf
 53l2NFCzvL/dZcXJFtMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 4:44 PM Orson Zhai <orson.zhai@unisoc.com> wrote:
>
> There are a lot of global registers used across multiple similar SoCs
> from Unisoc. It is not easy to manage all of them very well by current
> syscon helper functions.
>
> Add helper functions to get regmap and arguments by syscon-names all
> together.
>
> This patch does not affect original syscon code and usage. It may help
> other SoC vendors if they have the same trouble as well.
>
> Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> ---
>  drivers/mfd/syscon.c       | 75 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/syscon.h | 26 +++++++++++++
>  2 files changed, 101 insertions(+)
>
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 660723276481..e818decc7bf2 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -225,6 +225,81 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
>  }
>  EXPORT_SYMBOL_GPL(syscon_regmap_lookup_by_phandle);
>
> +struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,
> +                                       const char *list_name,
> +                                       const char *cell_name)
> +{

According to the binding change I suggested, this would not take a 'cell_name'
argument, but instead a an arg_count.

> +
> +int syscon_get_args_by_name(struct device_node *np,
> +                       const char *list_name,
> +                       const char *cell_name,
> +                       int arg_count,
> +                       unsigned int *out_args)
> +{

and I think this could be combined with it, like

struct regmap *syscon_regmap_lookup_by_name(struct device_node *np,
                                       const char *name, int
arg_count, __u32 *out_args)

    Arnd
