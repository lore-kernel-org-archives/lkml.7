Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34954C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050E220835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="nPHsuwVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbfDQQr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:47:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44444 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbfDQQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:47:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id y13so12351141pfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C2UyvVFvQC92KV1X271Qlc1j2PEBuyGtbodh1E8s1Kk=;
        b=nPHsuwVccflV0I7Ei/7HiN9YtqULsiUtd89/U0IOdLzro9bQUvqGJX6XccmcQCzSl2
         QbSkslLQ11/gVWA3L+eHoEJRRk/tUv0wdD2iqZFSyAADORTo39Ed2RI8LmDVF8o3+UfX
         +k1ZTNjC7qOlfA9fyg6Z/n0NTWrn/L+vL+V/y6AVNvC6iqcuUTFYXD7N56k3c4H+8TkP
         vPFYMEPZQERKcBvgZBZ52wS4oORKnWcCl3QQyEtRTHZzfiexuifjF6QNoV10kBKlyc0C
         0EP4NKZvXs3gpTju/aGVi9wZND5SHcsV0k0haK5ynbKUq2YcrUd90VlVN6CsVqrjQx8r
         OTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C2UyvVFvQC92KV1X271Qlc1j2PEBuyGtbodh1E8s1Kk=;
        b=IiXOleOhKM3OqtoYQbazZAIzzdM0hN1odmj4M8Fj4wcdHgQtJCdBcpcoGfaupEIive
         9YiXEQKpXYIBJL95DSkYI3SDWlcbL7ar7E13lrIwQzZme4a2WS/vcmAyVZu4mdSZpy4f
         mMBy4nG/sa1vdHhw3LwcKlughftZnCAYlSy0PKf6f6anzFSBVBvaW/55E3xRFo+fY7Tw
         pfZrhPdO7ValtoZxab8GdrJuYo5SK1XrGAHov8+ZO2K0zGPtA/JjE0VnmWvZpMmDgDNw
         qTWetcBb1ejIK09z6hJ6Tt8wFxAuNDnidjFD7ZwJJKDNwXx0lJ4DNbuZysetY1bjRXer
         CJEw==
X-Gm-Message-State: APjAAAW3SCgBwwi8QAPQeV1IMwqOBlw1AOm6xTyxq6P+AN1f18CFuEhO
        FAUnO2uScfcXC9rLbEj6ew7wlQ==
X-Google-Smtp-Source: APXvYqz4Qd4n7fZg2hgPWQTSuYsQN07c6UF0QpsNKPe4Dq1aEYgIondbBcS0B+l43/mmZOjTdULj8w==
X-Received: by 2002:a63:5621:: with SMTP id k33mr730424pgb.437.1555519676233;
        Wed, 17 Apr 2019 09:47:56 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:a0ed:a1f7:629a:b372? ([2601:646:c200:1ef2:a0ed:a1f7:629a:b372])
        by smtp.gmail.com with ESMTPSA id v6sm71148466pgv.92.2019.04.17.09.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 09:47:55 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <87v9zc6cz2.fsf@oldenburg2.str.redhat.com>
Date:   Wed, 17 Apr 2019 09:46:49 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA79A567-A002-4935-80A3-AB273C750AFD@amacapital.net>
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net> <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com> <87v9zc6cz2.fsf@oldenburg2.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 17, 2019, at 5:19 AM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> * Andy Lutomirski:
>=20
>> I would personally *love* it if distros started setting no_new_privs
>> for basically all processes.
>=20
> Wouldn't no_new_privs inhibit all security transitions, including those
> that reduce privileges?  And therefore effectively reduce security?

In principle, you still can reduce privileges with no_new_privs.  SELinux ha=
s a whole mechanism for privilege-reducing transitions on exec that works in=
 no_new_privs mode. Also, all the traditional privilege dropping techniques w=
ork =E2=80=94 setresuid(), unshare(), etc are all unaffected.

>=20
>> There seems to be some demand to be able to do large
> parts of container setup using posix_spawn, so we'll probably add
> support for things like writing to arbitrary files eventually.  And of
> course, proper error reporting, so that you can figure out which file
> creation action failed.
>=20

ISTM the way to handle this is to have a way to make a container, set it up,=
 and then clone/spawn into it.  The current unshare() API is severely awkwar=
d.

Maybe the new better kernel spawn API shouldn=E2=80=99t support unshare-like=
 semantics at all and should instead work like setns().=
