Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA58CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6C520640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391230AbfJWMON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:14:13 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42259 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfJWMOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:14:12 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MowOm-1hetlU2NIM-00qOq5; Wed, 23 Oct 2019 14:14:10 +0200
Received: by mail-qk1-f177.google.com with SMTP id p4so19503992qkf.5;
        Wed, 23 Oct 2019 05:14:10 -0700 (PDT)
X-Gm-Message-State: APjAAAVgFidVU8O7xHC8sllB8qi9XpNBjes+CBPHMJHN17BYr1N/UyRL
        IHSkK1l97zOafM5EnkQF68qbgseU5D6NyAHqKo0=
X-Google-Smtp-Source: APXvYqx9FmGVkwD8EbgMmlWydk5PgzJ33OYlaEnM7tpXys5e+jS3v3e/vy3XLGsCvMOw7vkw88sF/Z9WI6L06moKLMI=
X-Received: by 2002:a37:9442:: with SMTP id w63mr7673807qkd.138.1571832849353;
 Wed, 23 Oct 2019 05:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-5-arnd@arndb.de> <20191023102750.GD10630@pi3>
In-Reply-To: <20191023102750.GD10630@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 14:13:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0SwvSHRddMZEiRy3hHQB5OpyP1H05c0oZt3JUeKOf+=g@mail.gmail.com>
Message-ID: <CAK8P3a0SwvSHRddMZEiRy3hHQB5OpyP1H05c0oZt3JUeKOf+=g@mail.gmail.com>
Subject: Re: [PATCH 05/36] ARM: samsung: make pm-debug platform independent
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:a43ik33BKP22rbmRQGbj9BzOnOijdOzJH6/EMxbiAQS0BlFPVUi
 sv5fjSrhrftA5lEhZ2zRyCAz4ReA0rUbaBpnR1vZF7ASNqCfdnA88xcLrPX7kG/dpUhwK19
 arl6t0NVDw+MGcuyZX+9xavpDdG2hq1tS3Sgpnlfm2cjbPuMMsbqqKVEkMqoIuCBVxwLRT/
 m3qjEXTctE+hAMRVwGF/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IFNGo97kzRE=:vHjLrX1J+UWjDoRAJ2NxxE
 A1ONjWNttP62cWJX18DBkYCPK2HNTebke7HEno7klZENLGXOdy0gbF8CTVG07CoUJ9qB3VVDL
 T15BpDYxE1qzWPvGVwEdK6uWSybEIup+PDg6W3nRanLJG+tQY67q0LDkbebKmE5htfJMk/DZ3
 P1RDdxkdaHj1k0O3F/HVxClk8VrlDRSPU/7ZQLqNa6ob54Mb2oCYl5mM6Cd3sshKKZ11cwvBl
 3zC74MPED8P5VNqMiYuyGJsplgmN0rU5E+GltWsSNtmdOpGC/02jsxUdjGopAfJ7A29Wg3Ae3
 Q6WUPaRcqPGzNF3oNXCc+1+Cep9Cv5exMezLjmpgz700N5daVlLEey6t37WJfaMJZ6tkjNpIz
 J5P52xD81KKRE0uq6zO2NyWZ2HqId5JI1Wg/ChS4U/QRR6RaogjRq/G9+AYLbKtFuncQl/spg
 3X7G48/oVPn6QNeeRbJTTbk4gEW8jCnpVIIDjuS0jkfr531CqfNVQLbMPVU4KTaEeafruJHOs
 PxE1S+LPoQs7Af39qvNT6RI7K5PB6YJyWjfcJPVXgocUsrfbK7dFi5aOMDb8wkPkCghgEJkZy
 DqhS7aTx5BVUaCuK0SH+rUplHYp9QBsFWc+DYWYy46Pbo9y1wDwimwiCspqiP55ZiRGd7gIza
 Cur+KSjCSbvlnvRr3oyyh/u0b2NHoPY+7vWZ1u6ujgL+jTJTPaVuRubXbiNOMBS9K5v5tM1rA
 mRakYKF0wdP014emxSTzY+J5Vq8edyCxFGklQg15lJ/aS1TX4t2Na33SLpfRo4ikAJggOLWI6
 iqElYZljLSfscFtw6NTqHT4M1XzMG1X9gg/s6mTQjvuhDzyOdqg1xPJatGjKp7aFdhgn6kZcT
 sg23VWvUxaE5IOBjnN6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:29:49PM +0200, Arnd Bergmann wrote:
> > diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
> > index b336df0c57f3..efdb5a27c060 100644
> > --- a/arch/arm/mach-s5pv210/pm.c
> > +++ b/arch/arm/mach-s5pv210/pm.c
> > @@ -99,8 +99,6 @@ static int s5pv210_suspend_enter(suspend_state_t state)
> >       u32 eint_wakeup_mask = s5pv210_read_eint_wakeup_mask();
> >       int ret;
> >
> > -     s3c_pm_debug_init();
>
> Your patch is not equivalent here. If there is a reason behind removal
> of UART init (e.g. not needed), I prefer to make it in separate patch.

It is equivalent, but the reason is a bit subtle:

The definition looks like

#ifdef CONFIG_SAMSUNG_ATAGS
#include <plat/pm.h>
#include <mach/pm-core.h>
#else
static inline void s3c_pm_debug_init_uart(void) {}
#endif
void s3c_pm_debug_init(void)
{
        /* restart uart clocks so we can use them to output */
        s3c_pm_debug_init_uart();
}

On s5pv210, CONFIG_SAMSUNG_ATAGS is never set, so this
function does not do anything. Splitting the change out into a
separate patch to explain that is a good idea, I'll do this.

        Arnd
