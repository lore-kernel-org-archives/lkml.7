Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55315C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122A321707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556622357;
	bh=dOaXlZT36suy/3pGKNAJM4ANBkXafeZaakoXcISOgHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AMkrXCmXxSGDQC6VH19QtkVJzo3tu7sG2hE24zzQYAk3Nv8IaE/sGGu0eyc5HURkz
	 9L/cIBH+3BxM7Z84cb8amor3DoVsF8mk5mxYLbxFfsu9E2UxyFd9raawUG0ABuHLrO
	 DbPk6Xfw9ZZHqyJoiUqNeNR2sJzJjqdcDe8vJAdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfD3LFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:05:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33663 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfD3LFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:05:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so20576384wrp.0;
        Tue, 30 Apr 2019 04:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hcjAClggzePqeJJtXogSOe2XblmZfTT3PJ7ZOWIVOqU=;
        b=t98F86tkS7nDT8aNYRRoUWLg5OJwxhtOdcoSs/BsTtn9OgzzITqrjV4cmLJ98Mwb1P
         Mqw3Dky/HvlbeumYpqCqDtokl2IbheHHUnKfUpXQ0vQd6X+E1+vsNWuApgGiz1Ij6D6i
         +9xEmITSRyeCwSFy9q9E4JB3oCgGLdH24ITrmedONPahTcgCy77/DWS8CyWArsuDWL/w
         owESCNvAj/CWa7Sb/6wh4ChvjV4oU0P3zh91GnzAIafx5K0sRIqzIGcixj4Gxq4j97rE
         k2XyJDVliGcsNDXJHNAcFA+7Vw9dqdqI3dOV3G6HyXz1P5JqwFoCvCTftErm8e2FhbSr
         rxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hcjAClggzePqeJJtXogSOe2XblmZfTT3PJ7ZOWIVOqU=;
        b=IETqXVQqlEX6fsZqSTSZo7zl+330S3CjmcuLFu4Unz84s1Oy5XymcsVXrYYVEwuvnZ
         SB2EpY3IEmbBvljOup7w6Nz/sEbeTYaQ6OeuBd6H+6SLoO9xbnajFyIXt8P4VCcT7MTL
         yLMx3hbBGKDr4zK7TusGhKQwmkFFXrCTeBr6/e1vVX1QKBNTHPKt+U4j2QNO11iV0OI4
         B8QKeVxbmD4JW4r+5GY2nfACNNesblIC8nro4XEmfxdLTzTw1z9ZwTv6AIjfPbX9HsiW
         k1JD2y1Obx7ob5+JnwQkITBjbWPHqmoBbC1bl7pgY5sFfBslnuzDSAy162LXkDrxmFco
         kqcw==
X-Gm-Message-State: APjAAAXRpaihll5ZgOoVAwTcY1pgbnRsTHloslC2PZz/qvDPkXX9RY7c
        LJ1E1jod6rWLefbNnTYkB4s=
X-Google-Smtp-Source: APXvYqx47jP/dkWfwfM3K6Jq6/BSx7pleW6oIHBiVt9pYJlp3l08JXsCge/13B3lJoEXdct7iMOKyg==
X-Received: by 2002:adf:e288:: with SMTP id v8mr8583758wri.7.1556622353105;
        Tue, 30 Apr 2019 04:05:53 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b11sm4059486wmh.29.2019.04.30.04.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 04:05:52 -0700 (PDT)
Date:   Tue, 30 Apr 2019 13:05:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call
 isolation
Message-ID: <20190430110549.GA119957@gmail.com>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com>
 <20190426083144.GA126896@gmail.com>
 <20190426095802.GA35515@gmail.com>
 <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
 <20190427084752.GA99668@gmail.com>
 <20190427104615.GA55518@gmail.com>
 <CALCETrUn_86VAd8FGacJ169xcWE6XQngAMMhvgd1Aa6ZxhGhtA@mail.gmail.com>
 <20190430050336.GA92357@gmail.com>
 <20190430093857.GO2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430093857.GO2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Apr 30, 2019 at 07:03:37AM +0200, Ingo Molnar wrote:
> > So the question IMHO isn't whether it's "valid C", because we already 
> > have the Linux kernel's own C syntax variant and are enforcing it with 
> > varying degrees of success.
> 
> I'm not getting into the whole 'safe' fight here; but you're under
> selling things. We don't have a C syntax, we have a full blown C
> lanugeage variant.
> 
> The 'Kernel C' that we write is very much not 'ANSI/ISO C' anymore in a
> fair number of places. And if I can get my way, we'll only diverge
> further from the standard.

Yeah, but I think it would be fair to say that random style variations 
aside, in the kernel we still allow about 95%+ of 'sensible C'.

> And this is quite separate from us using every GCC extention under the 
> sun; which of course also doesn't help. It mostly has to do with us 
> treating C as a portable assembler and the C people not wanting to 
> commit to sensible things because they think C is a high-level 
> language.

Indeed, and also because there's arguably somewhat of a "if the spec 
allows it then performance first, common-sense semantics second" mindset. 
Which is an understandable social dynamic, as compiler developers tend to 
distinguish themselves via the optimizations they've authored.

Anyway, the main point I tried to make is that I think we'd still be able 
to allow 95%+ of "sensible C" even if executed in a "safe runtime", and 
we'd still be able to build and run without such strong runtime type 
enforcement, i.e. get kernel code close to what we have today, minus a 
handful of optimizations and data structures. (But the performance costs 
even in that case are nonzero - I'm not sugarcoating it.)

( Plus even that isn't a fully secure solution with deterministic 
  outcomes, due to parallelism and data races. )

Thanks,

	Ingo
