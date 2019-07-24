Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D84C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535E52238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="LZWjiZpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfGXA6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 20:58:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32918 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfGXA6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 20:58:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id r6so39617964qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 17:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oASs8uYGKSbhcsk738Ru91K1IEqBMwZxngEg6++szx8=;
        b=LZWjiZpBtpT2bEFO6EUMuDgmX2l5GA3NIJ7uhRtxRtT3kT6m1aQy24Gom1WLWTLBHA
         mbcbb5Ghnk0kH0giCbvjnCrfq6kB90kehk6ZCl5JK1ziFAU4GF5MpzNG4SPvOpvvh1sY
         Ys6q/OeoUSJeWet4ylOeMbmMZwPOdDdIlToKDwwGJXpY4dptVxFpCJK7HmfeQ5HwWZPS
         oxN0l2xC3IekY9R0LacrU333l9Uq3pebzWhvTYqsotUQo6DpCHJ/+ndzf9qNZrtlwUyj
         iu5HuManAbQJm2gAb2whlSgWtY1/95MCPv42FkL4j31Qob/lGVpX/9IdP7LZVWZMHaHB
         fwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oASs8uYGKSbhcsk738Ru91K1IEqBMwZxngEg6++szx8=;
        b=B6FmdBKMNfxN98ynw3IeZXb9rQbWWuz/d7bXCJRhN/f6pF09/JtwmfE6ZmCESsnxXW
         eY1HSftv6eMEX9MyinLMMgJ8WbBNiGizDL5SSVae/sa4NuuJl7rLxV7bSs1mwOWAK9Aq
         1veeUpSwotlf3f1OtxIDxsQl6Yrmb8bN+r1W7rZEDd+dRXoWgZOIv74qIz3Giw9xyIgM
         myF5JK5u2Xd72F7l+131PWVUF1RXJNVypQfjw2ROJy9lmMRcMkonk77HIVoJIZf1q1dr
         NeQMDWaUc/O8JMYlvwOWORA4BAMgoT1hxjMX9SqGvGRORsSyq05luYpWgMVPtqxhHQ2v
         WKnA==
X-Gm-Message-State: APjAAAX3rxptBnoLIaKurAdmuE9dNjwMszKRxygkvprLr7wPS1uA4MoM
        tU7/x7Mv86BP4qVFwOY8+/GyvsVP/omPtpfpr/U=
X-Google-Smtp-Source: APXvYqwcNmsPPp8085fZAASKJZsAQ3t8jFnX8fmaYib9qDAxnfX0Wj0y2Rk0U2Q0i6+d7tHPu6gkO5twYW8ut9749Zs=
X-Received: by 2002:ac8:2409:: with SMTP id c9mr55507527qtc.145.1563929884513;
 Tue, 23 Jul 2019 17:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190711113517.26077-1-axel.lin@ingics.com> <20190723112647.GE5365@sirena.org.uk>
 <CAFRkauDSbmtGRnE0xvKOKxb=SWOA+03i60Wu-9KHYxh1qFuCEg@mail.gmail.com> <20190723163503.GL5365@sirena.org.uk>
In-Reply-To: <20190723163503.GL5365@sirena.org.uk>
From:   Axel Lin <axel.lin@ingics.com>
Date:   Wed, 24 Jul 2019 08:57:53 +0800
Message-ID: <CAFRkauBACWC1pcxJe9tJyK4vM2R2BSu2z9sej3GLket3niZg9w@mail.gmail.com>
Subject: Re: [PATCH RFT] regulator: lp87565: Fix probe failure for "ti,lp87565"
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2019=E5=B9=B47=E6=9C=8824=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Jul 23, 2019 at 08:28:35PM +0800, Axel Lin wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2019=E5=B9=B47=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:26=E5=AF=AB=E9=81=93=EF=BC=9A
> > > On Thu, Jul 11, 2019 at 07:35:17PM +0800, Axel Lin wrote:
>
> > > > The "ti,lp87565" compatible string is still in of_lp87565_match_tab=
le,
> > > > but current code will return -EINVAL because lp87565->dev_type is u=
nknown.
> > > > This was working in earlier kernel versions, so fix it.
>
> > > This doesn't seem to apply against current code, please check and
> > > resend.
>
> > I re-generate the patch but the new patch is exactly the same as this o=
ne.
> > It can be applied to both Linus and linux-next trees.
> > Did I miss something?
>
> It's a fix so I was trying to apply it on my for-5.3 branch.

The commit f3f4363b1239 ("regulator: lp87565: Fix missing break in
switch statement") from mfd tree has been merged to 5.3-rc1.
So I'm wondering if the better approach is rebase for-5.3 branch to 5.3-rc1=
.
Then you can apply this patch without conflict.

Anyway, I will resend the patch against regulator tree for-5.3.

Regards,
Axel
