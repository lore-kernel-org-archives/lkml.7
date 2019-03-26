Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB00C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EF8206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoXxNm/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfCZRtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:49:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46994 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCZRtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:49:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so8391685pfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KzO+CU2dSWmCpEqeeTfmUaJiSo4wNZbc4gsxqYU8WeQ=;
        b=JoXxNm/b2ehv3oT5N3vjbE9YnD2PrW9Ru2dvOQ0qJpNSBjyj7Z3dCoWTfPLQ45AjAC
         TgdDqdI7/O6AP61KgQJVAb8uYx/UXZT/FGdaw8WNIfH5tMc0yTR67tcZleAH8uYz+rNZ
         G1ZacFPPscHheMgH3pJcMKBYw2T82NGG735WslNENh7+S4dkGmUTj2t+xOC70vfqP6UY
         EuD3xZvLAg3zaHhJzAulzvwoB5ezAo0I0wKceDn34VelNzMiwNyMcejME8gFTzx4JGwR
         gfrLIDx+R3He2rP+guwQHx55ok23ITbI2+Sg5N0tegTrfMfQjrUPkd6e+GZGhxR9NybE
         BQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KzO+CU2dSWmCpEqeeTfmUaJiSo4wNZbc4gsxqYU8WeQ=;
        b=nnfVnIfnWdwF399/5+fDL7kq94RKkGGM6Q+fDU05ru3UmE4dwiCnRRE5NrcxHHJd2M
         jVKXdjsZZWk/+coIhYm+pfSbMbHmS7AEOcqboEcxV+fBqeYcbzog14p86ZdpFwapkybJ
         MeIV48Qq2b/BEEp9wgin8tbvfT+32lTVXrF5YBDCraUsw6H4pD4uAojLDBB0uCfwtrcU
         sgFSlY0LyXcd1ggUJsTXI/SY8GzI5g5FiXq7BqgwJhi4R893CDMLGv5dwr9eWD3ekgWp
         lVSGwxb6wnJ2V7onuzJcU2CjA+bGWL5bhAIy8CqNknAeYux+pvclVfuZfB4dyXq2c25m
         RN/A==
X-Gm-Message-State: APjAAAWuYctt3KUb4rNO7q6OXeV7iS7HVKJIexswxHv0y4H9RVvtTEsG
        H+layIpZNFJTVjBu1PGWPJI=
X-Google-Smtp-Source: APXvYqz1+C9s1RC5C4A32leCe4w/W5BFLiZdgq7tvaBcrMREZAo0ZnPUUjcfCKlHtyYcaD/qMH+6Sg==
X-Received: by 2002:a65:4bce:: with SMTP id p14mr30613987pgr.68.1553622542259;
        Tue, 26 Mar 2019 10:49:02 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h64sm32136049pfj.40.2019.03.26.10.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:49:01 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:49:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [PATCH] ASoC: core: Fix use-after-free after deferred card
 registration
Message-ID: <20190326174900.GB9916@roeck-us.net>
References: <1553621018-8944-1-git-send-email-linux@roeck-us.net>
 <CAOReqxhLmTBZx04FZaeS_-9f6bk1RwJ_31UqB8MQ=KyB-5Ou=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOReqxhLmTBZx04FZaeS_-9f6bk1RwJ_31UqB8MQ=KyB-5Ou=Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:35:41AM -0700, Curtis Malainey wrote:
> This has already been patched. See
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-March/146150.html

Ah, obviously. I missed that one. Sorry for the noise.

Guenter

> 
> On Tue, Mar 26, 2019 at 10:23 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > If snd_soc_register_card() fails because one of its links fails
> > to instantiate with -EPROBE_DEFER, and the to-be-registered link
> > is a legacy link, a subsequent retry will trigger a use-after-free
> > and quite often a system crash.
> >
> > Example:
> >
> > byt-max98090 byt-max98090: ASoC: failed to init link Baytrail Audio
> > byt-max98090 byt-max98090: snd_soc_register_card failed -517
> > ....
> > BUG: KASAN: use-after-free in snd_soc_init_platform+0x233/0x312
> > Read of size 8 at addr ffff888067c43070 by task kworker/1:1/23
> >
> > snd_soc_init_platform() allocates memory attached to the card device.
> > This memory is released when the card device is released. However,
> > the pointer to the memory (dai_link->platforms) is only cleared from
> > soc_cleanup_platform(), which is called from soc_cleanup_card_resources(),
> > but not if snd_soc_register_card() fails early.
> >
> > Add the missing call to soc_cleanup_platform() in the error handling
> > code of snd_soc_register_card() to fix the problem.
> >
> > Fixes: 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")
> > Cc: Curtis Malainey <cujomalainey@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  sound/soc/soc-core.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> > index 93d316d5bf8e..6bf9884d0863 100644
> > --- a/sound/soc/soc-core.c
> > +++ b/sound/soc/soc-core.c
> > @@ -2799,6 +2799,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
> >                 if (ret) {
> >                         dev_err(card->dev, "ASoC: failed to init link %s\n",
> >                                 link->name);
> > +                       soc_cleanup_platform(card);
> >                         mutex_unlock(&client_mutex);
> >                         return ret;
> >                 }
> > --
> > 2.7.4
> >
