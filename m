Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B874C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D67233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfH2IBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:01:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32966 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfH2IBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:01:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id v38so2719048qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrDRlo6tswkQiQ3OI2OWjkWb4KwruICZsEfI0GzK7Ww=;
        b=BZ+TVMIWJyQNHNJs3arivMJfihq7Ax/RiteHqaSWQuHdBBw9R2NLi8m0uxjYhvvZVP
         Kgc5VwTCEG2jP7dhG2ihv+4/psbFgbazY8QXA9z1JXVAWMUFj5GgXMccEqd/iLBcYF8R
         OsHG3ah2HU95CeHtjhyd0id2plNIpeMH5kgg9tDDAHB3rdl0m9pTRdPWjMrMJFCJHvhl
         PxvTZuOeTeK1ds9rP1ROcu6mzu/l4yNVkXKIrLAsCcNy77GH2GZqf7z+f2QBfj5KTwXx
         GRxr2N18uQqpGuzsNj6F/uUI6UdVIU4sKxDh3UPr68uol/Q6dCGOobxhXs9aDkMFNABc
         v7eg==
X-Gm-Message-State: APjAAAX1lyUB6gLOrBAER7aCbQaxdkS/UM9NoJHyPduPVqC3KomBUe2g
        X9GvwrMw3H6irIWGBmfJ4MHPvtLpoANI6a6IPTA=
X-Google-Smtp-Source: APXvYqwtnho1S9aTMw3n9PpmlnfWxuTW5C6zA+a08plX+sQKqxSz2EK+Fy0FMAYbRaCLp86xbGf9AV3saoTYB0mrL94=
X-Received: by 2002:ac8:35bb:: with SMTP id k56mr6444401qtb.142.1567065692859;
 Thu, 29 Aug 2019 01:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567007242.git.msuchanek@suse.de> <0ad51b41aebf65b3f3fcb9922f0f00b47932725d.1567007242.git.msuchanek@suse.de>
 <20190829064624.GA28508@infradead.org>
In-Reply-To: <20190829064624.GA28508@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Aug 2019 10:01:16 +0200
Message-ID: <CAK8P3a2qgLTbud+2Fw8Rr0RXV8-xwBMiBg3hFuqqBinN1zS90A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] powerpc/64: make buildable without CONFIG_COMPAT
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Nicolai Stange <nstange@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joel Stanley <joel@jms.id.au>,
        Firoz Khan <firoz.khan@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 8:46 AM Christoph Hellwig <hch@infradead.org> wrote:

> > @@ -277,7 +277,7 @@ static void do_signal(struct task_struct *tsk)
> >
> >       rseq_signal_deliver(&ksig, tsk->thread.regs);
> >
> > -     if (is32) {
> > +     if ((IS_ENABLED(CONFIG_PPC32) || IS_ENABLED(CONFIG_COMPAT)) && is32) {
>
> I think we should fix the is_32bit_task definitions instead so that
> callers don't need this mess.  I'd suggest something like:
>
> #ifdef CONFIG_COMPAT
> #define is_32bit_task()         test_thread_flag(TIF_32BIT)
> #else
> #define is_32bit_task()         IS_ENABLED(CONFIG_PPC32)
> #endif

Are there actually any (correct) uses of is_32bit_task() outside of
#ifdef CONFIG_PPC64?

I suspect most if not all could be changed to the generic
in_compat_syscall() that we use outside of architecture specific
code.

       Arnd
