Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090A6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D411620857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbfDBLDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45951 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfDBLDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:03:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E07B308213C;
        Tue,  2 Apr 2019 11:03:34 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-117-189.ams2.redhat.com [10.36.117.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F1301001DD8;
        Tue,  2 Apr 2019 11:03:25 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
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
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
References: <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
        <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
        <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
        <20190330171215.3yrfxwodstmgzmxy@brauner.io>
        <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
        <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
        <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
        <20190331211041.vht7dnqg4e4bilr2@brauner.io>
        <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
        <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net>
        <20190401114059.7gdsvcqyoz2o5bbz@yavin>
        <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
        <CAKOZuev4Q4CY0-2rUpTujSKMVJ9L9Exv=_divFC0G0_OaQHaGw@mail.gmail.com>
        <CAGLj2rF85hZLAR79oEA1dQARadw1OHr8bxqCLbvO6g9B6ou2Qw@mail.gmail.com>
        <CAKOZuetovU9NawSjUfGTAwXVfnmKC9GFtmS8FxAE5Hjmzq0HHA@mail.gmail.com>
        <CAHk-=wjgENV0pT8=MjB1UVBeWCrECCNXv15AKKX7Kfg7Eak7qw@mail.gmail.com>
        <CAKOZuet2QCoW1XMpTAzXS868PhF-gh14czFn4gwE4A=oX=Yr8w@mail.gmail.com>
Date:   Tue, 02 Apr 2019 13:03:24 +0200
In-Reply-To: <CAKOZuet2QCoW1XMpTAzXS868PhF-gh14czFn4gwE4A=oX=Yr8w@mail.gmail.com>
        (Daniel Colascione's message of "Mon, 1 Apr 2019 09:45:22 -0700")
Message-ID: <878swsr7nn.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 02 Apr 2019 11:03:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Colascione:

> But doesn't the CSIGNAL approach still require that libraries somehow
> coordinate which non-SIGCHLD signal they use? (Signal coordination a
> separate problem, unfortunately.)

There's already an allocation mechanism for realtime signals in glibc,
via __libc_allocate_rtsig.  I don't know what it is about: It's clearly
intended as an external interface, yet there isn't a declaration in any
installed header file.  ALSA has some optional code to use it, but I
don't think distributions compile ALSA in that way; it always uses SIGIO.

Thanks,
Florian
