Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C51AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EDC2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 22:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5ZaoDoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfH0Wvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:51:55 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43111 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfH0Wvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 18:51:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so259371pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 15:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFS84o865rjfeoexZQAGgSJ3KNvxXPbscOst+ksMfHk=;
        b=U5ZaoDoTMnBmZDZcgGS8Su54bbbtcSFASghPcUfi99ZKeSsquWSZ0OmqEN+ywvbci9
         kPWL/GrVNAH+uD8Vp387aOL8ddYMFSoFKGByd2YY7T9wKD3nXpWkrxWbNRWuhqMbqG3Q
         XtBe5ZS7HPuopgQ/ibLfCap9AEQyJt6xZFSAPkSvLFEgJ3HkCo4YseWnc1PmsV4jN16p
         WLa4ctoa8ZtCan6eKllVrcwbJcIBFqyAh767zdKLiIE5Q9KfQxqLaKKPYcPrqac7t3Yf
         Vs+/JXMdcD4tS3rbB9tGbqwqdT3X3GrfvHOwOGFrqM7UpWYp03CQbb7y8tpbJqh/l1L4
         pkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFS84o865rjfeoexZQAGgSJ3KNvxXPbscOst+ksMfHk=;
        b=BgC9WBpNSXDUDRULZmGgfXJPVR17W6YbtGxGe/CtNHlCFIHom7vKVL3lS5aGvKuyj7
         BN4hwf7xI1EjW80IWW4JNGifcOmS1/aTStWLFMvym2DKD77eMOEBcxc8Ei8ALGpFh7Om
         hGK8RhfKj3QynV3TdwQ5e/hBlQzjs9knTWH8VqJlmUeeyy1gpXMt5E5AkHMMz82mMBCC
         IFs0tB8ZGJCrOMpmMeArBbNtTQPIsyqWkkPYG9NzgLLiZQEEZG+GA2MliGBSj4k2ZPf0
         fUmNIFrcx2ggXYhGF15kvTafGmllVr1TF07cqSVG0cT+BKONK985ir04uDS6Pb70MLz2
         3hGg==
X-Gm-Message-State: APjAAAVHlknap9urzAA3WdYk9yW1eE19bZYj+xYtk86aZdxhZ51rYtSI
        DN5jqlwKO90XwDJ1z7iY4oGc44V0XZm2GwBrCSVfYQ==
X-Google-Smtp-Source: APXvYqyrExoKN9najOR7V5s7stTvKEsXiw2IOvSZbIU7s73MYVywoFW/iq5kG9gtzPZ5Fewg9UH2ruHTBZ3fs4FucS0=
X-Received: by 2002:a17:90a:7f01:: with SMTP id k1mr1087908pjl.84.1566946313462;
 Tue, 27 Aug 2019 15:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190827174932.44177-1-brendanhiggins@google.com>
 <ae9b9102-187c-eefe-d377-6efa63de2d28@kernel.org> <CAFd5g473nZAfM4D=Vkr54O_+nn=MSt3dzuDcXzNMZGRDWg1nxA@mail.gmail.com>
 <CAFd5g47rSBJS8QVH6d5HqoJW5PJXdNnkoP6WcvQCFUqHUEmDzw@mail.gmail.com>
 <CAFd5g44A5vtgxBYErP4mCGwDgOHEMYUXCDSF=d9bYB3ktpW5jA@mail.gmail.com>
 <10b44374-829d-0daa-8fb0-4450582cb40c@kernel.org> <CAFd5g474EYEj1BmqCv=xe6M9JW4L389xL2SU1Ak-evjmpGOvJg@mail.gmail.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF977A5D82@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977A5D82@USCULXMSG01.am.sony.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 27 Aug 2019 15:51:42 -0700
