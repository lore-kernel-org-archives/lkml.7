Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC97C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7320A20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551895173;
	bh=6emJEMNkBmkw/qdWxaKwwoyFpuFZb6ZEI7+AgKwntZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=heNSwsAG/fIUuT6Eh4wncFKQd8fR1jZvTCHQblcGpnJ3CFbsPkfOMQK7LoaSHEDVn
	 yDfAt51nZ1xgJf2EfbxecPsPre7nqt9hgAQwL5n+Lui6Cko5S2oWSYzXg2dLcu9LwK
	 64PuPMQ81k1vwdH3SThjcn0crf0c5sInQLw+UchM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfCFR7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:59:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44886 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfCFR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:59:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id q128so11704857ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hi84fhsxf2r6cg8iA9zWa4Z/EZJKaybISgwttPqRQ5U=;
        b=VLMEmmigBcNy4dP3EdIF7z4ljXRAq/zI8gVEbvZoIAIpq1rrYVcZ0UrhmL8rkz75SR
         wiW1mEsfxmmHbQogIP2rK6hZgV9yZefGEOTQdIygHNqeGu8VxuIOeb2Pd82TortkPeXY
         sL8dlitQTj7ylYXuUGvSBfiaO8c4fm6q9x2NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hi84fhsxf2r6cg8iA9zWa4Z/EZJKaybISgwttPqRQ5U=;
        b=B56uoKjV6ZYFPg1peLf3R5ATqS38Xk5SicHYeo9fU0SDE2yMCI050W5nW3U5J8z7gH
         DpSjsxXBZdQPdDOx20Em56OC8y18hIEErRcFmnBgDkGa1aAi+l0Di4tHDmYvZhcPou7L
         IL9jgfkMn8e6aI1+/7y9MRE80RQfimsBnRs9onLcuHyWVbZJthkXv+773A24SJVDSecK
         n8Ve9FMKRvWzxj7PpcVY4DtQ1Uc3vQcYK63PTzLjvauhT6s/cGEY57CI283+P0/8Jnm5
         l1/XK17MaJfijx/IHoRJeb5+lEx8PRRwb0ydPtdIrz6FgikzR/6HKILhWHgc3M08w/8Y
         9frQ==
X-Gm-Message-State: APjAAAXhhHyoI6Q99nARP6Lf2jei3OgGKFA7+Y+PkUHGCqVa2Ka6Q9bu
        enXfHjfE/BSl0+1FB9aNAGgptyJ9Kq0=
X-Google-Smtp-Source: APXvYqxcooZuUPiDNCxNz7e3Zneo9hXpQUugMG9f0Xrn7BtstsLxfz5YBWNsfJbBeKTgDKGXGrM9DA==
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr3369544ljg.146.1551895169096;
        Wed, 06 Mar 2019 09:59:29 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id g21sm425209lfb.73.2019.03.06.09.59.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 09:59:28 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id a8so9611200lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:59:28 -0800 (PST)
X-Received: by 2002:a19:48cb:: with SMTP id v194mr4748710lfa.166.1551895167718;
 Wed, 06 Mar 2019 09:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net> <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net> <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <20190306171451.GZ32534@hirez.programming.kicks-ass.net> <20190306173715.GA32534@hirez.programming.kicks-ass.net>
In-Reply-To: <20190306173715.GA32534@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 09:59:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiDfi_=hny1hDCrxaEUUcgvykaWXt4f1qn+pt1RD1OFLQ@mail.gmail.com>
Message-ID: <CAHk-=wiDfi_=hny1hDCrxaEUUcgvykaWXt4f1qn+pt1RD1OFLQ@mail.gmail.com>
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

On Wed, Mar 6, 2019 at 9:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> The below seems to 'work'.

Yeah, and makes things cheaper for the non-SMAP case too. Looks sane.

One note:

 +       asm volatile (ALTERNATIVE("", "pushf; pop %0; "
__stringify(__ASM_CLAC),

Hmm. Every single use of __ASM_CLAC is together with "__stringity()".

Maybe we could just get rid of that oddity, and just make __ASM_CLAC
be a string to begin with.

At one point it was used bare in the __ASSEMBLY__ version, but that
does not appear to the case any more since commit 669f8a900198
("x86/smap: Use ALTERNATIVE macro") back in 2015.

                 Linus
