Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FE0C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 02:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA121743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 02:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556676216;
	bh=mSiOCFMvlSiPydjEqVWlKPheZqiDWSkdLW72K8Xg74U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AEowYbt5vRVFFhtBrAHXolMR0nfp6g15uY0YvOe/nLO8s50wEbqL6UfeJa1P+zwFj
	 XaRXAe6IaaFYZgTIknM/GKArKFmpURL8qwL96AAv8bgltsBOTOLUD1ektdmlsciIeG
	 8y73XjOlPyutP3YTgExWLC2QTcjR22wK6dLw9XjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfEACDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 22:03:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34788 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfEACDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 22:03:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id s7so11838314ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 19:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmXNfPLOFbb8hAF6Vl5xp7lQQxPxX9F/tPvuKsQzATU=;
        b=Uv7TmbDCtMO9OVF1wwQKKT6KJaz16R9pk7p/lUNKiKQoViWyOjhOShjt1rXzEbmmks
         pmlBHurjILNX0wuRZI3kdDTmXE+0EIMcNfEle/j05RKDoGD+a48SSxnYFMopH7Zi/0N8
         k24pIeuX0qpCiaq30SlxmkHDKBRv2OvNH9Mws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmXNfPLOFbb8hAF6Vl5xp7lQQxPxX9F/tPvuKsQzATU=;
        b=mxoiDg9e4Ig+IbJYYsVRiVNnSECnAmIxSLDizkksXDuhRsSkKmLZx/yq6pkPWRKx1s
         X9T3T2TL08peYoumWnOoLcmYvUXrQj4szYSDqVMFPDHA8owq4jNT0Ji2MYYp7EQov79v
         d1l+nvcx70uLRIjDQKIuBageiO+iAe7TQmcWx4/YunK8lbqX9+edMTvuQkAtUxQtkzHm
         7EZXz6R4IkdS/MWFUO/dDcVjEo8mSU3o49Gd69wJrR3VCNO7jNUjLtFxXefKjxs67fQk
         KGjlZ2xc2ci5w3nbtK/bHG267JttEkvQNe8hS7qbx66sdTzy5lE1IwOVAOVaMYh/YSV7
         AT1w==
X-Gm-Message-State: APjAAAWwzP+/OS02T/4hSrt95hE64cAMUbXYJs5e3MH04iihMcDVhg/o
        7HlQIlvQxruxrYtTtWqJ8c3y6ThEK9Q=
X-Google-Smtp-Source: APXvYqzmRA5XhKDhoh0h26fM/anK2lsm1QCzqX+RcZjTSU/to7aBc6f7L6wcNz/mLFDGD9/AVvbPPA==
X-Received: by 2002:a2e:9ed3:: with SMTP id h19mr38019487ljk.129.1556676212507;
        Tue, 30 Apr 2019 19:03:32 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w2sm6045213ljh.72.2019.04.30.19.03.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 19:03:32 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id b12so13366765lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 19:03:32 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr34056779ljj.79.1556675903960;
 Tue, 30 Apr 2019 18:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190428133826.3e142cfd@oasis.local.home> <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
 <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
 <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
 <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
 <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
 <20190430135602.GD2589@hirez.programming.kicks-ass.net> <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
 <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
 <20190430130359.330e895b@gandalf.local.home> <20190430132024.0f03f5b8@gandalf.local.home>
 <20190430134913.4e29ce72@gandalf.local.home> <20190430175334.423821c0@gandalf.local.home>
 <20190430213517.7bcfaf8e@oasis.local.home>
In-Reply-To: <20190430213517.7bcfaf8e@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Apr 2019 18:58:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpS92oz-FkzaVdTEXVMre1NQioiLfqyEYYkmrVoVvgzw@mail.gmail.com>
Message-ID: <CAHk-=whpS92oz-FkzaVdTEXVMre1NQioiLfqyEYYkmrVoVvgzw@mail.gmail.com>
Subject: Re: [RFC][PATCH v2] ftrace/x86: Emulate call function while updating
 in breakpoint handler
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 6:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> Probably easier to move it from inline asm to ftrace_X.S and use the
> lockdep TRACE_ON/OFF macros.

Yeah, that should clean up the percpu stuff too since we have helper
macros for it for *.S files anyway.

I only did the asm() in C because it made the "look, something like
this" patch simpler to test (and it made it easy to check the
generated asm file). Not because it was a good idea ;)

                 Linus
