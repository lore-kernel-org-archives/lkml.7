Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D951C3276C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D577D217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 00:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578010111;
	bh=SMUIa4SzEL/j8kNnhyrIRtcJ6DVLRt+dGDZa9AlrDKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JdpXIZJVBVz6Mvt2FXXZdOR9/b4Wg6FKCjGXJ/P+FzByd1OIPCqJQN3opXWUb0C8I
	 h2iijfa9TS0/vZ/MGf/auCbwBjxebLvCHR7zUtkCbom8p4pXT3EJRoBQnNK0RPF+AF
	 Nsj11d6hzeTGKQFBoq7ZSwYDDFt8EmhrCjIJbDj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgACAIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 19:08:30 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37473 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACAIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 19:08:30 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so30917654lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 16:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXQQH9TITRlriLDkmnMSZfR2BNB1iw10HsF91le2H5M=;
        b=NQ/D9k51K2Q5WjCrOcvwHMQ6Bkynk3X0IxmvWi1leEorgHVHUExOWHrJt0/8tKG5YT
         p+ycspJpzQnogk3WSvbVxbCKtQqutbkohf/T8FeHpGiW8lXcerHNgQXBanB/ZyM4j+hr
         9pJrx4bqh2BRKEW+Km3eRUdDwJRWz3k0UIwkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXQQH9TITRlriLDkmnMSZfR2BNB1iw10HsF91le2H5M=;
        b=G9cDZDatSqLjTJ43Wa9ljuNidgNvcXHuTayEAceTZWCK/L1vvgIdsQGGsulTf4DK+U
         UABmzkcCnj4NufEkCinmpoCOxhCGqewAcgSa2tkqVxhRe3Tvuuy7eZgq1a3YIVQkqS8o
         Vh6tYwJ4bPiJ3gyUEkJr6bGxOWpNypvH1dip/IRXJhwcJ2zuZuPhs6+nm4urcVW+GkGz
         So9PpKDUxjt2V1qwmYkn0mOGbBnKeXfhYiFcw5fh16Kp53A4nhivARryoeOGlQjbhlGK
         TTBwWjudjjgw1qjS2cPgE83KovNcAOfQApqhgBSVAm2yVYSRzan9lGBgIplDJfMN/3ON
         I8CA==
X-Gm-Message-State: APjAAAVYIR50NyE7zpRn7omVH4xuuq9RY132qm2Wjwj56sBAG4RfhtyS
        O2wYwC33NgM6pri8TuOPXpkf7x2YnOk=
X-Google-Smtp-Source: APXvYqwXA6fqzr260lpceTElIhVfFr3V/OQPZJPEf0NGYJR2Q94eFN1/zqU2uj0P0NrnZsT7OplYZw==
X-Received: by 2002:a19:c80a:: with SMTP id y10mr47072531lff.177.1578010107933;
        Thu, 02 Jan 2020 16:08:27 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r15sm10901010ljh.11.2020.01.02.16.08.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2020 16:08:26 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id m26so39878609ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 16:08:26 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr50911509ljn.48.1578010105946;
 Thu, 02 Jan 2020 16:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20191224020615.134668-1-damien.lemoal@wdc.com>
 <20191224020615.134668-2-damien.lemoal@wdc.com> <20191224044001.GA2982727@magnolia>
 <BYAPR04MB5816B3322FD95BD987A982C1E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB58167AD3E7519632746CDE72E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB58160982BF645C23505BA085E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20200102213612.GD1508633@magnolia>
In-Reply-To: <20200102213612.GD1508633@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jan 2020 16:08:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaTKptXbcP9OXaj9KRzuU5pd+aiTEEzy+Q88mMKMrK2A@mail.gmail.com>
Message-ID: <CAHk-=wiaTKptXbcP9OXaj9KRzuU5pd+aiTEEzy+Q88mMKMrK2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: New zonefs file system
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 2, 2020 at 1:36 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> /me shrugs, I guess we're not supposed to use S_* in code.  Sorry about
> the unnecessary churn. :/

The S_* constants are useful for things like file types etc - so you
very much _are_ supposed to use them for things like

    switch (mode & S_IFMT) {
    case S_IFREG: ...

etc.

But no, the permission _names_ are complete and utter garbage. Whoever
came up with them was just being silly and they are not to ever be
used. Yes, POSIX specifies them, and yes, if you are outside of Unix
environments maybe they can have some relevance, but in a Unixy
environment, the octal codes are a *lot* more legible.

So if you want "owner read-write, group/world read", you use 0644.
That can actually be parsed. And 0777 matches that pattern, unlike the
insane jumble of letters that is "S_IRWXUGO".

Seriously, anybody who thinks "S_IRWXUGO" is easier to read than 0777
is just wrong. It's just shorthand for S_IRWXU|S_IRWXG|S_IRWXO, which
is _also_ a complete and utter mess and insane.

Just say no to the permission names. They don't even cover all the
cases anyway (unless you start or'ing in the individual bits and make
them even less regible), and by the time you parse all the random
letters (and know enough to parse them right), you inevitably find the
octal representation a lot easier to parse anyway.

And if you don't know how the unix permission bits work, then neither
the symbolic names _nor_ the numbers make any sense, so just give up.

So use the octal numbers for the three groups of three bits - aka the
low 9 bits aka the "UGO" bits, and use the symbolic names for the
other bits. Everybody will be much happier.

                   Linus
