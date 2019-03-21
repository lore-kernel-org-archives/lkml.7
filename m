Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DF2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAFB21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553192490;
	bh=S2HUQmV62FrUUAvEDQQjxG+gMpzppHGa21/2LuT5mfU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ve/gHzUzu+Er0jEZXcmwudQ96aTVAUoudLvVb3ceUAim7RtnUO8rJ+gygSZu5QYRj
	 6WDwDQ+te9Xlcrl+ofHlmuI6KExrLn5dUbIL/CBVdjod9yUFWvC3NMCkflIgFXO+xC
	 ktRx55kpd+wjDLurfQ2/o5+DbKKOsSksQD1zHSoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfCUSV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:21:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39492 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbfCUSV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:21:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so5296316lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+0b9VVczCNu771OwGdqYsi7tYY4OdHda2cZMvBhZeE=;
        b=PcxwRvzfg4AwdcOUXpwt2G91lZCl071d626fa3eMevbEDNpke9EqVLxuvHp8DjpcgQ
         yUDZBoPeWIKziXNUKDwVUAj/WWfCP/9CXl+PhrC32AzAQ7cJCHQdPjfs6HOOUwCN7TAK
         EKUm5UHxzRJfAmR/nGODH92ggFCQX6HwH5Wcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+0b9VVczCNu771OwGdqYsi7tYY4OdHda2cZMvBhZeE=;
        b=f0QkzYluTg9rn3ZXYhdPk5bbC8L6my5fhBXEha4hHsJpGhQ7R6X6DgSlegVw2mRpOt
         L72qk+IplNuySo2wc74PT/RVSW2qicmTzQMKNSVHGttL9blsSZIZt50/bz+f826BaBo+
         fUAjRPL4JpvuP2gXSkXEQ2PRi2UIKj6cv5NeBXVOzoCBlUMV5IXsx22EDlUftJuWS0Dj
         gVnFST1jazJGRSdQ0YnmT82H/JsrSJwnEbfJ+mF5u+49DxBc7mYoGn0zizB0+OKppDM8
         tuikoLFL+BepUa3AvX8/8SWN1YbQqoroxDduJ//V7xzVr9aOjW2vDZXRNdLQyYdQQBPf
         1AFQ==
X-Gm-Message-State: APjAAAVfb2poRcsRMDA1RYAdBxrLqqR5U48y4/mhNkRtyVgZrPpt3VU0
        8YLJlg6TF2y2u+jfu2W1nn1OLQVJnP4=
X-Google-Smtp-Source: APXvYqywK5MmL7AIg11b9x51h0a/kyPkN8TBuvONT7fHUsxvIrJgwe2tETr9+VrXGGn3WvzK2AZhVQ==
X-Received: by 2002:ac2:4355:: with SMTP id o21mr2848602lfl.85.1553192484472;
        Thu, 21 Mar 2019 11:21:24 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m4sm978169ljc.28.2019.03.21.11.21.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 11:21:22 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v22so6123636lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:21:21 -0700 (PDT)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr2781480lji.125.1553192481488;
 Thu, 21 Mar 2019 11:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190318153840.906404905@infradead.org> <20190318155139.963285969@infradead.org>
 <CAHk-=wgYUTJ33ANOF5=5AKafzgqCi4Xe9iRCdgUV4s05HrH_Pw@mail.gmail.com>
 <20190318173657.GV6058@hirez.programming.kicks-ass.net> <20190318175135.GE6521@hirez.programming.kicks-ass.net>
 <CAHk-=wguWBY_W8-M0vSCae538mAY2vQtkrdNbZX4T8rvAYxPxg@mail.gmail.com> <aac45ef8-0196-b1c4-67ce-26dd0da6d641@redhat.com>
In-Reply-To: <aac45ef8-0196-b1c4-67ce-26dd0da6d641@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Mar 2019 11:21:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhfkKxSbJ+Ag6rw5jOp2MjXLwDaswbUWYmdK5vA-N4Fw@mail.gmail.com>
Message-ID: <CAHk-=whhfkKxSbJ+Ag6rw5jOp2MjXLwDaswbUWYmdK5vA-N4Fw@mail.gmail.com>
Subject: Re: [PATCH 01/25] x86: Make SMAP 64-bit only
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
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
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:25 AM Denys Vlasenko <dvlasenk@redhat.com> wrote:
>
> >
> > But iirc pushf/popf isn't really that expensive - in fact I think it's
> > pretty cheap when system flags don't change.
>
> I did not see evidence of this. In my testing,
> POPF is always ~20 cycles, even if popped flags are identical to current
> state of flags.

It may have been an artifact on just some older CPU's. I have this
distinct memory of popf that changed IF being more expensive, but
maybe that was the Pentium 4 days.

Or maybe it's just that my memory is garbage.

               Linus
