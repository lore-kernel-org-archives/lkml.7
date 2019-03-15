Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C25FC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3CC21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 08:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="oELe57sN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfCOIe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 04:34:26 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41804 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfCOIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 04:34:26 -0400
Received: by mail-vs1-f67.google.com with SMTP id z25so3597549vsk.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s5upj3v+TSeq1leK9fAsZyA35bnuuGD34MaHoF8Wovc=;
        b=oELe57sNsZVSlcdttIyaeC7KAlvCBASH9QF93WSwUDxIg+1CrtRF1RpKzM9b+HjwGT
         BIHOmR8TfKZopjrL+FtSWIGBQb3XouaNWBT2N3EGmPeaxj/zfOJVfYx9fk/8DfrxTVyp
         ZlAGpvkBWHympzmyvQlgaiilHO8DkCii1ks7f02JVe6ZM1DlbReaIxOqLiSSpA2mubG2
         GyoPtbv/zexGKFstBr83F7stkYri7dSs4veM4B0p+uyauq9kRtCWoBHTDwFi5AfnD2fa
         b6qRVAVvKStlE+21JuETHds0/zbf3bN7m9hGE3nL2ROEVATxSZDUEKCwzOpGJsfNnCrD
         hNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s5upj3v+TSeq1leK9fAsZyA35bnuuGD34MaHoF8Wovc=;
        b=jOHzZQ727dyyJ9dNYrQmuTFrucCzmiPCSXoRNJBtSr3CMc/rZZ5kFbWCF/tVzjHmFk
         N4TSxefOpdwi8LsADkIBoHM9KpdqCeY7tceUapWVdvfqAQLDD4HD+cdbXYS7rU8kPxte
         WIp6COti5m1pCoW3NdjYaB7NMJr3NAjwSBPkhak5l+72p5S5OjrptDQzSPUapcr29aD+
         BGYKJlhEgL1kErtM5T7pLQu7yKKPrs4v1efq+eGqEmBGY4QtJzr1DAXmkwn1O2AzlegB
         rb3oG/pCeHQmUWIR9ovrgKVxJ9V2iH6qPQ6jqu0T4mlE4de9km1kAHo7Oqr/8BIrvbp7
         PVoA==
X-Gm-Message-State: APjAAAUhKN/vtFAb6QJV01nYdb1vudDlAZGRVqcTjHsqnFwLmvCbXwju
        z+IsA4Do335J+ClRgomha7TS29EM5AUpJrZwgmVsYw==
X-Google-Smtp-Source: APXvYqxKIuoqcCTvQhbTpjvwM8OShctA1QmP+rbImuBsoMDLFsaDkMlX9FrNwfAeLPU9OfcAv1dpbuWgLkcoGwb8k1c=
X-Received: by 2002:a67:ba05:: with SMTP id l5mr1305615vsn.153.1552638865111;
 Fri, 15 Mar 2019 01:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190314111637.20236-1-hans@owltronix.com> <103c19f4-02a2-f54c-13f8-30bc5447426e@intel.com>
 <FE25456B-A63E-4601-960D-96F519250B8C@javigon.com> <CAJbgVnU2RXK4ci79n0szwTpZ+UB2zx977PHo1ie7h5y5kJrbhQ@mail.gmail.com>
In-Reply-To: <CAJbgVnU2RXK4ci79n0szwTpZ+UB2zx977PHo1ie7h5y5kJrbhQ@mail.gmail.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Fri, 15 Mar 2019 09:34:14 +0100
Message-ID: <CANr-nt0DHudD9TFBqLzhgBuYz8GqVbwgiU7W2b5OVsLtpMuu_w@mail.gmail.com>
Subject: Re: [PATCH RFC] lightnvm: pblk: fix crash in pblk_end_partial_read
 due to multipage bvecs
To:     Heiner Litz <hlitz@ucsc.edu>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 5:15 PM Heiner Litz <hlitz@ucsc.edu> wrote:
>
> On Thu, Mar 14, 2019 at 7:16 AM Javier Gonz=C3=A1lez <javier@javigon.com>=
 wrote:
> >
> > > On 14 Mar 2019, at 06.49, Igor Konopko <igor.j.konopko@intel.com> wro=
te:
> > >
> > > While reading this patch, idea came to my mind - maybe it would be si=
mply better to get rid of partial read handling from pblk in current form a=
t all and use bio_split() & bio_chain() combination instead?
> > >
> > > This would definitely reduce a number of this 'kind of complicated' c=
ode inside pblk and let block layer help us with that. Even that the perfor=
mance of such a requests could be a little worse (few smaller IOs instead o=
f single vector IO), I believe that partial read is more a corner case, the=
n a typical use case, so maybe this would be a path to go.
> > >
> > > Let me know what you think about such an approach - I can make a patc=
h with that if you want.
>
> I like this idea as it will clean up a lot of code and get rid of the
> read_bitmap.
> Note that a single request can be turned into up to 32 requests if
> cached and non-cached sectors alternate, each one probably requiring
> an l2p lookup. I still think it's worth doing though.
> When you split, note that you have to release all line_refs which were
> acquired during l2p lookup.
>
> >
> > I agree with Igor.
> >

I agree as well, this path deserves some loving care and cleanup.
Let's just try to avoid read tail latency degradation.

Simplifying the code is a great first step, then we can optimize if needed =
be.

Thanks for the feedback y'all!


> > As I mentioned offline, we should fix this in a way that survives
> > further changes in struct bio; either making pblk handling visible to
> > the outside or rethinking the whole thing.
> >
> > Igor: If you can send a patch you mention, it would be great. I have
> > been trying the helper approach for some time, but it is too specific,
> > as fixing holes in the bvec breaks the bio advance-only semantics. Your
> > approach seems much better.
> >
> > Thanks,
> > Javier
