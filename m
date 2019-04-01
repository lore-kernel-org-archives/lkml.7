Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A566C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89AA21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554135674;
	bh=2V/Ko7PyNJhIDy+yWZwaYRj3fj95SNnYqlq0HYIobZY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QLxIJEANDyeOs/KLDMlQgQdhUi28G0EssS5ZGKkv7b5X1GQM7WVV7BHxx2G5ktOle
	 iQiiFWBujlN12SyHOVGPgSuiTi9TLHQOS7IAkHr91kR3lxPqBYkh7Sbf8j789djMVY
	 7b0Cy1L/IwtD6QnoRO26NW3zJoAEY5sOTC8k4uaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfDAQVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:21:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39467 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfDAQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:21:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so8737673ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PrygaNWnDryni1ERH41cFwgQicTFKFc+tb7/PeD2atM=;
        b=Nc9ot7kgr5Wnyws3ntu/9l9X0TejONtrYeAwrslYZsvTM1m3DuvDkC4aJ7F9ZLzmHC
         oWfLq1vCH8JuktU2b0G2yFQJ/96WLOnfoUPMXt/ULaSkLYqmxfhHlVw2J7EnnxNBviwS
         msT4XkikFVtNmWUZhi7izBE/mmDpS9ubSD49A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrygaNWnDryni1ERH41cFwgQicTFKFc+tb7/PeD2atM=;
        b=DN/R/BeJvqSlddDp/xu78RIUccMBe8kq18JIwei6ZJUIdrmbRVaEA/oxx8QXzDxsSO
         wZywzUe7tppT+YY80whDhRAgC8cS2E5qwzZnMl8IFXdS9UzDJNNlu7M7fwtZbziN4VJr
         iM9oZ4hxeiAX6DBNfxuQT7LyezB0ZzQnK6+vfMoTZy6s8pbFMhGVNQPvQjCcpToFGj/y
         W4GuzBeVthuUzgfY3Yx14Z3G3JgF/4TVpDv/wqZ8RsiUNmP44Pv3ggc0FMtcLPChVv3x
         Mm7T6B8HtAPF1/VqZJrezx8Tluke8orzvVsOVo5jlLIhhPFQ3j2oy/DYiHlCw6kyND5p
         bARg==
X-Gm-Message-State: APjAAAVe1Ot1xNbTV17mR0lvIf8RahyFB/MiIiFjAeP7QA4CbwY08C8l
        jxt5fKw83ELNlymHAAnBxl6LUq41g0c=
X-Google-Smtp-Source: APXvYqwrC0E5nhqv+SYAHDfrk/fW+zGiZiHJfFYxOs7nXIAdM3zUjgmBTkdj6rsO3v4YGZYnjkzHjg==
X-Received: by 2002:a2e:1311:: with SMTP id 17mr14120365ljt.75.1554135670547;
        Mon, 01 Apr 2019 09:21:10 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id v10sm1933556lfe.3.2019.04.01.09.21.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:21:10 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id j89so8760031ljb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 09:21:10 -0700 (PDT)
X-Received: by 2002:a2e:8316:: with SMTP id a22mr35528351ljh.171.1554135316678;
 Mon, 01 Apr 2019 09:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net> <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
 <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com> <CAGLj2rF85hZLAR79oEA1dQARadw1OHr8bxqCLbvO6g9B6ou2Qw@mail.gmail.com>
In-Reply-To: <CAGLj2rF85hZLAR79oEA1dQARadw1OHr8bxqCLbvO6g9B6ou2Qw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Apr 2019 09:15:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1UEsMv5wmBZB5S+5YiCbxd-AtVsoz1TfuD-KrdcLQew@mail.gmail.com>
Message-ID: <CAHk-=wi1UEsMv5wmBZB5S+5YiCbxd-AtVsoz1TfuD-KrdcLQew@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>,
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

On Mon, Apr 1, 2019 at 9:07 AM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
>
> With the POLLHUP model on a simple pidfd, you'd know when the process
> you were referring to is dead (and one can map POLLPRI to dead and
> POLLHUP to zombie, etc).

Adding ->poll() to the pidfd should be easy. Again, it would be
trivially be made to work for the directory fd you get from
/proc/<pid> too.

Yeah, yeah, pollable directories are odd, but the vfs layer doesn't
care about things like "is this a directory or not". It will just call
the f_op->poll() method.

              Linus
