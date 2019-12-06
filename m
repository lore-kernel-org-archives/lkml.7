Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387D8C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F122464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="PMP8XJvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLFQXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:23:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37582 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfLFQXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:23:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so7942998wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fdPlznXjsegEiAPYnd0HK7CV3hab9ZO87Ii/Lizh6WE=;
        b=PMP8XJvcJDVfVU//ePjm6Du7LzjMC5qbbnQOVa5H1FaRZARVngl8tHBqkedQYDI1iR
         VdQtTm8G4ZVeqpqsyKoXSWomDfoYHZAzART67qQxmCrJ7AXx+0w53Qw+Qo5+3/XaL/YD
         SsfFD9oSuSop9Ee2wb94p511OUk5Q+nLRQONesFmDhapfmyVgTFP3z6/eQe7l8ewS8Ru
         5bLY39ghP3r4Zsohk4KQXsyKrpNJ8hNwPlkfxfoJmaI94cjua3jM46mmUlNsJrsyuRQ+
         qBwngECftopDIfJbkfNEYwLHLfcC1VRAZ7gfNdkqUSneYu+bzgaekbldDzEq7nw52NSk
         L/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fdPlznXjsegEiAPYnd0HK7CV3hab9ZO87Ii/Lizh6WE=;
        b=kn+B5Lc45WqW8AWu/RzVAX0fRJubWbzo/OUWi/4Cn+N5e9MAI2uij7LaNiiKK+sl7w
         LbvSodlYRCRc8lQM002j0afz6RSVnV6tWVJadjdpaWGytRZ/5ozGOBopYy30XdWA0SGg
         HRyaHEmXD4do2RIgXpWjHNhygIxK0DHpG9moRXBrHJifyXEsuhZdLsV7WEOKdRhXec9H
         LTyZP2hoJErTzmmxFCkX31Iu3kVgKjfDQO57XnzXVkgz4pod6lU3igbqU4odoXdCagXj
         kpadu9hIWCXrZ2sgdoO42EFfznbGXLmUDOhlfmtm8UTNX65M0+EgCbnjBMnyrZyOR3AU
         4M2w==
X-Gm-Message-State: APjAAAVrZKbJ51QrRugbvtO5gNREWyKH98wB6G0lDBLZhLZvIQ+OQhPn
        jCIrWsW21KQROHkMnFIZtwOMqhIgK4RujcxlLHSfOa+RlFXdYQ==
X-Google-Smtp-Source: APXvYqxlrk1oUwNtNdjvCVFqCdbzIpGNNGg0lV+vuJwAMAhCUMdoWRis/lgtjqn/SMh4nxyqGXqguHODQqBJ6XHcOPI=
X-Received: by 2002:a1c:9602:: with SMTP id y2mr11253181wmd.23.1575649399094;
 Fri, 06 Dec 2019 08:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20191205174902.4935-1-anup.patel@wdc.com> <20191206090059.vpwku3gsqjtcubf5@holly.lan>
In-Reply-To: <20191206090059.vpwku3gsqjtcubf5@holly.lan>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 6 Dec 2019 21:53:07 +0530
Message-ID: <CAAhSdy0k=1tzGCTdw6jLgj0Rod6VfvNVxkzCqKDaPWc2b6P45w@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Add fragmented config for debug options
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 2:31 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Thu, Dec 05, 2019 at 05:49:18PM +0000, Anup Patel wrote:
> > Various Linux kernel DEBUG options have big performance impact so
> > these should not be enabled in RISC-V normal defconfigs.
> >
> > Instead we should have separate RISC-V fragmented config for enabling
> > these DEBUG options. This way Linux RISC-V kernel can be built for
> > both non-debug and debug purposes using same defconfig.
> >
> > This patch moves additional DEBUG options to extra_debug.config.
> >
> > To configure a non-debug RV64 kernel, we use our normal defconfig:
> >    $ make O=<linux_build_directory> defconfig
> > Wherease to configure a debug RV64 kernel, we use extra_debug.config:
> >    $ make O=<linux_build_directory> defconfig extra_debug.config
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> > Changes since v1:
> >  - Use fragmented .config instead of separate debug defconfigs.
> > ---
> >  arch/riscv/configs/defconfig          | 23 -----------------------
> >  arch/riscv/configs/extra_debug.config | 21 +++++++++++++++++++++
>
> Might be better to call this rv_debug.config (or riscv_debug.config),
> This would imply it is a set of options recommended by riscv
> maintainers and also having a suitable prefix means it is less
> likely to ever conflict with .config files in kernel/configs .

Yes, rv_debug.config seems a better name.

I will wait for more comments before renaming it to rv_debug.config

>
> BTW don't respin the patch on my account. Using a .config file was just
> an idea and I'm not sure it reached consensus on the v1 thread.

Not a problem, actually David Abdurachmanov (SiFive) had also
suggested to use fragmented config for debug options.

Actually, we are seeing 12% performance drop in Hackbench by
having DEBUG options enabled by default in normal defconfigs
so we certainly need to move it out of normal defconfigs. Having
fragmented config for DEBUG options is certainly a clean and
maintainable approach that's why I went ahead with your suggestion.

Regards,
Anup
