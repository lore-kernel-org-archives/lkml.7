Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF5FC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25C12178F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 19:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567884483;
	bh=51vfoY1O2eVVgGBYq7hlwJ3P2n9zjG1bl6lYCskA0Mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aVFR40rhHwrF1S6Q2sIjm/a7MwN73R5R58/ugx1xW40NlcpXwxBW+JG6w0OEQ4zCq
	 QQKj5T0Q9ot4srNDz35Kx9tt5R9JRG7ilR+C93PNd0rMlpWeblskccVEKJ/y+B+A1b
	 NSGyefqdCWX37bfKAFJOKmJDNeEHwtCBAK5++FW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436658AbfIGT2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 15:28:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41522 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436634AbfIGT2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 15:28:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id j4so7572634lfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvf94hkMNtV2tovWa4EFFtQ7MzVwBeT/1I0CJcOizE4=;
        b=WkZOy1pETguk5cMBv//IdgRbCj+4j4/Yht9NxT6MvmEBa1xxabfBAqBSVBZnbNZnil
         LrYbn9LpNxyHN3UYGUlLN47SD7Mb8U6r0nJlHk+vwWghzYWPDyQiyZ99JZWctqnYRW7m
         E/G6gjr0R4ivaEwraD218Wan7lHeLd9u8bc+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvf94hkMNtV2tovWa4EFFtQ7MzVwBeT/1I0CJcOizE4=;
        b=f8GSX9xiJjSNLY/aLvG2i14OuPit8BubF2ybXuImWMzfIH6seo1Ei7WG5nmiXZjYjJ
         PhXM4PDjfXlbaaTRizvhZJUhqZpBZ7kAyzN7ox1eKjyR+sR6RoWXGfZarEpPgYf3Cjnm
         RVHjS5J/HVApy1Dh/oeeLa/H5Yo5S/qfoCCtDrq2gQ5gYw2+sMKRPi2l4NC0vMgYY/Qy
         VHrsvQXkMVMWUTMcGEbsuSpeHKCriiPSlr+P73WClXsS/APQmnhCM6QNntnsTzKeiguG
         TO1K5Jxg4xroMgSMGJj+neu0dnvM7vQkHQlunlMZd8+tisJdRTwCiYj+mtaDfqlvh2hi
         Ie/Q==
X-Gm-Message-State: APjAAAWDpHgjSHf6XFp/5xC4mmFOCvlcBdAhhI8nQ5O2xz/tEQ8CBBUY
        9+luBvoZNdn3t91NxWU+FfLFhIVv0/U=
X-Google-Smtp-Source: APXvYqyTUFaSbek0gw6O/i5YZ6AYN1h/JpyonVVVa5FpU26iXfqjrnRSVfs5i1y+4c/LkXbwGtWWiQ==
X-Received: by 2002:a19:c709:: with SMTP id x9mr11065446lff.20.1567884478970;
        Sat, 07 Sep 2019 12:27:58 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n24sm1601939ljj.87.2019.09.07.12.27.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2019 12:27:58 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id y23so9014296lje.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 12:27:58 -0700 (PDT)
X-Received: by 2002:a2e:3c14:: with SMTP id j20mr9675480lja.84.1567884477831;
 Sat, 07 Sep 2019 12:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi_nBULUyO=OKtNBCZ+VSqdOcEiUeFqXTQY_D5ga5k4gQ@mail.gmail.com>
 <156785100521.13300.14461504732265570003@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071628420.1902@nanos.tec.linutronix.de>
 <156786727951.13300.15226856788926071603@skylake-alporthouse-com>
 <alpine.DEB.2.21.1909071657430.1902@nanos.tec.linutronix.de> <CAHk-=wikdDMYqhygJYkoWw7YxpGNx7O2kFRxbG91NNeFO7yu3w@mail.gmail.com>
In-Reply-To: <CAHk-=wikdDMYqhygJYkoWw7YxpGNx7O2kFRxbG91NNeFO7yu3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Sep 2019 12:27:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimjeOCi4k7+nhzx3XWzvQUbMtNpcKNo8ZteodQ5c5APg@mail.gmail.com>
Message-ID: <CAHk-=wimjeOCi4k7+nhzx3XWzvQUbMtNpcKNo8ZteodQ5c5APg@mail.gmail.com>
Subject: Re: Linux 5.3-rc7
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Bandan Das <bsd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 12:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm really not clear on why it's a good idea to clear the LDR bits on
> shutdown, and commit 558682b52919 ("x86/apic: Include the LDR when
> clearing out APIC registers") just looks pointless. And now it has
> proven to break some machines.
>
> So why wouldn't we just revert it?

Side note: looking around for the discussion about this patch, at
least one version of the patch from Bandan had

+       if (!x2apic_enabled) {

rather than

+       if (!x2apic_enabled()) {

which meant that whatever Bandan tested at that point was actually a
complete no-op, since "!x2apic_enabled" is never true (it tests a
function pointer against NULL, which it won't be).

Then that was fixed by the time it hit -tip (and eventually my tree),
but it kind of shows how the patch history of this is all
questionable. Further strengthened by a quote from that discussion:

 "this is really a KVM bug but it doesn't hurt to clear out the LDR in
the guest and then, it wouldn't need a hypervisor fix"

and clearly it *does* hurt to clear the LDR in the guest, making the
whole thinking behind the patch wrong and broken. The kernel clearly
_does_ depend on LDR having the right contents.

Now, I still suspect the boot problem then comes from our
cpu0_logical_apicid use mentioned in that previous email, but at this
point I think the proper fix is "revert for now, and we can look at
this as a cleanup with the cpu0_logical_apicid thing for 5.4 instead".

Hmm?

                   Linus
