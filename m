Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B757C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B64206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfZyrUjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfGBJvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:51:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44350 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfGBJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:51:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so90293plr.11;
        Tue, 02 Jul 2019 02:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96/3jtqs845f5zIFwO5nxuuVCQy9SyepnoAKFsIrIMw=;
        b=JfZyrUjlJL43ILmmdwAy6F7txZsfdzO4AQzkvU7IZPP/iF9/X6mtv5kQO6hMGe4MJV
         2l0FeeMmm6hwQNIyj1F/HRmwbXPZJxWLb+aw+9WQ+CbJpEYfWp2N7nLI+xWWUA0TJddq
         J1SrIjHpPakOu+/2qOzUTtgqt0GDGhKM+5lqGldG1FvUP7qTXUHsZLLs3KmEJ2mmKzc6
         C0hgtVgTsJFWst0ts15bRtKuNlwucq4HLOHhSZuiWhCIsNxLQzP8oppYwIx6iYl5TZEl
         3kcJwVcth2oV3/nxOU2RR9CqWxMtosf0r3x2Ok+Rq1pTgO/MbphyI9wQ0PhKI1a//55F
         yo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96/3jtqs845f5zIFwO5nxuuVCQy9SyepnoAKFsIrIMw=;
        b=HvrIYKAxGpf0qO821BMs53SIpW4laZ0gsOH++pVqhHL+9Ot6X2/oN+ebOR7AVsA2mN
         astrVA17BR3yuDdEHUcxW/y40jB/S1Sdsc4paMeJdxK8+MZVYHbyzrPf9CP15HZK4kOi
         IIZ7MIslvhSnVGsQkhHBeDcxndICidZuJ3BUg7CBx82i5GIFK4xuVkNj8Ban4lamoexU
         0QFFOrk3tcCVnWjrGACEWosuX+99XQng+THNEZo3XK2rBbSGaE718RCjl5MMSQ9J8Q64
         nN+6iLnaBOLzGetAKcKrlH8te/+fL4uBmJFLPSCy1wquJQcIbLlzCmwos6H7w+QKrjMF
         hWgQ==
X-Gm-Message-State: APjAAAXCIyNd+1Gx5T7jtwfIndv821+fgC2Jbw/NveLF5qZX1jcFif8w
        hxT9XADAASJ4EVC3JTw2oAOqVsdusMDr/XKo3zs=
X-Google-Smtp-Source: APXvYqxhyUjR0CrI9KX1v9haSzz6fkp5zqzu2IxjxZvlFO45fy5nIdN3K4RDU2J0uhXSTOlvwyIMohZj8GfA+WQFMqk=
X-Received: by 2002:a17:902:934a:: with SMTP id g10mr34957358plp.18.1562061097869;
 Tue, 02 Jul 2019 02:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190701032342.25971-1-huangfq.daxian@gmail.com>
 <20190701075255.GD172968@dtor-ws> <CABXRUiSO2Fos1V3hR5t3AviZ9Hit_y+E-Tp3PNOQj6-FKUBJBw@mail.gmail.com>
In-Reply-To: <CABXRUiSO2Fos1V3hR5t3AviZ9Hit_y+E-Tp3PNOQj6-FKUBJBw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jul 2019 12:51:25 +0300
Message-ID: <CAHp75VeUo2Au66tETo3zneBpeaVU+Y+-h5zghpo+hPuB=a6-eA@mail.gmail.com>
Subject: Re: [PATCH 2/4] input: keyboard/mouse/touchscreen/misc: Use dev_get_drvdata()
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Olof Johansson <olof@lixom.net>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>, Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Christian Hoff <christian_hoff@gmx.net>,
        Tony Lindgren <tony@atomide.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Brian Masney <masneyb@onstation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 11:20 AM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> I am not an expert on this. I just write a coccinelle script to search
> this kind of misuse and fix it in a naive way.
> Could you tell me about how to use the proper bus accessors? Then I
> will fix it up and resend a v2 patch set.

First, don't top post.
And answering to this, simple drop the patch.
Proper bus accessors is exactly what it's used in the current code.


-- 
With Best Regards,
Andy Shevchenko
