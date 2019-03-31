Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAE5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12AC2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554067570;
	bh=gk8LB73UBXeohcuaRUyDxHlzIWBeFQgxsiDPN2w0F3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sfW0/iHu3IIzpt5t7hbVcFmVfOb5+loZq3yANvVFXXBl1PP9OOFqbAPNSP1EqK0Vx
	 NzWiuEsUMllPIGj3YhyfAsuJdina6qbJjlzBn+8Cs3SWTG0o58bw+yZTrMIwQOe+P+
	 xqJAAAckvJlMQhxjawHEK9xUnqOyixl8vMXdTneQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfCaV0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 17:26:09 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42726 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaV0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 17:26:09 -0400
Received: by mail-lf1-f68.google.com with SMTP id b7so4802368lfg.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QykvtwKNSA7Uszl/U2GAXS7tqZQaMfLNjJXLADD8ouU=;
        b=Lk08/K+nKWPRv6fK0NepwcA1cTCEFTcQq3Itcl0wREPAY56rCAFih/74u/0CFEAFt3
         tPMwvAacuIoyhUzZ8Twh3bZ9vnLesLddgYr6RabnJbhEoWNyvgptd7yauIJ4Z0WFWg13
         iwIjWzyrxjxYLGh5rl8dKHv89NV0g4ckqn9I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QykvtwKNSA7Uszl/U2GAXS7tqZQaMfLNjJXLADD8ouU=;
        b=WZMokS4+MgWgFZ5f4osHx56GJcPnNIZqonffJwMd8E990QLzdWScag3ra3hRZrm8BI
         kts7woMzsdI3tg8KZrbLCJ8OtlLMN2h/UqbzQuHSWxgnNfsuVJ1hnpBV0oQOCMmxLFyM
         7l4J8s+G4RYOfp5Uwvw8qND6zyNETqjdCuVk4mkq7fun6z45bFfWYzoLETilxyEICDSS
         AAj+vryOkXV2LX1jffV/o//aOyYKky2SQhNJ+BknXWeMHn4lpHRvyvDRieWqvWMX90et
         lcP1N4nUeYVnhnVliZ3ofS5FqsXpCkDlX2fjtY4r9kPNcIrshRNDMP3VtOCPde/oe7jt
         Zhdg==
X-Gm-Message-State: APjAAAUw30pkre3N153z5GeEnjJ+lvONWNBlXPbl3jvU5jGEQmPbQReE
        URnhXwn9PsXNLZ4dKiF0PW36ja0mlBw=
X-Google-Smtp-Source: APXvYqyCJ65d6s+yGd6hLUHNugDrTZ52KPCu3PNz7x6bfwnlTpX8YXcEwtKCaHeeahHD6jHo4G2+2A==
X-Received: by 2002:a19:520b:: with SMTP id m11mr32987155lfb.156.1554067567017;
        Sun, 31 Mar 2019 14:26:07 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id x20sm1465341lfc.94.2019.03.31.14.26.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 14:26:06 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y18so4823296lfe.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 14:26:06 -0700 (PDT)
X-Received: by 2002:ac2:4424:: with SMTP id w4mr30415952lfl.148.1554067084754;
 Sun, 31 Mar 2019 14:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io>
In-Reply-To: <20190331211041.vht7dnqg4e4bilr2@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Mar 2019 14:17:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
Message-ID: <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
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

On Sun, Mar 31, 2019 at 2:10 PM Christian Brauner <christian@brauner.io> wrote:
>
> I don't think that we want or can make them equivalent since that would
> mean we depend on procfs.

Sure we can.

If /proc is enabled, then you always do that dance YOU ALREADY WROTE
THE CODE FOR to do the stupid ioctl.

And if /procfs isn't enabled, then you don't do that.

Ta-daa. Done. No stupid ioctl, and now /proc and pidfd_open() return
the same damn thing.

And guess what? If /proc isn't enabled, then obviously pidfd_open()
gives you the /proc-less thing, but at least there is no crazy "two
different file descriptors for the same thing" situation, because then
the /proc one doesn't exist.

Notice? No incompatibility. No crazy stupid new "convert one to the
other", because "the other model" NEVER EXISTS. There is only one
pidfd - it might be proc-less if CONFIG_PROC isn't there, but let's
face it, nobody even cares, because nobody ever disabled /proc anyway.

And no need for some new "convert" interface (ioctl or other).

Problem solved.

                   Linus
