Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E78C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5CD216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 05:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557381562;
	bh=WnEha//6UYNHnLUsbzQBF7PulaZ8cx0sIGXx71okKBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sikH4qVZ5V2xigMfvksuDUsnYex2KltSKlpjUsRpCdsxEMdTqqjh2BkrC+EuAj0ky
	 2MW7w08yYYon88eku4QnVpi+I98/qNcJZBdTdkMUGsK5cTQ7KT04HzqwZR6rFfZthw
	 lqEKuylG0/VPgli6JTWyu8MJ6Cvo45ETd9SPuY7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfEIF7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 01:59:21 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:40669 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEIF7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 01:59:20 -0400
Received: by mail-wm1-f49.google.com with SMTP id h11so1437846wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 22:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CDL1LOFL6Jlvbl8W+9pBU7MYHG/j9NgPfPY2BCaA4/8=;
        b=ukO8xFTk6d8lkBW+BnbvosZqdHt/Z23qFZl2MnuIOiwHS6LgHeQK+TQJEHet9+/uGo
         FvQwCmaCHeebWVzM8tcXAVKzKQu+a4x3FpcKhw9r+wBGuwFc55GycXOJzz1hcBWOjJGq
         2Uktdl4/e6sVL1dTceBmmYDDwxwKqkQ1e7vVoHA6pQLMkHSjP3XZyczyTaH52Hf/IN1S
         iOXyxRvpW6PlcOop3UKlghRbwjLs1Ei2AGyUQg6J45/cfC/paMnKRw8eR+I9l4kqILj4
         7DlxP2MzWhz0W4Y97L3EaHc5rLnKCKdpyM+6qLDGYsY6zwWospLTzTm17dX4pNNIdCmZ
         IIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CDL1LOFL6Jlvbl8W+9pBU7MYHG/j9NgPfPY2BCaA4/8=;
        b=YpzKH8mx3gBDZ3Tji5apziZJb9JQKM8cibDh5O4XeyLQm3SjHcXPMFE/tQfbcKw30F
         AIbMOpS3Nqx092uSP5xRxz2wrIYdAGpZCfW9BRwc08jwnxaFYz+adk9UxWDUI8qUqukV
         jaXc5Dynt4zfWzZxkG721cnlCZM9fbkUuOmzAmqnGDtXeK3Rnan7s1tFCu3gJqwFyE68
         GdFQIDNgoym4sNAmfnHAqiH9lJJKkTg1YJcbGNmyGoM0Dk9mjMN/4AWU1JuN78l0a7sh
         xNOQZ1rNDr1U42krDAYLEpe1bX9gpL3plmYb0Ct6mF9afw8YWmymrJNTgkHbE2Ntmv6k
         tlCw==
X-Gm-Message-State: APjAAAW96v5mnPDqeR2xwtKHamhKw443BiYnfvs0YDkvrm6cmqE1Y0Jx
        rxWyeEFqcbMB17XZ6ANuPEw=
X-Google-Smtp-Source: APXvYqzhrqUo1CvwG+RMHZq8RlOHZQ/qqgQavage6WPcNUl9NMahmJz5bNig2fptPyoNSBBZW0CWgQ==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr1441523wmk.66.1557381558974;
        Wed, 08 May 2019 22:59:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g3sm1397588wmh.27.2019.05.08.22.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 22:59:17 -0700 (PDT)
Date:   Thu, 9 May 2019 07:59:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
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
Message-ID: <20190509055915.GA58462@gmail.com>
References: <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
 <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com>
 <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
 <20190502164524.GB115950@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6F523@IRSMSX102.ger.corp.intel.com>
 <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
 <20190508113239.GA33324@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C762F7@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C762F7@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Reshetova, Elena <elena.reshetova@intel.com> wrote:

> > * Reshetova, Elena <elena.reshetova@intel.com> wrote:
> > 
> > > CONFIG_PAGE_TABLE_ISOLATION=n:
> > >
> > > base:                                  Simple syscall: 0.0510 microseconds
> > > get_random_bytes(4096 bytes buffer):   Simple syscall: 0.0597 microseconds
> > >
> > > So, pure speed wise get_random_bytes() with 1 page per-cpu buffer wins.
> > 
> > It still adds +17% overhead to the system call path, which is sad.
> > Why is it so expensive?
> 
> I guess I can experiment further with buffer size increase and/or 
> using HW acceleration (I mostly played around different rdrand paths now). 
> 
> What would be acceptable overheard approximately (so that I know how
> much I need to squeeze this thing)? 

As much as possible? No idea, I'm sad about anything that is more than 
0%, and I'd be *really* sad about anything more than say 1-2%.

I find it ridiculous that even with 4K blocked get_random_bytes(), which 
gives us 32k bits, which with 5 bits should amortize the RNG call to 
something like "once per 6553 calls", we still see 17% overhead? It's 
either a measurement artifact, or something doesn't compute.

Thanks,

	Ingo
