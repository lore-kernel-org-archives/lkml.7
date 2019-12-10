Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E7DC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BD22077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMUGE9oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfLJMTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:19:32 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:36782 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfLJMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:19:31 -0500
Received: by mail-lj1-f180.google.com with SMTP id r19so19657085ljg.3;
        Tue, 10 Dec 2019 04:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZr/+6HpSIONAz05WKaRqDWYK5bxI03ma7Dp4hXBj4Y=;
        b=nMUGE9ojdwfx0CYOyowero9vGQjdbfF89mEUclB2RMCR99DXXtRTKdjAe9UYrHCXl+
         yMd9U8yaKIpJHa/pzllZRZm3WZvZeiI/65EemTHFHEqwtx/7QGrssXMNS8tCkhb0qJyy
         SOo72CzR9bc5QntEM6TCY5c84vgzQ2/+JwHwCvlr6Ez8e7P7pfQiNmK/gNeJFso3heF6
         UF3H7O83XG6Yx5JR+uWjto0uCIURwxn4ndrt+ajjQwiy5mifPQ8hhTMCXdBIZatE4sCJ
         H1nANPPM5+5XL0zZi+MTgE28Zkep3Y4GSdRMsEET/FY6wWlfBto/AArG3dJHlBJSr8xY
         gzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZr/+6HpSIONAz05WKaRqDWYK5bxI03ma7Dp4hXBj4Y=;
        b=pIIp0Npgb8BPSpixTNf71S1EopRWbMhpsVcX/T62Lnm8G14RR8u1G3aTaIjG/ONwar
         BEC8llJKKguPfwMStks2rw/vGeA7t6z5ZMl/S2xjNaPUcWyd1L8ZouAh4zTrK9cChg7G
         HjZ+Fbmh7Lpo+UbopUlL8bQqwuhiMwARahQQGZr81yujomesrS5OilRrNm15dSkTWOuS
         GA7xbwU37HYOzhOq4unRKzQiFM+9iiEt0Ds4crbpoUUhZ+5MR7Q/DBw7JrPKrVSF8ywi
         ORe6YcvTyrDKi/u+NdcJLNLbr6LiMzRhW+BEzbuzJInjuumxVpzJsOgl4JDmpunERYWl
         jyhA==
X-Gm-Message-State: APjAAAXrNV+6YSVkMWoqcwltJuoQR3pbHvWHEoXh7DGoZA/g1alJJ5G+
        3901KHgGhyyFUQ62L9Z0piAYcWE4ChJPrdsVfOc=
X-Google-Smtp-Source: APXvYqww+mmoqgVXNIbfcua+rHzXuSgDDkoZs8OWbxCzt9D+f/gPdFAfoXdomnkfJO5QwjZfHhzqKWF9QGxZRgLWfY0=
X-Received: by 2002:a2e:6e10:: with SMTP id j16mr20421893ljc.202.1575980369201;
 Tue, 10 Dec 2019 04:19:29 -0800 (PST)
MIME-Version: 1.0
References: <08794fde-cdd0-287c-62bf-e2e3b8c80686@gmail.com>
 <20191203101509.wte47aad5k4mqu2y@pengutronix.de> <CAOMZO5Cn993y9VeFN6hPO3-cfNnUKiuFd_rqAZ8htz=dO6t6ig@mail.gmail.com>
 <CAOMZO5BniszDhWKkoWY=P62kv9cY160r9P=pjpbSOZasxJvdBA@mail.gmail.com> <77fff313-3f40-6b5e-fe30-5a65a189bdff@gmail.com>
In-Reply-To: <77fff313-3f40-6b5e-fe30-5a65a189bdff@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 10 Dec 2019 09:19:18 -0300
Message-ID: <CAOMZO5Ay6opfhb2cOOFHsbC_kgwreG=0TBAwtwwxM6PVE6tK6w@mail.gmail.com>
Subject: Re: Issue with imx_get_temp()
To:     Igor Plyatov <plyatov@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Tue, Dec 3, 2019 at 11:36 AM Igor Plyatov <plyatov@gmail.com> wrote:
>
> Dear Fabio,
>
> > Does the following patch help?
> > http://code.bulix.org/l3rz2e-982595
>
> Thank you!
>
> Patch applied and will be tested.
>
> I will inform you about results.

How did your tests go?
