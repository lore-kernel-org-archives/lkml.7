Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF79C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F24241CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KTEDuF6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfE2VDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:03:12 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36017 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfE2VDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:03:05 -0400
Received: by mail-oi1-f194.google.com with SMTP id y124so3273008oiy.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrCXOU+Fm+D2XlSRN/oeiwuNWs703wLzrQB7UZuJ5ic=;
        b=KTEDuF6OHEwEqFAKEWrxlaTwkqrnqj7E9yKJ0O++zOhyyT4Fp5kRm5PM3usoPHtu/3
         LjzFFhTrvV6ILOW0jympmFuRwzD0DMCfpI+fHJt4DZ7zrHwddOdVah83xhqgQv57aY92
         k+8g4PiKSxk3hYqSjGtff1InjUdNb4ES6hebQmnP5kRDjK1Pqyzs240Jlxqi9S2MxO8m
         k58BERuICI8nv9UQ2xFzlnbdPf4y9UpfUIQCdonyOYVv0WhCddsh6sxut9+nvdPsSOXM
         Dz7KaqHhArEBPacWAdSJnzHETpCdV9Va1tCAhrXglXPP20wPYHMQfLZUEVZpFApyFCYR
         up8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrCXOU+Fm+D2XlSRN/oeiwuNWs703wLzrQB7UZuJ5ic=;
        b=FNQC1G2/kEwIHmSgxsjYoFeFuStF+/PWlM/Vyy05iF5VrsUePuBMMfMD6fF6xpb4Fb
         3OJvV7mtvW3nqUN2eWpdwiodTaQxxUO1lXuyb1KVy8CkDbO9hIK5sZ3NeBe1K3l1YqCh
         NRKp/OfZ0Ww+Mrkhowgwry+RYiZaKYdh3FNETIs/tRmDoPn+T8cRTFpmUAwMP4/QVqCb
         La95uEVPixm0ZeCKGML7REajNzdU0O+n0nFs9CImhS1N3MrlCwkErY4CzV9sQqmmnjE6
         JBMx4/QQhpWGJhH/PAnHh7nrRskzrd0qcPPjctYx8mpunqvbM5LM6y+lYzLYg8w8cPRY
         qziA==
X-Gm-Message-State: APjAAAWcPlX+6zenP9OS/2/SDzI5agEOkwmS8xkP5J23n5Brw9Xu2n4a
        elna2h28EqRkYmtgWjwnlb7koc8dwGMQVzJ3DnOgzQ==
X-Google-Smtp-Source: APXvYqwn7ucbSFiXzlW+IFbh7rkNfnxvOs/2khrOIorDHa5B99PJy0kfksLU3aEADcVN3E0C8Xds7J1sMzL2msNBUGY=
X-Received: by 2002:aca:f308:: with SMTP id r8mr193653oih.39.1559163784053;
 Wed, 29 May 2019 14:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190529113157.227380-1-jannh@google.com> <20190529162120.GB27659@redhat.com>
In-Reply-To: <20190529162120.GB27659@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 23:02:37 +0200
Message-ID: <CAG48ez3PCoZTqKeUJ-jLu8HtiXRf_mOcnC6AtgTc0QM0Q6VrSA@mail.gmail.com>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> On 05/29, Jann Horn wrote:
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -324,6 +324,16 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
[...]
> >       mm = task->mm;
>
> while at it, could you also change this into mm = READ_ONCE(task->mm) ?

Actually, that shouldn't be necessary. The caller of
__ptrace_may_access() holds the task_lock() on the task, and that
should prevent concurrent updates of ->mm. If concurrent updates of
->mm *were* possible, we'd probably be in deep trouble here (and by
that I mean use-after-free).
