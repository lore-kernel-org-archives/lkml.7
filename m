Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8CCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C6B2173C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553962715;
	bh=7zHfvKmcXTbkbHUfQ7DBq3UOTt564z21U+PdvGiXTvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=h9wqg0JoYd4AtsviuG+GPIGrEIcC72H/s1YfNkgkgq08/F6m2joIf0l8xzIHo8iSL
	 MDuOsD5AGUIUuVXCuji3hPTL5K3yUrrkVONW1QszwzytezMtfLdOwJcsIG7sGj/ZBm
	 MVMGh5PleluHcmNVMh1BZBSH98OI2vMBwBT0muuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfC3QSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:18:33 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42311 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbfC3QSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:18:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id b7so3437267lfg.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1GhFU3iV1H35FPX24qZfXe3AgxfHGfcTzIPyzWQhGs=;
        b=ehOJ3mdsT9qaHYJDm4hJ68bj1MybQSXLxH9aUESrfc6rGlN2WiDJUChtavLzzn55E6
         FvPJ0L/ApFmGfNI3CYnCInMxeenRr57AJhL8UgL3Da6Zjq9HyUUJbaaSDd33QdFzyg0K
         xV/J7Ixzaudrtw5G76O5Szb66bLc+vYOlWzHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1GhFU3iV1H35FPX24qZfXe3AgxfHGfcTzIPyzWQhGs=;
        b=olhICG9tg0ffanNMK5/mM1baYjZo96eyifZwqSEFcgHk1Lew3HXAgzypHafVysXQDa
         UB+oiSqW88IFexytbj0L/EEAxco6UfH7tsWRG4kbhGHJGoynEjesu8naJ0CSnfwgxsf2
         c/AAVWzQdeSXlmk5uiPVN+wZGpjlaMq17dR5X2jK9XlOe1tMw74Kq6W44tLP0zq7oiSr
         2r3gcNLzDWj3eXuPcsMrtUHScCfAbqo+yjeL0K5dW7KlM9d9Y66iNsBRNP3yT14+AfPe
         ByrnffA9X1BvJH7FkkX9sUuLwQUjt7lDLxmzh0wOzqbkKuFhqR9vYZ+zfWiyK48snz6W
         9k7A==
X-Gm-Message-State: APjAAAVjpfJ66qGk6MMf8fRkN8AbxrJJt9RamILvCoYSuMP72Q09yXFM
        s48oS08bSrTdGJ6G496oQP3Tezs6Ae8=
X-Google-Smtp-Source: APXvYqx/Ikw252WW6LCwiOzhODlmXxudoFc3Pe7YH72oE1fk94wlG8aLNJOuUjjtRQhqJHP8YFYBug==
X-Received: by 2002:a19:ed19:: with SMTP id y25mr7574413lfy.80.1553962710355;
        Sat, 30 Mar 2019 09:18:30 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id c7sm1079744lja.90.2019.03.30.09.18.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 09:18:29 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id h16so4478325ljg.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:18:29 -0700 (PDT)
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr14234758ljj.79.1553962708756;
 Sat, 30 Mar 2019 09:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com> <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
In-Reply-To: <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Mar 2019 09:18:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1kQDVN22qv7M=bWU+CngZZXcPAMKCsDZMeuY3k2tkyg@mail.gmail.com>
Message-ID: <CAHk-=wi1kQDVN22qv7M=bWU+CngZZXcPAMKCsDZMeuY3k2tkyg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Daniel Colascione <dancol@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
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

On Sat, Mar 30, 2019 at 9:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And no, we are *NOT* making pidfd_open() into some "let's expose /proc
> even when it's not mounted" horror. Seriously. That's disgusting,
> wrong, insecure and stupid.

And btw, this is not debatable. In fact, this whole discussion is
making me feel like I should just revert pidfd, not because the code I
merged is wrong, but because people are clearly intending to do
completely inappropriate things with this.

Get your act together.  Stop hacking up garbage.

               Linus
