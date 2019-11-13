Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69178C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FBA21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfKMKEX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:04:23 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:57741 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfKMKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:04:22 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N2Dgk-1hl1B43mog-013brR for <linux-kernel@vger.kernel.org>; Wed, 13 Nov
 2019 11:04:21 +0100
Received: by mail-qk1-f172.google.com with SMTP id d13so1192274qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 02:04:20 -0800 (PST)
X-Gm-Message-State: APjAAAUfzO/wFJIKb3n1NLDE0fQRnBuhAagispHGOADGPpRO8JrJSrZt
        I1OP80a61+JQ2zEMORp+189FiNOeJOAmDckM+Vk=
X-Google-Smtp-Source: APXvYqz76N6YiMmMuv8QGr8pQBLKX8fP4b2vDDkNDidONegs5IwTjLmxR7A3gx/rfbjKvqliI9W4OwftLepJpjq9AAU=
X-Received: by 2002:a37:9d8c:: with SMTP id g134mr1708504qke.352.1573639459115;
 Wed, 13 Nov 2019 02:04:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573576649.git.msuchanek@suse.de> <13fa324dc879a7f325290bf2e131b87eb491cd7b.1573576649.git.msuchanek@suse.de>
 <1573613683.ylw9dz9mlc.astroid@bobo.none> <20191113084137.GI2770@kitsune.suse.cz>
In-Reply-To: <20191113084137.GI2770@kitsune.suse.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 11:04:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0ikEMP6MQzL8QPMTgdA-euf7_AsFZAbxkDbFh=smMuaQ@mail.gmail.com>
Message-ID: <CAK8P3a0ikEMP6MQzL8QPMTgdA-euf7_AsFZAbxkDbFh=smMuaQ@mail.gmail.com>
Subject: Re: [PATCH 31/33] powerpc/64: make buildable without CONFIG_COMPAT
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        Breno Leitao <leitao@debian.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell Currey <ruscur@russell.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:4s974YwDo2C/+5Nc/d22dJtU7F6ZPc3QTSvbH3bPlopUb1svGk/
 et7GO2Z64BFzau48FF67vq7FtUnAk+z8EqlCfnIDi43ygQ9enW86OUe4pdTBENQnJFSOFsz
 Aomx6PUjq9PKP9CGE1fo8jrUd2td1sXo1a93bhwXkcfccpFYfmFMCJ+b/x4DHRnzVUHH477
 XML0woKM6wUldNEbXxwZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S3saXF5IiUA=:DN1TaMLVO2XgKJMRJ6BheO
 +H+I9NqLJSYLgoPkmSSFUJy1+a/bLm8paJQ5QeOUADvAdv8VDgef2SpZ5sDTqPMj+03kmLbUX
 DbLpW3c1Li0rt+IicaaVDuo5jNsKOBDcqAmyqxg80/6ewhGN1i5EzVlrmVEyxQTRCnYWEx5hc
 z3ZpZ0X5SB6uga0pOAdUiYVMWsv1ofsJMZPpxQdcFqTWcivToR4prskpDAaw3ywcl+1MaOOpo
 AoKnkzQZP+Qn0TaJfdEzdTm93cnzLEg3yDmkZXSdb6HcMaAYj3mc7AsnxchMsZECO7IzzeBDB
 gqD7Dch8nMrGIeecibb+ADWOlsm3kM+w6nOqugVtOyBE+UjsUXfxlgMq3Fqnw06r540ufPTca
 yVszseWpFBzZI1wMbKMhD5PJtguAbuFeCqtT4rxb808NnFg+Y+WRJjllwTMfhwN03YVA3sJTi
 jjf9po76EmrlbG5SCJCRirZgOyQQrBSgd0EZS8cJmQbshKfGrGrCaLZYH166s1sn+irHbYsNt
 74M8OKgSZkslRKy2fj58Z/yLUF2IL3ws7g/nyLlJpLX4gRdkWA48O89bFwXrDG669SEHacDsa
 4Ao1s6sIQ6XJHp6rYPf4PlVRRHhmy9cGK1o1rnTJQdLFqNLLDwNWKoGDzTmRjKc976iVTRffC
 LdUyBzNa8hoxqivwZAPfLQ7sqk8CNkSSW4KkwFnjxf12TvlcQGpHJDLbTHBPGCFv/5g0Xp/PI
 bBj6yhoTz8MpyH+p0+t2r2YcLl+Rozu4e5qU7U+/xK55prbFrvPDsEJzdgYNg0PzSgJNJ7zCX
 hxcnlE/L+KdhgfpBcLh0XJC9CuOLhb+02uMzLVcmu7O+HNMPv0SPtVWJ6jgLuOdbtpAKKHXK4
 Xn5haKUjBz71T99CGpUA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 9:41 AM Michal Suchánek <msuchanek@suse.de> wrote:
>
> On Wed, Nov 13, 2019 at 01:02:34PM +1000, Nicholas Piggin wrote:

> > >
> > > @@ -277,7 +276,7 @@ static void do_signal(struct task_struct *tsk)
> > >
> > >     rseq_signal_deliver(&ksig, tsk->thread.regs);
> > >
> > > -   if (is32) {
> > > +   if (is_32bit_task()) {
> > >             if (ksig.ka.sa.sa_flags & SA_SIGINFO)
> > >                     ret = handle_rt_signal32(&ksig, oldset, tsk);
> > >             else
> >
> > This is just a clean up I guess.
>
> It also expands directly to if(0) or if(1) for the !COMPAT cases. I am
> not sure how it would work with the intermediate variable.
>
> There was more complex change initially but after some additional
> cleanups removing the variable is the only part left.

I would be surprised if that made any difference to a modern compiler,
but the new version is definitely clearer to human readers.

       Arnd
