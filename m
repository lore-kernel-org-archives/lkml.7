Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75704C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4444D2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbfKGIat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:30:49 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44822 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:30:48 -0500
Received: by mail-oi1-f195.google.com with SMTP id s71so1213114oih.11;
        Thu, 07 Nov 2019 00:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8SlBIYjjuh+a+loecxV7Gpt3WURvHvbz61KEdh7SEw=;
        b=WNNXAjs60yDE1kNkxOIq0oAET9tO2Li8B1oMCEBeb3pJ0/0y8y2uBkbSloCETMQJRM
         Oic0erHR02Xile4mFIOBSvkHoXPnsQMin5FpE8jDYwJY+Xty7JjxZ2hVUhxeJOI9m6BL
         jCOncsLcj+03FofJ1r9HLgwfEI4OwEPwLESH+EdqlpcpEtL69m/lN/ijPHNQkX4KDZQ+
         zzGmEi5hIspfna9H1I2zwpuRUuNAAKqxSEuFLfI4k59bpgQhuD/yNsSiKTM2hCD7REoL
         gcHpTDe8wRJfpG7htEzqVZd/tCiC/e+gDTAlQqnKLyTcz9kZTAgth+UsDluuXwiDsh6b
         nVEQ==
X-Gm-Message-State: APjAAAVAGqavycXTUhDknI0Yjp+zHkIW5DNrCOV9xNFVWmTlYLR/JPbx
        fG6J/2Vak33Ez/YHJWoaSgg8nnHFlbl3EaXrDVc=
X-Google-Smtp-Source: APXvYqw13WT6xquXLrX5DcTtgJQPV7I3LxDF82LlDVjBmxzHAi3Xfa/JPyNIYQSazWI1ILJmdf8zDxkpyW6OhRs+K90=
X-Received: by 2002:aca:fc92:: with SMTP id a140mr2165600oii.153.1573115447693;
 Thu, 07 Nov 2019 00:30:47 -0800 (PST)
MIME-Version: 1.0
References: <20191018131338.11713-1-hslester96@gmail.com> <CAPDyKFoBYchP96hv=7XfTo8CrCSD+KC0h_oFRAsOYT-Lc1SFZQ@mail.gmail.com>
 <20191023153313.GB5153@kunai> <CAPDyKFo9wYwhdy-1BDcRMJKTjADappsT-gBaKZE7hTLE4obxiA@mail.gmail.com>
 <20191031221211.GA3853@kunai>
In-Reply-To: <20191031221211.GA3853@kunai>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Nov 2019 09:30:36 +0100
Message-ID: <CAMuHMdXSKU40E8Br0Z53H2FyrQsLxnB-EERZoN6HQHExP5tqxQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: add checks for pinctrl_lookup_state
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Thu, Oct 31, 2019 at 11:58 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > > Well, I don't like to bail out because this error is not fatal for basic
> > > operations. How about releasing priv->pinctrl again with an additional
> > > warning that pinctrl settings are broken and will prevent 1.8v modes?
> > >
> > > Opinions?
> >
> > Hmm, from a mmc driver probe point of view, I don't quite share this approach.
> >
> > I would rather fail as it forces the DTB to be corrected immediately,
> > rather than trusting some developer to look at a warning in a log. The
> > point is, in such a case it may never get fixed, if the product is
> > shipped with the wrong DTB.
>
> I could agree to this arguement, iff the only way pinctrl_select fails
> is a DT misconfiguration. I am not sure if this is true right now, and
> we can't be sure about the future. Or?

Isn't "state_uhs" optional? So bailing out if it doesn't exist is wrong.
"default" should be there, if the device node has pinctrl properties.

renesas_sdhi_start_signal_voltage_switch() already handles fallback
to 3v3 operation.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
