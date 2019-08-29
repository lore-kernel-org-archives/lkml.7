Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE5BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDD82189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfH2IuB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:50:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36857 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfH2IuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:50:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id d23so2267623qko.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hJnFjek23O2V38kY7EYOvwYgJYYzBTv0EJwKFbs3Z3k=;
        b=SIWMgzb2hj15Ufge6e+OlpGOJfHDr/cPzyqHteuHzBFjmSV2GG1C8TAxb17gqTMtLg
         v1zgLaCEP5ndCwyXC+IToLlVJmLnSXqRxoSvAbx65uMZ6vzdQ75IsiqMp+q9wA9duDeX
         JPIfI7NVnArcOjN2h3aUs4uOdGW795I7dAguDAmstibXviSAuFcXeNCUTF6wNKggJTuh
         bhFhD8mLAuquxJC8UUQTmtfj48tasQkDTZqanBZth9kexxv8rHsykSDrjthW4bY0lLJ7
         62bZTUqw/ZPTcaAuj452IHi06fo+mZoFdmNsO9dQTabH1GMcw4H5XUGgqUKMcm2Dd9cd
         u4Qg==
X-Gm-Message-State: APjAAAVm0IVxceubWQeREFJEcBDJmcKw6y9lZfZdvPWDz7G3aqw7z67Z
        D7Uwge6lcuxFGwOq3Yjr0d/rQdsGgYtwG/B1I20=
X-Google-Smtp-Source: APXvYqzfksfAvkZZtTSqyDq8tB0+Rf1Wd2K6am1QAcyFlx3Qsw97Mog/htbrBH92YpGL+Cf/beVqCnNpQcD8Fvoer0Q=
X-Received: by 2002:a37:4051:: with SMTP id n78mr8064833qka.138.1567068600467;
 Thu, 29 Aug 2019 01:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567007242.git.msuchanek@suse.de> <0ad51b41aebf65b3f3fcb9922f0f00b47932725d.1567007242.git.msuchanek@suse.de>
 <20190829064624.GA28508@infradead.org> <CAK8P3a2qgLTbud+2Fw8Rr0RXV8-xwBMiBg3hFuqqBinN1zS90A@mail.gmail.com>
 <b3f74049-be82-be3c-5156-69a18010537e@c-s.fr>
In-Reply-To: <b3f74049-be82-be3c-5156-69a18010537e@c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Aug 2019 10:49:43 +0200
Message-ID: <CAK8P3a1zXqUP0R2O88wnoc35tU9YzF5hZV0J2N6tXG27UJb0tw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] powerpc/64: make buildable without CONFIG_COMPAT
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christian Brauner <christian@brauner.io>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Suchanek <msuchanek@suse.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 10:38 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 29/08/2019 à 10:01, Arnd Bergmann a écrit :
> > On Thu, Aug 29, 2019 at 8:46 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> >>> @@ -277,7 +277,7 @@ static void do_signal(struct task_struct *tsk)
> >>>
> >>>        rseq_signal_deliver(&ksig, tsk->thread.regs);
> >>>
> >>> -     if (is32) {
> >>> +     if ((IS_ENABLED(CONFIG_PPC32) || IS_ENABLED(CONFIG_COMPAT)) && is32) {
> >>
> >> I think we should fix the is_32bit_task definitions instead so that
> >> callers don't need this mess.  I'd suggest something like:
> >>
> >> #ifdef CONFIG_COMPAT
> >> #define is_32bit_task()         test_thread_flag(TIF_32BIT)
> >> #else
> >> #define is_32bit_task()         IS_ENABLED(CONFIG_PPC32)
> >> #endif
> >
> > Are there actually any (correct) uses of is_32bit_task() outside of
> > #ifdef CONFIG_PPC64?
>
> There is at least  stack_maxrandom_size()
> Also  brk_rnd() and do_signal()

Right, makes sense.

      Arnd
