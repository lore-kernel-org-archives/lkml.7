Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E35BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AE421906
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574250105;
	bh=c54FTPihjJBlYMetR/UyUFcl4cuOdFUsY8+B0OczVlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qbsw7iqX9v2r7crgzBLVW2ntMrnn9MpOQC1m4hEQ6KKBoeIo2rRw5pskguVoW/NjD
	 shPyD5BqrM4kCDTMpNxFtAtb4kRKPgGyQsvlc28zd/8DEJi06a723FSrCWzQE4Zt6f
	 gBRVDF/Ffrk0deiIs2RKCtf4Y7cA5PUk+s2kpNKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfKTLlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:41:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32814 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfKTLlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:41:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id t26so961787wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x9xVJ7mXWw8oZuqrstfEkI3veCueqnyo7bS5uNfNe1c=;
        b=eXkRJGZLZ6D4XKijtgh5kgmQXmomYEzldhHOXjpAShGyutxPONvJiJC4EZGctWpzSj
         5ssGLcJxTVEw9mrmWAB1F//yLDm8n3sOdxC0/Hc7BSCW2BejLTxW2kcak2TBQiisTnrV
         Mzi2keltM1sJcXNTmSz674CvfJRWRJzTugVBfDfJgcm3/atSKA0j6NyHgzWqIQjmZKa8
         Ci6i4m/BLT1ZPUFHRKmhfBejleTr8n8W3Mb6O1G4ztzDgy07Gdgs328NOjMm/+d29nCA
         Df2iPdhnyYCUmYKpY2UXTyclgjNBCqeVu7DgkdGFtkfE7HLwXd9jYPYaegDu6s14q8p0
         TI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=x9xVJ7mXWw8oZuqrstfEkI3veCueqnyo7bS5uNfNe1c=;
        b=kY0uLUd5y+Lpvzuz/sEznO/6qZ93oqWnT6zyQFxFf85ELQ6+8QZmX3MuHx1i9v8fFB
         azFmB0wANn1Y2ehJoHOSkfX+hcc4w69cfd+KCsVtG8TGrJy9CR6bfFmk4UvEL77LnwLd
         fvOTfejMH978oMd0/lhNXPwQCVySpWeVNrCHkdcxPpORIrVid/RokT1ZhQqX+w1nawPj
         JP7h3ZArvW3m7J/2j3C4imBpp6LiG/V02VJLxd24X3fy2r+5aXDDZSfHyD89LPfdThRg
         S5v0/fpoOX7+N2nRvRuUsG0MMXkrKmwxUmQtolqL6hizja6bopnVeU0os8wKaZG3Pqby
         FQ+g==
X-Gm-Message-State: APjAAAXTF65x4g3bj3H6VfQ9yTcvJ67rN8e8iUxe+KnXWYJPAWkA4QbP
        8C5KOtZGAuqCfJ1iBp0CPXo=
X-Google-Smtp-Source: APXvYqyiZKPwWo7Sl4WENLYinPVTV8jqx8gj6VXdS001xRV97w79Gg/SoSdNfSu7LVSPnKVqLd0cqw==
X-Received: by 2002:a1c:a512:: with SMTP id o18mr2592588wme.4.1574250101878;
        Wed, 20 Nov 2019 03:41:41 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v128sm6875441wmb.14.2019.11.20.03.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 03:41:41 -0800 (PST)
Date:   Wed, 20 Nov 2019 12:41:39 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 2/3] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120114139.GB83574@gmail.com>
References: <20191115191728.87338-1-jannh@google.com>
 <20191115191728.87338-2-jannh@google.com>
 <20191118142144.GC6363@zn.tnic>
 <CACT4Y+bCOr=du1QEg8TtiZ-X6U+8ZPR4N07rJOeSCsd5h+zO3w@mail.gmail.com>
 <CAG48ez1AWW7FkvU31ahy=0ZiaAreSMz=FFA0u8-XkXT9hNdWKA@mail.gmail.com>
 <CACT4Y+bfF86YY_zEGWO1sK0NwuYgr8Cx0wFewRDq0WL_GBgO0Q@mail.gmail.com>
 <20191118164407.GH6363@zn.tnic>
 <20191118173850.GL6363@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118173850.GL6363@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Nov 18, 2019 at 05:44:07PM +0100, Borislav Petkov wrote:
> > [    2.523708] Write protecting the kernel read-only data: 16384k
> > [    2.524729] Freeing unused kernel image (text/rodata gap) memory: 2040K
> > [    2.525594] Freeing unused kernel image (rodata/data gap) memory: 368K
> > [    2.541414] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> > 
> > <--- important first splat starts here:
> > 
> > [    2.542218] [*] general protection fault while derefing a non-canonical address 0xdfff000000000001: 0000 [#1] PREEMPT SMP
> 		  ^
> 
> Btw, tglx just suggested on IRC to simply slap the die_counter number here so
> that you have
> 
> [    2.543343] [1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc8+ #8
> [    2.544138] [1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
> ...
> 
> which also tells you to which splat the line belongs to.
>
> Also useful.

Yeah - but I think it would be even better to make it part of the 
timestamp - most tools will already discard the [] bit, so why not merge 
the two:

> [    2.543343-#1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc8+ #8
> [    2.544138-#1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014

Thanks,

	Ingo
