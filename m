Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F5CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930CC208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t82bo+7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1QBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:01:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42172 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfH1QBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:01:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so22166ljj.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yR3tqYiTxpppS/HN0rTYfpt0BO2DjSod+qzn1YFlyUY=;
        b=t82bo+7nReRN8qUwONp3FOyUNOQe+SJmGjj43nMjkurkeSF72Pd1VV3hRf1OgE66RR
         KDWoG2kZQnBVJzkM8KDZCFy7mqz9bcKdJSmmEx2dYdkoTRZLvN6pnCl8E0pBhjwKdkJ4
         sf49qG2yOviuQ4Fu1Tm1UKeNFc43o8A1iRxF9LdpIDyvUrr/EXGEZPFdILgnN8BLCa2n
         KW3jLLC38MeV3yMp6xS8/rl6fTmU4XS6EpBjg41uqXmYE0AhDM2igs87zJIiHIANDVPC
         XsI6R22UTUjfppFtkbsj92qJogfUbp92F2UjpP47UJCKAq9rZ+NXm3mNfnDYXCPxjkdA
         RFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yR3tqYiTxpppS/HN0rTYfpt0BO2DjSod+qzn1YFlyUY=;
        b=WEo/8rEeQuhKTpBnvZe+9SVACV/uRId6GkItilRfJbI/fX8Ka3adtcF/McwlCOPhuG
         VODWQIcwOp2uzruR+u4XWfXEYBtevkBIob3CpGiTzhgHn2yfmsjZ4qW80aYdKWsJ0/vb
         8SpEkYsiSBpnkX/9FYyUb5xrUtuPJFolp27SCvpHk1XQfFeVBpBAEIophDw9+jZuydW8
         BWBoNq/3SDAQntG630VzBxJeRL4xh+kzXsCN4ROTgBpWZWEYz7SdM11r90i80hdA6IAm
         1XATxC6RugQw6htP4tR5/sacpX2Sj9vjDTPOQZ1d2wC8gZMW+EgGpKfy8bqiojx8ZJSz
         R+RA==
X-Gm-Message-State: APjAAAV7ny4WCP5Fn/p9/eUuRZ1x1LzEXJY6IrtHgjuALnwRAc71vx0U
        iqSjMnocOYrVvkOhByi5P/VLi02Yu4yYyW4B1j4=
X-Google-Smtp-Source: APXvYqyOP2EB8a83ZtqOJPUj3xY7/goLSp49RDBCXTtxODlPCxl+xIBbp0pHHEXIFG32IeOGVr0WeRsO6J9J5w8UT1g=
X-Received: by 2002:a2e:978e:: with SMTP id y14mr2524405lji.10.1567008091865;
 Wed, 28 Aug 2019 09:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <1567012817-12625-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1567012817-12625-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 28 Aug 2019 13:02:32 -0300
Message-ID: <CAOMZO5BF6M4McwGTuNU8jM41+N3jeaJp+U2ST5JY7e+yv8GO_A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix clock control issue in master mode
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Wed, Aug 28, 2019 at 2:21 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The test case is
> arecord -Dhw:0 -d 10 -f S16_LE -r 48000 -c 2 temp.wav &
> aplay -Dhw:0 -d 30 -f S16_LE -r 48000 -c 2 test.wav
>
> There will be error after end of arecord:
> aplay: pcm_write:2051: write error: Input/output error
>
> Capture and Playback work in parallel in master mode, one
> substream stops, the other substream is impacted, the
> reason is that clock is disabled wrongly.
>
> The clock's reference count is not increased when second
> substream starts, the hw_param() function returns in the
> beginning because first substream is enabled, then in end
> of first substream, the hw_free() disables the clock.
>
> This patch is to move the clock enablement to the place
> before checking of the device enablement in hw_param().
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

It would be nice if you could add a Fixes tag as well.
