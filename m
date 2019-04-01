Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A858620883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140814;
	bh=5kyvTziVK9q5Nj8Q5xIZp7rNJGdb63pPF2u8A4oxgYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uBvKh6boPv1TbrkbsC6rm5UMNbEjOxGIygr+WKFf2QPu82BTfXQmQpkAIXawZQXx+
	 MEZzdIkWoEkDbuEjNNqw0r2MK8cJ3mIDKZfpFH43kRQAP5DXdfzlf9dVxKNMEWoEJW
	 qAfPv/UHkuvzbnOfX42nc99RXP4nTJOiSrhg1eMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbfDARqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:46:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45693 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732735AbfDARdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so8939691ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkVyCOCzlPevBGlHkhyB6pYv+tZ/Vf3HjXGMcg8N2bk=;
        b=Ya86KO0ODqDU5WICgG5ENr8T+5l2RBH8Lsx3IKCO4ADslV236uh+SFGLOUnzv8flov
         2LzHpTjxJCnavJJwJRKWZOE+7FnFSPHXxOhiqr3WGVZxTCikpRoXLlL9UJDjfB8ZLC/T
         IXcu528lX/McaTj7GMUua9lG+5s4A9CDzhez8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkVyCOCzlPevBGlHkhyB6pYv+tZ/Vf3HjXGMcg8N2bk=;
        b=jkNN94fJ4gI6lD7SFnO+plszvWAG4e0IHOvZUjhwamj9v73sl6Ff6H98iU9Ggn/xIb
         XVns7yGOs0u/dmJPw4rNb6puXqnp/N5pbFHjrTggeZBwDzMM7q6iGrFUUJ6qy3GE5Mgc
         /VsKme/CwIAjmyVT6NebYS2NqrruNOAE0DfqR6e0gI7+WY6vmQhCMC3wjpNELh0WRjbI
         oZYBs01KpYgDl3l2eNOX+cR5Out65sFTLU5l93OtDAZ53SOQc5HmpeZjkwxRGaxic6fE
         7S+HSsVrv79PvA0Rct0PzfGQejA+op610iMltCr4Q2fprcZZ4mzm9i5sIgIEZagPtf1k
         Je1A==
X-Gm-Message-State: APjAAAWUD4hCQKqyQTilAW0OPf2MgPtUwmiKQlcwiasYfU4Q6Wk4koPK
        n0n96CFc6WJUSM2ZKXMKKr202JXRX0A=
X-Google-Smtp-Source: APXvYqyYNhYObFxmgChdJ2yit/DCBOqXv2zbKxxQhIxCRnkMoIEWZFl3VTsm5d4cJNzQYEvYB4GGDA==
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr2291787lji.163.1554139979408;
        Mon, 01 Apr 2019 10:32:59 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id l12sm2006897lfc.61.2019.04.01.10.32.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:32:59 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y18so6918895lfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:32:58 -0700 (PDT)
X-Received: by 2002:ac2:5479:: with SMTP id e25mr30308085lfn.121.1554139978264;
 Mon, 01 Apr 2019 10:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
 <CAGLj2rF85hZLAR79oEA1dQARadw1OHr8bxqCLbvO6g9B6ou2Qw@mail.gmail.com>
 <CAKOZuetovU9NawSjUfGTAwXVfnmKC9GFtmS8FxAE5Hjmzq0HHA@mail.gmail.com>
 <CAHk-=wjgENV0pT8=MjB1UVBeWCrECCNXv15AKKX7Kfg7Eak7qw@mail.gmail.com> <CAKOZuet2QCoW1XMpTAzXS868PhF-gh14czFn4gwE4A=oX=Yr8w@mail.gmail.com>
In-Reply-To: <CAKOZuet2QCoW1XMpTAzXS868PhF-gh14czFn4gwE4A=oX=Yr8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Apr 2019 10:32:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXsK1X=PUaHNT9V-h+v2maB1bLA0P3XHXBNRa0e299XQ@mail.gmail.com>
Message-ID: <CAHk-=wgXsK1X=PUaHNT9V-h+v2maB1bLA0P3XHXBNRa0e299XQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Daniel Colascione <dancol@google.com>
Cc:     Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
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

On Mon, Apr 1, 2019 at 9:45 AM Daniel Colascione <dancol@google.com> wrote:
>
> But doesn't the CSIGNAL approach still require that libraries somehow
> coordinate which non-SIGCHLD signal they use?

Yes. As mentioned, this was seldom used.

In some cases it's ok, eg aio would just specify the signal in
sigev_signo (except it was never fleshed out to have sival_ptr etc
because nobody ever did it, afaik).

> (Signal coordination a separate problem, unfortunately.)

Yeah, in several cases you would just want to signal a handler
directly, not an index into handlers.

Anyway, I'm just saying that the whole "reap children" part is not
necessarily tied to the pidfd thing. And honestly, nobody ever does
anything like that anyway in practice, because of all the other issues
it causes that you'll hit.

                 Linus
