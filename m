Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F121C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7130D206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJIH8gUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfDZH0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:26:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33192 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZH0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:26:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id k189so1349110qkc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 00:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=user-agent:mime-version:message-id:in-reply-to:references:date:from
         :to:cc:subject;
        bh=FzQTuDX8vAiiE9klyzh6KTDb2QcE1KMuKgtEA0Htn/A=;
        b=sJIH8gUfIyU2tmlQ60N5Q1pa3ykBmGa45b3jHSh2lacBj0T+RW052hH5ouFm81wu+B
         er3dt76xJN4P5aYI+9g0+BD1jwtHrpWwOF2xBMxdFiMfrTO1dJv+UzzDFJtdNc1sqZPM
         5FA54TGhIPQ5pe/mkbK42o7jYBiq/9St/f0Hx5J51WSbqvlKeK++ViQIQoZudFS8vnD9
         koaruTmihRhFSNB2t6lT2rzuW7cjrwrez6lV9xmIDoZaysL7OWgsHlPtTnBEIKSTNaPF
         rLt88juln/m7idW+csKlPhKc4CtUqXHLrd8jz7rxdtbNn/Sh1LmV5UZONo+bZEiMx6E8
         IuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:mime-version:message-id:in-reply-to
         :references:date:from:to:cc:subject;
        bh=FzQTuDX8vAiiE9klyzh6KTDb2QcE1KMuKgtEA0Htn/A=;
        b=tZDGosYaPfumWoy2wlLSxkG2jFrAmb4OgJyJl21fiZDucaogSL7t+hSb5mMWXo7JvR
         QvQ1UhmMa7a2QbYrmn2X8s9VU6d1KEuqOsHsgAkVqWuffqOCXt8rFToMgzB/XQlD0/nj
         EvxFWpRq5LxY/odjRXdc+iOChc/9jg3LQaTWGy4p4p2mGyPy1iNkd6un+MeXQzFIwMls
         dZm/Fpg3X32bryUbKXP6x1rTPwzACfLXrwxLwuimDR9j8fGXE4Cq/RQwKof7DxeFIMr1
         vHfxwWQrj9dZpReUrwE6pEdz9tqNOzT9bXJu0UJl7BtGZTBQAcmZhvkwliAzTxgLl3iy
         +6vQ==
X-Gm-Message-State: APjAAAWsl0zpY53NPK/7FZzOn4zOevbOLImwB4exKcQwodmzsVM77JpW
        LqN0xAJKAl1SR+bj5RxRgpA=
X-Google-Smtp-Source: APXvYqwEjPnkBUurqk9yVWqEfXisrdvNmQocv0RcG5jhSL5EURyus9pd+0GuJG4Gf0bPALDFbeDmSA==
X-Received: by 2002:a37:99c7:: with SMTP id b190mr34683536qke.2.1556263562518;
        Fri, 26 Apr 2019 00:26:02 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id k16sm1463671qtp.28.2019.04.26.00.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 00:26:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id B87C220EB0;
        Fri, 26 Apr 2019 03:26:00 -0400 (EDT)
Received: from imap1 ([10.202.2.51])
  by compute6.internal (MEProxy); Fri, 26 Apr 2019 03:26:00 -0400
X-ME-Sender: <xms:hrLCXETz4IxWrlaRNFyy66eQWEFBFocQxwjujoGmg3A2Hc1niBK-8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheehgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdeuohhq
    uhhnucfhvghnghdfuceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffoh
    hmrghinhepkhgvrhhnvghlrdhorhhgnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhq
    uhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqud
    ejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgv
    rdhnrghmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:hrLCXCNCpZaiy6LL-JzWM4bKIFD9qJqSftpnzZkwTGEHJBn-JuTtIA>
    <xmx:hrLCXIvd3sovZdy73hLzFVY36QHLIYiVVTQXdDuYruvTb9DA_1DtiA>
    <xmx:hrLCXOSlJrmdyGqeNxT9N-6xlW8QPhovctn-CtRmKGketos9-KG3oQ>
    <xmx:iLLCXMFxztLEUD9sM29CTBz168jXXrSXKe1WSMzjPewMrAlBa0drMw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A6621D48EA; Fri, 26 Apr 2019 03:25:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-444-g755619f-fmstable-20190423v1
Mime-Version: 1.0
Message-Id: <b05c7236-1ce9-4a7e-b2bf-84ec4061b4ed@www.fastmail.com>
In-Reply-To: <CAHttsrbf30jTT3XidoeWV7j2xovCvJuM3=qy4u1z_GC3dXYp8A@mail.gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-25-duyuyang@gmail.com>
 <20190425200336.GY12232@hirez.programming.kicks-ass.net>
 <CAHttsrbf30jTT3XidoeWV7j2xovCvJuM3=qy4u1z_GC3dXYp8A@mail.gmail.com>
Date:   Fri, 26 Apr 2019 03:25:50 -0400
From:   "Boqun Feng" <boqun.feng@gmail.com>
To:     "Yuyang Du" <duyuyang@gmail.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Will Deacon" <will.deacon@arm.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Bart Van Assche" <bvanassche@acm.org>, ming.lei@redhat.com,
        "Frederic Weisbecker" <frederic@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_24/28]_locking/lockdep:_Remove_!dir_in_lock_irq_usa?=
 =?UTF-8?Q?ge_check?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Apr 26, 2019, at 3:06 PM, Yuyang Du wrote:
> Thanks for review.
> 
> On Fri, 26 Apr 2019 at 04:03, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Apr 24, 2019 at 06:19:30PM +0800, Yuyang Du wrote:
> > > In mark_lock_irq(), the following checks are performed:
> > >
> > >    ----------------------------------
> > >   |   ->      | unsafe | read unsafe |
> > >   |----------------------------------|
> > >   | safe      |  F  B  |    F* B*    |
> > >   |----------------------------------|
> > >   | read safe |  F? B* |      -      |
> > >    ----------------------------------
> > >
> > > Where:
> > > F: check_usage_forwards
> > > B: check_usage_backwards
> > > *: check enabled by STRICT_READ_CHECKS
> > > ?: check enabled by the !dir condition
> > >
> > > From checking point of view, the special F? case does not make sense,
> > > whereas it perhaps is made for peroformance concern. As later patch will
> > > address this issue, remove this exception, which makes the checks
> > > consistent later.
> > >
> > > With STRICT_READ_CHECKS = 1 which is default, there is no functional
> > > change.
> >
> > Oh man.. thinking required and it is way late.. anyway this whole read
> > stuff made me remember we had a patch set on readlocks last year.
> >
> >   https://lkml.kernel.org/r/20180411135110.9217-1-boqun.feng@gmail.com
> >
> > I remember reviewing that a few times and then it dropped on the floor,
> > probably because Spectre crap or something sucked up all my time again :/
> >
> > Sorry Boqun!
> 

That's all right. I was also too busy to send another spin...

> Oh man, I thought about the read-write lock stuff, but I didn't know
> Boqun's patch. Let me hurt my brain looking at that patch.
>

Yuyang,  a few about the status, I've changed a little on the algorithm, the
latest code is at 

          git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git   arr-rfc-wip

but unfortunately, I haven't got time to rework the comments and documents, so
be aware of this inconsistency.

Feel free to ask me any question, and I will try to send out a fresh spin in next month.

Regards,
Boqun
