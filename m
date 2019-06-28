Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225EDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB1620656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mYrk7KIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfF1LYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:24:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46994 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfF1LYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:24:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so5770222qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 04:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/Ug5dzWgzAo254GigTyB3K1N9vqEmjljvMsZ1gZJ+s=;
        b=mYrk7KIObHI2/13Kp27Vl24AfH1GeS822BC9Blo1INXT9dMN8zg1hOJrqg0OUujE9r
         o/sACm63p6WZMySZR7m28wnwBaSvEaJE65i+L0PXmSg8id7jHR/maNMUwPP1xoB6OFpK
         d55TI5ehAD9OWc3poyR68Yx5AxYZlp1MwGf0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/Ug5dzWgzAo254GigTyB3K1N9vqEmjljvMsZ1gZJ+s=;
        b=YXkjXUC+C29V6nPhnGA8f7vzQZXiMTwiJVES/huJMPFG/dFw2ltYlE2k2fw7jZZ8S8
         cpYCRyfFI9UkXP1s5/xXs+aLg2EFtz93rpTZqyq9vAflLFmmOIQtjIUcUzq0uojZn/lM
         xZggAJhc/ABFAknr1QzyuzZk6o0/M8K03EuYJzI1v7Td1iV5Zx2U2nX/Z6h4TyjcOxl8
         VyMzxoACQNUqC2kQ+pm5y678zajirpVfJXF8VjONiYAkPJVnTI7aeqOg7KdZxn7Go+hD
         Ke9I/cb28whZXYd0cGiMaui0R21TYD1c0cuKiYcIoyN8QUSJP+DH6avS6coxJv0QsUQw
         y4HA==
X-Gm-Message-State: APjAAAU3z/U3wRNNNAuaqYJB2GiWnzdhXas0JYWgIo18pdbgP/2lDEol
        Y9dpdqSVYd1T4RWhYNApDOb/rRU9uT1UUzIP+ToG4A==
X-Google-Smtp-Source: APXvYqyma+rIlgBTxFdrPMygxhmPVjGgIj7WgGfVJNGUReXJEloaTE7RwdyJzDCp0z57gIOQR4eTrJoCGDnA/EKAxmI=
X-Received: by 2002:ac8:4601:: with SMTP id p1mr7671783qtn.181.1561721051369;
 Fri, 28 Jun 2019 04:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190612043258.166048-1-hsinyi@chromium.org> <20190612043258.166048-3-hsinyi@chromium.org>
 <20190628093529.GB36437@lakrids.cambridge.arm.com>
In-Reply-To: <20190628093529.GB36437@lakrids.cambridge.arm.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 28 Jun 2019 19:23:45 +0800
Message-ID: <CAJMQK-g_9bDHJgKr-qKpQ6HwombB+6Asg_z3r6nv+pC4q4j-Aw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] fdt: add support for rng-seed
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 5:35 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Jun 12, 2019 at 12:33:00PM +0800, Hsin-Yi Wang wrote:
> > Introducing a chosen node, rng-seed, which is an entropy that can be
> > passed to kernel called very early to increase initial device
> > randomness. Bootloader should provide this entropy and the value is
> > read from /chosen/rng-seed in DT.
>
> Could you please elaborate on this?
>
> * What is this initial entropy used by, and why is this important? I
>   assume that devices which can populate this will have a HW RNG that
>   the kernel will eventually make use of.
There are a few discussions here[0]. We basically want to add more
randomness for stack canary when device just boot and not much device
randomness was added.
[0] https://lore.kernel.org/patchwork/patch/1070974/#1268553

On Thu, May 9, 2019 at 1:00 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> This early added entropy is also going to be used for stack canary. At
> the time it's created there's not be much entropy (before
> boot_init_stack_canary(), there's only add_latent_entropy() and
> command_line).
> On arm64, there is a single canary for all tasks. If RNG is weak or
> the seed can be read, it might be easier to figure out the canary.

With newer compilers[1] there will be a per-task canary on arm64[2],
which will improve this situation, but many architectures lack a
per-task canary, unfortunately. I've also recently rearranged the RNG
initialization[3] which should also help with better entropy mixing.
But each of these are kind of band-aids against not having sufficient
initial entropy, which leaves the canary potentially exposed.

-Kees

[1] https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=359c1bf35e3109d2f3882980b47a5eae46123259
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0a1213fa7432778b71a1c0166bf56660a3aab030
[3] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/random.git/commit/?h=dev&id=d55535232c3dbde9a523a9d10d68670f5fe5dec3
>
> * How much entropy is necessary or sufficient?
64 bytes should be enough. But depends on how much bootloader can provide.
>
> * Why is the DT the right mechanism for this?
EFI based systems can inject randomness in early boot. This is aimed
to support DT based systems to also have this feature.

https://github.com/torvalds/linux/commit/636259880a7e7d3446a707dddebc799da94bdd0b#diff-3ded2fe21b37c6f3e86c2a8418507714

Thanks
