Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B61C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFFF20675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555399671;
	bh=cBWwQ5A3vsIjU0E0VQsjAoJwwT/6qF4+x4JBX88jBjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j++hfIcGoSRh4KBmUv3ywUQ8N5t41o5I3LazwWO6tBJEQEbFhyALkwUY9TGeiDyew
	 LPNEbUaL0ve/fxX/SHlUI2kPGc+BIrFfs4QV8L9MAXfc8uoHKxjftBH6s321xqyayn
	 wNINMyreqEkXwmW5owa4iFXuy7xToNhIn/v+T5h8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfDPH1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:27:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43668 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfDPH1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:27:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so20782240wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iSo05Jt5RnAXOby2ru8viiose9aGvqFZsI6rZkMZre8=;
        b=ncIxQhDfEo1k5qTMVIrNV31WUnjG2KFlbshj7pVKd82+qcBDfmUmXkxh91hwQBM6ao
         GalhBIvaU7rOQ59ne9KDebLuzQGVdJJK/1Klt37uY4km44lMSaH1u9BiUJjVCcBLanJF
         sbdhnZ3oDimQsyZabvDUe7oYBO621DxMDehyeVbJhlAyaYpNA4+/A9UnMVhikmONcaiE
         LABRuktZjDisyBzVleiga23BQb122xtr77DfPEpgpxKsNg2L2YyzADNFta7NeG55tTs0
         2u2b2raB5x1yxLOCFqrv8UnLNcwL/QJauAQ6kRqGQKu6YzLaP1/jJs0F63M8gf49U1Z2
         0luw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=iSo05Jt5RnAXOby2ru8viiose9aGvqFZsI6rZkMZre8=;
        b=gO0fsMTJ3o+G6TrjCc0ZUUlCShhHntxjkpAiYhj9KDbgO5GIE5yaZOkjxIleUT8bw7
         jCMp2YOiH5bn/VK+XACCAioXkWWBRMgrR3f6dlbAZxexLm99ASqt9+eZZ0Of+5b4++h8
         cLySpLDSzpcjKdhfz+RktJY64hUzuCX7uUJQOusq3Ar2Qg9L9TxBCgmGZFKuPPwQEW87
         qC0ZzpNWavUeqQZm/9EqXRgeVjyt54nOjocADhzCiSk6+ZXityD1JB/ZLdgutBVNK5up
         b51smDrmHUBRaA89kcBqY7Q4dCFOlrGwrKSh98cxf/xJXAFucxSksimePmVVl5badj9C
         Uwtw==
X-Gm-Message-State: APjAAAWrdpisjFIQpTEqwLx3xbzavjgcg2PSJS6DnftJ68BNwrtWs3sT
        dYg1lPNNVgYVg+kSyMnyulg=
X-Google-Smtp-Source: APXvYqzUusbyACoIv9TITBp4D9CeWpheyLpX6OjBBeGfZFDhKG2ngl/fnWW9hv1doTitMbTr+gzlQQ==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr49905438wrr.147.1555399668228;
        Tue, 16 Apr 2019 00:27:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s21sm21302057wra.45.2019.04.16.00.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 00:27:47 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:27:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] x86/entry/64: randomize kernel stack offset upon
 syscall
Message-ID: <20190416072744.GB127769@gmail.com>
References: <20190410112103.15170-1-elena.reshetova@intel.com>
 <20190410112103.15170-2-elena.reshetova@intel.com>
 <20190410114259.GB9293@gmail.com>
 <CALCETrVme9=aVpSOhtkuVtwDy06pxB=6C9fkqRVoUF_fx0LrOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVme9=aVpSOhtkuVtwDy06pxB=6C9fkqRVoUF_fx0LrOQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> On Wed, Apr 10, 2019 at 4:43 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Elena Reshetova <elena.reshetova@intel.com> wrote:
> >
> > > 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
> > >     base:                                        10000000 loops in 1.62224s = 162.22 nsec / loop
> > >     random_offset (prandom_u32() every syscall): 10000000 loops in 1.64660s = 166.26 nsec / loop
> >
> > Stupid question, how did you manage to buil timing_test_64? Here it fails
> > with a bog standard gcc 7.3.0 x86-64 distro toolchain:
> >
> >  dagon:~/luto-misc-tests.git> make timing_test_64
> >  g++ -m64 -o timing_test_64 -O2 -g -std=gnu++11 -pthread -Wall  timing_test.cc -lrt -ldl
> >  /usr/bin/ld: /tmp/cc8VRkuV.o: relocation R_X86_64_32S against `.text.startup' can not be used when making a PIE object; recompile with -fPIC
> >  /usr/bin/ld: final link failed: Nonrepresentable section on outputcollect2: error: ld returned 1 exit status
> >  Makefile:39: recipe for target 'timing_test_64' failed
> >
> 
> I think your toolchain is screwy.  If I create this file as ingo.c:
> 
> #include <stdio.h>
> 
> int main(int argc, char **argv)
> {
>     printf("Hello world!");
> 
>     return 0;
> }
> 
> And build it like this, it fails:
> 
> $ gcc -o ingo -g ingo.c -pie
> /usr/bin/ld: /tmp/ccofYU9N.o: relocation R_X86_64_32 against `.rodata'
> can not be used when making a PIE object; recompile with -fPIC
> /usr/bin/ld: final link failed: nonrepresentable section on output
> collect2: error: ld returned 1 exit status
> 
> Which I assume means that -pie requires -fPIC, and your toolchain is
> screwed up and is defaulting to useless options.  I'm guessing you
> should file a bug against your distro gcc package.  For me, it works
> if I remove -pie.

It's just a bog standard Ubuntu x86-64 installation.

Thanks,

	Ingo
