Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100B8C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB18F21851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFuRkObg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfFNV40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 17:56:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39935 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfFNV4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 17:56:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so3980071wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUPwJUWb0cbPi64d5io+sp15yAFvJIw1A1ix9PCZafU=;
        b=UFuRkObgNzYFwkt84alkzE67Ng+0R2XzLo4vP2JpNTFgbYISojn8Uu+Kfycq0ktWVl
         gVg21S3+EjWzndp45P3C3+ivhSs153czVuVOuSNEp6uXneVtYOVuzoH797In3/zCSJzc
         R+5HM8GjF8E2IqbYkOfurXPtrgfMpX4JDqofLYgXY9vOsEzJFhnK7tPiKVf2oBeXoqrK
         ajcHR09x0A8xfd9UXz3pVfuwxvhDUvTRY9YzN3uBBqdOO2I3LPZkzREWkZN9N3VlTNut
         HQU0IawlCkYTzBK+ZKzVB9QjiHuZD1H4X5cM3n43VYVOVvyOmdIoxCMeHGD2ZNyCtqum
         dfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUPwJUWb0cbPi64d5io+sp15yAFvJIw1A1ix9PCZafU=;
        b=Qniq9QxVtYV7UchVk7XnUlYMXiOyJxsyWmJXCcQ/pjMiCjIN49qDbSZHphuYn4ko1F
         Kkb085AiwA+xDnGYRNCGAYdmTaAJJLW1niz1CFQFQJlyI2Vo7SPQmlYOjtgxFg4SEvZF
         sPj45zmjjVJiwBfZXe8d3YrVRLLNawYK38JSZS27TAwuNRxmiHh40Y4ikkCwHBab4lfl
         tM0lx8Qx+ISVnRL+gfdJzDpxt6yDL3lqP1NAx9qNLtVFjsZxVJKuI2i+tOyQ2i6BWnSd
         WGq9Rva3X7ZbfEW+mi5JEbvWJ3/7We4+U0YPbIuPB+ernD19lyVc6Xu9xzXlOhqT/KvA
         F1CQ==
X-Gm-Message-State: APjAAAUyctL9vhoZ4hKRd1re+lbPwyOYVFHNzz1cZFPkXICWSm71phQL
        o8AJttoBUCCCt9GltdJSzSU4eQzSu1fT7TS1ufUJ
X-Google-Smtp-Source: APXvYqxXIRasRWwFTy04OtRS6QvArITc4ngBSutBNoLD3rNRbqUTl9hhlJYOHWVORGjTVi5ytNq4jGXIKAWHioDZzTQ=
X-Received: by 2002:a05:6000:146:: with SMTP id r6mr53178621wrx.237.1560549380946;
 Fri, 14 Jun 2019 14:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <1560507893-42553-1-git-send-email-john.garry@huawei.com>
 <CAErSpo6jRVDaVvH+9XvzUoEUbHi9_6u+5PcVGVDAmre6Qd0WeQ@mail.gmail.com>
 <CAErSpo6qaMc1O7vgcuCwdDbe4QBcOw83wd7PbuUVS+7GDPgK9Q@mail.gmail.com> <82840955-6365-0b95-6d69-8a2f7c7880af@huawei.com>
In-Reply-To: <82840955-6365-0b95-6d69-8a2f7c7880af@huawei.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 14 Jun 2019 16:56:08 -0500
Message-ID: <CAErSpo5cqJCZjt6QqMNZ6_n=G-_WxFeERnsESOMxsdr1P-6JLg@mail.gmail.com>
Subject: Re: [PATCH v2] bus: hisi_lpc: Don't use devm_kzalloc() to allocate
 logical PIO range
