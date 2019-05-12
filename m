Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1C8C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677372146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557648173;
	bh=tLFKkBC3yj+IjTDmFVxQeinzN1aQkBvFJVM8INnyVBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZQWAwAxIVAjeopdDB/lq/ObryVSvZSdwE6b92+KeKCGKZVU8Cbl+9FZ1vR/Me23jl
	 aUDb3oKiE6TNx1TiEwmFxHIK48lwzdMwtB6JF1amShX9FaJ3q05cZm6dhjz6BgjQkO
	 UAJxlFTmvedINxytPP1P/BU1pv43IjowHdjmxLKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfELICw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 04:02:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34623 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfELICv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 04:02:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id m20so9069038wmg.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=az2NvBw/j6sKFx3ItUU3E4tKs04UFXT+eEsNSTjgcOk=;
        b=MtG+xbcXBmHQ4IcxpcWKC11SCKZq+OSTqMHyXCPi3JpftuK38K7VD3qLs9v7st1HUT
         KJslOQ3ydVQtYDnWPOnUn74A2rmXAspsgG4ef+88P39xZiYN/ow6lLsJOH5w3gMZY9Nj
         gY3aNEThPCg8C+wk+VHUlSyLqq33JIrWrP7560qtrREcwChnxmckl5RJ4I8zMr4/GgNU
         nYwGRjPdwu2BZ4ou5myfZIx1EWlV08tKcnX3BVPQ6Ac/pi6YYU0yP+FPO+PMvXDnFGTm
         ieyt1XWOzRBdJpi6/4vBzXEcOr8KStrptVcwSmEj+bLl4j05vePYfEJURfCHNn3gqGGZ
         bvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=az2NvBw/j6sKFx3ItUU3E4tKs04UFXT+eEsNSTjgcOk=;
        b=lGHtbnbFw9u+ZGu6+0dX1WntNOcZPCNWLUiHbL8PWhwyDzBYZGcBpCNaDIuTp2CVGc
         RDsyjRh8JakbWWrq0WmvZiSbJ4oKJ9Wm5SI2v78375AlsveOasxnvQRlofIORqmcVW50
         EBqZHDQ6uXO6by7+afw6TVhaXKtBpPGMkg+YtRSNA9IjVNBPnwVxNUUgOHlP2F8QnlLD
         SfbP7MAD85NAX3j9p7RfxSj9TYrVH3REQMBv04Gwk6OqE9fr5O5sh2JL9v2RqiNvTmvG
         Kg+1Junket1QZOA6NBNScHYm/8Bex6ror57/+GOIuiJG+QMNA1pQiGOq4ilCc71ZhUt+
         A8HA==
X-Gm-Message-State: APjAAAW+9sKMHsvDbQ1l6bmNe/LLnl6SWXZStiJsbuuXhP5tsJcQRva1
        XadWAIoy/2S07w/ZHInyaUU=
X-Google-Smtp-Source: APXvYqxVXN7MHSj6wajDWsQfPzO42N7IX3nfYdRVBUuuioVQgP5x4hpPPyK3lHc3ny/5d82FAfWrew==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr11686869wmd.30.1557648169896;
        Sun, 12 May 2019 01:02:49 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l14sm7040797wrt.57.2019.05.12.01.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 01:02:48 -0700 (PDT)
Date:   Sun, 12 May 2019 10:02:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20190512080245.GA7827@gmail.com>
References: <2236FBA76BA1254E88B949DDB74E612BA4C6F523@IRSMSX102.ger.corp.intel.com>
 <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
 <20190508113239.GA33324@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C762F7@IRSMSX102.ger.corp.intel.com>
 <20190509055915.GA58462@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
 <20190509084352.GA96236@gmail.com>
 <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
 <201905111703.5998DF5F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905111703.5998DF5F@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> On Sat, May 11, 2019 at 03:45:19PM -0700, Andy Lutomirski wrote:
> > ISTM maybe a better first step would be to make get_random_bytes() be
> > much faster? :)
> 
> I'm not opposed to that, but I want to make sure we don't break it for
> "real" crypto uses...

I'm quite sure Andy implied that.

> I still think just using something very simply like rdtsc would be good 
> enough.
>
> This isn't meant to be a perfect defense: it's meant to disrupt the 
> ability to trivially predict (usually another thread's) stack offset. 

But aren't most local kernel exploit attacks against the current task? 
Are there any statistics about this?

> And any sufficiently well-positioned local attacker can defeat this no 
> matter what the entropy source, given how small the number of bits 
> actually ends up being, assuming they can just keep launching whatever 
> they're trying to attack. (They can just hold still and try the same 
> offset until the randomness aligns: but that comes back to us also 
> needing a brute-force exec deterance, which is a separate subject...)
> 
> The entropy source bikeshedding doesn't seem helpful given how few bits 
> we're dealing with.

The low number of bits is still useful in terms of increasing the 
probability of crashing the system if the attacker cannot guess the stack 
offset.

With 5 bits there's a ~96.9% chance of crashing the system in an attempt, 
the exploit cannot be used for a range of attacks, including spear 
attacks and fast-spreading worms, right? A crashed and inaccessible 
system also increases the odds of leaving around unfinished attack code 
and leaking a zero-day attack.

Thanks,

	Ingo
