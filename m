Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDBBC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A6620726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuAuAaWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfLITYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:24:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52661 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfLITYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:24:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so560792wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 11:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jyxu52lJ82wz6kUvOXMHO9X6LCKML6pCq+dZRSdiz3g=;
        b=RuAuAaWNc4+4r15qBvDkEC8cXwqOvhP3j5BB4UPmrMpBsYLuHmZUNUMpcxR2Lvu7cu
         DRtzPLrQRvqDzNj1qFoDc4YLkdfiALI3Qi0plhuM/iqG3mr9D1zOvQeAUV7m7XaMBhww
         Tvtdz9GKICDtBJouWvb7QHknXYCB4wC0sEqhIrwjDDKENLFSO155m6feK6JeR66BRazC
         zRDwWKpXavbCD7yVsgnOwEBYsTD7HMH4kU+a9zXe57Sc4992shwhCUNkDwGqkehz1WNy
         D00Z5wPGnqj+mFr1w39OosPkE0EU5o5slb4TUwsv+QCGrl3fxGgP8c4ynrD08sql2JUo
         Uc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jyxu52lJ82wz6kUvOXMHO9X6LCKML6pCq+dZRSdiz3g=;
        b=PWpbVfXIC8ZzhWz/AX1oUR/HqhYgM2/aOPIWHjfkXgDeH8PK2MPNtQyGHrsROt2nZj
         FQ7XJy9EfWbqlE7r3yXFdXb2KXEAKMektTTFCNo4VbN3Zip7UIclmZRZpdUm8abY/fff
         mZvstiT9KtCviE138edKLaosWusqCCPC9xcjjrN7Hy0DG95ZsQfZYBbxJ/Fl8yj/8dkx
         ersWi8O6kO08gGQHeRpZi+lb2TMrXwnyidoyAadvyE3MRIiCLDQFi8vBoqs/p2sbq562
         Xct2YbUbCNIaD4xGcQsvAG8eZa0pyThFSigaj6NaohAAQrioLgIj2HIvfajYln1Qm48t
         SW2A==
X-Gm-Message-State: APjAAAWPkGpRUSds/G12xtSTVG/97hFJ6MTBZFMt26hNLH6/qkTWNoNM
        RQvGYi8RdJoWJP7Fhkw7nqrPi2pu9J103a3iikUFOQ==
X-Google-Smtp-Source: APXvYqzw3L2TTghU6RShL3uFA+/NTaC1vOxlI6Z98m/WSY70sybkzPgyqmV8nSDV45bLdelQdjFjnWDSGmzOR7X5o2c=
X-Received: by 2002:a05:600c:3ca:: with SMTP id z10mr677323wmd.148.1575919455265;
 Mon, 09 Dec 2019 11:24:15 -0800 (PST)
MIME-Version: 1.0
References: <20191206165542.31469-1-ardb@kernel.org> <20191206165542.31469-7-ardb@kernel.org>
 <20191209191242.GA3075464@rani.riverdale.lan>
In-Reply-To: <20191209191242.GA3075464@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 9 Dec 2019 19:24:13 +0000
Message-ID: <CAKv+Gu8QWcSwRajsO5voTQJxDHy613ugCd_R6=SStf9ABrmtfQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] efi/earlycon: Remap entire framebuffer after page initialization
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 at 20:12, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Dec 06, 2019 at 04:55:42PM +0000, Ard Biesheuvel wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > When commit 69c1f396f25b
> >
> >   "efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation"
> >
> > moved the x86 specific EFI earlyprintk implementation to a shared location,
> > it also tweaked the behaviour. In particular, it dropped a trick with full
> > framebuffer remapping after page initialization, leading to two regressions:
> > 1) very slow scrolling after page initialization,
> > 2) kernel hang when the 'keep_bootcon' command line argument is passed.
> >
> > Putting the tweak back fixes #2 and mitigates #1, i.e., it limits the slow
> > behavior to the early boot stages, presumably due to eliminating heavy
> > map()/unmap() operations per each pixel line on the screen.
> >
>
> Could the efi earlycon have an interaction with PCI resource allocation,
> similar to what commit dcf8f5ce3165 ("drivers/fbdev/efifb: Allow BAR to
> be moved instead of claiming it") fixed for efifb?

Yes. If the BAR gets moved, things will break. This is mostly an issue
for the keep_bootcon case, but that is documented as being a debug
feature specifically for addressing console initialization related
issues. Earlycon itself is also a debug feature, so if you hit the BAR
reallocation issue, you're simply out of luck. Note that this happens
rarely in practice, only on non-x86 systems where the firmware and the
kernel have very different policies regarding BAR allocation, and on
DT based systems, you can force the OS to honour the existing
allocation by using linux,pci-probe-only
