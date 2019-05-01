Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C3C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AD720675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556737560;
	bh=BeBRKMJDieNk7rgnor3kOMBv5hXbyliZ8Y5kUb3R8pU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gV7sf5BDIj71i2nU9jVe8W7we+zObsTQK50UAeixJshySAHqa1qgl6MdzTxdo8AAw
	 Y5tmNgMrpz4hhHDT+FxPWsU8gH0/e+M7zQXjqPKtudbDUW5mhw2lWxp5p7ECDiOobR
	 sFbfSEK/8S1UiuzNIGGjvwVHLATi0F/lRrIsMjSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEATF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:05:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44491 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfEATF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:05:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id c6so9764317lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sel235hwbH6X1YvFcp9cC7JRXnS2M4BkT9uwVxDW2CQ=;
        b=hKJ92qX+WBtDkwAkIRCoWA4GuXtRFgmwNS/x4HHoRL1Cph8V9Ovoot3NqLu+fqUiqM
         Qth2QafTxUxf+Pm3vpTn95XuskqJEgEpvVEeBMW2fZtoLYrabbeAmSNI1KU3JXjTPrP/
         nm6QVbnOD2fawZyDG5MwCG7W040aS+7zbGhdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sel235hwbH6X1YvFcp9cC7JRXnS2M4BkT9uwVxDW2CQ=;
        b=DAG9lcDs0MbewIo0Aq5N8LAS6v49peYGJPFLgtOYw6KM31pTu1wHtkYQyjKc/AqKJZ
         TeXMLaf2wZdi7NhpnLpf0hPAJRG+mR1ityFDgOvz0a4HeB7aVjN+dKBFH607F9jfWlhO
         yr6AFVpU10hgYURKtrCW6uzdCaQStO36bHnLIRduUlHhQAv3KW2F8VEBWcOteaM404pw
         HkZhcl8nAwzKbaWd3U/Ga/PpwClKseo6gm3/OOVMOiwVqP7BYd/0SKDANihKnw42oUTb
         D6rVLMJa/5BrKc13+dLSOOLZbq+iVv/6S7nVnQzosdDIQ8k5xuUf6kH7g4Y8oW8v4NW/
         1YBA==
X-Gm-Message-State: APjAAAWutria99B5vuIL0qIuAk/w10Ksz2i9rVZiN4JEEFpS0JAChGKd
        i1TSW2PAveJ1KNkknzdbAE7MPYpJk58=
X-Google-Smtp-Source: APXvYqxzUiy+YK1byj6WXWMe+eoK7mRECKF5Vk9jw+aIx7HD6qus5VA+nedrWL//sYZZpSmt9OYx3w==
X-Received: by 2002:a2e:9746:: with SMTP id f6mr4105105ljj.127.1556737556782;
        Wed, 01 May 2019 12:05:56 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id t7sm8229632ljj.87.2019.05.01.12.05.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:05:56 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id u17so68082lfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:05:56 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr18577958lfn.148.1556737161870;
 Wed, 01 May 2019 11:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190501113238.0ab3f9dd@gandalf.local.home> <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
 <20190501145200.6c095d7f@oasis.local.home>
In-Reply-To: <20190501145200.6c095d7f@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 May 2019 11:59:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMZJeMCW5MA25WFJZeYYWCOWr0nGaHhJ7kg+zsu5FY_A@mail.gmail.com>
Message-ID: <CAHk-=wgMZJeMCW5MA25WFJZeYYWCOWr0nGaHhJ7kg+zsu5FY_A@mail.gmail.com>
Subject: Re: [RFC][PATCH v3] ftrace/x86_64: Emulate call function while
 updating in breakpoint handler
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

On Wed, May 1, 2019 at 11:52 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I got Peter's patch working. Here it is. What do you think?

I can tell from just looking at it for five seconds that at least the
32-bit case is buggy.

You can't look at CS(%rsp) without first also checking that you're not
coming from vm86 mode.

But other than that I guess it does end up being pretty simple.

             Linus
