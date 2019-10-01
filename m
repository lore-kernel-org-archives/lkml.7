Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9707C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6432168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569950101;
	bh=O1XhKT9SpICuFEX4cta8iDmCH+T0Gf/goqoQlQVedjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ma0kfEC6DgBeofNdL/iK0UI183SHcw3r3C3HzWPUrGBoj7FHjUhTgKmHmkZnEiTzB
	 a2zCg+0llKl6YIjecSRflxrCjvmpuIVM+btKmwQx8xa7tmu3aAk71STB3wnWpQu0Z7
	 dpyQt0HvXZaoA25fsaMUfaJLG8bIU3D0NHTLTDI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfJARPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:15:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42681 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfJARPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:15:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id c195so10504542lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEuCxhcjsGTl2dAs2lSougJ6NsHoyENBtaiEDpg0vW0=;
        b=CAOrEjWfrgxQe1kRn7vPNyNDDhxcOBYHgGpKgiFUvC+8Xh0bryCl/hbhQcREBq7Lqy
         Di8Nvc8kr3Fdq7b6vyveiKmeu5qc4iGpH0q5xoUQXQkYJhnbf5ha2ZaOQBPrhPXgLE8d
         HNVn8AUmqP4MQqP5rQ+BB5vG46fYP7i6BWsnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEuCxhcjsGTl2dAs2lSougJ6NsHoyENBtaiEDpg0vW0=;
        b=kAGsyu+oA6aZmIg0uyRWAaig4TItus2AY0/fp2eNbyWVWm+aRiaAV5GWBPEuzixUWE
         VDSTM/xNJKC9ShqaccBXFOhblxDPaRBjZeYd/TwcvgzzR6oYzSMmT8TuBEQt1nAus27z
         2z2tTWp5Zuqs9HwKiG7Ce9jttMnkBHaVacWUig4UwA7+TW8fA9+WlqdxZ4ES/NuwD6sD
         ESXKYrZlFQXqB11S5gs0tqLY4uRJfgeVoXgWvVLesQhnGD9p7LYkZACUs23CprsC2DLS
         L13yM25GwJ/wg6oDpHmXmFmQPk6fDtyV7sG4fv8uF67FFTOtWi6GwRc2UG4zt/F+Rzsh
         DxZg==
X-Gm-Message-State: APjAAAVub7DZA5aLWJeuCXJD0MkC5x+RlRoSBXaKKw+R/1Eb6pwr0Otf
        w+RKq09zaLTaV0DehWXx7lPubN7NGEE=
X-Google-Smtp-Source: APXvYqxbe2LHjvek5OhWsjvXcr64R5P+EFue5WOGZdayqZ9OtT1bW56pj6PMvWRbCXiNmpypSypkrg==
X-Received: by 2002:a19:ca07:: with SMTP id a7mr16872622lfg.181.1569950097981;
        Tue, 01 Oct 2019 10:14:57 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id d26sm4100842ljc.64.2019.10.01.10.14.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 10:14:57 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 7so14198426ljw.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:14:56 -0700 (PDT)
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr16622987lja.180.1569950096519;
 Tue, 01 Oct 2019 10:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <CAHk-=whKhD-GniDqpRhhF=V2cSxThX56NAdkAUoBkbp0mW5=LA@mail.gmail.com>
 <20190930061014.GC29694@zn.tnic> <CAHk-=wjfLfnOyGkHM+ZRn6bc6JD6CU3Ewix3cJDqCqjbMO5PNA@mail.gmail.com>
 <20191001135108.GD5390@zn.tnic>
In-Reply-To: <20191001135108.GD5390@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Oct 2019 10:14:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-rUBFjJ-p-65DhX+uOHuoUcf2=XtxwEUOPqojw7vEUw@mail.gmail.com>
Message-ID: <CAHk-=wh-rUBFjJ-p-65DhX+uOHuoUcf2=XtxwEUOPqojw7vEUw@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 6:51 AM Borislav Petkov <bp@alien8.de> wrote:
>
> So when I add this by hand and do git diff, it adds a second hunk:

You and me both.

We both have editors that always add line-endings, and right now that
file doesn't have a newline at the end of the file thanks to commit
428826f5358c ("fdt: add support for rng-seed").


> and I kinda get what it is trying to tell me but this is new. And when I
> do
>
> $ xxd drivers/char/random.c
> ..
>
> 000125e0: 646f 6d6e 6573 7329 3b0a                 domness);.
>
> there's a 0xa at the end so what's git really trying to tell me?

The previous state of the file didn't have that 0xa at the end, so you get that


  -EXPORT_SYMBOL_GPL(add_bootloader_randomness);
  \ No newline at end of file
  +EXPORT_SYMBOL_GPL(add_bootloader_randomness);

which is "the '-' line doesn't have a newline, the '+' line does" marker.

> > Doing something like the above to /dev/urandom is likely the right
> > thing to do eventually, but I didn't want to mix up "we can perhaps
> > improve the urandom situation too" with the basic "let's fix the boot
> > problem". The urandom behavior change would be a separate thing.
>
> So make it a separate patch and let's hammer on it during the next weeks
> and see what happens?

Yeah, probably.

> > Also, talking about "future changes". Right now
> > "try_to_generate_entropy()" is actually uninterruptible once it gets
> > started. I think we should add a test for signal_pending() too, but it
>
> Wouldn't that even increase its entropy, which would be a good thing?

I'm not sure it increases it, but it certainly shouldn't make it any worse.

                  Linus
