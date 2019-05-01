Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F02DC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1D920675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556734091;
	bh=zIsK/Lnl5jEJK8Wwi8GMwp/sR8ddJquKVXWWp5FTlZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W8jE0Z7yKhe0kCqZ0SFsyIvgXQsLjWxzrCZ0ITqOUKOao9ZRc/OoJd8zmQXL4Dc9N
	 3nAlAXQu5YuCR6qToa9JGk9oPYzt8Q1XcdM8uXRMttRiwr18iG7hxEOctOaxUUfbvU
	 bSgXiHQZK7mUjM9MB4AQSeAQOFaN/GygyMGa/zHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEASIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 14:08:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42498 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEASIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 14:08:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id r72so11767538ljb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1/pQlD+UKjcy9BQef1uO7G8NLgF3ClUu5utleWV5U8=;
        b=SD+L1zZxq3h7DQlOdVxAz8bLmC20f34sU3I1jlvMvjehPVfqTcXtJ+Hwy0wlTmDIe5
         ZLaHqL3C8OOgHUXO6bwxpGoSuwoZz3oAEkyG+sz7yDMhvcRmvy06STay7znm1I1QvhVO
         zhHdFU/CRi9/1FtAUFa9dZP2Hcbq7SwkLVz84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1/pQlD+UKjcy9BQef1uO7G8NLgF3ClUu5utleWV5U8=;
        b=emdCNbct1EZhc8Vr//6x9CzKpkdCQp0OOs8DwHAk1UX6Sb3Z5ux/HPkYf7VgdUSmqL
         qOg6hsixwTd7gl885TxRdI4VhV5+4aBRhAGX+CbceB+3V7ZkTHntmhrcksfUi9FhHpqR
         vzBhPc8Io4GyDcC0VOxs/0Vh21ZLJLtFALBec0OX0oPzAOywiHJ2WySYXKmsha3MX7l2
         wpVzidCqWKIgy0+KiB3YG37BHpMdE5+RCjFCqGmFP7ry3FiIoNU0rBq1eMvv0qWMV34x
         ACZM8cIq5qUI8bBz0jbRmcgTCI9cMtNKkClvduNvW+uY/OtEYI+A7GCfvMjq8eO+dIEy
         P8pQ==
X-Gm-Message-State: APjAAAVpkzom6eVLWCcYvDhzHs8yJ9lXDCd5NgEujIc5/NSGyc9YOsXU
        1FJW3V7Y33SxQhhiQ12+ZxoK5/2NLyg=
X-Google-Smtp-Source: APXvYqzPuqW/uASBw3Mjso2Pa8kLxdaFx/tkyL8Cx94kqvfJuDhlUg5bD1Ih8/ThZT/HZpd8drMXrQ==
X-Received: by 2002:a2e:984d:: with SMTP id e13mr18377786ljj.61.1556734087467;
        Wed, 01 May 2019 11:08:07 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id f15sm8882541lfa.89.2019.05.01.11.08.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 11:08:07 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id b12so14956205lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 11:08:06 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr39363092lja.125.1556733683510;
 Wed, 01 May 2019 11:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190501113238.0ab3f9dd@gandalf.local.home>
In-Reply-To: <20190501113238.0ab3f9dd@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 May 2019 11:01:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
Message-ID: <CAHk-=wjvQxY4DvPrJ6haPgAa6b906h=MwZXO6G8OtiTGe=N7_w@mail.gmail.com>
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

This looks sane to me, although I'm surprised that we didn't already
have an annotation for the nonstandard stack frame for asm files. That
probably would be cleaner in a separate commit, but I guess it doesn't
matter.

Anyway, I'm willing to consider the entry code version if it looks a
_lot_ simpler than this (so I'd like to see them side-by-side), but
it's not like this looks all that complicated to me either.

               Linus
