Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3C1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0E220661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551883372;
	bh=qCIJOb71XifbAfTijNXMnEgj3SZJ+Dmncf3rNZhdpW0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SqayixjyGfKphluJd5GkLPHDD5U6qsBuh0vX2W/6+7HPmW+ZbZWsLr0E4OtcRqm1+
	 3d3ScIABX6CQfxUxMdCVACht0mvBdSdj3KD3/QcVdBfsv7V66v/FoGKePMTnPWG0nF
	 QgYqpB/GhCeQIJJ3mt5inrgx7xEPOuluE4CiGTjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfCFOmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:42:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36198 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfCFOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:42:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id v10so11102569lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 06:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocVqGt0e2wak6Ia5gTv5IFu4sD2q98MawTfHV8Uvo50=;
        b=PTIcjuZUXg2i7g8f11aKcAtH52M9/abQe7Kn4HwYsXNLIW/WJBtcUKwKbJQbIbaH8J
         aG9IVtCqzVUg4pqXJcZTS8ZdVHPiRhb2yh4YELCRMOhlB2EzibXCpG8zAth14KKwNXwa
         7WY7gVOGyApf9VUamcR0yv7XxUFlST0I5fE6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocVqGt0e2wak6Ia5gTv5IFu4sD2q98MawTfHV8Uvo50=;
        b=bcw+CKCXXgAZa8a+T0uBE4Y4DOs9dZXQyJ2NyU0sSY2K9J8pTbT3VTMQAGv+WFAXlJ
         puMqzPJHi6i++s7bCu4Gp0GMznb5F0rV7pNa5ZeByZ3wrpR/W6PrXsX8d5ucv7Hoas6g
         j+vKsWwp0vfvg6WvFjuGf9jEouSC8ulcBwNEEMwOUG9fm01QniMSkigebXl2akSbj9S8
         S0B3ng5wookUQFGtWrOTZIHmjx+hnNBBDHPNpPJLqMo3/2j3njVysbciDBeMmEQ3AEXz
         7fjt4BfCyqi6s4i3+5C8gCeZKxkkKhJmEEPoYUrkJjf2wsPqChoyNVI2pSozcoe+pCeA
         aajw==
X-Gm-Message-State: APjAAAUxG4lc7dImMpaHCfl4B+EAAZNsNVU47+uAYJm85oo+zWg6APcV
        PHufhpTudGOnTip8EkcFy13qg1Zrz5Q=
X-Google-Smtp-Source: APXvYqzHSGR77lqQXJozbE/tZKbW013ynzqSUkXkRPAZvX4TMnoradLE/9zl9v6cWlrcrqG2XK5b3Q==
X-Received: by 2002:a2e:4d7:: with SMTP id a84mr2629044ljf.86.1551883367672;
        Wed, 06 Mar 2019 06:42:47 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id r18sm363297ljd.35.2019.03.06.06.42.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 06:42:46 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id q128so11083147ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 06:42:46 -0800 (PST)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr2671139lji.135.1551883366150;
 Wed, 06 Mar 2019 06:42:46 -0800 (PST)
MIME-Version: 1.0
References: <20190305120301.GA93284@gmail.com> <CAHk-=wiM4_0ZDDAcN0nJ8TsK+MnO1ObmSH4nTvrirA5nenFTHA@mail.gmail.com>
 <20190306070836.GA111385@gmail.com>
In-Reply-To: <20190306070836.GA111385@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 06:42:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVkir377S9fbWjxpYqVDUx0NphLb6YhL-Q=JP-u-GcOw@mail.gmail.com>
Message-ID: <CAHk-=wgVkir377S9fbWjxpYqVDUx0NphLb6YhL-Q=JP-u-GcOw@mail.gmail.com>
Subject: Re: [GIT PULL] RCU updates for v5.1
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 11:08 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. I think this made my build time explode.
>
> Could it be the locking tree?

No, I hadn't pulled that yet.

And it looks like it was a false alarm anyway. Sorry for the noise.

                         Linus
