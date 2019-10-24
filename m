Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408C5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F17D20659
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bNp+7fUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439976AbfJXRQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:16:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33085 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405901AbfJXRQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:16:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id 71so20258963qkl.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crG+DRT5ntTO6UrnZjz7Zk+aIch4CLzmhTF61MiVCPc=;
        b=bNp+7fURF9Ol8vUPwHGKGm6mK9ijx7pSmONTo8SbOqpmSf0D+KM+IwQY2l8cYRl0tc
         4Jlf4tFma80yY3usPo8m8fNAx2W3NJVos7I5+Fy3FYeouo5F7elc73VyeznclDfRUKJ6
         1GQuz3/rw88FlDhwFBVqYsiDxvtt5Si747jAG4IuuZuyBtTUXxSgpxctMMsWrQHI2KXC
         L4kMhUMuXKs1qttPbAlVMMH9KKVo9HAGMIHvPYm9S97Q9Oer5iiXEy3Yi0arikGoB0rO
         +td1l/vUo1NwJh2Ncplo9FWjk5/JcFWW548edS3pxJbv/LR2OyPs0zvvU0VdgI5PWi4G
         W/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crG+DRT5ntTO6UrnZjz7Zk+aIch4CLzmhTF61MiVCPc=;
        b=N0KWKVhVX+ItI6QjWmi1o5/YdeAkVM2w1tjSFFRn7juaRXyFXmXMzUet3VLTj7Fjg1
         BiIyAcxe2e66OEeYMRRmsz3WsYwQgw4DK8ovLeBhEnBExnrskwZyrsns+tnymgWOyajh
         afcQst2CRTshBYVPsBsUISRaDUhGj6uKK0X6HWWCbYKNGK1Bpu31iWLLuyh2DyKwh8t7
         qMYEscLzwobYfXm7M1G4OhcdlCNueh4kvgFxbkC1PEN4T/xYXaZ8Jxb85oLGav9m3cgD
         5hkr/JHRxW/b5tkbSlqUPNHe1NyIPi14uHoSqUCKgd9YMhBzgvLVMc5DrMuLmieu7f51
         GJnA==
X-Gm-Message-State: APjAAAWCuwyfE2NRiI63rO5RvCVkxw/8wMfMXqZge4ma4pvfCmLNFDIy
        J52WvbzGk+mWWr34Xh0zf9DDzDcaNMWOvHFPmj7VIg==
X-Google-Smtp-Source: APXvYqwO+pjq/T6cA1+tZZRLnofnfCEwAKnPL1uQAxpaH1IWS8TnV2isw/FukpIexYC5euabMYGxtp47q9ysO8wbEl8=
X-Received: by 2002:a37:9a8a:: with SMTP id c132mr14717102qke.92.1571937359669;
 Thu, 24 Oct 2019 10:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20191024124610.18182-1-colin.king@canonical.com>
In-Reply-To: <20191024124610.18182-1-colin.king@canonical.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Thu, 24 Oct 2019 10:15:48 -0700
Message-ID: <CAOReqxhzYnN4vkoiJ1vDN3UwmkJs--u7cUgpoSDtMr1dSThR3Q@mail.gmail.com>
Subject: Re: [PATCH][next] ASoC: rt5677: Add missing null check for failed
 allocation of rt5677_dsp
To:     Colin King <colin.king@canonical.com>
Cc:     Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ben Zhang <benzh@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 5:46 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The allocation of rt5677_dsp can potentially fail and return null, so add
> a null check and return -ENOMEM on a memory allocation failure.
>
> Addresses-Coverity: ("Dereference null return")
> Fixes: a0e0d135427c ("ASoC: rt5677: Add a PCM device for streaming hotword via SPI")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thanks

Acked-by Curtis Malainey <cujomalainey@chromium.org>
> ---
>  sound/soc/codecs/rt5677-spi.c | 2 ++
>  1 file changed, 2 insertions(+)
