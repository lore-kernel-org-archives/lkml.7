Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04410C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF7620855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE7kSjzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfDDQYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:24:06 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33262 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfDDQYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:24:06 -0400
Received: by mail-vs1-f65.google.com with SMTP id a190so1737756vsd.0;
        Thu, 04 Apr 2019 09:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4AkQLLIUIPYpV/JS7s3jTAzAGf+1v6pVPd+k37Rstdw=;
        b=hE7kSjztgwz0MC81/GIIudK1yRuB2MB5Y5TeYbNvTO6g/0pyPzGhuXpjmr56P9rklO
         h7AHxEG8CysYexiruRj5kkSKQlJgQHUMaJ5rq8sKgfcfB4yTr4tNFUX/h3aD0amYg4qY
         77Qst/drCl1J0cEvN6tSLpyBctCjsJORMSgLFfKal9vbUtrh9ixKN0cCafn2e6yUNaqB
         ff5G3aYJDcnvumoMQ36+bBVl9lAtwul8/YTzB1TcF3UiKYGkQb+64xJ7L7K1JgCVS0hK
         00TCdcBhhESk3NASVju+AWBV7q87tI77H+ssa6XcImMX434t9HgfWTCjmqEsm+0Hykbo
         o1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4AkQLLIUIPYpV/JS7s3jTAzAGf+1v6pVPd+k37Rstdw=;
        b=DkZFb6RnL2Q2FdlTCbnrSKffuJokxLtW6pExL0o0UrvKSmesCLaEjzi5XVeZRaFxJc
         A7lB3XNxbO6sFIDaIjy/1Ghivs1Dwe2bPwKOt6ixLGF12Uy8G8VXMIo83grwjIW2QW1Q
         wPjJZGqWHfIBzB/D/0zL4DZyCm3ALiO2kpbqQ//BSs95jCrEnufWpXW1rlkeXUOs3JmE
         duVYDeblIf26qq6Z+x38h+wUsgDfRO1SGVQxZmmE0FbzJDkYpKanMGGhdeK6EAIca/7N
         OCPf0okHzJGLjQEfFh4kqFXfUb7aOpVbPV34pHDYFFXlG6nmhVqAkrgva8euTuoZAybg
         iD5Q==
X-Gm-Message-State: APjAAAXMZO6lwZCMeQ6yR9Hoti9PX/choLVOil/F3FY8F7Yv5dOa4nJr
        BmzBsuCs1oWzMcCoFp+pAIMKzee25pKSnClvL7g=
X-Google-Smtp-Source: APXvYqxFQT3+wPMm2/64FSrBlqdA60ZMPBDoaUVOx92JlpNwVBFxOtwTuGCYtnOr9rfOug/5fN3M++UH323rTDv0MKY=
X-Received: by 2002:a67:e9cc:: with SMTP id q12mr4569249vso.208.1554395045066;
 Thu, 04 Apr 2019 09:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.92acdec88ee4c280cb74e08ea22f0075e5fa055c.1553032382.git-series.maxime.ripard@bootlin.com>
 <fecde1c7b65caa0e876a2f01769289a883014712.1553032382.git-series.maxime.ripard@bootlin.com>
 <CACvgo51WMD5hsyLB5QTriGNwcPmeN4TDjscJV11M3PXFncPHeQ@mail.gmail.com> <20190402145114.bpt5atxxooufgzz5@flea>
In-Reply-To: <20190402145114.bpt5atxxooufgzz5@flea>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 4 Apr 2019 17:24:03 +0100
Message-ID: <CACvgo53mNnH88nB2XkzBLQyXD8osGwBGL7ba=QXTx-T+Bp_iKA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/20] drm: Remove users of drm_format_num_planes
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2019 at 15:51, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Emil,
>
> On Tue, Apr 02, 2019 at 10:43:31AM +0100, Emil Velikov wrote:
> > On Tue, 19 Mar 2019 at 21:57, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > drm_format_num_planes() is basically a lookup in the drm_format_info table
> > > plus an access to the num_planes field of the appropriate entry.
> > >
> > > Most drivers are using this function while having access to the entry
> > > already, which means that we will perform an unnecessary lookup. Removing
> > > the call to drm_format_num_planes is therefore more efficient.
> > >
> > > Some drivers will not have access to that entry in the function, but in
> > > this case the overhead is minimal (we just have to call drm_format_info()
> > > to perform the lookup) and we can even avoid multiple, inefficient lookups
> > > in some places that need multiple fields from the drm_format_info
> > > structure.
> > >
> >
> > I'm not fan of the duplicated loop-ups either.
> >
> > > -int drm_format_num_planes(uint32_t format)
> > > -{
> > > -       const struct drm_format_info *info;
> > > -
> > > -       info = drm_format_info(format);
> > > -       return info ? info->num_planes : 1;
> > > -}
> > > -EXPORT_SYMBOL(drm_format_num_planes);
> > > -
> >
> > The existing users are not updated to cater for the num_planes != 0
> > case... Which seems non-existent scenario since all the current format
> > descriptions have 1+ planes.
> > Should we add a test (alike the ones in 6/20) to ensure, that no entry
> > has 0 planes? Is it even worth it or I'm a bit too paranoid?
> >
> > The above comments apply to 2/20.
>
> I'm not entirely sure what you mean. num_planes is returned as is in
> the drm_format_num_planes function and it doesn't check for the
> num_planes value itself.
>
> That being said, we could definitely add some more tests to check that
> we haven't falling into the situation you describe, since most of the
> drivers indeed don't check for that value themselves. But that seems
> pretty othorgonal to me?
>
Hmm I misread the old function as "return info->num_planes ?
info->num_planes : 1;"

Pardon for the noise.
-Emil
