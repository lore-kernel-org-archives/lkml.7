Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE2C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83A020989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IwWDVQRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfEHV7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:59:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46186 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfEHV7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:59:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so197191ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZMfXBQdOHBDgXhrafYn8rmUp2moZY4YUtAHGpeXcXQ=;
        b=IwWDVQReBqLpD91rfRHP5GUe1YVtCg7a2594K/O6nP3EjOMfYjP9Jvg4wQFnrIuxJo
         2xoX7a6EjGItF1lhoQX2Z7iEJzN7X0+uP1nULC7/B/NmgLe0tvRGxZqYWKBfpy7+PSKV
         onf595Hho8vuccSrSxuNJeMLoEM3irs+ejy4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZMfXBQdOHBDgXhrafYn8rmUp2moZY4YUtAHGpeXcXQ=;
        b=hk0iKxR/aafS3b8JJK+kqJ9VdnOzOD65g+7Wa0oenSt+f/d+BszAl09IeDR8mZTLGr
         8koWoZHQwHgF4jsAzcz9amjSDVYVcm7nRnvP2SkmFb5qchixny3IENfVVyBvvhtMESfR
         a2TEebQFFvnCVqPfwiYt3LInT7i0t5ay1u3JEoLi23lmfB5v8PLAWXOGk57Ebubd+kx7
         ydssIM/GN0qSvOFZWRdoWjn5svJ1eAQMEfb2/a+0kV7WdjZeM+xxNudljwZHJVLM586e
         hZyGhBjFN2qH7mtBlsni1Yj7nCuiD5b48F+BUvI1lAMrKwyQE6Tpzccc2Yk4CgTrrx0W
         wc2Q==
X-Gm-Message-State: APjAAAWixmtuIGDz5z4986KOlhRq1wnZ3Cq6Bo/amfIqflZYYz4pjLAr
        uskfbG0JApFTn3BdSp2FOcD2CKiKOvo=
X-Google-Smtp-Source: APXvYqxMTo7xVQ563KZv3qw+96OUpQXb2tHHtGdaT1aXfKbUXRIaWtINVJSvjVhNEmzayJoCbmBnLA==
X-Received: by 2002:a2e:9812:: with SMTP id a18mr100026ljj.146.1557352747119;
        Wed, 08 May 2019 14:59:07 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q7sm7635lje.41.2019.05.08.14.59.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 14:59:05 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id r76so201983lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 14:59:05 -0700 (PDT)
X-Received: by 2002:a2e:298d:: with SMTP id p13mr107842ljp.64.1557352744587;
 Wed, 08 May 2019 14:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190507215359.113378-1-evgreen@chromium.org> <20190507215359.113378-2-evgreen@chromium.org>
 <cb0accd5-6b0d-065a-9b54-321252862d88@linux.intel.com> <CAE=gft7PtNWzH1QYigbQvDcJwZSb7ZLWoKzurPGBnh72DYcZrw@mail.gmail.com>
 <0d2c6330-7882-a7e5-8dcb-51eec0e845ba@linux.intel.com>
In-Reply-To: <0d2c6330-7882-a7e5-8dcb-51eec0e845ba@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 8 May 2019 14:58:28 -0700
X-Gmail-Original-Message-ID: <CAE=gft4sTgnmzWDry2GB9_EAeC6Un2m7itvL4AG97z1XnWxe9A@mail.gmail.com>
Message-ID: <CAE=gft4sTgnmzWDry2GB9_EAeC6Un2m7itvL4AG97z1XnWxe9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: SOF: Add Comet Lake PCI IDs
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 10:00 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 5/8/19 11:42 AM, Evan Green wrote:
> > On Tue, May 7, 2019 at 3:14 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >> Minor nit-picks below. The Kconfig would work but select CANNONLAKE even
> >> if you don't want it.
> >>
> >>>
> >>> +config SND_SOC_SOF_COMETLAKE_LP
> >>> +     tristate
> >>> +     select SND_SOC_SOF_CANNONLAKE
> >>
> >> This should be
> >> select SND_SOF_SOF_HDA_COMMON
> >
> > You mean SND_SOC_SOF_HDA_COMMON I assume.
> > Except that I also need &cnl_desc, so I need CANNONLAKE to be on as
> > well. Should I select them both?
>
> Ah I see. I'd rather use a different descriptor then, and make the two
> platforms independent, as I did for CoffeeLake. You can use the same
> descriptor for the two -H and -LP skews though.

Ok, I'll add a cml_desc and have it conditionally compiled in on
either _LP or _H Kconfig.
-Evan
