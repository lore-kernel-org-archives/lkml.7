Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804B4C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 22:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FDB20830
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562452916;
	bh=TaTWlW4MxU3HSnn2pAToXz+X388mEWuvf17ogWFLe4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yIVmigUbGEE0Man9not3eyz8UjzT8URDWV1v3bOC6UAnuqFT9TsyeXXQL1gwndCmm
	 w8FHH0JvnYttioeTWKnjLtbH21KR/ewoJdLNBwIJDBbsaIoAZSQ+K+V3u5TAk1oerC
	 +P6WiHAAPatkHCr2+/IciMWDqA4TTLHtJsxX82mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfGFWla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 18:41:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46893 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGFWla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 18:41:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so12385297ljg.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 15:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+ictAHIABdlYxV9reDagwuMhq6TDAmRYkMgCNdOUUA=;
        b=PSjV6e3Jf59NKny8Di+u0rMsvs0iFq22a7M1HMvXNO9+bm2pMmuvZNsVlbRvbpMjl8
         SwDlPx4mA7iahCxwM3NKsG5PmJgVa1/xm/1N7+j2GKZrw8UTWL+GqXy8SPPbDGq4kMx8
         gU8+suXqHKKEdoKT4wo+Dt+Tjoe18SHVtoc6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+ictAHIABdlYxV9reDagwuMhq6TDAmRYkMgCNdOUUA=;
        b=cOsUNkfstsKTN6afiH3897jXixXkytYFJLTDQkc3gBxyZtgoF9a1vrF22jmdT9gzhS
         b+A1/XIPRFLLbBHJ70wfj52PWOqeaah0ve8DzfDrpCBwWHxH/BpNWQ770GY0a8LYZqSs
         GseBEZhQntbBxDFCEke+ENadpWFMSDGiaq9POWJ64aZvZTFIedDSV4JDP52nV1HN46y9
         Tl4LUR7MFK/gkhvjvxQ0yxx3d14PJ7ppW4eZFmDzFxE3CS9a9RAbaXJRY2OMlhglD2dn
         Zhrwbvd/HLF1hIArPrbS460bK/EN/u3XT01qqXjlzsu654QJl3auWnjmOB0DYg6qZLRv
         LLXg==
X-Gm-Message-State: APjAAAX5r+/XdZKhgVqaNXseCkycMhMATbarZw++GMkJ0LQqnMEEf3t8
        qXsleXBv+GhrrzaloOnV2KTYucCPOww=
X-Google-Smtp-Source: APXvYqyH3g/KCELyydYQQoHSmLbvD+2zXdO1tQGmQotvbFTfIZldL1YRG++97pVHVbVXpfOe5f5Peg==
X-Received: by 2002:a2e:981:: with SMTP id 123mr6081445ljj.66.1562452887717;
        Sat, 06 Jul 2019 15:41:27 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id s7sm2642131lje.95.2019.07.06.15.41.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 15:41:26 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id c9so6695532lfh.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 15:41:26 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr4917559lfn.52.1562452886160;
 Sat, 06 Jul 2019 15:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190704195555.580363209@infradead.org> <20190704200050.534802824@infradead.org>
 <CAHk-=wiJ4no+TW-8KTfpO-Q5+aaTGVoBJzrnFTvj_zGpVbrGfA@mail.gmail.com>
 <20190705134916.GU3402@hirez.programming.kicks-ass.net> <CAHk-=whsgA+8XtqJY91gqHhh9xLYQLM3kLLFTby=uf2eoZyK7Q@mail.gmail.com>
 <20190706182728.435a89ed@gandalf.local.home>
In-Reply-To: <20190706182728.435a89ed@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Jul 2019 15:41:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=vCn1c7O4rpjwnS1fZbEppkeUhAq=ob3+wox0FKNZwQ@mail.gmail.com>
Message-ID: <CAHk-=wj=vCn1c7O4rpjwnS1fZbEppkeUhAq=ob3+wox0FKNZwQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] x86/mm, tracing: Fix CR2 corruption
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>, devel@etsukata.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 6, 2019 at 3:27 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> We also have to deal with reading vmalloc'd data as that can fault too.

Ahh, that may be a better reason for PeterZ's patches and reading cr2
very early from asm code than the stack trace case. It's why the page
fault handler delayed enabling interrupts, after all (which is one big
reason NMI was special).

               Linus
