Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45613C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FDD2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557853695;
	bh=6Bp7u/hjaY6JED/b+zGTgJh6VcSKEyTH0NAOhu8zoIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Lr7Wc4REi1hV3fUZdd2ndqDYVHfz2kgmhIhrsApPjDdhrLHw94MqL5idW2cQ53LXl
	 PmiEXIqiAyvy9XTBDHHP8pY2kaGIdUfUXSuGAZMFmSYzGW8us4X95p9mCjgsitTmyC
	 g7jOhfApTcFMaJ9cfs9RkXIyJQ2mQWkYGlYZpvwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfENRIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:08:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44212 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfENRIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:08:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id e13so14996420ljl.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ex9PPn739Xr+bGkq3/whL7LXHhKWhdJEiYFtfuJN3g=;
        b=O/8QoiKxXWtyVM4OLdq9hhH6iJGOIMQhyrS7akn0/RQ0332RmNdKap3tf+MbEVOieh
         U54FKLqq+K/tHAkrpmWIsKsfYE2IoIRWtDzVSWhTyFj5zSSgwXvZS10+exiHTdSMn/z7
         CZmFqwK/jlzEfEx+SWY6dKNc0pdVuZenJJhmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ex9PPn739Xr+bGkq3/whL7LXHhKWhdJEiYFtfuJN3g=;
        b=IupnVUnJFhGXMrToKgCT3kU8Qrks3H7hKn1UcsKhpAskr3Zfuz1qJR3ks3cRECaS4r
         7+SvcN86mE5a9Acx6b+0NrpqjtyxJzBsR0509RFIyRg/c8H2tMbXm8dexcblimeVtwWj
         eMn5bYXqAGL9/A729CW20P5ef46ARQfhK/yM0hgfbqWOZpJOu0WQXs8miLfrObzivv3Z
         2Gqf8YnApHq3sqtI8vU+6xiRaxMH95UiiRSLblCcoTnQUFB4mTnZg3cP1YcQZl5BzQkw
         WmPHoouu/U2I4iuEXBEMNCZMBKl6K7YQoXYVUi2VcYQwXznwjivmgBTQZrVeITfEGJak
         veIw==
X-Gm-Message-State: APjAAAWUhgN6Emv8Ihogre+w44P0dJuDUo59GAAoCF9aHnlWSpmfteNK
        8shuOoEz/TuXCXQHz7fVUcDh6HtyciY=
X-Google-Smtp-Source: APXvYqxfhuznj7GcI80fNlZY+uPimW715DGNM97LUu4AP1PgeWtIKIIX7sbTwiFxzd2xF+K1uRpjXg==
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr17480394ljc.46.1557853690924;
        Tue, 14 May 2019 10:08:10 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t7sm372102lfq.39.2019.05.14.10.08.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 10:08:10 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id w1so12464178ljw.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 10:08:09 -0700 (PDT)
X-Received: by 2002:a2e:a294:: with SMTP id k20mr12284722lja.118.1557853689354;
 Tue, 14 May 2019 10:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190424123656.484227701@infradead.org> <20190424124421.636767843@infradead.org>
 <20190424211759.52xraajqwudc2fza@pburton-laptop> <2b2b07cc.bf42.16a52dc4e4d.Coremail.huangpei@loongson.cn>
 <20190425073348.GV11158@hirez.programming.kicks-ass.net> <20190425091258.GC14281@hirez.programming.kicks-ass.net>
 <20190514155813.GG2677@hirez.programming.kicks-ass.net> <CAHk-=wgxT24Z6Ba_4DKbMfBnQ0Cp4gzwp6Vq1aBkU5bsjqKUhg@mail.gmail.com>
 <20190514165614.GV2623@hirez.programming.kicks-ass.net>
In-Reply-To: <20190514165614.GV2623@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 May 2019 10:07:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgo_NxNYBSfSSGUV=CJPsz6nm_H6UnwsArBb-9GZ_sY_g@mail.gmail.com>
Message-ID: <CAHk-=wgo_NxNYBSfSSGUV=CJPsz6nm_H6UnwsArBb-9GZ_sY_g@mail.gmail.com>
Subject: Re: Re: [RFC][PATCH 2/5] mips/atomic: Fix loongson_llsc_mb() wreckage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     huangpei@loongson.cn, Paul Burton <paul.burton@mips.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "andrea.parri@amarulasolutions.com" 
        <andrea.parri@amarulasolutions.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 9:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Understood; the problem is that "*p++" is not good enough for local_t
> either (on load-store architectures), since it needs to be "atomic" wrt
> all other instructions on that CPU, most notably exceptions.

Right. But I don't think that's the issue here, since if it was then
it would be a problem even on UP.

And while the CPU-local ones want atomicity, they *shouldn't* have the
issue of another CPU modifying them, so even if you were to lose
exclusive ownership of the cacheline (because some other CPU is
reading your per-cpu data for statistics of whatever), the final end
result should be fine.

End result: I suspect ll/sc still works for cpu-local stuff without
any extra loongson hacks.

But I agree that it would be good to verify.

               Linus
