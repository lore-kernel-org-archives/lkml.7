Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB69C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6F820718
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 17:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574185261;
	bh=CluRblEFMUETyKbYj2Mbw+FlclYGBj6WdguG//F2G7Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q/VR5+24F0KmuvWQkyA+ab1W0I8sLK8Q2zrcY62qf3sg9aiFSNmTa0S8aO3gAFLZf
	 51h1Iagh8Lm4tM4izebY6hcwHMUKvkYrzZb+40f6gSKyl3neX8YMy40ZgIITIkfcJ8
	 Q2EJcUTWjFWz5hgx9t6JvIgzi26W4rypiWnwwLPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbfKSRlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbfKSRk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 12:40:58 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACEFC22384
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574185256;
        bh=CluRblEFMUETyKbYj2Mbw+FlclYGBj6WdguG//F2G7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QNdH6mi5PiBtuEUA+43zu2S/TU+LbiB0e005F3zS94ECiaj4JE+mdeafj73BfHmPV
         EdXo8E+E08nSEn2/f6U2g/kBww828l/aRDCGIhlCgTGANqLIlsgR91hNi5+zRNetYB
         qZqmwLE61dEejb4RB62BEBD6Va8/0rIAsEmn4vb4=
Received: by mail-wm1-f41.google.com with SMTP id u18so4153165wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 09:40:56 -0800 (PST)
X-Gm-Message-State: APjAAAVh6QaWPvnLAF7fUHKlJzWbKPXPT+wVT9M3/5KIYrRahLjeYeAP
        Vo/FvQc9vtF65wQ3IyywabWl08wtVvmBsVMr2Qu+tg==
X-Google-Smtp-Source: APXvYqw6UtwVIGhkNwkVtKkd6cSjWvijD04+2DtfuhQRcsA5MlCEw0Y6e7FEa0raVjE8DvKEE5qxMkQ82hVrcQ4PLB0=
X-Received: by 2002:a1c:f210:: with SMTP id s16mr5247240wmc.76.1574185255074;
 Tue, 19 Nov 2019 09:40:55 -0800 (PST)
MIME-Version: 1.0
References: <2476454.l8LQlgn7Hv@positron.chronox.de> <3043322.Kq9igzfA0K@positron.chronox.de>
 <CALCETrVXGuShozaf5RpgmQnwtTpAbmaTVny+E0q8OE4OLuWwAQ@mail.gmail.com> <5323691.yyFvDVlHDV@tauon.chronox.de>
In-Reply-To: <5323691.yyFvDVlHDV@tauon.chronox.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 Nov 2019 09:40:43 -0800
X-Gmail-Original-Message-ID: <CALCETrV9W9_rkdCZ4ZvV0bQWiE0ms8cvAyZqeNy4=kHnFj9BRA@mail.gmail.com>
Message-ID: <CALCETrV9W9_rkdCZ4ZvV0bQWiE0ms8cvAyZqeNy4=kHnFj9BRA@mail.gmail.com>
Subject: Re: [PATCH v25 03/12] LRNG - /proc interface
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 2:57 AM Stephan Mueller <smueller@chronox.de> wrote=
:
>
> Am Dienstag, 19. November 2019, 11:06:02 CET schrieb Andy Lutomirski:
>
> Hi Andy,
>
> > On Sun, Nov 17, 2019 at 4:16 AM Stephan M=C3=BCller <smueller@chronox.d=
e> wrote:
> > > Am Samstag, 16. November 2019, 17:39:40 CET schrieb Andy Lutomirski:
> > >
> > > Hi Andy,
> > >
> > > > > On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chrono=
x.de>
> > > > > wrote:
> > > > >
> > > > > =EF=BB=BFThe LRNG /proc interface provides the same files as the =
legacy
> > > > > /dev/random. These files behave identically. Yet, all files are
> > > > > documented at [1].
> > > >
> > > > Why?
> > >
> > > I am not sure here: are you referring to the documentation? Or the on=
e
> > > additional file?
> > >
> > > If it is the documentation, do you want me to add it to the patch
> > > description? I initially did not add it as these files were present a=
nd
> > > seemingly known what they provide. But I would add that documentation=
 to
> > > the patch description if this is desired.
> >
> > Sorry, I should have been a lot more explicit.  Why do you want to add
> > a new interface to read the RNG?  What's wrong with the old one?
>
> There is nothing wrong at all. I actually want to be 100% API and ABI
> compliant with the existing random.c. Thus, the list of the sysctls are
> identical to the existing random.c with the same behavior (hence I skippe=
d the
> documentation of these files).

Whoops, I misunderstood your commit message.  You said "The LRNG /proc
interface provides the same files as the legacy
/dev/random.".  I assumed that meant that you had a file in /proc that
worked like /dev/random.

So never mind.
