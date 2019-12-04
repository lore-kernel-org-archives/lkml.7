Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A898C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF342073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575422128;
	bh=ZEkpuT0z/bBmq6scGtoJ6Khafcm4MHS0w+KUsxg6SP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=V8mglnkbuFuCc8bKvD0oehXIBAWY/huaYjTG8SYqk309tR6htyrgy98hizTZoMRTs
	 xGmwr1iymbDTE0L/Wt7pd7JsS1T4GSF48xtKzbDL6zH9uW2reI5O+LeuvdFMXWsoXM
	 RXG7SGgVo/BS9GodVp0C0HtKijGHeywlQtZn0Xyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLDBP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:15:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfLDBP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:15:27 -0500
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEBF52073B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2019 01:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575422126;
        bh=ZEkpuT0z/bBmq6scGtoJ6Khafcm4MHS0w+KUsxg6SP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cG+4aafv1E8nno0ItzZf943IV1POqdvOU/T2dzdtaGKJHKSGJ+MYyv0gyQpx71RPc
         flDsIyk2ZloOpa42YmyOcF6VgJfjMSReVOU7H7wxtnGH4S8HytgV8c7jQIJ0ooY3g8
         9tR2BH7deynEm0CEyVYs3esoyCU8iJCfpwofwDo4=
Received: by mail-lf1-f43.google.com with SMTP id m30so4637750lfp.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 17:15:25 -0800 (PST)
X-Gm-Message-State: APjAAAWJDRx8VUYzFDYsoO5Okrc6MlBLZ7wmy9Zf2oezN7kSS64i3r38
        Yj3moeyGFaFAu1i6zQOCts4lOn5jXR/v0+YZA7k=
X-Google-Smtp-Source: APXvYqxrRK2dGr2PJpdBKRxMdqxG+or+gwmtEZF6JNNGM3/ofLyVk4KQXXK0Su6IITRWVQMU7JQqmI9ZuB2NvHfHxi0=
X-Received: by 2002:ac2:5dc7:: with SMTP id x7mr472849lfq.24.1575422123956;
 Tue, 03 Dec 2019 17:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20191202211844.19629-1-enric.balletbo@collabora.com>
 <20191202211844.19629-2-enric.balletbo@collabora.com> <CAJKOXPdJSLoEX7+34imGuZ6CEE5unajL=byb+h9VT3Bejc353Q@mail.gmail.com>
 <3355589d-0b0d-f30f-624c-0f781ee9cd8d@collabora.com> <CAJKOXPcrTp7baiPMYaaf_44w+b8GUBWs=X3YTgNZtxJVx0zbgw@mail.gmail.com>
 <CAMuHMdXdWASPa3yr04N5w9jTt3=jC_H20yVpcG1J1_Sx0PRtgA@mail.gmail.com>
In-Reply-To: <CAMuHMdXdWASPa3yr04N5w9jTt3=jC_H20yVpcG1J1_Sx0PRtgA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Dec 2019 09:15:12 +0800
X-Gmail-Original-Message-ID: <CAJKOXPfzYSJdVg_j7MPP14WOve0cJpF+NV2FWWhjGbUEwVWavw@mail.gmail.com>
Message-ID: <CAJKOXPfzYSJdVg_j7MPP14WOve0cJpF+NV2FWWhjGbUEwVWavw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86_64_defconfig: Normalize x86_64 defconfig
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, 3 Dec 2019 at 18:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Krzysztof,
>
> On Tue, Dec 3, 2019 at 10:26 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Tue, 3 Dec 2019 at 17:05, Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> > > On 3/12/19 3:15, Krzysztof Kozlowski wrote:
> > > > On Tue, 3 Dec 2019 at 05:18, Enric Balletbo i Serra
> > > > <enric.balletbo@collabora.com> wrote:
> > > >>
> > > >> make savedefconfig result in some difference, lets normalize the
> > > >> defconfig
> > > >>
> > > >
> > > > No, for two reasons:
> > > > 1. If running savedefconfig at all, split reordering items from
> > > > removal of non needed options. This way we can see exactly what is
> > > > being removed. This patch moves things around so it is not possible to
> > > > understand what exactly you're doing here...
> > >
> > > Ok, makes sense, I can do it, but if you don't really care of having the
> > > defconfig sync with the savedefconfig output for the below reasons or others,
> > > that's fine with me.
> > >
> > > The reason I send the patch is because I think that, at least on some arm
> > > defconfigs, they try to have the defconfig sync with the savedefconfig output,
> > > the idea is to try to make patching the file easier, but I know this is usually
> > > a pain.
> >
> > Till I saw DEBUG_FS removal and Steven's answer, I was all in in such
> > patches from time to time. However now I think it's risky and instead
> > manual cleanup of non-visible symbols is better.
>
> IMHO, it's the maintainer's responsibility to refresh the defconfig(s)
> regularly, from known good config(s).
>
> I.e. you start from a known good .config, run "make oldconfig", verify
> the changes by comparing the .config before/after, and run "make
> savedefconfig" afterwards.
>
> You do not run blindly "make <my>_defconfig && make savedefconfig", as
> that means you'll miss out on new options you may want, and will loose
> old options that are no longer selected by other options.

Instead of keeping this known good config somewhere outside it should
be just equal to defconfig. There is no point to trim it with
savedefconfig and then later experience missing options (because some
option was a dependency but now is not). Instead, all visible options
(possible to select) should be explicitly defined by defconfig to
avoid what happened with DEBUG_FS. I assume here that when removing
non-visible options from dependency, all defconfigs would be updated.

Best regards,
Krzysztof
