Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A232C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED5620835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8LlnsQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfJGUL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:11:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36024 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfJGUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:11:56 -0400
Received: by mail-io1-f68.google.com with SMTP id b136so31529949iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdV5HTN4JZDuKfdhD+OsYsj3d75VR6rtXR3hcKBV4Rw=;
        b=W8LlnsQwC0jEJMtCBhOivrXr0LvXGMzZW2vBbOhrRqnQ0b+rkjtk7semjEvCr2GB1C
         MfI9OrDKuKYyBlywIQK6jN9WcvXVAfsczgXa/GzGNMpvNDnC/u8O7h/8cP6Satp4p0B5
         Sj+xr1TVGCEdaIYZL35m0Y2o0d8dG6K17QDTKNLFvFuKG97MRXshlNI2wAlYtsZIPrSX
         yCiElWoBvO5qoOlgo4SAgvPGV98RxW1iyONZAcibZxjzu5kIlfWaQPgwTqHz4M0PpgoL
         hnzT56af2lfPOimHypt9QJgANyC5xytGoZD0kPgWIefgMP9NNjTnWXyjvpqUoyefcKVs
         AQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdV5HTN4JZDuKfdhD+OsYsj3d75VR6rtXR3hcKBV4Rw=;
        b=ZIMuxYI2gsiI48Bfdc4bUz1xtg46uBiVIK+NSpAWbiiNCO155v+FlLGvc6q5d7RECT
         d/5pprQYGEleaR3JOMt7XPrv7VgB7FIImNYEK786NzPCRqIXV/wMwIcLIEMvJvZ04Br+
         LTKe64ieDEGkD4sP/yHni66wdiXQ3/AeuuO1yU0P2TVu96iEVQVFnJRwVa8O4nQD1H0S
         x9Is3bpgjcrzERXzciQhrAQv5dQ5bQX1HXQZgyezkmUyrfDCoOHj+/BzKH+k6rI1Lwpn
         rpcAb7qvatqBvCS7SwvvDx6EUbrwQoZXkI+ppJVQorLf6Kba7qcUw1X8WPE4EwsqVGzQ
         og5Q==
X-Gm-Message-State: APjAAAVeSmC7vyqO46dhFaczwucllsC6o8DxPieoUELEGZoVWuCNSzOM
        Heubxp+x2x28BqoSA4Fk6EHZKrZ+FoyBv/h9lZ9/jDv4tUY=
X-Google-Smtp-Source: APXvYqzLT5M0O9WcSSTD7MR6fcBnm4pKLmjJQlxCNzf1+n4khnsYPCeIHxMUoEI5MhXL6umDPklkoPaLgdZkHFKS34w=
X-Received: by 2002:a92:da41:: with SMTP id p1mr29336727ilq.36.1570479115671;
 Mon, 07 Oct 2019 13:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+szGtvxCo9he+pYjvMjVkMqBHLrXh6gNM4AHRYUWXQp_LnOw@mail.gmail.com>
 <CAHk-=wiK0Mmo-9qkuoBj4Syx_q9Lbn-ZZLb8BGpvuCf8OHjMgQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiK0Mmo-9qkuoBj4Syx_q9Lbn-ZZLb8BGpvuCf8OHjMgQ@mail.gmail.com>
From:   Francis M <fmcbra@gmail.com>
Date:   Mon, 7 Oct 2019 21:11:45 +0100
Message-ID: <CAO+szGvTSy5m6d219X3=i+mXgEVTfaLYKtgXESEKJu8TDZXBGA@mail.gmail.com>
Subject: Re: Decoding an oops
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 at 20:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Oct 7, 2019 at 7:58 AM Francis M <fmcbra@gmail.com> wrote:
> >
> > Attached is a JPEG of what I've been able to capture from the console.
> > I'm guessing it's probably not enough to go on, but hoping someone
> > might have an 'ahh, that looks familiar' moment.
>
> That is an awkwardly small snippet and not showing any of the real
> oops state at all (the code/rip dump is actually the user space state
> at the time of the system call that then causes the problem).

I was pretty sure it'd turn out to be worthless, cheers for
confirming ;)

> Can you make your VM use a bigger terminal so that it shows more of
> the oops? Assuming your virtual environment supports the usual VESA
> VGA modes, it might be as easy as just booting with "vga=775" to get a
> 1280x1024 console.

I forgot about the old VGA mode parameters. Have had trouble
(read: zero luck) getting a high-res console for this VM from grub
through to kernel boot since it was provisioned, but I'll give the
above a shot once I've got the disc images safely backed up.

Have gleaned a small nugget more of stack which might help
down the road if this turns out to be VirtualBox-specific: I'm
reliably seeing "vbg_*" (drivers/virt/vboxguest/) stack frames
very early in the oops but they're scrolling way too fast for me
to snap a photo with my mobile. Maybe stack corruption,
maybe not. Pretty sure the VM is using mainline vboxguest.

Anyway, I'll try and glean as much info as I can with vga= and /
or delayed "printk()".

Should note in case the Oracle devs see this, this is a Win 10 Pro
host, 2019 Core i7, running VirtualBox 6.x. I'll haul this bug 'report'
upstream if further analysis points to vboxguest.

Cheers,
Francis
