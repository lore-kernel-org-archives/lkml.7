Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489D1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19017206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQNjW9fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfKNRCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:02:37 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43684 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNRCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:02:36 -0500
Received: by mail-qv1-f68.google.com with SMTP id cg2so2623103qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1l5ZXAPHJt0a+XpeA7xQeXkw9CmNqTnUN3g64Iafec=;
        b=gQNjW9fu+UTvoleQ8tOOf5NpmJruqGHt1EvvtSyGxkQDXsh0eGjJMUH4zTQj/hHMtc
         PHiC9CMQa9R6FhKgwMfxKjlEEZ0qlGRzX8NTzRN1n6oVyir+D/ojwZWxECm0UFw21P90
         o3OqWI7IbQV8OFUqE8W2KgYO2T8tLal+e29EzkejJj/ZRLslBRtfDTTcQxCP/1WpAE0K
         qOenJYZxUj0o65u5m16zJbM7ONTUpM70XntIHgA75mazMqJILh5026oVQLOd+PoJ5DTO
         KLmVtzdYOy2KXC2leqUwih4iPUxmrRTgdO6Gz6CDAkxXBZdbJwoRGg0q9RqfSMoGLqlZ
         s8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1l5ZXAPHJt0a+XpeA7xQeXkw9CmNqTnUN3g64Iafec=;
        b=B05UR/CQ+zrR8x7i0OTwv8BCVe/wOF26hAFVz0blipDg99s2+Sll5QHwWNOa9SH+AF
         zpl7ft0vSlQZE+1wkOd/i3vIvolFlxHIVXuXGCUZcyK/qRwvyWZB1ao3LGfIH3QMTDDl
         N96nvFLw2Ec3CoGulMee5WYT2FNB1CWzPgHWHtAlxYq3vy+/VRLwXD2anYw7hAeFsKkf
         3cs44qbv5rEWYD9ze+32O16UMhMn2OwSS7U73hkGvh+80FgFrqM7KCyfORyO3mUJdLg6
         82MDSU41zT3Z/T/8Bs4/hY3+Ovn4fuTPDOvN+ZIug6Td22Ugbaqy76AnUVNVcFc5E74j
         5X4w==
X-Gm-Message-State: APjAAAUOL6wFsv+UVOERjoWD33H8rMyL59I532iwWd4jqRtjv2QB4zKz
        mP/WoCirlybJy/Oidkod9YUBRi//mrdPos7CMH/YEA==
X-Google-Smtp-Source: APXvYqzot6FBVnO83R2lmasQUs7XRy8tEip+Omj1oNafWjZ6nVOWohDS+O8L/UP4Zr4JlAHkkejjRTUAYm1nDsHpTP0=
X-Received: by 2002:a0c:d2b4:: with SMTP id q49mr8697240qvh.135.1573750954348;
 Thu, 14 Nov 2019 09:02:34 -0800 (PST)
MIME-Version: 1.0
References: <201911142322.pHmcOJHb%lkp@intel.com> <20191114153304.n4pyix7qadu76tx4@4978f4969bb8>
In-Reply-To: <20191114153304.n4pyix7qadu76tx4@4978f4969bb8>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Thu, 14 Nov 2019 09:02:23 -0800
Message-ID: <CAOReqxgtfNWDZOMnT6nSWh408dsrGxJLVgKtUN2dNf0J-JpnWw@mail.gmail.com>
Subject: Re: [RFC PATCH linux-next] ASoC: rt5677: rt5677_check_hotword() can
 be static
To:     kbuild test robot <lkp@intel.com>
Cc:     Ben Zhang <benzh@chromium.org>, kbuild-all@lists.01.org,
        Mark Brown <broonie@kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 7:33 AM kbuild test robot <lkp@intel.com> wrote:
>
>
> Fixes: 21c00e5df439 ("ASoC: rt5677: Enable jack detect while DSP is running")
> Signed-off-by: kbuild test robot <lkp@intel.com>
Acked-by: Curtis Malainey <cujomalainey@chromium.org>
> ---
>  rt5677.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
> index 48955b22262fa..cd01a3a8daa82 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -5243,7 +5243,7 @@ static const struct rt5677_irq_desc rt5677_irq_descs[] = {
>         },
>  };
>
> -bool rt5677_check_hotword(struct rt5677_priv *rt5677)
> +static bool rt5677_check_hotword(struct rt5677_priv *rt5677)
>  {
>         int reg_gpio;
>
