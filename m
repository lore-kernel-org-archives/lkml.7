Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFBDC352A9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 01:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FFD21906
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569806436;
	bh=B28xnNiYAiGAaP7AhsCZHzZYt2xKHOPjSq3aQeAA9+o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EER5apdSWM9T6VFJQ63se6ZvDu1xhg07DwpV3oqrdUcnWrnH9Vbtil/bRsre9DYRL
	 iKA6shs3CTuCtUO+ZO4iYRkJqjUw5LHDg+vNk/TkIdfCCzbO1zefnKUK7c0s716r1d
	 lMcanYyicytzCzVDQzoBMNaSlGJAOoecO6ql2cmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfI3BQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 21:16:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36208 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3BQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 21:16:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id x80so5729391lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 18:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OStn3A8XRbnEfI71UUE4yVSkm+2U9S4IJIR3YZunIa8=;
        b=NXyBIBloVeIZL7SxyBQNtnDx/LQgEPT2tcB8WqFj9hd7uFstu2xRSHRF18908ykPiN
         Irluv5r2DT8bSW+MV2afzkAR18XW3EkZUfTn/pox8jg3Oc3rK+mK1Pio5UwibMlJpTrw
         7wUNQ8EjSNEYYBuZZgNTf9/HpUIcwq18e4XN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OStn3A8XRbnEfI71UUE4yVSkm+2U9S4IJIR3YZunIa8=;
        b=XrHgfvyhC7zr+S6h6MACQB8YVHkQN5jAv1ye5pY+z5fh6mZBFZs3sFyyx43XtF+jkW
         29ITHIToH2kCVwrVD342obbcRk3nBMyr3DYzeIEi3dFL006z3XnM8rZT3RJwFHbNNaQ9
         9j0Q3zg51Gxtbma4CxVfaSYDkG4S+di8Nbod+ziJ0tJl8r3aZAgOiqrFLbCvxAjN+FcA
         p3YngqqSvcR0CFFWS546oqFZmp8GoqwXl6hHKOMDil0oxRNo+wzTMsTpM88gIJiWDPvd
         UIso5fCtJNSw/jgt4ckgXW27CK9egScLmKC0rnND6/WSanzjB+73ucs1xwnMT24KNo64
         yLGg==
X-Gm-Message-State: APjAAAV/OFB3HsniUEp4c7235j32TGIrKcvkRMrchv3NxQlMsc423FIG
        qwBavLST1R1gLNqspF5+s1HNVysNBH8=
X-Google-Smtp-Source: APXvYqzxgAMzGEqjvzFWkpid7r0CZuoTuEJ8oBrK6rsEzMuT8qZ0Ybnjvx7OqKQPdaD/vEDnTifH4A==
X-Received: by 2002:ac2:46ee:: with SMTP id q14mr8858859lfo.152.1569806210765;
        Sun, 29 Sep 2019 18:16:50 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id c18sm3548982ljd.27.2019.09.29.18.16.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2019 18:16:50 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id a22so7662117ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 18:16:49 -0700 (PDT)
X-Received: by 2002:a2e:3015:: with SMTP id w21mr10202435ljw.165.1569806209417;
 Sun, 29 Sep 2019 18:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de> <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
In-Reply-To: <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Sep 2019 18:16:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
Message-ID: <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

On Sat, Sep 28, 2019 at 4:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But hey, here's a made-up patch. It basically does jitter entropy, but
> it uses a more complex load than the fibonacci LFSR folding: it calls
> "schedule()" in a loop, and it sets up a timer to fire.

Ok, I'm sure a lot of people will end up finding this distasteful, and
I'll admit to just waffling about it myself.

But I am supposed to close the merge window today, and honestly, I
want _something_ to happen about the getrandom() issue during the 5.4
merge cycle.

So I had a few choices

 - just ignore things and hope some consensus happens

 - start the movement to a new getrandom() interface and encourage
user space to say "yeah, I don't need _secure_ random numbers"

 - or just say "hey, a lot of people find jitter entropy reasonable,
so let's just try this".

And I went with that last choice. If it works, it makes the
getrandom() interface changes a non-issue.

I'm not saying my patch is going to be the last word on the issue. I'm
_personally_ ok with it and believe it's not crazy, and if it then
makes serious people go "Eww" and send some improvements to it, then
it has served its purpose.

But I've committed that patch and the revert of the ext4 revert to a
local branch, I'll do some basic testing of it (which honestly on my
machines are kind of pointless, since all of them support rdrand), but
assuming it passes the basic smoke tests - and I expect it to - I'll
merge it for rc1.

I also have my old readdir branch that I decided I want to merge due
to the (completely independent) discussion about filldir issues, so
I'll probably end up delaying rc1 until tomorrow, but just a heads up.
I don't want to leave this until "some time later in the -rc series",
although I will be _more_ than happy to have people send me fixes to
my somewhat simplistic patch.

That said, my patch may be simplistic, but I suspect using a loop with
a real load like schedule() and arming a timer is a lot more realistic
than some of the jitter entropy papers with their _very_ trivial
LFSR's and some made-up pointer chasing.

But yeah, I think improvements to it are also not unexpected or unreasonable ;)

              Linus
