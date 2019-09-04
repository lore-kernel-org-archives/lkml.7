Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA5C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BC92087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621231;
	bh=3/Lw2+5tkQ9b27JAWQVZ4hfFuCO6iReicQ/dfluSlQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gXthzSVCvEuOmpDyT4EAokoC8PMbUUf+uTC+ZnkfQpkSRhKXy8uVr0A8QN1WsR6TM
	 a6PH8zDd1UBnzSd5FI7nKjyK0tC77D4g37IpLRueJbCrw81GarGLLruZTl+gfwfwJg
	 GH0hSm5arz2xetFfswbo3BGS/R8bhIW4ZR3Zk62M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390067AbfIDSU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:20:29 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46059 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbfIDSUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:20:23 -0400
Received: by mail-io1-f67.google.com with SMTP id f12so28881918iog.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D27Zs+STvqIcqPGbkFvSR5YBtl93H53NlQy8TmMQ104=;
        b=FkPQsG3WR1YbR2JzeHMw/rv9JM87flNUuNo7Y+xbD2DJNytrA9+X8V+7zJ/fmuxtCA
         8xZJFPVFel2vCew6v0IXDtx5bHrTa4GvDfSh2dNDzCTNthDwmm2YUUl4/gfmcT2VbGtg
         4ApFszIbB53oyQlY9D4vR8eo4SA7jeAUSVXA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D27Zs+STvqIcqPGbkFvSR5YBtl93H53NlQy8TmMQ104=;
        b=KmS+PexwhcDjD4afZj4pWYVxTWbiSp59d8I0J+qiw+7uSM547bmgFetSO2I2SsI8Dk
         DWuVyUeRNIBugGuToBCdbJPQqKu6oLLw7nDTt3BRukexC8fk26cF8qVsp3rvUyYCKm5n
         bigH/H3FfnJ1ty1Xs3fsicupu1PoiO4kVSeQArtLDhOxiTR4usUDMDuKt/iPT2RndI6K
         zGLtsNuWRARS9SGmFzwTJCpXCD/FksPELXuf4+FrC5KEUW1YOviGTfJEgXOIeiA4uyIk
         D+8MSJqfSdVCXe8LOQBzFlKUKhhMXbMgf/3Km7+Ji4vzKnWaMKDkNTY7yss/NJji86Xa
         EnTA==
X-Gm-Message-State: APjAAAU0orkfIhzhGZ/3AFPQZpslgy6T/seYRVjHYkPhffXuh2TN0UaG
        XK8QaEtg2yJYJ2uISv/pnr0A24HdSow=
X-Google-Smtp-Source: APXvYqx4ksyIz2mp2cVEg7gzmc1wLIVctlBhstO+/w9PNAVcEaLfWYidhI8b/EOywYxqFtJebLyMCQ==
X-Received: by 2002:a5d:9c0b:: with SMTP id 11mr4273776ioe.192.1567621222620;
        Wed, 04 Sep 2019 11:20:22 -0700 (PDT)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id p9sm19328035ios.1.2019.09.04.11.20.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 11:20:20 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id n197so44426208iod.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 11:20:19 -0700 (PDT)
X-Received: by 2002:a6b:581a:: with SMTP id m26mr1356085iob.161.1567621219740;
 Wed, 04 Sep 2019 11:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190830160957.GC2634@redhat.com> <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org> <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org> <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org> <87ef0yt221.fsf_-_@x220.int.ebiederm.org>
 <20190904144415.GB20391@lenoir> <20190904153245.GF24568@redhat.com> <20190904163325.GA22421@lenoir>
In-Reply-To: <20190904163325.GA22421@lenoir>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Sep 2019 11:20:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whv60YepBaTUWnDvZ1QMezTyHLvCvzF_QgUQ+6LdrpScw@mail.gmail.com>
Message-ID: <CAHk-=whv60YepBaTUWnDvZ1QMezTyHLvCvzF_QgUQ+6LdrpScw@mail.gmail.com>
Subject: Re: [PATCH 1/3] task: Add a count of task rcu users
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 9:33 AM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> I thought the point of these rcu_users was to be able to do:
>
> rcu_read_lock()
> p = rcu_dereference(task)
> if (!refcount_inc_not_zero(p->rcu_users)) {

No. Because of the shared state, you can't do that from RCU context.

But you *could* increase rcu_users from within the process context
itself (as long as you do it before the exit path, ie during normal
system call execution), or possibly while holding the tasklist_lock
and verifying that the task hasn't died yet.

I'm not sure there is any sensible case for doing that, though. It
would have to have a similar pattern to the runqueue use, where you
add a new RCU lookup point for the task. I'm sure something like that
_could_ exist, I just can't think of any right now.

             Linus
