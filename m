Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E47AECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7BB2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcfsGbCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfJAXOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 19:14:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33358 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfJAXOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 19:14:36 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so52636379ior.0;
        Tue, 01 Oct 2019 16:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7GZGFrE8g4aFYCkd/kn56E+LCqap8x+Hr8ty1XtTJs=;
        b=QcfsGbCG77Zjj1kd5g92af79DfUtzh3+m/pwY0IW8M/2aVjSNAiJC9FSL5g1QgVekO
         tEgcCY+Jt56bkOiK4NfI6N3L0ngJpskmWLEPjNDw61h4v+a1gqLeIMOp0Fzs6BwgUoSF
         cI8GWVUrzXoJ3dgQWbdwSdu4+TnxHFjYLh+dx+p6380fUrJdPwjjK76YyP61cpl3Xd+A
         1GqeFC/hewmNbFowgdVxT/w74orEK23UUqtsyPP/TPfUaF+mgo3eKzJlq1Zhj+WWLRUX
         /DR10Q+shHL2a9lfqZrQ9rtn9UGyfjHyjeprm+wZfn0Aq8c0bcEaB0UNEdhtMKLE1s66
         2grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7GZGFrE8g4aFYCkd/kn56E+LCqap8x+Hr8ty1XtTJs=;
        b=BcszLCXOyuan9mAlzb6CdhVt4AO9uA6eVSkKyeSMnXXvqybVoRoMcsWk2PKcWdGuy2
         d7WG9Zm5YdtE/xeXmtzO2u7UCWPtpKiUswg9RsB7QnykuiKm4Sat+TRxrCPxqPQ2M1gF
         7dufkPYWuqOpODWs647HHCHoTOsYsiYdRcDWva8ZpTd8ZVuUd0Af47TVC8ibrfrzgkGL
         z4mWQu9ZZ83/l6XgEXil6EXtKPG2P2wJEmukg2IwNE6U65LAgmd0NrZARTWTD6BWFlWp
         /pQgetP+Qyg55wtFlHvokvxzd60f231lEILaj6vBklZmV37w5pm34TE3EzEq3dVawrt3
         ul6A==
X-Gm-Message-State: APjAAAWPH95UXslVdKJwdM9RpxK6KwVINq/3ssoCQ6FdqyOvVS86yh1c
        niYadK/mUxtXKn1jJwC6aeMDCdHsqeqhtf/uJRs=
X-Google-Smtp-Source: APXvYqxMU7/5uW0MyUvmt2lUjkWPCdcEqtXmk3Hydlb7ge1HQ9ZIH506P7RA7yyl2Wl+ZJmONkOHelpAd9zdlk6uSrI=
X-Received: by 2002:a92:15c4:: with SMTP id 65mr664464ilv.173.1569971675391;
 Tue, 01 Oct 2019 16:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mspD=iMnO-CuyHMf3jmS0zm7fbqNOXe0cqMcKsXfLAu-Q@mail.gmail.com>
 <20191001231017.67txq4dhrvhyzbu5@desk.local>
In-Reply-To: <20191001231017.67txq4dhrvhyzbu5@desk.local>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 1 Oct 2019 18:14:23 -0500
Message-ID: <CAH2r5mvnYtmfpHY+jeUbN4JehQwY1XfBWYVNSLO+wx1wkAA6gA@mail.gmail.com>
Subject: Re: Many unexpected warnings with current sparse
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, sparse@vger.kernel.org,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may be related to the following sparse make warning:

No rule to make target
'/usr/include/x86_64-linux-gnu/bits/huge_val.h', needed by
'sparse-llvm.o'

I don't see huge_val.h in the Ubuntu 19 version of libc6-dev

Will send you the kernel config - but I am using the default one from
the Ubuntu mainline download of 5.4-rc1

On Tue, Oct 1, 2019 at 6:10 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Tue, Oct 01, 2019 at 11:28:16AM -0500, Steve French wrote:
> > Updated sparse to get rid of some unneeded kernel sparse check
> > warnings but now get many more
> >
> > I get 100s of warnings similar to
> >
> > ./include/linux/quota.h:114:17: error: Expected ( after asm
> > ./include/linux/quota.h:114:17: error: got __inline
> >
> > but that is simply
> >         default:
> >                 BUG();
>
> Hi,
>
> I don't see this on v5.4-rc1 with defconfig or allyesconfig and
> sparse's current version. Any sparse's version since roughly
> mid-December should give the same result.
>
> If you're using an older version of sparse, please upgrade.
> Otherwise, please send me your config so that I can take a look at it.
>
>
> Best regards,
> -- Luc Van Oostenryck



-- 
Thanks,

Steve
