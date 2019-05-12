Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5892EC04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 00:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259C820657
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 00:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="haKSxF+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfELAMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 20:12:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35745 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfELAMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 20:12:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id t87so5184485pfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 17:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y8+fw8I1ApGmaw/OLwHaGigKZmnm+yTygMk8BjKay9A=;
        b=haKSxF+A4OyWeeLByqdc0zPwZjI5znt+/ESISP8jr4aTkGwht+7Ppn9o26cZfioEFM
         ymmW0tJAxRCxtOALa86uVByBbkFtGRjOfHDptqEKgo0D6F4mU0+YA71cVU4tiwJIEq6z
         KHLXvfZaT3M1wOZrjxyuuT19hl1i745NYKDTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y8+fw8I1ApGmaw/OLwHaGigKZmnm+yTygMk8BjKay9A=;
        b=BzvLT4ddH84fGFJzq35sbKWcPuoNQSWgb1IJRqrLaE7XxoMjx3bpQbYrmnx9cbdbpC
         QookGyUj8b5FJ++JYwAiRGSBx6D1OzuZ/o1ouSTzGXmkvjMDSoyW+FVM3QT0wsCz/pwk
         435nX9EQJB83o63uwUfr/A30kWLI1jHN4AKAKLyciuU9+n5HzTK6VBlAMRR3jWWq5ZGt
         Qe2A44l/nXQtJcxQJqzdW2VcNYRjqDchJFKmRZLYIZAbKtIM7grKyP535eRCK4X7Fsbg
         swy9MxI3mk/FZyhZO3rAJQhv9ssYjnXHwaPen2rGgiUPS1EJXT06gUUCUNCHo+55fqSZ
         5o+Q==
X-Gm-Message-State: APjAAAVdT42qBaqHguN8R2mgfeixReNL1w7rvGDpBrN3tawDLff8A3O8
        Stpd4EJfrvRQ5Ao7i4xIqfjtyQ==
X-Google-Smtp-Source: APXvYqwSY7m0FPhEjnXbwPttmHAJ8p2ZLHyh/m6bPkr9/xLaiz0H+W7ufbcjyMrYD2AQQnoch2iHow==
X-Received: by 2002:a62:e101:: with SMTP id q1mr24929478pfh.160.1557619963312;
        Sat, 11 May 2019 17:12:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y10sm9439481pff.4.2019.05.11.17.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 May 2019 17:12:42 -0700 (PDT)
Date:   Sat, 11 May 2019 17:12:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <201905111703.5998DF5F@keescook>
References: <20190502164524.GB115950@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6F523@IRSMSX102.ger.corp.intel.com>
 <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
 <20190508113239.GA33324@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C762F7@IRSMSX102.ger.corp.intel.com>
 <20190509055915.GA58462@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
 <20190509084352.GA96236@gmail.com>
 <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 03:45:19PM -0700, Andy Lutomirski wrote:
> ISTM maybe a better first step would be to make get_random_bytes() be
> much faster? :)

I'm not opposed to that, but I want to make sure we don't break it for
"real" crypto uses...

I still think just using something very simply like rdtsc would be
good enough. This isn't meant to be a perfect defense: it's meant to
disrupt the ability to trivially predict (usually another thread's)
stack offset. And any sufficiently well-positioned local attacker can
defeat this no matter what the entropy source, given how small the number
of bits actually ends up being, assuming they can just keep launching
whatever they're trying to attack. (They can just hold still and try the
same offset until the randomness aligns: but that comes back to us also
needing a brute-force exec deterance, which is a separate subject...)

The entropy source bikeshedding doesn't seem helpful given how few bits
we're dealing with.

-- 
Kees Cook
