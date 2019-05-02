Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCECEC04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A41920B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556815412;
	bh=KyVVcCXTixTCbXh9xsXVAwKvATMolC5nUzmUR2HfbRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TNXx2ahjx8EQc8RqEUC6oaCbh0G4hhe/dE/oTc9RiSu2XT/63QxE20LmhrYIcd7mI
	 s5x2tBbFB2V1h/xkiWDeEZj2pIlhbNluKwTZDlgXZ7QuEWedlH0KNu6L7G2Ea7fyXh
	 4/5R8cmIw/B6Jc7BTgxFqNvHuAYt1eHbKbaseKQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfEBQnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:43:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38655 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBQnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:43:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id k16so4305694wrn.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 09:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SgRxXaRaZ7SS6NKygq+lIA0qjuJOX/iaVYfC9TFkYh4=;
        b=iRI9fosK7/vQzOX2YILGZPZbqFlSYGLXN3m3zv10cxaT47ebsjCOg6Sbb2SLSNyeJV
         Thntxx6lkLkECavJfhkQYJE9sSDk7Mv5qge8l+xKquEolbu1CPLaBx6TA5WLCad+4iTF
         ARNXgEsXn273nOa5XnYl6wxc/mJKGhAdj/YG3Q6qunwMQsZm+Ud161MYLjwIlHCf+DAM
         rYww7QiWbT31NSBK3IvGACptfEtYPz4L6cJZ+dirCa8TiQCL1+140DwGb43oQ4axnIcI
         c46N7T9EJf6s/oFTh0NWHHnJvLlMeIYvWuLmnjc0odr6YMn9E3QpHw/B4FF41YVjG+fB
         A7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SgRxXaRaZ7SS6NKygq+lIA0qjuJOX/iaVYfC9TFkYh4=;
        b=KrAYowX/c6gnMxdNPV9VJZGJG/gT14zQnMmg7hX/EVBG0g2tSC1w14nfo6QkQ54Vo2
         C/NOW+SSBd3uhDKybpmb9EZ1/48ipGpC22gF7okaTe0Lf3EouRvz9vOXp3wI+2HRDDMP
         pA0AJCp9KhPdQtx9r+Y1RX2gZhKySk/vFQl4kWOWLQIKd/tTKr5Bnj6cGx9DL97BysWy
         k0tO6U3Wlx73EqzqIkPQhh/Qd2sBprH//TSzIoJoRsUtSttOUN60cA/RJ2hKRpfnEQQj
         cdfHwdvpbWkcfrHUyBT1fjzx+XYSGFq7DxooT9wE41f16I+RH4xq1Kt2RlGmWBNcpe0/
         /Juw==
X-Gm-Message-State: APjAAAUvodQXlF3aFHyglpMzGvrR+S9bInGTSCri9UMP0E6nBhg02t0j
        rAZj8Tga3n/kM1oYp9COLJY=
X-Google-Smtp-Source: APXvYqy72lvK1lMDC+Kb5NMeslgzcW3PpNmJlPNyjcD92sTLitvZ3dS1MP6kS7O8kEtW7/Mvc+wuHg==
X-Received: by 2002:adf:f88f:: with SMTP id u15mr3471762wrp.155.1556815409231;
        Thu, 02 May 2019 09:43:29 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c18sm25658390wrb.16.2019.05.02.09.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 09:43:28 -0700 (PDT)
Date:   Thu, 2 May 2019 18:43:25 +0200
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
Message-ID: <20190502164325.GA115950@gmail.com>
References: <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
 <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com>
 <CALCETrVBXZNAKGRXm0_txKGjqKnjx30Eb05hesye8M50D4A8Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVBXZNAKGRXm0_txKGjqKnjx30Eb05hesye8M50D4A8Mw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> > 8 gigabits/sec sounds good throughput in principle, if there's no
> > scalability pathologies with that.
> 
> The latency is horrible.

Latency would be amortized via batching anyway, so 8 gigabits/sec 
suggests something on the order of magnitude of 4 bits per cycle, right? 
With 64 bits extraction at a time that would be 16 cycles per 64-bit 
word, which isn't too bad, is it?

But you are right that get_random_bytes() is probably faster, and also 
more generic.

> > It would also be nice to know whether RDRAND does buffering 
> > *internally*,
> 
> Not in a useful way :(

Too bad ...

> > Any non-CPU source of randomness for system calls and plans to add 
> > several extra function calls to every x86 system call is crazy talk I 
> > believe...
> 
> I think that, in practice, the only real downside to enabling this 
> thing will be the jitter in syscall times. Although we could decide 
> that the benefit is a bit dubious and the whole thing isn't worth it. 
> But it will definitely be optional.

Making it "optional" is not really a technical argument in any way 
though, either distros enable it in which case it's a de-facto default 
setting, or they don't, in which case it de-facto almost doesn't exist.

Thanks,

	Ingo
