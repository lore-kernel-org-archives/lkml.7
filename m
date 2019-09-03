Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6591BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B00A21881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567530523;
	bh=2qGxsAY3niXX25H5ZCs+XwFEk5SyMC+WHkBGUXc32hg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cmwx76ebDEy5zy4Zlio/HT6ED6Mc/+9T2mlO9KkTD1yb8S08bYRyUzlSiIpmk5O+j
	 EoqBD2rgvDhwOse+Qb8F4XWIJG1nm7QZoEo7xRg7rGmYtsdS8fzL12XekxIxKU248u
	 sbhCl905aibkgQB+NvTDQO/l10PY7aMZDQEnZLhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfICRIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:08:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43039 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfICRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:08:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id d5so5834285lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/jJDGkq8oBPM3T63/+UYh9pnVX7abLZtO0vT5E+2EmA=;
        b=Iqzvar997Z68mEga73kvm0pCGRdq9rvqLMqMQ3fQlSs6OW0wCqHObv9P/HeFkStbvV
         sDe56NXRgviwNNWr1F/TnU8PejR0lv6UIvY40yJGRgYP0xj/7oG9OjWgwrCjjkuZQ41Z
         KHmfleHjtocIccea1MeWuqkAPz9fiIzyD6EFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/jJDGkq8oBPM3T63/+UYh9pnVX7abLZtO0vT5E+2EmA=;
        b=kXZ3j5ZPAUrJX/d0I2fzvYzGiyuazIDGKiEQnYr9XvzZ3a8RqgaQJQSoj51G4hcIpL
         KUBer1VsZSf+R4zE5mhjDssxpLC1VobOkxjcGKG+3MpILo1EBergcjB9RxUG9N/mDkX3
         mJU/MrvHBq38fNq4WU0tNXZbaahgy2t68fJ4ihcMeXmLPLcCVUZTAF5eJUZORnZYAlyR
         CSnR1UAbm+tKNDXJXbQeYaT4TcnLZvblSR+7Uk9j7iZmQsGpCLIzAHpPzYlhttAClpew
         E7Abl4Fh4WRZGwxOHfCIYgeUgVKRRyWsfPl8FWq8+l2d8fFUE6xwc1itb57pkUeaEv2E
         Jpog==
X-Gm-Message-State: APjAAAXw7v44EoKwu71ao3b6ktjXvqm74owLEwnrh5UY6J+FDno4BFwF
        8/7RANrNsHhz+9nouJNdng5jam1zX7s=
X-Google-Smtp-Source: APXvYqzho0QIYnH9f46cLAODNoCTKErvRAZUoiWFTFdSvSCWaONZXYw5IoWswzDCLlMDXxEo5CQs5A==
X-Received: by 2002:a05:651c:20d:: with SMTP id y13mr15351066ljn.112.1567530519102;
        Tue, 03 Sep 2019 10:08:39 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z18sm3377440ljc.45.2019.09.03.10.08.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 10:08:38 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id a4so1775876ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 10:08:37 -0700 (PDT)
X-Received: by 2002:a2e:3c14:: with SMTP id j20mr7261749lja.84.1567530517568;
 Tue, 03 Sep 2019 10:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com> <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org> <20190902134003.GA14770@redhat.com>
 <87tv9uiq9r.fsf@x220.int.ebiederm.org> <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
 <87k1aqt23r.fsf_-_@x220.int.ebiederm.org> <878sr6t21a.fsf_-_@x220.int.ebiederm.org>
 <20190903074117.GX2369@hirez.programming.kicks-ass.net> <20190903074718.GT2386@hirez.programming.kicks-ass.net>
 <87k1apqqgk.fsf@x220.int.ebiederm.org>
In-Reply-To: <87k1apqqgk.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Sep 2019 10:08:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
Message-ID: <CAHk-=wjVGLr8wArT9P4MXxA-XpkG=9ZXdjM3vpemSF25vYiLoA@mail.gmail.com>
Subject: Re: [PATCH 2/3] task: RCU protect tasks on the runqueue
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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

On Tue, Sep 3, 2019 at 9:45 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> So with a big fat comment explaining why it is safe we could potentially
> use RCU_INIT_POINTER.  I currently don't see where the appropriate
> barriers are so I can not write that comment or with a clear conscious
> write the code to use RCU_INIT_POINTER instead of rcu_assign_pointer.

The only difference ends up being that RCU_INIT_POINTER() is just a
store, while rcu_assign_pointer() uses a smp_store_release().

(There is some build-time special case code to make
rcu_assign_pointer(NULL) avoid the store_release, but that is
irrelevant for this discussion).

So from a memory ordering standpoint,
RCU_INIT_POINTER-vs-rcu_assign_pointer doesn't change what pointer you
get (on the other CPU that does the reading), but only whether the
stores to behind the pointer have been ordered wrt the reading too.

Which no existing case can care about, since it didn't use to have any
ordering anyway before this patch series. The individual values read
off the thread pointer had their own individual memory ordering rules
(ie instead of making the _pointer_ be the serialization point, we
have rules for how "p->on_cpu" is ordered wrt the rq lock etc).

So one argument for just using RCU_INIT_POINTER is that it's the same
ordering that we had before, and then it's up to any users of that
pointer to order any accesses to any fields in 'struct task_struct'.

Conversely, one argument for using rcu_assign_pointer() is that when
we pair it with an RCU read, we get certain ordering guarantees
automatically. So _if_ we have fields that change when a process is
put on the run-queue, and the RCU users want to read those fields,
then the release/acquire semantics might perform better than potential
existing smp memory barriers we might have right now.

                 Linus
