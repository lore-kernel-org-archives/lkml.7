Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E861C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC4B218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T56ZL0tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfGYNVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:21:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34958 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbfGYNVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:21:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so50799469wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZUGd2jspUiG+FAZ+7RGXuDLiEmYs11194A8ngHTeyP8=;
        b=T56ZL0tUgVYFHxu5umztZcIPeZ+Y8EP8VLpHuXaydTQ2sRYjlSuJGRW7wGkv6BaLef
         2rmXbB+mslBhrq6hpaJjKktJCFFSUwgbuDnRy2lrDzGwgtfptspfvaPBQlwIq9p1FT29
         nEDaROkdDc+VuBxTand+b9z8uQVgKmntkAOI9EsNO9SJdWKJfFsxEvzyi7MTrxF58qg2
         18CPs3hYcN08R3Q14dvUsVLIjfvne6Kh6IXf3qeU4yNgaxrJ5gWLu8IycArfQ+MP1U/v
         z1wYqGOsp9S8aZ1vMY0UrW3uMRaq+kn1Lwz8zRr16qOkrdhgYj4LmulNozig/NxmAYNr
         5gUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZUGd2jspUiG+FAZ+7RGXuDLiEmYs11194A8ngHTeyP8=;
        b=CRXuStOIdiSMmsTEtR0FoxEIbxFxBObp5paoCaMaGV+9iydfC6lpEkF3TEUVo/LILX
         0P+eeD2fbevLQ0l28LYF2m549xMDucBBXnoo7QVGbvQ69zla79du7FKUr2dqepKziU/l
         qd68GHRr5fPa0SoX3izwhvLpSVL1BN/YGEJX3O9iXuTC/63dTOPqzSfbktRwAk32y+a+
         YpJd3f++Aog57UbDHV3sb/UWwBrCQi43tXYBDQQazusWQ7uvGcauXAg6NVysiwM18xRW
         kvkVSsMDkm2ySJrcrt5nAMo2BKT8JwYn5ccFfuXZHzYrAOSya+BuiAV4Jx4FNO8jUfaD
         hK0Q==
X-Gm-Message-State: APjAAAUOxdm4R/Z1X/7jsdMMjPH/0OoNer7C55pKpNBKnNrIURRs8/fh
        /Tk0Wn7o2bttaEvhzlB8VR0hlA==
X-Google-Smtp-Source: APXvYqwwDUYgCEVbqCOrCIRQ3IOn2d2MD6ZRphM4OAuYE08YMKhoSF7VOHW0dgqJ4VhM8pmfOrVkog==
X-Received: by 2002:a5d:4108:: with SMTP id l8mr93347933wrp.113.1564060902228;
        Thu, 25 Jul 2019 06:21:42 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s2sm39836778wmj.33.2019.07.25.06.21.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:21:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/6] ASoC: codec2codec: run callbacks in order
In-Reply-To: <20190725130016.GC4213@sirena.org.uk>
References: <20190724162405.6574-1-jbrunet@baylibre.com> <20190724162405.6574-2-jbrunet@baylibre.com> <20190725130016.GC4213@sirena.org.uk>
Date:   Thu, 25 Jul 2019 15:21:40 +0200
Message-ID: <1jlfwmxna3.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Jul 2019 at 14:00, Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 24, 2019 at 06:24:00PM +0200, Jerome Brunet wrote:
>> When handling dai_link events on codec to codec links, run all .startup()
>> callbacks on sinks and sources before running any .hw_params(). Same goes
>> for hw_free() and shutdown(). This is closer to the behavior of regular
>> dai links
>
> This looks good but needs rebasing against -next due to Morimoto-san's
> recent DAI changes:
>
>   CC      sound/soc/soc-dapm.o
> sound/soc/soc-dapm.c: In function =E2=80=98snd_soc_dai_link_event=E2=80=
=99:
> sound/soc/soc-dapm.c:3857:10: error: implicit declaration of function =E2=
=80=98soc_dai_hw_params=E2=80=99; did you mean =E2=80=98snd_soc_dai_hw_para=
ms=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>     ret =3D soc_dai_hw_params(&substream, params, source);
>           ^~~~~~~~~~~~~~~~~
>           snd_soc_dai_hw_params

I did rebase against next and saw Morimoto-san's patchset. I must have
messed up when formatting the patches, sorry about that. I'll resend.
