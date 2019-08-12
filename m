Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F265C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8EF20651
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlaFDJkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbfHLMKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:10:50 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40983 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:10:49 -0400
Received: by mail-yw1-f66.google.com with SMTP id i138so38581690ywg.8;
        Mon, 12 Aug 2019 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4z7p+08vVGRKaFoY5K0HIJAi+xxlVs7dirH0vF1HBV8=;
        b=ZlaFDJkn8yLyk6xQ571Oe8ABNlq9Ly3tW4PGAUu0Hla738q5vre4pOqrZkuY8VjcLY
         QpxgkZTkbiY5sV9lQyaoMRfyOwYTWorH8Q/M9AGSYfXcB2QnWh+47f3RNUrhS2QpK/5e
         u3IU8gEwuMfoi3EGj67aC76xwxowAQLpbLbVGMW7agkwzX82V6xh1zjOBqIhiqHYbyaF
         yVd6r5BMz4VbmSsQ6rCvKNmfk8yfWU+9/KiQ0PdmBWgR/JeRaGFjSPZxUW9F6UL+1/eV
         wU+j+FFe1HlJHonkDpZU+uOHPi21H1I9DZdnZ2Adw2fBBWsnTpd0/OHNFbV2q6NBxxKh
         4VfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4z7p+08vVGRKaFoY5K0HIJAi+xxlVs7dirH0vF1HBV8=;
        b=EndTiCuOp0VhPZGy93xn5tLtSXROWw9gsoz1ntZ4MqVoNZLvHRLl0RAJf9pKw7XdNl
         e9DVfvbs6/PuzK6aL/xIAtMjsIZwbAzH7pgKQjO/sLLYKt89BXpYe1R8Jnx+ZTXZ6fF/
         03/chUzXIg+YK6ShF5qTiChPwI/RrFUuRkhASqaRfsxVOr0P6X4XnTayrbbnO+DkKiRI
         dnVjqvxcLWRWw9XGTnn+ciGQaslNXR2fEpP+I1Mio3drMXj3saf1nwkbRhluVaxryw0U
         WuRCFUn0JQrgTMmoY/RLXNI2O1G5SqMzDCN8dqj/xecsA4EDWElUtzmAlrMGyQmtyUcg
         1ivg==
X-Gm-Message-State: APjAAAV89uvPYAuFrc8AORp6xfWU87rG5xBWkpxVTkj+kgQnR0wo+0xa
        Q9tWifeKBj8c/1tPefEouYpWloOuQo2yjYKYLZk=
X-Google-Smtp-Source: APXvYqzEXZhLUtV7pYNDbu1/3ce7u6Be+J9JdJvlDEwjC+aEheD9+kDaCkP9TtrZOgUEqijXeYpwIxIL2W3izU/ZO14=
X-Received: by 2002:a81:2655:: with SMTP id m82mr4525703ywm.306.1565611848215;
 Mon, 12 Aug 2019 05:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190527200627.8635-1-peron.clem@gmail.com> <CAJiuCcfUhBxEr=o7VVpPROQZadQh7z1QC0SkWSYt-53Sj3H2qw@mail.gmail.com>
 <CAJiuCcc3_1jZWV7G3+fFQYRZ8b6qcAbnH+K6pkRvww6_D=OMAw@mail.gmail.com>
 <20190715193842.GC4503@sirena.org.uk> <CAJiuCceYDnyxRLLLLy6Dn6DLTZ+NmSaUnoX1Vmzvgiy0XvF_Fw@mail.gmail.com>
 <20190812110103.GD4592@sirena.co.uk>
In-Reply-To: <20190812110103.GD4592@sirena.co.uk>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 12 Aug 2019 14:10:36 +0200
Message-ID: <CAJiuCcdNFbKgo+oGZXKfBpyPKNOuUwpPbHdq-yBpcm3XYtPhEQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Allwinner H6 SPDIF support
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, 12 Aug 2019 at 13:01, Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, Aug 10, 2019 at 10:45:23AM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
>
> > Hi,
>
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.
>
> > Sorry, I just discovered that the ASoC patches have been merged into
> > the broonie and linus tree in 5.3.
>
> > I'm still quite new in the sending of patches to the Kernel but
> > souldn't be a ack or a mail sent to warn the sender when the series
> > are accepted?
>
> Not every maintainer will send those, I do but you might find they've
> gone into your spam folder if you're using gmail.

Thank you very much for the answer,
Regards,
Cl=C3=A9ment
