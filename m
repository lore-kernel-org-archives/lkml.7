Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1158CC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D200D20679
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctY1dTvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfJLTWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:22:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41217 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfJLTWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:22:30 -0400
Received: by mail-io1-f65.google.com with SMTP id n26so28477051ioj.8;
        Sat, 12 Oct 2019 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HQJU3/LoSPot9T+dJMRPqRv4aXw0MOIpjtfyaywm/aQ=;
        b=ctY1dTvKbUjja1n+HmJ/0QdJo4l9dAMkFi10eQfrFjsqgOWit80kgCnq30q0OeiWfa
         /aUwSbUbZJTKgMLaQRHrc735ma+8k8xg3+RuKcs08/Y27Bvp2HmB3VCXVh53JIpeepH1
         Ex6BkyIFuWyhgQ4hj3IvriacAVaZFw7DIOvS0t56h7sEO7TnQ2FbSzJDxvuUFfVYZfpm
         8i8ceDDgjqJO4QPLbUuA7rjn5ssg3y1AC1+0v+G8txow0cuyM+hhZA63VbZBlCaXGXA2
         Cp4ZiJNXwdEapBQhk8X9d8hv+/l895BVSFvmchGs1gyzKBV8A4NRrRo6EFq1qAYA7zW9
         Z1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HQJU3/LoSPot9T+dJMRPqRv4aXw0MOIpjtfyaywm/aQ=;
        b=R01HaeOXcg3Pxc2lmR/f+oHrAkffh7C4DJn1wqzNGbyF+NtjbRLhDXeD7X2k/Dq+W7
         K9nq0twVv7Kcb6Jts+XEk1UiSZIj3yEZHc1F6ral/BNkhUcS8AZ8OX4UliOjV67XyDx0
         HRGZ1qTr+F98Z5L9vK+TBrmlEai2Vyp87lDRr/G0rRUF4K9+F0B47CXF2UDcI72juOJg
         rL+aKi6hPPH7HY9KsvnTBPAOQOSMKmtcGeuyxnOKz1FQynvFagB8eRZkJYT9V7AUNYAt
         KnWLoGi07vbJxSLMFmtaQcG6AT2EBmga9xb3McStmMSZzUySvl1dgdiJsHRjTu9/4eXH
         9CCA==
X-Gm-Message-State: APjAAAXzLvV8R6psk3vmBdGN6X+iM/lzEce0KGGAYkgqJC2Le7Ybwj84
        vqd8wqJDhmvcfUjtBItoajKKxhN7u70Y9mtEAkc=
X-Google-Smtp-Source: APXvYqyJteMzDjNIWw8MOM6EkZMsiXv/drPcqPJn3dGo9FtbSnM6zKB7jm0eZ0l/nvmkFQFosHWse+jWfLyMEYAymH0=
X-Received: by 2002:a02:7b0d:: with SMTP id q13mr25703029jac.114.1570908149253;
 Sat, 12 Oct 2019 12:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191004190938.15353-1-navid.emamdoost@gmail.com>
 <027fde47-86b3-35c8-85e6-ea7c191e772c@web.de> <f90d7b4a-c4af-eac1-f326-211e932dbd22@web.de>
In-Reply-To: <f90d7b4a-c4af-eac1-f326-211e932dbd22@web.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Sat, 12 Oct 2019 14:22:18 -0500
Message-ID: <CAEkB2EQUrHpfCXDQ9HV9_hw7Ke5DmX3SvKWJd+wSwXB1Uqaf5g@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: fix memory leak in imx_pd_bind
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No, that is not correct! You should not try to free imxpd here as it
is a resource-managed allocation via devm_kzalloc(). It means memory
allocated with this function is automatically freed on driver detach.
So, this patch introduces a double-free.

On Sat, Oct 12, 2019 at 6:54 AM Markus Elfring <Markus.Elfring@web.de> wrot=
e:
>
> > +free_edid:
> > +     kfree(imxpd->edid);
> > +     return ret;
>
> I have taken another look at this change idea.
> Can the function call =E2=80=9Cdevm_kfree(dev, imxpd)=E2=80=9D become rel=
evant
> also at this place?
>
> Would you like to combine it with the update suggestion
> =E2=80=9CFix error handling for a kmemdup() call in imx_pd_bind()=E2=80=
=9D?
> https://lore.kernel.org/r/3fd6aa8b-2529-7ff5-3e19-05267101b2a4@web.de/
> https://lore.kernel.org/patchwork/patch/1138912/
> https://lkml.org/lkml/2019/10/12/87
>
> Regards,
> Markus



--=20
Navid.
