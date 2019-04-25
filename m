Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAEFC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B1C217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uN7kEvu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbfDYHI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:08:58 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38108 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388042AbfDYHI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:08:57 -0400
Received: by mail-yb1-f196.google.com with SMTP id a13so1894272ybm.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tiwQQD0bmTZ/iR7pMI5uZ9dZcUGO6BCQnQb0GwZQxYA=;
        b=uN7kEvu75syS2tsfrGmrZIV3MxBGydxBZvo/9oWEWhq/SXvVNdM2dwTH+nrTeyu3Kx
         DpbBRw+7YVlWsbiFvlkHqFHn+W9AjaZf/yRyACjZsWvsPcRRRpT/kiaoOnPmxPD0AMj1
         AeI/NduTJTnpP5njJ3+t9kEhchmcvcldDYyvqj2VP+r9VR7f2CIm9sbWyL1kTbMEB6Ih
         XqK9U0XJ1yVK1yzomwKMX6KZxKL06nkAa3eknapMebYBps0gxSfJF+FXpe7boUwdsor0
         ueFCeJlgOlxidFx+q4vglUgAVV5DCZ7cRsLEJ5HABD8eAXVpqdgtomFXJbnRfa2q12Nl
         OA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tiwQQD0bmTZ/iR7pMI5uZ9dZcUGO6BCQnQb0GwZQxYA=;
        b=pX53H+F/0bD2AxQf1gyQvsuf6mU2M3HPh0jHOxpxP/p/mG83Ek6vo3KYQU3GzKXh8+
         CbM8vJMQIgbnvzntI6HZwEQF7LGydSII31WI5sih1UCu0nxENi13r2EXyIs6vFwn1bKx
         G3FOgnklrtXyYeoJrBuXeCmq9LwWkwiRgOcgULjNQIU1tG/2dfqCKgc+ww8yK7d1Mu1E
         z894+gnG5YePk8K6TnILC0J2FispSaBRvSPkDBOjC8EJA5wjYNHLyouVoy79/joslM8B
         RfBXOU90Rk35wyKZmPccNjZttBgPVg5zQ2uU/QDiV1JbjC8FTPo7Gx88za4z7oabjEG8
         kn6w==
X-Gm-Message-State: APjAAAX2Q+AS0mwIQhEwDJGQTSEkeUL6Zz8dxH30ZJXthn4mQinfRNpX
        OQgT1kaOl8+SzoYLCV+A78C38Qfy3pcwmMqmGM62eQ==
X-Google-Smtp-Source: APXvYqxemhnT1MHWjjUv05tPwp5JTURMgj6lyWgbMlLyEHq2mkDkkGqCa0nWKIHN+Ek32TK0TPDotEQi9kdhX6raOaI=
X-Received: by 2002:a25:dc8e:: with SMTP id y136mr29522833ybe.195.1556176136581;
 Thu, 25 Apr 2019 00:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190424114114.27073-1-anders.roxell@linaro.org> <13969360-f863-e93e-9d48-d27c0034795a@linux.intel.com>
In-Reply-To: <13969360-f863-e93e-9d48-d27c0034795a@linux.intel.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 25 Apr 2019 09:08:45 +0200
Message-ID: <CADYN=9J7U125FHU10=fQ-L21zZSrPh3h6eUhSn7=J=hHJPgY2Q@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: bytcht_es8316: fix cast warning
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 at 01:13, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> On 4/24/19 6:41 AM, Anders Roxell wrote:
> > When building bytcht_es8316 the following warning shows up:
> >
> > ../sound/soc/intel/boards/bytcht_es8316.c: In function =E2=80=98snd_byt=
_cht_es8316_mc_probe=E2=80=99:
> > ../sound/soc/intel/boards/bytcht_es8316.c:508:11: warning: cast from po=
inter to integer of different size [-Wpointer-to-int-cast]
> >     quirk =3D (int)dmi_id->driver_data;
> >             ^
> >
> > Rework to use uintptr_t instead of int.
> >
> > Fixes: a8d218f4fe81 ("ASoC: Intel: bytcht_es8316: Add quirk for the Tec=
last X98+ II")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> I submitted an alternate fix last Friday to alsa-devel, along with 2
> additional patches to handle the quirk_override in the same way between
> machine drivers.

OK, yes your patch address the problem.

Cheers,
Anders
