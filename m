Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0B0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D1D20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557166034;
	bh=cku1bSY6NOsBU+MOGLdNKKwTnwaOvztyXMkmmtWr2rg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xta/srlfOacv3kNqNEqWOSWx1smZXayajW1SFi7jnmn64wUYsCXGqZ5cJBqvGyW0l
	 qJxz1wZg5a2XyHOSVu4c4+t1/bBwEtjlI/Wl4DLlpZPHLjlqJYyA2jYZS6sQICN3m9
	 oUILlWhjNu6tSgJJyrO6Yt28iemZVUTLO7GXA2Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfEFSHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 14:07:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37523 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfEFSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:07:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id h126so9827781lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QBasbgDBBBZgS2pVJekzI8/+EO3uoHDtSFy2Fyb2GE=;
        b=KY56o2zkPfttJHquP5i+aSm2DJQcYtHn8+L5gH++7lWF4448+Xba0wDZ28VwqzrGv1
         tcq/bdUNFwTDnHCXu5vdwHSNmP7T3yuhy8K9P+M95vYbA5STJOSfgc37VSP/ttbrK7R6
         jlISK8kLlMP2oYwfXqmkLs9dVgVVu51tUvEBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QBasbgDBBBZgS2pVJekzI8/+EO3uoHDtSFy2Fyb2GE=;
        b=OGpSnaUioKVaIXkoCNse0sgc74C3YqDOylIH3rk9qVqO7/yaBpaIEFne/7/E+kkLUh
         W1F3LzDMUKLGeL//yRPlV3gt0rf6T0nHmiIKmI7k2FsUF1o/RUFa8lzLWR2/+yJTJfXy
         tHk7MoN5YCcuYH1Ht+XfViJM77GkVDkrJflc0YMYslu/+ix54421S/Kp4YeguwUYlnXY
         +ygFEhAmZq13byfiKB08HUUa/97q8oM+QVpQ8QejW0Wu/KkovwZrKH6y6GBuU37wECjH
         ZSw9Zj9JQSZ0aJebQ5RZWhzYX5tAWqfmyE9gFCo3A6DP9k4BdtXlVZeTO+gcdyvnzxcK
         DO9w==
X-Gm-Message-State: APjAAAVg19/DESPQUFD3crk3UdW89idifxjZNka6OLbbvKGQTtFq6Rtz
        ZrMuSZpvjFzJAYmAJu6aoBO/EB7BeNw=
X-Google-Smtp-Source: APXvYqyA3k4wu/sKxjUmJZmWMquSB/yoSAkLfl2c2ZqgT74G4f4sOmA87Q4XcgBnKYgMSOqbJNyjfw==
X-Received: by 2002:a19:189:: with SMTP id 131mr11910785lfb.74.1557166030435;
        Mon, 06 May 2019 11:07:10 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id f2sm1682377ljb.63.2019.05.06.11.07.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 11:07:08 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id k8so11895375lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 11:07:07 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr13096464ljj.79.1557166027424;
 Mon, 06 May 2019 11:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190502181811.GY2623@hirez.programming.kicks-ass.net>
 <CAHk-=wi6A9tgw=kkPh5Ywqt687VvsVEjYXVkAnq0jpt0u0tk6g@mail.gmail.com>
 <20190502202146.GZ2623@hirez.programming.kicks-ass.net> <20190502185225.0cdfc8bc@gandalf.local.home>
 <20190502193129.664c5b2e@gandalf.local.home> <20190502195052.0af473cf@gandalf.local.home>
 <20190503092959.GB2623@hirez.programming.kicks-ass.net> <20190503092247.20cc1ff0@gandalf.local.home>
 <2045370D-38D8-406C-9E94-C1D483E232C9@amacapital.net> <CAHk-=wjrOLqBG1qe9C3T=fLN0m=78FgNOGOEL22gU=+Pw6Mu9Q@mail.gmail.com>
 <20190506081951.GJ2606@hirez.programming.kicks-ass.net> <20190506095631.6f71ad7c@gandalf.local.home>
 <CAHk-=wgw_Jmn1iJWanoSFb1QZn3mbTD_JEoMsWcWj5QPeyHZHA@mail.gmail.com> <20190506130643.62c35eeb@gandalf.local.home>
In-Reply-To: <20190506130643.62c35eeb@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 11:06:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
Message-ID: <CAHk-=whesas+GDtHZks62wqXWXe4d_g3XJ359GX81qj=Fgs6qQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 10:06 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Can you try booting with:
> [ snip snip ]
>
> And see if it boots?

No it doesn't.

Dang, I tried to figure out what's up, but now I really have to start
handling all the puill requests..

I thought it might be an int3 that happens on the entry stack, but I
don't think that should ever happen. Either it's a user-mode int3, or
we're in the kernel and have switched stacks. So I still don't see why
my patch doesn't work, but now I have no time to debug it.

                   Linus
