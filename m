Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94193C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6261F206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551893784;
	bh=Y7IdUEq5hwVcLJp6e8nvgOD0/pecoYaZwVpjtpngDaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tlShOOdKAAZrcGliRGo6lILo3UAK+ot6EHMIElYl1p3U5/PAc7GJcSkAhHCW+DttE
	 slSHTq2JpgzXt0F9ElYU4la9RNGtfUhQ6Ov+EtEZOSJXQnpdabj1ZFYFrN//agg8Yr
	 fWpX6sJuuVztUP7JhbS8WP2zizeX4nQRMvz8L88U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfCFRgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:36:22 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41868 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCFRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:36:22 -0500
Received: by mail-io1-f67.google.com with SMTP id 9so10915914iog.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aI8L4QbeKU876nUr3argl4tzEQoli28e7lWrOJFwtc0=;
        b=CyeUsy7dMQ480cpsaI5OA+QMg7OCNRujb41x6AiPbLR+e0DyWbwCmasrWSXCsUNDmT
         9ukeYSmGr8nSdta9QQsQ8NrPl3DuaV63pgFYpgwKZyr65HyIEvDOF7pmjF/0CFfM5zLq
         tA5nc26j7FkG+RyPIs58PWV+hZtszK7cN9Gmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aI8L4QbeKU876nUr3argl4tzEQoli28e7lWrOJFwtc0=;
        b=FFte92pkHAzXbW05kUUuEploPnXnFSvekfz1BgTB/OFipnvgOaKljzfBXniS5KGVxU
         r44BIv3Zd/kocNnDBFGRBd+Cxe/OuGFB1itMIMCV9k9a/MdVwZ6W1YwrPQRoVjOWgB9A
         oJJlUh0qLpbG+H80WnmlfAQPjX+h0JG38ryqa5lt5+qe2aqoH8RZViGGYHTyKwxdF05f
         p7u29qxzezsk8bMEaXdwq5EwRZZlG00gMaXZ44kSkovThShWx0EY8ry4uakTL6ugO/mq
         QfMKJ1r/+ZxhWBEwwB8PFfSVMOnVS4ZvSLO74+IWSF4gBWoOosTrobwUkxMVk3b08lbF
         dfPg==
X-Gm-Message-State: APjAAAU0+2ZDIxO83ie+NYHtO5xUlsZEn73b7rWhC37cg7x75p8xb+ta
        tS/bgEK86NuFLQiXBrM2D9nsENYc6YKFwA==
X-Google-Smtp-Source: APXvYqzM7SLLbKABTPJHVVzi9lEuiVzkJci41aXVQ0SR68d9hDLeOiA39xY8BYnUoU2oJwRCYqpaVQ==
X-Received: by 2002:a5e:9e01:: with SMTP id i1mr4083671ioq.44.1551893780504;
        Wed, 06 Mar 2019 09:36:20 -0800 (PST)
Received: from mail-it1-f179.google.com (mail-it1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id u10sm1073663ita.24.2019.03.06.09.36.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 09:36:20 -0800 (PST)
Received: by mail-it1-f179.google.com with SMTP id l66so11422538itg.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:36:20 -0800 (PST)
X-Received: by 2002:a24:41e2:: with SMTP id b95mr2892026itd.115.1551893330847;
 Wed, 06 Mar 2019 09:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net> <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net> <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <20190306171451.GZ32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190306171451.GZ32534@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 09:27:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=whG6vFV-B-RDLiBkGjgzKtNS1X5Lk5xKZ040oyZ2vNdnw@mail.gmail.com>
Message-ID: <CAHk-=whG6vFV-B-RDLiBkGjgzKtNS1X5Lk5xKZ040oyZ2vNdnw@mail.gmail.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 9:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> And that (obviously) explodes.. Anybody got any clue why that Xen
> trainwreck wants to paravirt: "PUSHF;POP" and "PUSH;POPF" !?

Trying to regenerate the IF flag? I dunno.

But yeah, I think you could just force all of it into an explicit asm.
Or just use native_save_fl(). Except now that I look at it, for some
reason that is "extern inline" and we have an out-of-line option. I
can't for the life of me imagine why.

[ Looking at history. Oh, it's because of that same Xen issue and Xen
wanting to use it as a function pointer. Ugh. What a crock. ]

                  Linus
