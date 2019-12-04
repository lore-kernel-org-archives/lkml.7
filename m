Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B822C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790D220640
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 08:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLDIFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 03:05:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46155 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfLDIFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:05:02 -0500
Received: by mail-oi1-f195.google.com with SMTP id a124so5992666oii.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 00:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzmSszUb11ZTd3CAOQhLM1Oej3uQN3VCcm6xAiMI9lE=;
        b=T7lCSMbfMgSfjt3wGiS8tAm/EK0fdQ5YylhZCBYtk11JTitW+BA6ij4XkVPlUDC46V
         DotZ/FMiWDF3ksUD0U8nL3dQISEQ769WBHy9MWnqMkUeKwocEBGCk02mgzzXEiJJyjJk
         VM+DP7hdlmD1/Vq/G8eBOLiGNPsrj581+mjDWPHMdxgC5I25HTnHfoL0W0PAA09tZsX+
         XTcdwsLA4In6xTd8tTysU6kzT0Avu6ajAR9klqKLsknRffirPhszPV8+lvugxyPk3A8z
         M7yWj0u0YSsAyLX8mHYckZlz4OEvuq0Fm7t5ieBC0THCq1E4NxxhykWUJvG+15TZdEp5
         JvZA==
X-Gm-Message-State: APjAAAVz/fnezkdyYOd4O4IJkiZuvGHIvIia9/pNy0XZgS1dZyDPdiXH
        DAsY5AxBcsDkpX1YvifmEcABFZA5LuawhhIhWJw=
X-Google-Smtp-Source: APXvYqwQYYvmxJ27SQWgQ0TizKyJXAiCurvdzLmpuOoh7FLaPfY+GDK45gxkr80yn03ULebrjxWFAvuorLZFuVD3R74=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr1465019oia.131.1575446700716;
 Wed, 04 Dec 2019 00:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20191202211844.19629-1-enric.balletbo@collabora.com>
 <20191202211844.19629-2-enric.balletbo@collabora.com> <CAJKOXPdJSLoEX7+34imGuZ6CEE5unajL=byb+h9VT3Bejc353Q@mail.gmail.com>
 <3355589d-0b0d-f30f-624c-0f781ee9cd8d@collabora.com> <CAJKOXPcrTp7baiPMYaaf_44w+b8GUBWs=X3YTgNZtxJVx0zbgw@mail.gmail.com>
 <CAMuHMdXdWASPa3yr04N5w9jTt3=jC_H20yVpcG1J1_Sx0PRtgA@mail.gmail.com> <CAJKOXPfzYSJdVg_j7MPP14WOve0cJpF+NV2FWWhjGbUEwVWavw@mail.gmail.com>
In-Reply-To: <CAJKOXPfzYSJdVg_j7MPP14WOve0cJpF+NV2FWWhjGbUEwVWavw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Dec 2019 09:04:49 +0100
Message-ID: <CAMuHMdWbS+AD4me1fT4yuzDGTp4piubTcQ_3UHP1nrbZ3YFyow@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86_64_defconfig: Normalize x86_64 defconfig
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        fabien.lahoudere@collabora.com,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Dec 4, 2019 at 2:15 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, 3 Dec 2019 at 18:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Dec 3, 2019 at 10:26 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > On Tue, 3 Dec 2019 at 17:05, Enric Balletbo i Serra
> > > <enric.balletbo@collabora.com> wrote:
> > > > On 3/12/19 3:15, Krzysztof Kozlowski wrote:
> > > > > On Tue, 3 Dec 2019 at 05:18, Enric Balletbo i Serra
> > > > > <enric.balletbo@collabora.com> wrote:
> > > > >>
> > > > >> make savedefconfig result in some difference, lets normalize the
> > > > >> defconfig
> > > > >>
> > > > >
> > > > > No, for two reasons:
> > > > > 1. If running savedefconfig at all, split reordering items from
> > > > > removal of non needed options. This way we can see exactly what is
> > > > > being removed. This patch moves things around so it is not possible to
> > > > > understand what exactly you're doing here...
> > > >
> > > > Ok, makes sense, I can do it, but if you don't really care of having the
> > > > defconfig sync with the savedefconfig output for the below reasons or others,
> > > > that's fine with me.
> > > >
> > > > The reason I send the patch is because I think that, at least on some arm
> > > > defconfigs, they try to have the defconfig sync with the savedefconfig output,
> > > > the idea is to try to make patching the file easier, but I know this is usually
> > > > a pain.
> > >
> > > Till I saw DEBUG_FS removal and Steven's answer, I was all in in such
> > > patches from time to time. However now I think it's risky and instead
> > > manual cleanup of non-visible symbols is better.
> >
> > IMHO, it's the maintainer's responsibility to refresh the defconfig(s)
> > regularly, from known good config(s).
> >
> > I.e. you start from a known good .config, run "make oldconfig", verify
> > the changes by comparing the .config before/after, and run "make
> > savedefconfig" afterwards.
> >
> > You do not run blindly "make <my>_defconfig && make savedefconfig", as
> > that means you'll miss out on new options you may want, and will loose
> > old options that are no longer selected by other options.
>
> Instead of keeping this known good config somewhere outside it should
> be just equal to defconfig. There is no point to trim it with
> savedefconfig and then later experience missing options (because some
> option was a dependency but now is not). Instead, all visible options
> (possible to select) should be explicitly defined by defconfig to
> avoid what happened with DEBUG_FS.

While I agree that would fix the issue, it would revert to the situation
before we had savedefconfig. Hence it would cause much more churn to the
checked-in defconfig files, which is the reason why savedefconfig was
introduced in the first place....

> I assume here that when removing
> non-visible options from dependency, all defconfigs would be updated.

I'm afraid that part will never happen...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