Message-ID: <CAFd5g451bou3bDu9VBNanH9tPQb5ybb-P7HFyQmF6ExM-U6Q1A@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     "Bird, Timothy" <Tim.Bird@sony.com>
Cc:     shuah <shuah@kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 3:38 PM <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Brendan Higgins
> >
> > On Tue, Aug 27, 2019 at 3:00 PM shuah <shuah@kernel.org> wrote:
> > >
> > > On 8/27/19 3:36 PM, Brendan Higgins wrote:
> > > > On Tue, Aug 27, 2019 at 2:09 PM Brendan Higgins
> > > > <brendanhiggins@google.com> wrote:
> > > >>
> > > >> On Tue, Aug 27, 2019 at 2:03 PM Brendan Higgins
> > > >> <brendanhiggins@google.com> wrote:
> > > >>>
> > > >>> On Tue, Aug 27, 2019 at 1:21 PM shuah <shuah@kernel.org> wrote:
> > > >>>>
> > > >>>> On 8/27/19 11:49 AM, Brendan Higgins wrote:
> > > >>>>> Previously KUnit assumed that printk would always be present,
> > which is
> > > >>>>> not a valid assumption to make. Fix that by ifdefing out functions
> > which
> > > >>>>> directly depend on printk core functions similar to what dev_printk
> > > >>>>> does.
> > > >>>>>
> > > >>>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > >>>>> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-
> > 715a-fabe016259df@kernel.org/T/#t
> > > >>>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > >>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > >>>>> ---
> > > >>>>>    include/kunit/test.h |  7 +++++++
> > > >>>>>    kunit/test.c         | 41 ++++++++++++++++++++++++-----------------
> > > >>>>>    2 files changed, 31 insertions(+), 17 deletions(-)
> > > >>>>>
> > > >>>>> diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > >>>>> index 8b7eb03d4971..339af5f95c4a 100644
> > > >>>>> --- a/include/kunit/test.h
> > > >>>>> +++ b/include/kunit/test.h
> > > >>>>> @@ -339,9 +339,16 @@ static inline void *kunit_kzalloc(struct kunit
> > *test, size_t size, gfp_t gfp)
> > > >>> [...]
> > > >>>> Okay after reviewing this, I am not sure why you need to do all
> > > >>>> this.
> > > >>>>
> > > >>>> Why can't you just change the root function that throws the warn:
> > > >>>>
> > > >>>>    static int kunit_vprintk_emit(int level, const char *fmt, va_list args)
> > > >>>> {
> > > >>>>           return vprintk_emit(0, level, NULL, 0, fmt, args);
> > > >>>> }
> > > >>>>
> > > >>>> You aren'r really doing anything extra here, other than calling
> > > >>>> vprintk_emit()
> > > >>>
> > > >>> Yeah, I did that a while ago. I think it was a combination of trying
> > > >>> to avoid an extra layer of adding and then removing the log level, and
> > > >>> that's what dev_printk and friends did.
> > > >>>
> > > >>> But I think you are probably right. It's a lot of maintenance overhead
> > > >>> to get rid of that. Probably best to just use what the printk people
> > > >>> have.
> > > >>>
> > > >>>> Unless I am missing something, can't you solve this problem by
> > including
> > > >>>> printk.h and let it handle the !CONFIG_PRINTK case?
> > > >>>
> > > >>> Randy, I hope you don't mind, but I am going to ask you to re-ack my
> > > >>> next revision since it basically addresses the problem in a totally
> > > >>> different way.
> > > >>
> > > >> Actually, scratch that. Checkpatch doesn't like me calling printk
> > > >> without using a KERN_<LEVEL>.
> > > >>
> > > >> Now that I am thinking back to when I wrote this. I think it also
> > > >> might not like using a dynamic KERN_<LEVEL> either (printk("%s my
> > > >> message", KERN_INFO)).
> > > >>
> > > >> I am going to have to do some more investigation.
> > > >
> > > > Alright, I am pretty sure it is safe to do printk("%smessage",
> > KERN_<LEVEL>);
> > > >
> > > > Looking at the printk implementation, it appears to do the format
> > > > before it checks the log level:
> > > >
> > > >
> > https://elixir.bootlin.com/linux/v5.2.10/source/kernel/printk/printk.c#L1907
> > > >
> > > > So I am pretty sure we can do it either with the vprintk_emit or with
> > printk.
> > >
> > > Let me see if we are on the same page first. I am asking if you can
> > > just include printk.h for vprintk_emit() define for both CONFIG_PRINTK
> > > and !CONFIG_PRINTK cases.
> >
> > Ah sorry, I misunderstood you.
> >
> > No, that doesn't work. I tried including linux/printk.h, and I get the
> > same error.
> >
> > The reason for this is that vprintk_emit() is only defined when
> > CONFIG_PRINTK=y:
> >
> > https://elixir.bootlin.com/linux/latest/ident/vprintk_emit
>
> Ugh.  That's just a bug in include/linux/printk.h
>
> There should be a stub definition for vprintk_emit() in the #else part
> of #ifdef CONFIG_PRINTK.
>
> You shouldn't be dealing with whether printk is present or not
> in the kunit code.  All the printk-related routines are supposed
> to evaporate themselves, based on the conditional in
> include/linux/printk.h
>
> That should be fixed there instead of in your code.

Alright. That makes sense.

I will submit a patch to fix it.

Sorry for not suggesting that, I just assumed that it was my mistake
in how I was using printk.

> Let me know if you'd like me to submit a patch for that.  I only hesitate
> because your patch depends on it, and IMHO it makes more sense to
> include it in your batch than separately. Otherwise there's a patch race
> condition.

Thanks for clearing up the confusion!
