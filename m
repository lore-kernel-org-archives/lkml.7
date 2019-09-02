Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E6EC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA1B21744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567445708;
	bh=8yqLQHRlTZ2hKn0aZ5P8tAfcHqKi+sxVa1S+InXSiuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sT7yRHQORCBhXczSxJdb4+tSLhMoYkmPPNxaGYR2Rbqc+BV8i7UOIVlIBBZKzSr3p
	 khjuMGB9O0z5XWFzXOo8YMjJf+85jjYrn/K6supjIK+qFrGb4OkkSMUTqkEtOU7eBb
	 8+/7Nc148EtdsZ7jLJl24vsMPGGReQgIraz+7ofQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfIBRfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 13:35:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39493 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfIBRfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:35:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id l11so10921938lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCw81PO17IYjgVdOdLU0GkzKkdRKdJioIz65k0xU7t4=;
        b=eaADoccpWkAiyoyyg1k3vVA3ajT2J2VzinGEdxt4vY0XOzSh6S9MKTiGsGxYTW+KmF
         YdfdMcTrSDPfvRyKIsZ6L9mh7rw9d22oVZ2EX2VSfVtoHPk2JhCRJogRGM/PqXp+uW4x
         N6m3qfhx76piNjuVbFQnvlopj4DcLm3snNBxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCw81PO17IYjgVdOdLU0GkzKkdRKdJioIz65k0xU7t4=;
        b=D1OHGMO2pR8N9GCJ7iOz1SKVdZaVYaMxBOSwy6X2ksDSpBgu2whCqXl57d4MaTpF5v
         /y1UaqJy2XjG8H/f/Ig99fhSeQQqfx+4hM9BvwItZGX0YuPtOxr183rLwQCUkTrG4/Ki
         oDUr34IRhZCCH/adkdOOcUn4CxV1lRBJUfKR8NW8gdKWHRB/aib+93DgA7U9ueWawVCe
         fe1mQidKgg1wfIgiwrdfMFCEFM543ZRkdvbNM5DZxVzInSrWE6ZEkhgkzR6IoOTkE9R8
         KjMk4sNdTNOKZxLwknzTx7FHR3wBCFlWAE84e2OPpd+a3rzsUgyTYNmRk4AJotwFdiaY
         dPAw==
X-Gm-Message-State: APjAAAUue9LC2HGee4nhhFMdBjBCvfhfD7KWu15RbUGa/LSjpS6fK5Bb
        9ZkLm+V7G3R32LtX+FNpMDDhTXuAPvE=
X-Google-Smtp-Source: APXvYqyylpFpt/VcI8O8XquhCXZSqESbYAm5tpXvo4SBsLEsCLeju2mCaNscw6APGnGDBcGcpQopAQ==
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr186627lfp.134.1567445704151;
        Mon, 02 Sep 2019 10:35:04 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id s4sm498929lje.24.2019.09.02.10.35.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2019 10:35:02 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id h3so6706925ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 10:35:02 -0700 (PDT)
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr17066160lja.180.1567445702387;
 Mon, 02 Sep 2019 10:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190830140805.GD13294@shell.armlinux.org.uk> <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com> <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org> <20190902134003.GA14770@redhat.com> <87tv9uiq9r.fsf@x220.int.ebiederm.org>
In-Reply-To: <87tv9uiq9r.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Sep 2019 10:34:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
Message-ID: <CAHk-=wgm+JNNtFZYTBUZ_eEPzebZ0s=kSq1SS6ETr+K5v4uHwg@mail.gmail.com>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 10:04 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I like using the storage we will later use for the rcu_head.
>
> Is the intention your new variable xxx start as 0, and the only
> on the second write it becomes 1 and we take action?
>
> That should work but it is a funny way to encode a decrement.  I think
> it would be more straight forward to use refcount_dec_and_test.
>
> So something like this:

I like how this patch looks. It makes more sense to me than some of
the ad-hoc cases, and I wonder if this might be a pattern in general.

We have a very different "some users don't need RCU" in the dentry
code, and recently in the credential handling code. So I wonder if
this is a larger pattern, but I think your patch looks good
independently on its own.

But this is all based on "that patch _feels_ conceptually right",
rather than any deep thinking or (God forbid) any actual testing.

                Linus
