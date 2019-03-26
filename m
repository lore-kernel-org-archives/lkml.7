Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EF420823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stbcIIt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfCZRf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:35:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46877 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZRf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:35:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id k23so2570197lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fh1xn3BFpKpmZ9pOfN6sqvpgY9pmZ7FMYMOw16dPnCY=;
        b=stbcIIt8FnZdyb598n3p1ayhbvwjCKe8XA2yBLtPfa0HAZXlLfPW1E5NBZPSLnjLx/
         4/xmfZ1QGn00DhkY7iv5bQMZLzUc9Mym2k1VLgBQzT9N1BVdcvnuKJozzzk2liiv5ffc
         AA0M3UicoB7UVfO0aaBdBR+nBETkFSks4a+U9QUPMLwEXRVO3mCsBUj2RaPfGBLi/uSE
         rexYTCNqdWUvQMno2b3yrujVi2tCRnjHT7FLyeID23dVk5NvzjfYciQACXD12l8UGdWb
         7exIJjhJdB6Y6voNmL0pO8dxUKwX8cLLAtWfR4KIPX3BDopmOccEcJHgyg7vQIWa8Qvr
         2krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fh1xn3BFpKpmZ9pOfN6sqvpgY9pmZ7FMYMOw16dPnCY=;
        b=bGqNEUARkGkLleqgtCcHp751s0jUe7a8o4yM7TodqJ7TdhFDbm0U2UeMXy/qWayAnu
         u0clovSP8MXJhgIRVSa08M5PVYUBxEgDyxaKw3Vw+qoxin68rXUR62z5sfxYLxCX+9iO
         XA7EEWm/dbYmpwHxyYC1AGQR4Zqz8hGcIgm+E5hjnTWzcjLqI6yfsBIZCPwf3oXfNS50
         kMBPLF36EIE0rl2xIeznzTq/G0KNfL0Tflo+EanHAzjhFJqSOMXjeM0IRYsTkE0UQdd+
         9v3iy/Jd3ArdNeF1D0WJ1PR2NHVdybvY0Ya8xbDRaBaX9VgR20NAbbSlwmmYjrafIhnO
         v5bw==
X-Gm-Message-State: APjAAAXkA/AqiKWKaPOwAJT6WO/85glJkNNgNH6kddcuH+v6a78ILVsG
        AK3EyvI/QVGN98Uliim5imR82LBOxBXxLLREVlsDlA==
X-Google-Smtp-Source: APXvYqw2eYS9VvH4xzrKpZ5+CydCZg8js12rqULHc3FXdzteeUfkT6/7+5p+MhU4l1ogXHQjmCoczNENi2ML5GvWUr8=
X-Received: by 2002:a2e:47c4:: with SMTP id u187mr17435076lja.10.1553621753096;
 Tue, 26 Mar 2019 10:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <1553621018-8944-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1553621018-8944-1-git-send-email-linux@roeck-us.net>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Tue, 26 Mar 2019 10:35:41 -0700
Message-ID: <CAOReqxhLmTBZx04FZaeS_-9f6bk1RwJ_31UqB8MQ=KyB-5Ou=Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: core: Fix use-after-free after deferred card registration
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has already been patched. See
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-March/146150.html

On Tue, Mar 26, 2019 at 10:23 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> If snd_soc_register_card() fails because one of its links fails
> to instantiate with -EPROBE_DEFER, and the to-be-registered link
> is a legacy link, a subsequent retry will trigger a use-after-free
> and quite often a system crash.
>
> Example:
>
> byt-max98090 byt-max98090: ASoC: failed to init link Baytrail Audio
> byt-max98090 byt-max98090: snd_soc_register_card failed -517
> ....
> BUG: KASAN: use-after-free in snd_soc_init_platform+0x233/0x312
> Read of size 8 at addr ffff888067c43070 by task kworker/1:1/23
>
> snd_soc_init_platform() allocates memory attached to the card device.
> This memory is released when the card device is released. However,
> the pointer to the memory (dai_link->platforms) is only cleared from
> soc_cleanup_platform(), which is called from soc_cleanup_card_resources(),
> but not if snd_soc_register_card() fails early.
>
> Add the missing call to soc_cleanup_platform() in the error handling
> code of snd_soc_register_card() to fix the problem.
>
> Fixes: 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")
> Cc: Curtis Malainey <cujomalainey@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  sound/soc/soc-core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 93d316d5bf8e..6bf9884d0863 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2799,6 +2799,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
>                 if (ret) {
>                         dev_err(card->dev, "ASoC: failed to init link %s\n",
>                                 link->name);
> +                       soc_cleanup_platform(card);
>                         mutex_unlock(&client_mutex);
>                         return ret;
>                 }
> --
> 2.7.4
>
