Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B40EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6080E2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554070630;
	bh=WBd1j6vshmBObrJwHSeDz3eFp7u4ZjaJ80OgzjPD0rI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=opWPnCSV8FeNyJJEiFLCjAx2pg8ythikU0+eW277m3tCbwlyO+WM16AHxHl/nYvC3
	 gtYMlgD24zEOGQJqobbV7LQTSwejvS89CHsQ9QLZQ9OL0L0SLwlfWiFvlo6yfVJPPR
	 WVCPNQRmVPZuki3KhGSsWM97GqcnITz/WnEgBQwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfCaWRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:17:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33753 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbfCaWRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:17:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id v14so4865723lfi.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 15:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7iWaNGazU86TlQXdHpzXsf+daDCF3+iOIFXb6JN254A=;
        b=RxVcOUq+sSCNkmtuhzEZW0gzLmPC5ePL721nNOv0uNjtVOxFK5s2+qSYnxal6L7Eos
         6t4cDvAGjDeteyR9ZA6OJ0T9YsX6pbfBaxK8C/ItD7wDLZxdPCxorteJxbjEuQZJ6+L6
         EuN5Jbg4HNSiGTmM9KAKtUzy6labYD708MKAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7iWaNGazU86TlQXdHpzXsf+daDCF3+iOIFXb6JN254A=;
        b=sOOBetie+cWjdYPNB4zJQA1M9WgsagldWxDi7AtBGdNV/v8F89tBhm+k2svCnMzNZd
         Ov8sd+oavQldd++ZcZtfanuVwJqD+lWwDEZMsbJevQbuU5//e4WRuE5awJv4D3KRrl8H
         q616JB3WAtyI/wufKyRP4MlvVZgnKZzLIeT3WNaP9hQPuhlRroOF6rjsowow/HrpsA/w
         Qd2wu1hI2n13TcEEXtDTNyeLUEK9g4JL0/JApIS1wm4ikZT37pO59lc5h5zQExBfnxjZ
         wh0xhosCJyfUx3QqiUiZJKbD+cvi2AclJWl9yvCbQI820QJ6GyCm8S9/IHONUMEuBMIS
         P0NA==
X-Gm-Message-State: APjAAAXRG8bQRBcTKPOvqdDdQg4s4o4Ebln6sky5QFVNWs9SOd2dY7RZ
        Z4aGxtWyq+bNIyW212qJGgvmu16b8jg=
X-Google-Smtp-Source: APXvYqwMccykl8XLOYg3XtL7izqjZQ4hypUWJx63btHk8vJtj4Ofp5P8vZ7ww/M8EbJ0nqoQ+ZODfA==
X-Received: by 2002:ac2:4561:: with SMTP id k1mr25933360lfm.95.1554070625630;
        Sun, 31 Mar 2019 15:17:05 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id u11sm1707800ljh.80.2019.03.31.15.17.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 15:17:04 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id v71so33321lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 15:17:03 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr30531508lfg.88.1554070623650;
 Sun, 31 Mar 2019 15:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
 <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <20190331220259.qntxynluk765hpnt@brauner.io>
In-Reply-To: <20190331220259.qntxynluk765hpnt@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Mar 2019 15:16:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0jgRkZiNdFD96Zpjx+_G+NVSHieAt+QgWCQBJ2A-5Aw@mail.gmail.com>
Message-ID: <CAHk-=wh0jgRkZiNdFD96Zpjx+_G+NVSHieAt+QgWCQBJ2A-5Aw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Daniel Colascione <dancol@google.com>,
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
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 3:03 PM Christian Brauner <christian@brauner.io> wrote:
>
> Thanks for the input. The problem Jann and I saw with this is that it
> would be awkward to have the kernel open a file in some procfs instance,
> since then userspace would have to specify which procfs instance the fd
> should come from.

I would actually suggest we just make the rules be that the
pidfd_open() always return the internal /proc entry regardless of any
mount-point (or any "hidepid") but also suggest that exactly *because*
it gives you visibility into the target pid, you'd basically require
the strictest kind of control of the process you're trying to get the
pidfd of.

Ie likely something along the lines of

        ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS)

kind of requirements.

But honestly, just how much do you need pidfd_open()? If this is
purely because somebody goes "oh, ASCII is expensive", then just stop
doing it entirely. It's not. It's fine. Going throuigh a filesystem is
a *good* thing, exactly because it allows MIS to control it.

So it's entirely possible that the right answer is: "just open
/proc/<pid>/", and accept the fact that everybody has it anyway, and
people who don't have it don't get the new functionality (with the
possible exception of clone(CLONE_PIDFD), which only gives you access
to a child you created yourself.

          Linus
