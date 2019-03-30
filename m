Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620FCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31793218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SBAbLJ+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfC3QjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:39:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45902 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbfC3Qi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:38:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id m16so4560071edd.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jjm0qai9ZYPiT6TdWCxaI36M0QNMMCcOH+KsLm1g4yk=;
        b=SBAbLJ+yrT3ryIK8UHLD8e8YOy5e0RUB5qoIpTlBgTCKRnKhaWgXL1opeOGSFccP1+
         Rr+c5AGBH96NUOy+P5hPzupqRZwaBGNsPgk6Gemwv1DeT7woLhWA0211e0SyjGBunmkv
         B/LcHtd96AYr1f6m06qZau9xqoc45UoeqNJXrGWSc4cGFsNZCOLtdIVSHTMqNo0IlWLf
         MZrBcH6oFRTw2XgEA0Icu5Kp7f+v88CaXuKK4rKNvr2wI8hFiasqtIW6OIJaKD2t/MNd
         VqkMLvPNkrTb7JhylLzuHWXb9zFFQOLaqfYkH3FewhL0ID/zUpmTScMvrauYoZ5BznXB
         L2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jjm0qai9ZYPiT6TdWCxaI36M0QNMMCcOH+KsLm1g4yk=;
        b=Ex/11anN9l2ozGn/BCiR8tIQ1Ihx7bm/hPQCCpdOzwpPdPVhQ5c3XOrY+seqK3feOf
         LBcovnYleojLcKKshJzgTk5289hhvvNa8JawIcPYnPy5sO/lDdbGAgbDjcsOU24Ib7Qk
         c0nm7nMVcfxZoW+6UQ9NY/rfjzFjMh0IDZNZO+H+oHiRYiWadyCkgFRQxqDGG4uIVF03
         Kr1kGlameHqAIYyLItZUC9bn1yaP7M/O3FqXg759ponAfCYt9JHeiiNlIrDgWfWq44lZ
         9efHSLZo/66Og53bSa6LWmzcoohFeFQHSsWiOTb4kz5w8VFOpBalWjoOPbdzBv//AVN4
         wnxA==
X-Gm-Message-State: APjAAAW4zqa529xhdGJ18gvxO/x4gZ/O/2y5dwHdCq3q8wx6Fj+3EjUu
        Tu5x3VV6HaUke2dmXHJonqgYFqR69Pc=
X-Google-Smtp-Source: APXvYqwjwbGrlXkFfHKuLi9tVi+NPei06uIdq8rzwFfzs86tuXCrs4S8TxJXuTGg+WQUNI0MlV81qw==
X-Received: by 2002:a50:97d0:: with SMTP id f16mr34880013edb.287.1553963937408;
        Sat, 30 Mar 2019 09:38:57 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id z35sm1613912edd.81.2019.03.30.09.38.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 30 Mar 2019 09:38:56 -0700 (PDT)
Date:   Sat, 30 Mar 2019 17:38:55 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190330163854.t67m2h6m3hmshqtg@brauner.io>
References: <20190329155425.26059-1-christian@brauner.io>
 <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
 <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 09:34:02AM -0700, Daniel Colascione wrote:
> On Sat, Mar 30, 2019 at 9:24 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sat, Mar 30, 2019 at 9:19 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > From pure API perspective that's all I care about: independence of procfs.
> > > Once we have pidfd_open() we can cleanly signal threads etc.
> >
> > But "independence from procfs" means that you damn well don't then do
> > "oh, now I have a pidfd, I want to turn it into a /proc fd and then
> > munge around there".
> >
> > So I'm literally saying that it had better really *be* independent
> > from /proc. It is the standalone version, but it's most definitely
> > also the version that doesn't then give you secret access to /proc.
> 
> Just to be clear, I'm not proposing granting secret access to procfs,
> and as far as I can see, nobody else is either. We've been talking
> about making it easier to avoid races when you happen to want a pidfd
> and a procfs fd that point to the same process, not granting access
> that you didn't have before. If you'd rather not connect procfs and
> pidfds, we can take this functionality off the table.

This is dead! Nothing like this will make it through this tree. I have
no intention of endangering pidfd_send_signal().

Christian
