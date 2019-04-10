Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3CAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96A92064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554907750;
	bh=vkRTarru/CyLjxWJ+sBiiSbpijenoKX4UvMBtAiy+NU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G9irft3Z/pGhMqdHFFlJlpjnmVvh2QitsoMXZCTKngCsJbjgtB2obwPVdfTkQfLu9
	 TEc0zMwhOP6mIeQiYsslc/rb1appvr946hN28N3gsr+xL6CpjqWf+DQHwMVQEUd+ua
	 ZtEoFK9sQurebUnyLfdwblxSCnJzIJpxi1/tAyCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbfDJOtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbfDJOtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:49:09 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BF6E2083E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554907748;
        bh=vkRTarru/CyLjxWJ+sBiiSbpijenoKX4UvMBtAiy+NU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P3ABfPnfMC76isg+PeSMHobH7l1fVbgwGXZBcHUGriaDSg1/RNxUnSs/qfX/13AuS
         O1g/Sg6AzeZWR9GthBTPdGi9xqZudvGVGcUiOEdMoaEYw18zdb2RDKxQO55V6YyZc0
         JxKPR0/Qt88Uo1qcefYqfSGPF9t3bVbLuIwi3aXk=
Received: by mail-wm1-f46.google.com with SMTP id a184so2930520wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 07:49:08 -0700 (PDT)
X-Gm-Message-State: APjAAAXHQbMx8eEVCkJGYSSgaB8BRTnaWUrV4r67AaBVoYWlGxaSLGlN
        zo3LLrGEHsdORfpdzvSexnnifaWmZ4R4NyRt1BqE7w==
X-Google-Smtp-Source: APXvYqzS2NrNmu7auP8nOG7bTNErNuqFhnnKKLQCU3jn/iyMGHqm1VWYewSa10JUDmHOUy8J0SdSQPD4MYaTV7aWfqg=
X-Received: by 2002:a1c:99d5:: with SMTP id b204mr3031078wme.95.1554907746873;
 Wed, 10 Apr 2019 07:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190410112103.15170-1-elena.reshetova@intel.com>
 <20190410112103.15170-2-elena.reshetova@intel.com> <20190410114259.GB9293@gmail.com>
In-Reply-To: <20190410114259.GB9293@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 10 Apr 2019 07:48:55 -0700
X-Gmail-Original-Message-ID: <CALCETrVme9=aVpSOhtkuVtwDy06pxB=6C9fkqRVoUF_fx0LrOQ@mail.gmail.com>
Message-ID: <CALCETrVme9=aVpSOhtkuVtwDy06pxB=6C9fkqRVoUF_fx0LrOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86/entry/64: randomize kernel stack offset upon syscall
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 4:43 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Elena Reshetova <elena.reshetova@intel.com> wrote:
>
> > 2)  Andy's tests, misc-tests: ./timing_test_64 10M sys_enosys
> >     base:                                        10000000 loops in 1.62224s = 162.22 nsec / loop
> >     random_offset (prandom_u32() every syscall): 10000000 loops in 1.64660s = 166.26 nsec / loop
>
> Stupid question, how did you manage to buil timing_test_64? Here it fails
> with a bog standard gcc 7.3.0 x86-64 distro toolchain:
>
>  dagon:~/luto-misc-tests.git> make timing_test_64
>  g++ -m64 -o timing_test_64 -O2 -g -std=gnu++11 -pthread -Wall  timing_test.cc -lrt -ldl
>  /usr/bin/ld: /tmp/cc8VRkuV.o: relocation R_X86_64_32S against `.text.startup' can not be used when making a PIE object; recompile with -fPIC
>  /usr/bin/ld: final link failed: Nonrepresentable section on outputcollect2: error: ld returned 1 exit status
>  Makefile:39: recipe for target 'timing_test_64' failed
>

I think your toolchain is screwy.  If I create this file as ingo.c:

#include <stdio.h>

int main(int argc, char **argv)
{
    printf("Hello world!");

    return 0;
}

And build it like this, it fails:

$ gcc -o ingo -g ingo.c -pie
/usr/bin/ld: /tmp/ccofYU9N.o: relocation R_X86_64_32 against `.rodata'
can not be used when making a PIE object; recompile with -fPIC
/usr/bin/ld: final link failed: nonrepresentable section on output
collect2: error: ld returned 1 exit status

Which I assume means that -pie requires -fPIC, and your toolchain is
screwed up and is defaulting to useless options.  I'm guessing you
should file a bug against your distro gcc package.  For me, it works
if I remove -pie.
