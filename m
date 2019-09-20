Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF51DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B280D2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+dOqgXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408641AbfITKTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:19:06 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45283 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408628AbfITKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:19:05 -0400
Received: by mail-ot1-f41.google.com with SMTP id 41so5706729oti.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 03:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMy5oZwzaSi5YDfs1liS0DaI7vPop4R9fEaoU4PLnkE=;
        b=u+dOqgXqwLIk4ijIcH+Lh2Xp7CRSFHdQtnuAf3xgmziguzmDOjjbBtSHpMNmIP5mAH
         zW4CMOH0Pj+C0XhoqeX9X6iDvuE3nrtGZis4ernkiiBftEmJ6E450hVDs328gTpLzCx3
         UAOwihCQO1rxiQp8tj5HHaNOULxyVu7UbpTGWZrvGEvDzCmQAjuUOX6qmf4EI+MrURyA
         nGJA2LBD+Y+csBQVHe1zc7sGi6vP1jvXRmUA1xR468Wfa/NVftgqoVCCtwEvwIvVH82h
         VD02sc2aAQ1xhfYCSQ8q5Uquzt6VN/w68szq6rk/bLQUF72Vy+VYuFH7AHmxxiHdEKao
         g4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMy5oZwzaSi5YDfs1liS0DaI7vPop4R9fEaoU4PLnkE=;
        b=q9J0Ys8okpBfyjzuLGGsWaHj0qWu/ck6VDSzAec5i/8zcuXAPnaIUkTk+MzwRvoWFf
         fiqSBG9vTdHNqC6eRe/KNZKmzT/j6RAS8839fdL8NcjIH3RWaba4OYccJboCiuwWdmTt
         ov5sftd7ir62gu0fSzEmmNwqK5j6AI5Gr5j5NIgsE9dpYGwkJHaImt9BdeNxzGaWFD42
         Mpntjq/ptTag9kENQ09oEkO158q+JGAcrDJHuu4fSW6VIcv9fca3Hn0Y+fWGvxNFaZqf
         fZtYqcGa8/4B7zQ4g6C/cmCm5rJ+CNXY6OPcOkGn5qQC9ujJ91W1bBSSsy8INT+I0XTw
         RXvw==
X-Gm-Message-State: APjAAAVDkPuCnDCiK0O47wu+9CM5p0mBYwBPGnqsu9jhQCpDQJcxafXK
        jA/OtCclhZvaAp+nP5JJZ3W37E3+/4gUGBI9oE0=
X-Google-Smtp-Source: APXvYqzS1DBqjwuNikUvKoQL0j2CZpd6p+BrdFHsj/I9aTB8Jig4txY6GcSj0J9XA9WKUheSk03PzvdnBVOM28gIPys=
X-Received: by 2002:a05:6830:1e84:: with SMTP id n4mr9719021otr.141.1568974744502;
 Fri, 20 Sep 2019 03:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAOtcWM0P=w-iBZzwekVrSpp7t2WO9RA5WP956zgDrNKvzA+4ZA@mail.gmail.com>
 <20190915134300.GA552892@kroah.com> <CAOtcWM2MD-Z1tg7gdgzrXiv7y62JrV7eHnTgXpv-LFW7zRApjg@mail.gmail.com>
 <20190916134727.4gi6rvz4sm6znrqc@function> <20190916141100.GA1595107@kroah.com>
 <20190916223848.GA8679@gregn.net> <20190917080118.GC2075173@kroah.com>
 <20190918010351.GA10455@gregn.net> <20190918061642.GB1832786@kroah.com>
 <20190918203032.GA3987@gregn.net> <20190920074611.GB518462@kroah.com>
In-Reply-To: <20190920074611.GB518462@kroah.com>
From:   Okash Khawaja <okash.khawaja@gmail.com>
Date:   Fri, 20 Sep 2019 11:18:53 +0100
Message-ID: <CAOtcWM2271YEVCc=0O8QApyUhSJx+uA_vfnXyUnGHfjugzGoyg@mail.gmail.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of speakup
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gregory Nowak <greg@gregn.net>, devel@driverdev.osuosl.org,
        Simon Dickson <simonhdickson@gmail.com>,
        Didier Spaier <didier@slint.fr>,
        "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, linux-kernel@vger.kernel.org,
        John Covici <covici@ccs.covici.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 8:46 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 18, 2019 at 01:30:33PM -0700, Gregory Nowak wrote:
> > > Extra line between each attribute (before the "What:" line) would be
> > > nice.
> >
> > In a previous post above, you wrote:
> > On Mon, Sep 16, 2019 at 04:11:00PM +0200, Greg Kroah-Hartman wrote:
> > > Anyway, please put the Description: lines without a blank after that,
> > > with the description text starting on that same line.
> >
> > I understood that to mean that the description text should start on
> > the same line, and the blank lines after the description text should
> > be removed. I've put them back in. Someone more familiar with the
> > speakup code will have to dig into it to resolve the TODO items I
> > suppose.
>
> No problem, this looks good to me.  If someone wants to turn this into a
> patch adding it to the drivers/staging/speakup/ directory, I'll be glad
> to take it and it will allow others to fill in the TODO entries easier.

Thank you. I'll create a patch soon.
