Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6A1C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABE0208CB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556815531;
	bh=QM72Bwd7tUi663wsT6pedXakz44FmVlca2e5Raih7J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FuC4yxqfvY8fjDmtGBuWj1gtNSTOsCE76ib1n0OICbu6qqKjI+UgqI4ezVLe7sBbI
	 x/BVrbIy+YkyeA/hxNx10xEwTVNYElWyoj0BNpyQtJ0fWEJpMGYAtGjg5IUBY6MBe0
	 VCTw60OwOaDcUEvkhRp86Eu8zJVunVQ3zYL2iR0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfEBQp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:45:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38642 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBQp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:45:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so3514987wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SHbOKq6JTWffgCJIRF2gWVsgGXQKKc8XkaWvGai2ZzI=;
        b=GDh4zbm8o1D5vEGeall/FUSpxnl5A4A4A1Vx4vkOZ0saj8PUnNDArYn9ndi0iyOk/P
         LZ149e7pqokqCO5cIb/GTItBA32ERhPaKlTDcGQBvqIanGsaADzEiukMAV2rDZKs/3/X
         uP2S6o+O7g68iT0I2UNW4dfPsm3R7m4sn/d4rKhI35BLvLPCeNVFO4/wbvARLnYxxKNf
         niEk1wl3kfPmpB5AsFUk6vUzSxVPwa3mKt27sYIwmpg75bFDFDv58Tf1OgZ1ZG6Pi6Bz
         a5c/Ahd2wh8MwKUWve+nc8s7gIIApXRMAy4xTP8C3RAT9r+JvIFCCtGIZHstdYD/3znd
         f5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHbOKq6JTWffgCJIRF2gWVsgGXQKKc8XkaWvGai2ZzI=;
        b=ksobRVd6ngFt5vfQmsGR+CKIH5332ABhAu/SMzpxPMi1DelYyHQ5ssggUQBIxqpcJe
         vmd9hkJZVJyM6ZaP/A/E1zI+C4UK6ttql4s0dqgHayvffrcH+iRytOSzFW7M8pnZ7QxP
         OBjqLHD1zNm4LpeYu4Lh4FVRbb7W4Eg0veuh8M+jWzBeS25xklJy+i/mlSeK/7ZS3L/R
         91b7UUjPQms3xXKAu5tO2g8A/T5J7oTkACdO1pkqLqJUD3vkn4f9P1eHqFfopiVQJ4bE
         GKyeHtWk+lEBZxinukS7XX9L6WH4o7dqadjMLQdqbQR0ivKSBU1NNBnIKvKtZzIJP3xl
         DJbw==
X-Gm-Message-State: APjAAAVKJZOOYhbsn8s5qask+sIx7weNlTKEMif5Znpz4wDEDMVFGANX
        FPWzdHEajIZ5BEt0hI++2/w=
X-Google-Smtp-Source: APXvYqx78ge2PWAznH68jzDDmhIEmnCqzUBWvSUXwlz7WqMS15/4/uUfBXvQPl1FfRRu66xTqs6BTQ==
X-Received: by 2002:a1c:7518:: with SMTP id o24mr3034462wmc.42.1556815527776;
        Thu, 02 May 2019 09:45:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v184sm12334603wma.6.2019.05.02.09.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 09:45:27 -0700 (PDT)
Date:   Thu, 2 May 2019 18:45:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20190502164524.GB115950@gmail.com>
References: <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
 <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com>
 <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d64b3562d179430f9bdd8712999ff98a@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* David Laight <David.Laight@ACULAB.COM> wrote:

> It has already been measured - it is far too slow.

I don't think proper buffering was tested, was it? Only a per syscall 
RDRAND overhead which I can imagine being not too good.

> > Because calling tens of millions of system calls per second will 
> > deplete any non-CPU-RNG sources of entropy and will also starve all 
> > other users of random numbers, which might have a more legitimate 
> > need for randomness, such as the networking stack ...
> 
> If the function you use to generate random numbers from the 'entropy 
> pool' isn't reversible (in a finite time) I don't think you really need 
> to worry about bits-in v bits-out.

Ok.

Thanks,

	Ingo
