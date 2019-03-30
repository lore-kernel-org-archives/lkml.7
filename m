Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682BB217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553965561;
	bh=mIKvZh9CJ1i9Vx+2Q8/0zJnfmDx7ehV5+KlWUiTu6DI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IGRU5/YGoFfrAW/BunYoziWWlLpYKfLgc7QsD65LrzyU6zN1VdGCrcri1OHdfkjsZ
	 dBAWHOtb/pq0cwYwFRTGecxk6tCGpNKnJBIBE+v35kR2BQZ9h6Lt+3OHTGIkpYhbCq
	 gX7qEjzzTwzljGvK+51Rt4xgwZ7I+SLlXiAEuJvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfC3REx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:04:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36453 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbfC3REw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:04:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so4579034ljg.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MN10xuYvsg8+eHsG3Gm0v0OowWhETkrtz1/BCJnHmYw=;
        b=FUNTAiDipswLqNNPgeZ7vSuRVYSCtnYlT1nREDZfpW5iyUe1cAvLGZVjNFkFAbsdYy
         62yWD1QS9vwDjoExF1XdMZua/vOAHABjX9srfjwpHNBocdifxMUdR4KlABofZewPh1bU
         +43++QHC2Y0jRsuxIVSSGNCrq0CO24XohHaQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MN10xuYvsg8+eHsG3Gm0v0OowWhETkrtz1/BCJnHmYw=;
        b=f1f3LehTMVb63UOeFM+jHdKmGJeAzS4tSYX1MU5DX1AoXzj2EJxb1pI4KmyS2ADNMV
         6EqVjFhKI2LJEh9lzQ2k85JHaSI6emHA5K6orhmqNqr2I5d79fTzcQhVuwqRLCIbxEy2
         Oq6WELK+LHB1hLs7DuNtudD5apAOPbDhIN0pJ0VzFMYabIDNzeDAuyw18bG5jPtcmZmO
         VaSQl/D5zY+z01Ffmy7BHfZ/S0Rs/1L6yzsfFdYNKQuBdTTvtX0zKJUEkAlrZmz+083d
         CCQ/1hqN/RKsTohbV1XurTGTe0qNathY8ZROrY2z1cSszmGYrbxt7yqY90BhGvfv9pGR
         25rw==
X-Gm-Message-State: APjAAAWCngnfpDe9+qXhgDp2PapErm1Hs5gWw7VOcObY9nVNhB2c9GAg
        o5YfjQDjDl8N55I7ol7vep/ax0/fdi8=
X-Google-Smtp-Source: APXvYqx3r4koB7Swj3EVEgB9PYjNcf3PUqqhYNYJ8wiDX6dL0AHGjSmbu4Ra/F63l6rGs3ljlMsMBQ==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr25396424ljb.3.1553965490686;
        Sat, 30 Mar 2019 10:04:50 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id k90sm1017553ljb.89.2019.03.30.10.04.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 10:04:50 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id k8so4557669lja.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 10:04:49 -0700 (PDT)
X-Received: by 2002:a2e:8149:: with SMTP id t9mr29953441ljg.2.1553965489694;
 Sat, 30 Mar 2019 10:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io> <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
In-Reply-To: <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Mar 2019 10:04:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
Message-ID: <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
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

On Sat, Mar 30, 2019 at 9:34 AM Daniel Colascione <dancol@google.com> wrote:
>
> Just to be clear, I'm not proposing granting secret access to procfs,
> and as far as I can see, nobody else is either. We've been talking
> about making it easier to avoid races when you happen to want a pidfd
> and a procfs fd that point to the same process

So I thought that was the whole point of just opening /proc/<pid>.
Exactly because that way you can then use openat() from there on.

                              Linus
