Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DA12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 04:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sd9+XkNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfCRElb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 00:41:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33175 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCRElb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 00:41:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id q24so13309350otk.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 21:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltBVV44SsuqJ8Mxo4h0OwbaYZ4cq62RESnfO6q7Ji90=;
        b=Sd9+XkNo4Lt54ydKJHdvq84AIUJX9PQQMRaB2L0aafChhepf1CesU613CtWVhPggqa
         ULJcqejZST1dtGolaI3EUg6ECle17fjviWp7Gj8pInqdP2axsBRyqMMUS3xZYoTHaF76
         H4R8K44PMnailBOhl8FRe52GmClJ8CX3shOfTpW/KUvdTKFd87wygZvC9y8/GJcFTDIE
         +39GatzZSjjwJ2Wc6MAatBUD1/Oca8Xq5bhBDj/Y7dLOtJjIZ/YK27auMk2Y7ZA1n9Zx
         I6Nn+Sp/DZVvqQkPnoRnjkLgPToOF7u1w6kaq5bMjNPPmtpDq/ziQRVy5ipX/mehTx1R
         tiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltBVV44SsuqJ8Mxo4h0OwbaYZ4cq62RESnfO6q7Ji90=;
        b=f4OV502kAHLQuhouUZNLhl0MkdHLRBcDd6eh1kbvdmIakpZcIZbk9CVLnAiO5Er/Cw
         21E5gSnNzpsjsU920mwOcPf167nyEwVMpCmZdAYbSQjIlihkmRCF+oTglVQo7s8xF898
         5I5vasP/hlDHhDsZ4muOyKixodV+9W9mBeoNYGWFE/5aEXSTnkVQAXIy8ZvE386YlxGw
         c96IbhsaE4aTNyEoaU6VEiYpHg6ycYb0I4fwJGgWLZW9uWO9ctGFIascEDbtQLkX8k8t
         H1WdzwMcruwRFccc1eMsMXBC/vsboKfmtP8nFtrpSxp2jp1dzMZyyCHItyWpXiI+z72N
         dLhA==
X-Gm-Message-State: APjAAAXEHS4Q+/mAT27QE5t00RSOKA3Dlk/1V33HF2as0OL3xSjhsfyq
        ww6zWiPg65zJbg0bQq1eru0YgfR/ib+dVftAzG3czw==
X-Google-Smtp-Source: APXvYqyGCgQnnIXkIDLDotelmm2MrVCubQMjBF1/SJStDy4gVaQKYAPVNKAbfpxD15kMW9UHovu2kDzfE7WyyHw2gvY=
X-Received: by 2002:a9d:6c0b:: with SMTP id f11mr9996294otq.293.1552884090213;
 Sun, 17 Mar 2019 21:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-2-git-send-email-john.stultz@linaro.org> <b090063c-86ce-bc7b-4da0-80ca19883a47@redhat.com>
 <CALAqxLXho_rwsdAY9u3=oTXukQnTzqfP_EFmwgdZm+A1bQRVuw@mail.gmail.com> <86b9ef2e-99f7-ad8c-dbfc-418c1538a0a8@redhat.com>
In-Reply-To: <86b9ef2e-99f7-ad8c-dbfc-418c1538a0a8@redhat.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Mon, 18 Mar 2019 10:11:18 +0530
Message-ID: <CAO_48GE4ULgSNf5D-XnM7sZF1wN_-TPOUcPY9vAAgLh1949Vcg@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/5 v2] dma-buf: Add dma-buf heaps framework
To:     Laura Abbott <labbott@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 at 04:15, Laura Abbott <labbott@redhat.com> wrote:
>
> On 3/15/19 2:29 PM, John Stultz wrote:
> > On Fri, Mar 15, 2019 at 1:18 PM Laura Abbott <labbott@redhat.com> wrote:
> >>
> >> On 3/5/19 12:54 PM, John Stultz wrote:
> >>> +DMA-BUF HEAPS FRAMEWORK
> >>> +M:   Laura Abbott<labbott@redhat.com>
> >>> +R:   Liam Mark<lmark@codeaurora.org>
> >>> +R:   Brian Starkey<Brian.Starkey@arm.com>
> >>> +R:   "Andrew F. Davis"<afd@ti.com>
> >>> +R:   John Stultz<john.stultz@linaro.org>
> >>> +S:   Maintained
> >>> +L:   linux-media@vger.kernel.org
> >>> +L:   dri-devel@lists.freedesktop.org
> >>> +L:   linaro-mm-sig@lists.linaro.org  (moderated for non-subscribers)
> >>> +F:   include/uapi/linux/dma-heap.h
> >>> +F:   include/linux/dma-heap.h
> >>> +F:   drivers/dma-buf/dma-heap.c
> >>> +F:   drivers/dma-buf/heaps/*
> >>> +T:   git git://anongit.freedesktop.org/drm/drm-misc
> >>
> >> So I talked about this with Sumit privately but I think
> >> it might make sense to have me step down as maintainer when
> >> this goes out of staging. I mostly worked on Ion at my
> >> previous position and anything I do now is mostly a side
> >> project. I still want to see it succeed which is why I
> >> took on the maintainer role but I don't want to become blocking
> >> for people who have a stronger vision about where this needs
> >> to go (see also, I'm not working with this on a daily basis).
> >>
> >> If you just want someone to help review or take patches
> >> to be pulled, I'm happy to do so but I'd hate to become
> >> the bottleneck on getting things done for people who
> >> are attempting to do real work.
> >
> > I worry this will make everyone to touch the side of their nose and
> > yell "NOT IT!" :)
> >
> > First of all, thank you so much for your efforts maintaining ION along
> > with your attempts to drag out requirements from interested parties
> > and the numerous attempts to get collaborative discussion going at
> > countless conferences! Your persistence and continual nudging in the
> > face of apathetic private users of the code probably cannot be
> > appreciated enough!
I totally second John here - the persistence has been inspiring to me
personally as well :)

> >
> > Your past practical experience with ION and active work with the
> > upstream community made you a stand out pick for this, but I
> > understand not wanting to be eternally stuck with a maintainership if
> > your not active in the area.  I'm happy to volunteer as a neutral
> > party, but I worry my limited experience with some of the more
> > complicated usage would make my opinions less informed then they
> > probably need to be.  Further, as a neutral party, Sumit would
> > probably be a better pick since he's already maintaining the dmabuf
> > core.
> >
>
> Honestly if you're doing the work to re-write everything, I
> think you're more than qualified to be the maintainer. I
> would also support Sumit as well.
>
> > So I'd nominate Andrew, Liam or Benjamin (or all three?) as they all
> > have more practical experience enabling past ION heaps on real devices
> > and have demonstrated active interest in working in the community.
> >
>
> I do think this would benefit both from multiple maintainers and
> from maintainers who are actively using the framework. Like I
> said, I can still be a maintainer but I think having some comaintainers
> would be very helpful (and I'd support any of the names you've
> suggested)
If it's required, I am happy to co-maintain - we could even follow the
drm-misc model of multiple co-maintainers. I will support any or all
of the names above as well :)

>
> > So, in other words... NOT IT! :)
>
> I think you have to shout "Noes goes" first. :)
>
> > -john
> >
>
> Thanks,
> Laura
>
> P.S. For the benefit of anyone who's confused,
> https://en.wikipedia.org/wiki/Nose_goes


Best,
Sumit.
