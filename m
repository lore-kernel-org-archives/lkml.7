Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DECC5B57D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B63520665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="fWJqeTPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfGHDly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 23:41:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39283 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfGHDly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 23:41:54 -0400
Received: by mail-qk1-f196.google.com with SMTP id i125so12221129qkd.6;
        Sun, 07 Jul 2019 20:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vshiXcXoqLWXoh5b9sIO/G0bRIAMP3O5iBVUywrN6Y=;
        b=fWJqeTPFnRVITMgqOSt+foYJd6IRCAwvi/aRIhfRJnfGYb6kIeYUO8JhHRU6iZBXvB
         sm2VEoyPeXcNxwZZuoP9wp4qVlwc1y0C8Sy40bsa+5bJoI6aTSUfLCJG4fVA0Y9e1s73
         wU0RjDHMI6FO3FWGLcZmqsiV1g/lcvnd5++vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vshiXcXoqLWXoh5b9sIO/G0bRIAMP3O5iBVUywrN6Y=;
        b=nerpqND2em/xqaczaOaZC4xo9RcUiKAlbM3jAS/2FJlHUQ5GfAwJZSCWXYHit42f5N
         59LvIXoXa6E2vOjWgaa/iziol1bKrWvZLjxjdsngunEMgDLNMzUmLFzqDYSSQ9T143wn
         tcPBs80tjnKZeL6YZnO3ognn6RIMK7dr/Ps17Xsi9Qfw0R4ToqkGGm7TK0uWU9NhKNUZ
         3sPkusFRq5nX49rsGNilfHfy82RKhKbmrkEHFcoQjcMrytUebSITDsnBeASi04XlvyI9
         Y1dtMiwkDoGZEzT2SC67N23oF3M6x4aiucluNaPVXb1IDSzLkpaN6vi1yR5ogO85TUfl
         tNqA==
X-Gm-Message-State: APjAAAU4Tr95GLOkUX6nB3nNz1H8mqwmY2jPB6WquV+VsuWPqOe710ws
        QCGymWspslnjfcOJ3H/LHaf4gP5rGhal3H6RKuzW4Q==
X-Google-Smtp-Source: APXvYqx4M7vpNqLlCyb15EJ3sQkocolgJm6QJ9Q8vviG4FjGb+7Buz7arc5O5ak1IQ7W1aztYieBRVuPufJS3MV678c=
X-Received: by 2002:a37:b0c6:: with SMTP id z189mr12507331qke.208.1562557313014;
 Sun, 07 Jul 2019 20:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACPK8XfCpgjAwMeoyhcZqgqtXO=-wtpuB2kwsogvBnd1VzynDg@mail.gmail.com>
 <041ce2ab04d0594accdbf51078906ac116cc0253.camel@kernel.crashing.org>
 <CACPK8XdGC4V5xs5S=JHk=tUayLGHQkF5eH0pvFnyffpDaUuqQQ@mail.gmail.com> <20190705073158.1c8384ed@canb.auug.org.au>
In-Reply-To: <20190705073158.1c8384ed@canb.auug.org.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 8 Jul 2019 03:41:40 +0000
Message-ID: <CACPK8XeZTG8dxiQNi_HRyRAnfGnoagn2WonwYZD1mez9vzpJNA@mail.gmail.com>
Subject: Re: [GIT PULL] FSI changes for 5.3
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 at 21:32, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Joel,
>
> On Thu, 4 Jul 2019 06:03:18 +0000 Joel Stanley <joel@jms.id.au> wrote:

> > Stephen, can you swap out ben's fsi tree in linux-next for this one:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git
> >
> > Branch is 'next'.
>
> There is no "next" branch in that tree, so for now I have used the
> master branch.   I have replaced Ben with you and Jeremy as contacts.

Thanks. There is a next branch now, please take that instead.

Cheers,

Joel
