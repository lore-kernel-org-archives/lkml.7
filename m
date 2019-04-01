Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ADFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6FE206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554156827;
	bh=ZiU1P9EmPonvwt1DvQsS/U8iVcOs614R8IuRu1Qz7XY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0O+w9Ae177j0yucHm2w6q/oduTpluJMmPfiWgJWoR4lF0oqq9Xe7Fmh2rlEDVmoiX
	 um/4iY2WCes0jNrbkMPO4UF3/NSwpiPclakYF6ClGd3rqLo7vK4sy0CJ/YnG/U5dqg
	 dCU4fzAtNeclIlN7S85yeb3zS0MiK6t6CTD28eLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfDAWNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:13:45 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45056 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfDAWNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:13:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id 5so7432510lft.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 15:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyR+k49lcmz90Oo2ydMeShomW51EpxrQc9r10unpFSI=;
        b=WU0ohB8e7Zo5RCQUfpiq49pnyDsfOfwARf6PWjaZaT+X6PBo4Ww1o7K1g48oYa/6iv
         s4xKFot1JmEmQ90EPRzPlhh/mlQKMOz3W5Uo409GDUGqPexm0ccpfXo4B9j/JPDx/O+d
         DbRTOmvrayyRV1twNB3AClrxuOr4V/pNemEqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyR+k49lcmz90Oo2ydMeShomW51EpxrQc9r10unpFSI=;
        b=HL2mYDOPuHjHRK9Lh3Yj0TQqs8veiXPku4z9XgsjWJ9nLwwFCBu9SoDAuSKEfBFDgR
         0oFwukFtKWou2fq5ko/h4Z+8oKwNtqEksbOe0K2boHMxp0HR2IoFuMcbcNTRKvLzPzxd
         mfox/8O1wuy56vP93NTNYXEwN/iQH8RbJW16XIgUer6OFBflK4ZnRM54ghUtSABYHgez
         ACxFR9KxeW3+Y0o+EVb5sw7vLwQhXAYGwrxpMBfv9L5yqgjDUjWCoSOKyPcbk9fG/MyV
         p9i70lup7bCRMy1nNjXamgmD/KaTMAGnQZs64GfN4+Tr2VlFKL55WlQpQIxqJRWFTQf2
         6qQQ==
X-Gm-Message-State: APjAAAXY8t7Jc/aHDQ/SFIgSZxs8HCAHqsd0n4WUfq8MmxiYJR6UqUyX
        cYWEyBC8VA4EpaFMF4nbKGMb/HsiyiY=
X-Google-Smtp-Source: APXvYqwtB9jwnxhn6XCvd2UKc4o1ihUlIQfPaGdcXxK+6Dvb24d++hme/fLr1a3PhWaTCUeDCYk9Ew==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr35786308lfk.25.1554156821837;
        Mon, 01 Apr 2019 15:13:41 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k25sm2410867ljc.14.2019.04.01.15.13.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 15:13:40 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id l7so9673911ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 15:13:40 -0700 (PDT)
X-Received: by 2002:a2e:8108:: with SMTP id d8mr10332578ljg.57.1554156819972;
 Mon, 01 Apr 2019 15:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
 <CAHk-=wgKOJTdN9TqyjW6FngEZvgUTmCDzJPRrtekW_1SD0gfhw@mail.gmail.com>
 <20190401194214.4rbvmwogpke3cjcx@brauner.io> <CAHk-=wgjndAqzMBxgXZxbSRXLRqdXtNM3aHc9X-xj+Px1fsG-Q@mail.gmail.com>
 <CAGLj2rFvWE6ENFyKSbZMrhqSrLjkm0YrRh2+O0LC04HmJuEY5g@mail.gmail.com>
In-Reply-To: <CAGLj2rFvWE6ENFyKSbZMrhqSrLjkm0YrRh2+O0LC04HmJuEY5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Apr 2019 15:13:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDjdoS4erUTjWaHMY+ZT28omwA24pPMRoQEE-rtNcRpw@mail.gmail.com>
Message-ID: <CAHk-=wiDjdoS4erUTjWaHMY+ZT28omwA24pPMRoQEE-rtNcRpw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 2:58 PM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
>
> You mention the race about learning the PID, PID being recycled, and
> pidfd_open getting the wrong reference.
>
> This exists with the /proc model to way. How do you propose to address this?

Note that that race exists _regardless_ of any interfaces.
pidfd_open() has the same race: any time you have a pid, the lifetime
of it is only as long as the process existing.

That's why we talked about the CLONE_PIDFD flag, which would return
the pidfd itself when creating a new process. That's one truly
race-free way to handle it.

Or just do the fork(), and know that the pid won't be re-used until
you've done the wait() for it, and block SIGCHLD until you've done the
lookup.

That said, in *practice*, you can probably use any of the racy "look
up pidfd using pid" models, as long as you just verify the end result
after you've opened it.

That verification could be as simple as "look up the parent pid of the
pidfd I got", if you know you created it with fork() (and you can
obviously track what _other_ thread you yourself created, so you can
verify whether it is yours or not).

For example, using "openat(pidfd, "status", ..)", but also by just
tracking what you've done waitpid() on (but you need to look out for
subtle races with another thread being in the process of doing so).

Or you can just say that as long as you got the pidfd quickly after
the fork(), any pid wrapping attack is practically not possible even
if it might be racy in theory.

                         Linus
