Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F97C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F06E206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f75OYjPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfHNNJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:09:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36072 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNNJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:09:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so4424864wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDLa6zXMAOjQhOfwSq9LjN1EM9IBbq4NVeShp4a46KE=;
        b=f75OYjPPZqrZUXpIVDLeS6DLx3A+MnbtEpOHyayzqK0y7pDvvQDHb2pPMoFxAWJCrB
         ufhbdsMKzG+hWZiS6/aPr7uiCVgSq1ZgCZcQC7yiCU1HYAH+KE08GSlO+DgbNQdOdEp9
         WkWVjiAyySSx+VTYT3WHZ5/hF1XvD5z0bihtnMnTXlL7WFmgvogaWkUGtX4Rv2qgi3Gu
         mLCbBqlv+xVSCjhCHawEVff1MG3clE/qBUgXrkbsT5QAlMiC7qTK8W+yQGW5VMMn+CGl
         qmz1Q2Z1qBPAPgxfjdxLuueZAhR4GdYuZ4j/q9jI0Km84opMLHdDV+9OIiRwwfE3X5ZB
         OHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDLa6zXMAOjQhOfwSq9LjN1EM9IBbq4NVeShp4a46KE=;
        b=br6wKu6EJsMPPiHFvyLd5d6Ix/x9EpCyV6pqKHSygiExSghpr/0ys6XOGXstb9723l
         JaoBU5ZrGbxbtjgzdZQ7WuqHnFys8/+ntkO3tx7d4IuVFIiJxjl7MH58O7IJnI9Os82y
         dqt5BDO9GO8GvRhafC4rN0HfwoStlAXhHCVnCyQ38+RBpWBByPzD/7mY1IALsr/Y97wK
         /TroDPtr4bwLuO+nGyh4pJJtgw0qiZtc0AtiXeqGPBZjXBa+jVTeANJIGQI6IHWRCCal
         AzahTS0O7u3KjilfLCoY6FgP0Z5LuBQuDisjnh2yFzV1NYsbuFr7ODSNMejjHH8ra4ew
         iUcQ==
X-Gm-Message-State: APjAAAUQDxTMxTUFApiXjbUKjyFeJuUwzIvmsTZz6OVAIxstP7XTf7qR
        VtAu90oy3LVBOeYlCd5FkCQKQwyIehs6l3qom2IgZfJHihl+27qH
X-Google-Smtp-Source: APXvYqwYo+nywgJ51yXUMS0ayH35PhWDPLpiWFs2L1EnqpMr/rvtJW+8lSP/5xz5OHu5DkyvzL3KHDOVwxm+6gkEmOc=
X-Received: by 2002:a1c:a481:: with SMTP id n123mr7882793wme.123.1565788162062;
 Wed, 14 Aug 2019 06:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190813212251.12316-1-ben.whitten@gmail.com> <20190814100115.GF4640@sirena.co.uk>
In-Reply-To: <20190814100115.GF4640@sirena.co.uk>
From:   Ben Whitten <ben.whitten@gmail.com>
Date:   Wed, 14 Aug 2019 14:09:11 +0100
Message-ID: <CAF3==iuZvCnmAg9hqs8ivHw0wHaUQEf8k9U8=KTekMMjdyyEKg@mail.gmail.com>
Subject: Re: [PATCH] regmap: fix writes to non incrementing registers
To:     Mark Brown <broonie@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, nandor.han@vaisala.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 11:01, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Aug 13, 2019 at 10:22:51PM +0100, Ben Whitten wrote:
>
> > @@ -1489,10 +1489,11 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
> >       WARN_ON(!map->bus);
> >
> >       /* Check for unwritable registers before we start */
> > -     for (i = 0; i < val_len / map->format.val_bytes; i++)
> > -             if (!regmap_writeable(map,
> > -                                  reg + regmap_get_offset(map, i)))
> > -                     return -EINVAL;
> > +     if (!regmap_writeable_noinc(map, reg))
> > +             for (i = 0; i < val_len / map->format.val_bytes; i++)
> > +                     if (!regmap_writeable(map,
> > +                                          reg + regmap_get_offset(map, i)))
> > +                             return -EINVAL;
>
> This feels like we're getting ourselves confused about nonincrementing
> registers and probably have other breakage somewhere else - we're
> already checking for nonincrementability in regmap_write_noinc(), and
> here we're only checking if the first register in the block has that
> property which might blow up on us if there's a register in the middle
> of the block that is nonincrementable.  If we're going to check this
> here I think we should check on every register, but this is
> _raw_write_impl() which is part of the call path for implementing
> regmap_noinc_write() so checking here will break the API purpose
> designed for nonincrementing writes.

So it appeared that the last patch in this area for validating a register
block [1] broke the regmap_noinc_write use case.
Because regmap_noinc_write calls _regmap_raw_write and in
turn hits the _regmap_raw_write_impl, the val_len is the depth of the
one register to write to and not a block of registers which is assumed
by the previous check. By inserting a check that the first (and only)
register is a noinc one allows me to start writing to my FIFO again.

I'm all for an alternative solution though if there is a cleaner approach.

Kind regards,
Ben

[1] https://lore.kernel.org/patchwork/patch/1057184/
