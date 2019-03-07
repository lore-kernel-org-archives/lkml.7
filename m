Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACD3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0132E20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551981693;
	bh=O+bRqHthnwvyPcuC0Q+KKKGemMBCFF9fEIk1FchSqbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tUKfBUg7vK+mLEzRAxku5VJyC+vHVtvKLdki73jhOKXhDZhP+j8FNMHT1BH6ZIBKu
	 nLGyeIhFB7esAQFHWJYsMkmjyFylFvdzUIgfwEWfk/QG6CmVBni2rZhoULRqtFGG7a
	 P0SSFn/heuUuCmweRqdO7hMopw5wPkleA5NSC0IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfCGSBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:01:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42304 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGSBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:01:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id d14so15062999ljl.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36kE0MkjNErUKnrp0BPqSQ3I9YheVL32EsxlaB1Zqaw=;
        b=FhHNRP++Rj3t91SJAsxCUhLZm4eFqEeYml1UPR53Ma/g+zafmKyQmDN65Ti9LF/3Qy
         TSxxWQ4K/u6Wt94HMWR6D9o12999pFmVRMwXgVNmJ998JblJrwL4nUhrBgwNQ6pFzFuS
         DwgwVWKQWA7y4n9Y2fF8yvWvafIW3g9otyucA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36kE0MkjNErUKnrp0BPqSQ3I9YheVL32EsxlaB1Zqaw=;
        b=LCOoWUb7/BLNyb03Noxndnh+u0exA7iAqnGcDDV7kDMFVDlm/lqvVm91izfEP7RQFH
         3su6lQ2YVu8u33OygUpbXvR+otim+dw4hcvQuxMBfFuuL3a1HdwOmvu3nUWgKJaB9wc6
         Eeh+xySNWP8XffCEELovXFJweTj/Zob3AxvVntKJNztc7ThCYcHlfWSHgMjsrekl7cgC
         3U2dIV2/tsBtzIKlJMZq+JfAhBf5o2FBawO8KXLUzQyD5gs4nbw/w0XuWcYzrFq5Wbjc
         9pvvO++jMFxItF7ARw9KSHR3yUtvyFheg98pJN3173zOn/xdmS5Sw7Iro5uQbEa1z6mn
         kgfw==
X-Gm-Message-State: APjAAAU2v3navmjJ5opFNdVHV6XQbhcXM+6jUoqj9iDjwAnWKSL7kBVw
        GTs4FZRvtS2+JfHSLCf5zkIV2ECy+74=
X-Google-Smtp-Source: APXvYqwtsRO/h51dyTPiEPu1jH6+p7wzX6v5dlu6NEVp4fpCl61eB56HC467P0aQ5OytsVVp0T8a9A==
X-Received: by 2002:a2e:9607:: with SMTP id v7mr6720271ljh.154.1551981688503;
        Thu, 07 Mar 2019 10:01:28 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id s73sm515055lfe.3.2019.03.07.10.01.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 10:01:28 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id z25so15070447ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:01:28 -0800 (PST)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr6579542lji.135.1551981269940;
 Thu, 07 Mar 2019 09:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20190307114511.870090179@infradead.org> <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com> <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Mar 2019 09:54:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com>
Message-ID: <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com>
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
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

On Thu, Mar 7, 2019 at 9:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > What's the call site that made you go "just add __memset() to the list"?
>
> __asan_{,un}poinson_stack_memory()
>   kasan_{,un}poison_shadow()
>     __memset()

Ugh. I think I almost just agree with your decision to just let that
memset go unchecked.

I'm not saying it's right, but it doesn't seem to be a fight worth fighting.

Again, maybe we could avoid the static checking entirely for the
complex configs, and just make preempt_schedule() not do it for AC
regions.

Because AC vs KASAN in general ends up smelling like "not a fight
worth fighting" to me. You've done a herculean job, but..

                 Linus
