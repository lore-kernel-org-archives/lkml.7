Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EE7C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBAE2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551976298;
	bh=aQZ147eFQaKtlWkVDlAVwIG0HBABsF+ZK/bZfBPdubk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pXqsn0nG4KedP7cn/nbmGB8AUdxG6CdBnJLx0bL5joaPcvinHEC1R3CimZgo0GhCb
	 RQ4SCqQ3ljRqW6FmhMFmw7XiNR5JKd8CE5DKSkdWnQgmEUjfZKNQpcH62TWrT60ro2
	 fScPzIA6vhxuu+8miFffJdLzTBqwZ9cpVdIY0Z5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCGQbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:31:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43969 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:31:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id z20so14789216ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yob+KQqpWDosFrXnaT6Oy5XR1k/07iJpv86L7U2jnkY=;
        b=Gr7xFwU+f/EGDgsPMuJzDOzpQzTRsNQFnzL3BzLUtTCIEVV9EH3NpCsxGzPe45X1Op
         R+8qS5Atc7aN+Z4tiJQU83X/RTeCpDv5mnG2is+RUgKSgC1kKIToNkQ7rXS4SfjW1fHL
         UiSHSDrcKxL/f7+OXH4VupKqlI15vtH1guyxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yob+KQqpWDosFrXnaT6Oy5XR1k/07iJpv86L7U2jnkY=;
        b=X4fkM08V5cHyW2UMinyyAqnNRlCR9qYsLHkpFnVaqG6wePxgUvLIhnJqdcCCTZ2RcR
         HX/CH50RUbykjVYIrZ1GQLcp3pDwFamUaQmliwQvh3O7v42EBuPeg5uWZoqpkj4fCpRs
         5I+ZqTAQyBXkOH2RICztzDU4PIQgzx3biBbMaIz+tjvLMmwRpju4tr1y/jT5Nx1LzrUC
         wrCQqlKsj3vkQr7FDSXURLtSAED/rM9idXAeBgeGmH5wO+oCsFdmJ3MTjuDz9yZbdQpN
         WQhbIo6oHWGnN6SK+I0FIvUWZ6Bx8ih/nwA74JPMwPsnclqwDn77GfT8a08gq2ESDWh6
         9VKw==
X-Gm-Message-State: APjAAAWA3Oh+62V1GtiEB5soMakO2e0x2xAsji9dKMfkFrBDShNI6sUK
        TUlp4vAT33StdHRn4DUjS882XeJWkGw=
X-Google-Smtp-Source: APXvYqxo8nQ9Wop5ZYGOfe2Qpq3Zoxy9HmeSvhzHe4H6G6fNzBwIpmpUxIWLPDJViBKzhlNGexS3dg==
X-Received: by 2002:a2e:86d2:: with SMTP id n18mr6244798ljj.128.1551976293752;
        Thu, 07 Mar 2019 08:31:33 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id t11sm908470ljj.92.2019.03.07.08.31.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 08:31:33 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id z25so14802840ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 08:31:32 -0800 (PST)
X-Received: by 2002:a2e:8018:: with SMTP id j24mr6065247ljg.118.1551976292319;
 Thu, 07 Mar 2019 08:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20190307114511.870090179@infradead.org> <20190307120317.GD32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190307120317.GD32477@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Mar 2019 08:31:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCnFm9HNEwQW3bG-7v1KtKfuUvq4-rfFwN122U8F61Gg@mail.gmail.com>
Message-ID: <CAHk-=wgCnFm9HNEwQW3bG-7v1KtKfuUvq4-rfFwN122U8F61Gg@mail.gmail.com>
Subject: Re: [PATCH 00/20] objtool: UACCESS validation v3
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 4:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Take for instance this one (.config attached); it has both
> CONFIG_PROFILE_ALL_BRANCHES=y and CONFIG_TRACE_BRANCH_PROFILING=y
> and it compiles:

How about just turning off SMAP checking for the really odd cases?

At some point it's not worth worrying about excessive debug
infrastructure, I think. Just give up and say "ok. we'll save/restore
in preempt_schedule()".

Or just make preempt_schedule() check AC and not schedule. It already
does that for IF.

                   Linus