To:     John Garry <john.garry@huawei.com>
Cc:     xuwei5@huawei.com, linuxarm@huawei.com, arm@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        "zhichang.yuan" <zhichang.yuan02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 8:47 AM John Garry <john.garry@huawei.com> wrote:
> On 14/06/2019 14:23, Bjorn Helgaas wrote:
> > On Fri, Jun 14, 2019 at 8:20 AM Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> On Fri, Jun 14, 2019 at 5:26 AM John Garry <john.garry@huawei.com> wrote:
> >>>
> >>> If, after registering a logical PIO range, the driver probe later fails,
> >>> the logical PIO range memory will be released automatically.
> >>>
> >>> This causes an issue, in that the logical PIO range is not unregistered
> >>> (that is not supported) and the released range memory may be later
> >>> referenced
> >>>
> >>> Allocate the logical PIO range with kzalloc() to avoid this potential
> >>> issue.
> >>>
> >>> Fixes: adf38bb0b5956 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
> >>> Signed-off-by: John Garry <john.garry@huawei.com>
> >>> ---
> >>>
> >>> Change to v1:
> >>> - add comment, as advised by Joe Perches
> >>>
> >>> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> >>> index 19d7b6ff2f17..5f0130a693fe 100644
> >>> --- a/drivers/bus/hisi_lpc.c
> >>> +++ b/drivers/bus/hisi_lpc.c
> >>> @@ -599,7 +599,8 @@ static int hisi_lpc_probe(struct platform_device *pdev)
> >>>         if (IS_ERR(lpcdev->membase))
> >>>                 return PTR_ERR(lpcdev->membase);
> >>>
> >>> -       range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
> >>> +       /* Logical PIO may reference 'range' memory even if the probe fails */
> >>> +       range = kzalloc(sizeof(*range), GFP_KERNEL);
> >>
> >> This doesn't feel like the correct way to fix this.  If the probe
> >> fails, everything done by the probe should be undone, including the
> >> allocation and registration of "range".  I don't know what the best
> >> mechanism is, but I'm skeptical about this one.
>
> I understand your concern.
>
> For the logical PIO framework, it was written to match what was done
> originally for PCI IO port management in pci_register_io_range(), cf
> https://elixir.bootlin.com/linux/v4.4.180/source/drivers/of/address.c#L691
>
> That is, no method to unregister ranges. As such, it leaks IO port
> ranges. I can come up with a few guesses why the original PCI IO port
> management author did not add an unregistration method.

I think that was written before the era of support for hot-pluggable
host bridges and loadable drivers for them.

> Anyway, we can work on adding support to unregister regions, at least at
> probe time. It may become more tricky to do this once the host children
> have probed and are accessing the IO port regions.

I think we *do* need support for unregistering regions because we do
claim to support hot-pluggable host bridges, and the I/O port regions
below them should go away when the host bridge does.

Could you just move the logic_pio_register_range() call farther down
in hisi_lpc_probe()?  IIUC, once logic_pio_register_range() returns,
an inb() with the right port number will try to access that port, so
we should be prepared for that, i.e., maybe this in the wrong order to
begin with?

> But, for now, I would like to get this simple fix added to mainline and
> backported.

OK, I don't really like code that looks "obviously wrong" but has
extenuating circumstances that need explanation because it sows
confusion and can get copied elsewhere.  But I'm just kibbitzing here
since I don't maintain this, so it's up to you.

> FYI, there should be no possible further memory leak for continuously
> probing the driver.

That's good.

You might consider a subject line that includes key words like "avoid
use-after-free" or some similar higher-level description that tells
the reader *why* this change is important.

Bjorn

> >>>         if (!range)
> >>>                 return -ENOMEM;
> >>>
> >>> @@ -610,6 +611,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
> >>>         ret = logic_pio_register_range(range);
> >>>         if (ret) {
> >>>                 dev_err(dev, "register IO range failed (%d)!\n", ret);
> >>> +               kfree(range);
> >>>                 return ret;
> >>>         }
> >>>         lpcdev->io_host = range;
> >>> --
> >>> 2.17.1
> >>>
> >
> > .
> >
>
>
