Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E341CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FAB218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="0MlTjkkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCUIhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:37:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33711 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUIhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:37:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id z6so1536765wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HLP2LY+cRSTYtwBLnZRt3EFU/q7rs2iKa4IW8BWVVzM=;
        b=0MlTjkkjZ2/vNYeGMH6cSX4kT2g5TrO+Hwx8TCPzmQfIJsLuu7cl1vk3U8YtfQspi2
         UeGGDBb1+0/TLex7In1N3WbP6YRfRRQ5HqrH+YPbq4m/8/vaI26WLWTpNfN0zFtnp8FM
         Gt/lz9vIxfy1vDUlcg2JXlSTUKoRRKzwFRK3coAbh0hPCJqkDtOesHlYKlgCReu1maYb
         lSi14U3XDfdfrVY3/nusjGXvn3SwwJuawalNgzqEfzpe6cixxbhdn0PPZCcoCqF47B+Z
         DrajMnNW2H265/GDzIZdsPSsvKVAdekiggLq4VhlIf0sj94ymITxUqouAzeb2V7/yXcd
         bN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HLP2LY+cRSTYtwBLnZRt3EFU/q7rs2iKa4IW8BWVVzM=;
        b=ndJ1uIWP2jQF15u8maGQYcOcEvVnIj6esa6SId3x8IQqQj8LSbC+Qmi34kMAJkWx7w
         kvS36GEkok9UnHCJtU324NBGLB2DvzFQgaRyjP3uI8JYF5bl7Pn0K5soFkPK+3EHKPQo
         H8WFxWJsYEjsuO45NFXd4X/X/NEHRHCKoGXedeJMYVXb7CiVvaVB/zFq+g/ZEeBm4o2p
         39h5lUejabS+xLW+VjgzJmShg0xaD68AqHm/36gpOmc6vbaG7SVDQZc6W49vyLdt2yGe
         WCpH/+ksbnYZnYhXJ6woKJHsLh7RVJhCq9/YFLmE+cc3tHZ6mX9yI7Ox3EBB+0WTLwfa
         xoFw==
X-Gm-Message-State: APjAAAVvzoetAHo8hYG4bpGiHX1nRfOFberF+wef7VVEwL97F8iiRdfH
        AkIKRlYY+w0/fFkC0M268usBauxDFYvF6zgpyMOGlQ==
X-Google-Smtp-Source: APXvYqxvETEBGJeYVVYAjf5kSLOri3mjJTumt4HyU3RTPbRDj3HleMNx/u2ESzueWd6U3/haTjyx+3BrEReq3byoc+w=
X-Received: by 2002:a1c:f906:: with SMTP id x6mr1644078wmh.126.1553157451999;
 Thu, 21 Mar 2019 01:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190224012654.17217-1-axel.lin@ingics.com>
In-Reply-To: <20190224012654.17217-1-axel.lin@ingics.com>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Thu, 21 Mar 2019 16:37:20 +0800
Message-ID: <CAFRkauBdWeR8epskSrVNXG242LUu3PhHkidky61u31sPte-iMg@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77620: Fix regulator info setting for max20024
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Zhang <markz@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Lin <axel.lin@ingics.com> =E6=96=BC 2019=E5=B9=B42=E6=9C=8824=E6=97=A5=
 =E9=80=B1=E6=97=A5 =E4=B8=8A=E5=8D=889:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Current code always set pmic->rinfo[id] =3D &max77620_regs_info[id];
> It should set to either max77620_regs_info or max20024_regs_info
> depends on the chip_id.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/max77620-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/m=
ax77620-regulator.c
> index 1607ac673e44..0ad91a7f9cb9 100644
> --- a/drivers/regulator/max77620-regulator.c
> +++ b/drivers/regulator/max77620-regulator.c
> @@ -803,7 +803,7 @@ static int max77620_regulator_probe(struct platform_d=
evice *pdev)
>                         continue;
>
>                 rdesc =3D &rinfo[id].desc;
> -               pmic->rinfo[id] =3D &max77620_regs_info[id];
> +               pmic->rinfo[id] =3D &rinfo[id];

I'm wondering if anyone can help review this patch.
This looks like a bug fix to me because for max20024 MAX77620_REGULATOR_ID_=
SD4,
the pmic->rinfo[id] =3D &max77620_regs_info[id]; set pmic->rinfo[id] to
a zero-filled entry.
e.g. In max77620_regulator_set_power_mode, rinfo->cfg_addr is wrong
for MAX77620_REGULATOR_ID_SD4.

Thanks,
Axel
