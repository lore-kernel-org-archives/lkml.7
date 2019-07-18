Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3F9C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA0421783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563443945;
	bh=AWjdnSfyXbQ/4ZXvUB6IC11P/UFPFsul4lB9tUBMa/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gm/y/eTr33IDMZfxHgFdfwuhEna/XutLVBupMJ+GHf0NMi9R8bJApUPHHioMsgxl1
	 p9Ph3Jg46C7bYaPK+x06qzrBIjhpXaIGaHCu+FmNVyaDXpUJIavU1r858pmF0S1uyU
	 4yRtP4eWpS1pwZdts2F9NlNFxb/YNbYMEmjqsgkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389975AbfGRJ7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389934AbfGRJ7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:59:02 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7E4D2186A;
        Thu, 18 Jul 2019 09:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563443941;
        bh=AWjdnSfyXbQ/4ZXvUB6IC11P/UFPFsul4lB9tUBMa/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q3Rkw60UktJUkgRrFr+DK2X5F4Gl9Pd1waBBBy2/XkoQ1wGABpEIdJ1CtYTS//DPJ
         dcLpmXEerj8/PI4Dehhe++xwX12hAa+RTPS6f7ktxRVlUuIwtT7Qr0OoYcOJ3ikcIe
         mhCpahy5dptlgJFXdi8ZxRvq5RwaqYZ72ok5OhRk=
Received: by mail-lj1-f172.google.com with SMTP id r9so26691724ljg.5;
        Thu, 18 Jul 2019 02:59:00 -0700 (PDT)
X-Gm-Message-State: APjAAAXD8a0N2nQzgOJylyoxQqfTefJ3IT0o+Wo+8r3LcBK9Q6XNbgsE
        0Pp2nKPWDvGj+JDjEQJoRoufFokOUjAJdUwgXNU=
X-Google-Smtp-Source: APXvYqwyiTc2BJqJc/k+YP8sLFe69tVubWrxtf8iAhRiiRjrQvRJaDmNfKv+t71cpGoUpQn2Kl5xR/RzgOxrua6Qu8o=
X-Received: by 2002:a2e:8155:: with SMTP id t21mr23579565ljg.80.1563443938929;
 Thu, 18 Jul 2019 02:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <c4c10934-f06f-24a8-1162-b023e4ab4066@web.de>
In-Reply-To: <c4c10934-f06f-24a8-1162-b023e4ab4066@web.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 18 Jul 2019 11:58:47 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdRY+HaAKEj+jugJpE6kFYpkRacoCoKnMFjFL0t-EuMcg@mail.gmail.com>
Message-ID: <CAJKOXPdRY+HaAKEj+jugJpE6kFYpkRacoCoKnMFjFL0t-EuMcg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: samsung: odroid: Use common code in odroid_audio_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Takashi Iwai <tiwai@suse.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019 at 11:57, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 18 Jul 2019 11:42:29 +0200
>
> Replace a function call and a return statement by a goto statement so that
> a bit of common code will be reused at the end of this function.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  sound/soc/samsung/odroid.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
> index f0f5fa9c27d3..d152ef8dfea3 100644
> --- a/sound/soc/samsung/odroid.c
> +++ b/sound/soc/samsung/odroid.c
> @@ -316,8 +316,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
>         }
>
>         of_node_put(cpu_dai);
> -       of_node_put(codec);
> -       return 0;
> +       goto err_put_node;

No, it does not look good. It makes the code and flow more difficult to follow.

Best regards,
Krzysztof
