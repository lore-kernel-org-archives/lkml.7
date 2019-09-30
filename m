Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726A5C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA1C224FE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 20:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NmmtdnRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfI3Urm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 16:47:42 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:33119 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3Urm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:47:42 -0400
Received: by mail-io1-f49.google.com with SMTP id z19so42109170ior.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xVE7UhrvOn/gSJ8sR6VSbxHfHmyx3hbL0Hq7OBVF+qs=;
        b=NmmtdnRNpJGvs1EGQkSFVydi8Yfuu/G4fbedduH4jOUM+zUpCagbcZBWf9xrOtvHJ2
         838PUD1dxGSbZDAIShIumwHq3Pi3JlqBuyWDv7Is2VuNrP7mD5jWfjwKP++YOzvEQGpI
         m9WG5M1zzY5L+HPTxS8Di+i1ecZqpAkUFWkb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVE7UhrvOn/gSJ8sR6VSbxHfHmyx3hbL0Hq7OBVF+qs=;
        b=P6+sS6zVWdyd6phi09wqUqyHbcog0dssO8phHSdEtJsybeW5VAAVTntqVC53JY0iB4
         frvPuTNu01mXPRli0oj2rurjbD6Qe8rXAQxPH++iE+fpIZD6MdNgQ3ank6Su1Izab6Mu
         bcJaJXpxY4B28C8BILim0yf4R166FCtez9CvE05dYNwzNVAcfcy44RSFjO52drVb7GA8
         Ix+P8urWiCYEBIGQS4WgU6zfN0gui+Z9xdFnAo0rxLXxJQ4DYCZUGtM46BqPAQ0w2L7s
         DJbz4KdHKDDR+dNBblMsvB0xWErj5vbXyC1A8bA9VJfPjFKSsgZFra62beEnO5eiqJSt
         xetA==
X-Gm-Message-State: APjAAAUxYjjdSW/LJ5yAN/9AKBARA8owPS0R0MSw4nTs2bsR82w8zZc7
        wFMpoGWeB5fcPr76KkwQHPk2pqnkgk8=
X-Google-Smtp-Source: APXvYqzt8KCP+v3EQ6jxpJhI/Ik/ikaaZvJfTSFfX3rpR4ycYZhpUDVrE0XihtpcoeJ5Gm87okLXhg==
X-Received: by 2002:a63:2301:: with SMTP id j1mr25533599pgj.411.1569866722202;
        Mon, 30 Sep 2019 11:05:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h1sm13176567pfk.124.2019.09.30.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 11:05:21 -0700 (PDT)
Date:   Mon, 30 Sep 2019 11:05:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <201909301054.4E4F12B6D7@keescook>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <CAHk-=whKhD-GniDqpRhhF=V2cSxThX56NAdkAUoBkbp0mW5=LA@mail.gmail.com>
 <20190930061014.GC29694@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930061014.GC29694@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 08:10:15AM +0200, Borislav Petkov wrote:
> On Sun, Sep 29, 2019 at 07:59:19PM -0700, Linus Torvalds wrote:
> > All my smoke testing looked fine - I disabled trusting the CPU, I
> > increased the required entropy a lot, and to actually trigger the
> > lockup issue without the broken user space, I made /dev/urandom do
> > that "wait for entropy" thing too.
> 
> Hohum, seems to get rid of the longish delay during boot on my test
> boxes here:

Yes; for me too. This makes a huge difference in my ARM emulation
environments (where I wasn't using virtio-rng-device). Those VMs were
very boot entropy starved -- I was waiting minutes for sshd to start.

I doubt running something like dieharder on urandom would actually show
any deficiencies, but I've started a test up anyway. I'll yell in a few
hours if it actually has something bad to say. :)

-- 
Kees Cook
