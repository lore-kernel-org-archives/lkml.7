Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD7C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE45215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556569385;
	bh=yFXknfQ8/xU2HNUaIiD7hUrrFggx2J0Rox0w/83/JZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N6u39spLbS16rOREiWkAoV5sJXdhfaBplSwCF9J4clbXi4EMbGXs/+4/qlCrrV4YO
	 h3qfuFSsYugNK50bGDWZukGqmT6gbBKImfGyrhSHKJYJFpAeC6B3entgW/Bu9eZ3Ju
	 FYggdPV6hPTj9vlRsap+bksCVyJ921wWqo/hVA3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfD2UXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:23:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39790 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfD2UXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:23:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id q10so10610880ljc.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZPco9B0AwJRcXRx0/3kAi2/oUVRUui1oHWnui3+POE=;
        b=hK1kZGJXqBUwaiXALmHLkdcjKeYn61v//Mj8GdmL337feFsDle0PLwryNmXEBwrs8S
         nMiE6KN2OCuC2luJ1gtpTtS9+ibFu0S06CjKBRLSvwg6ZCsFCBznCGPdZiCpgm7+NDA8
         J3lnB9+NdA0txfHJzPOyF+qYo7ppMKAtL2K5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZPco9B0AwJRcXRx0/3kAi2/oUVRUui1oHWnui3+POE=;
        b=rHhkRn+uAX9sfZAnfi5R7Ubmdw/thQYvunCZgW0rXP/qY2tmQjbf+QgNTyqdbOewD0
         I1HRc+mFjz4BYe8FJ0ROfPzENiTqfhFDs1uCeeg6C/d2TUuNyOa4rNgxPyew8I1Ud5WO
         Zf4SyjwXhEYLrWfiyRpz/ZxkN4eXC+R++S6vCEDhn6u22LiedPTq0YuMEaUXJXtRR5aH
         tQ/++WmUh2FQvpj3RXbUpeTWUJzQJUmTv+mB8I/SFaZfybFbxMOQxfWQT3Yy3TPIZCy6
         p8xogAZlvzB9uWzX/xUHcLm3N3D8MwLRH7PPyz9zxB6aKOphJF5fHsx3Z8/ZZw5T1qUa
         s5/Q==
X-Gm-Message-State: APjAAAUiAKGPXmbVhNXCNNcnew6rHR35gvxgPwqI2CNX6tpjEXHD2qp8
        gSIdHxjVBaTJfyI4ufRU9EX/mA3pOXM=
X-Google-Smtp-Source: APXvYqwFQHwaqmncjmVjbwmBqvM9cAcowydAW4O8TWkDgRG4b++jUKfdB/sBG/djFT5TmFe14BBiDg==
X-Received: by 2002:a2e:8018:: with SMTP id j24mr9556562ljg.149.1556569381226;
        Mon, 29 Apr 2019 13:23:01 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id a1sm3498962lfc.17.2019.04.29.13.23.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 13:23:00 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id h126so9042424lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:23:00 -0700 (PDT)
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr3771995lfl.67.1556568986468;
 Mon, 29 Apr 2019 13:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
 <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
 <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
 <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
 <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
 <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com> <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
In-Reply-To: <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 13:16:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjyyKDv-WZLXZbVD=V05p2X7eg74z2SpR4TQTxN9JLq4Q@mail.gmail.com>
Message-ID: <CAHk-=wjyyKDv-WZLXZbVD=V05p2X7eg74z2SpR4TQTxN9JLq4Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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

On Mon, Apr 29, 2019 at 12:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If nmi were to break it, it would be a cpu bug. I'm pretty sure I've
> seen the "shadow stops even nmi" documented for some uarch, but as
> mentioned it's not necessarily the only way to guarantee the shadow.

In fact, the documentation is simply the official Intel instruction
docs for "STI":

    The IF flag and the STI and CLI instructions do not prohibit the
    generation of exceptions and NMI interrupts. NMI interrupts (and
    SMIs) may be blocked for one macroinstruction following an STI.

note the "may be blocked". As mentioned, that's just one option for
not having NMI break the STI shadow guarantee, but it's clearly one
that Intel has done at times, and clearly even documents as having
done so.

There is absolutely no question that the sti shadow is real, and that
people have depended on it for _decades_. It would be a horrible
errata if the shadow can just be made to go away by randomly getting
an NMI or SMI.

              Linus
