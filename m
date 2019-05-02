Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA1C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CC520675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556809741;
	bh=8m5xZzVo2eoLyShb7QCAgXR3ghFR1Flg9gAfGdg2WJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XJaU0LBZEi5bvbpkZ9rzVQq8bYWAjYS9Z8IGiHguYRyQzGKjC5+oIzW+MrvfIbFAV
	 lHi5rxTiyy0a+RL8q9/1fM6ZzurGfjybsIi3OCAkFLtiBap5EzIy7JMD3ba/ySI2mx
	 ic48Y0Kqf820zSf6R7KaOzR5DQzRRiWr4aO2oIjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEBPJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:09:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37468 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:08:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id k23so3871717wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1TNCGeuNp8G84cQrEGm4SyYivnE2nikv/Arz+uWr9Jw=;
        b=USy5IvwgOnGnOL8SWon1LPB1/ICXuB+9vrTlwuLJWWIxXY3xlg2aV0KR7Wy6caebP4
         dbJ4J7osOT+lmfedLKQJnryv0kBU+rsTJdNgy0cDRPHXe/LnwJQoQXA5FvbvRfVQFuS6
         sVwDJkL+/lwkqLDZgwSQVASys6vuIxwJBMeIV4DAnfH+Hq53BRK7OsXAVjhTbgM5YA9t
         zJeLMgevqe+3qOWChIcrnlOfJ+mm8ECn781DZCStkxRLuoN2g83jh9bocnX+I49v+sZl
         UzLGPuZxYizcvu9C537+7KLjW/4GC9bKCIVxNi3ZnjgXzrXcK3AW6mED72jyugftSP2+
         KrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1TNCGeuNp8G84cQrEGm4SyYivnE2nikv/Arz+uWr9Jw=;
        b=PnOqSu9Z3zZ4px8Oa0QZ8ZQDDzPcEx+oNOi0xHXd9wHAbzxIjQ62S0tFlXJDYgayBq
         IHYGHyYgwdYtUtZjXic1xytH+YNRSrvFF2+ZIQjdvQaZQz5Qev+s5lE7ZjL5+PNaSfwr
         k1SM6vPv+bQYIF9+A6MbjcYm6zIwF5hWXEF23a/30ZxYcTMMSgqS/t4QkCxAuUa/vYxj
         BUmBq/ZXrno04ixkOzxzgNeJ8Rvv0CBzi+72o9fitOeRDJknET4hoKBMCPmtgv7qQF3E
         b5SU2sb6D/jWDr/2JW5eanFCFtyE1q/9uY0H9MNalEvjfrg8H5JzWxvuflm+Hzp9Axya
         7vgg==
X-Gm-Message-State: APjAAAWyYa8mVEULuwDJjohk8XG4uR4Fa7JNGxOqJyJhc870eVewghnG
        /d/YY0rQuJ0BrpuleeoJdOs=
X-Google-Smtp-Source: APXvYqxzeFSAwlc0RDYWzY3a0mDpTjm74oIp1tg2x4HfHStqFZMXO79HoyEB/0vjt0FC7/B0PTEQ/A==
X-Received: by 2002:a5d:6b10:: with SMTP id v16mr3178292wrw.294.1556809737491;
        Thu, 02 May 2019 08:08:57 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q26sm6013672wmq.25.2019.05.02.08.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 08:08:56 -0700 (PDT)
Date:   Thu, 2 May 2019 17:08:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <20190502150853.GA16779@gmail.com>
References: <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
 <20190426140102.GA4922@mit.edu>
 <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
 <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> Or we decide that calling get_random_bytes() is okay with IRQs off and 
> this all gets a bit simpler.

BTW., before we go down this path any further, is the plan to bind this 
feature to a real CPU-RNG capability, i.e. to the RDRAND instruction, 
which excludes a significant group of x86 of CPUs?

Because calling tens of millions of system calls per second will deplete 
any non-CPU-RNG sources of entropy and will also starve all other users 
of random numbers, which might have a more legitimate need for 
randomness, such as the networking stack ...

I.e. I'm really *super sceptical* of this whole plan, as currently 
formulated.

If we bind it to RDRAND then we shouldn't be using the generic 
drivers/char/random.c pool *at all*, but just call the darn instruction 
directly. This is an x86 patch-set after all, right?

Furthermore the following post suggests that RDRAND isn't a per CPU 
capability, but a core or socket level facility, depending on CPU make:

  https://stackoverflow.com/questions/10484164/what-is-the-latency-and-throughput-of-the-rdrand-instruction-on-ivy-bridge

8 gigabits/sec sounds good throughput in principle, if there's no 
scalability pathologies with that.

It would also be nice to know whether RDRAND does buffering *internally*, 
in which case it might be better to buffer as little at the system call 
level as possible, to allow the hardware RNG buffer to rebuild between 
system calls.

I.e. I'd suggest to retrieve randomness via a fixed number of RDRAND-r64 
calls (where '1' is a perfectly valid block size - it should be 
measured), which random bits are then used as-is for the ~6 bits of 
system call stack offset. (I'd even suggest 7 bits: that skips a full 
cache line almost for free and makes the fuzz actually meaningful: no 
spear attacker will take a 1/128, 0.8% chance to successfully attack a 
critical system.)

Then those 64*N random bits get buffered and consumed in 5-7 bit chunk, 
in a super efficient fashion, possibly inlining the fast path, totally 
outside the flow of the drivers/char/random.c

Any non-CPU source of randomness for system calls and plans to add 
several extra function calls to every x86 system call is crazy talk I 
believe...

Thanks,

	Ingo
