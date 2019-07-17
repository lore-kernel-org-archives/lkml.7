Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11434C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5802173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEozaRqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfGQOxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:53:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40556 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfGQOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:53:38 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so46152370iom.7;
        Wed, 17 Jul 2019 07:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nkqgY/elZbcrJEMnIsIBOH0HseeBLn/T4w9IKlfYq8Y=;
        b=XEozaRqs7Uajdgr3NQ1IIYrWTIE83AO95ql+NN0hJoyTzD+cJyxBwZE3t73a//jkoo
         LwOXPYfNIr9riusqzu19AqgwTREIN76Kew4Fu1ju0mVgnZt42+QOY5Yn3cWg/0sZhS9U
         Khd3kEGk4DnNumniQp+1+S3pvHMy78mmcO1skmfjTwbsdWqGE6g35bYZI58wgnOrnisl
         BHB1nhfKXh8mu0gONA32axzYhb43w6RTS7Qk1SBQKPDoInaHLO52wz25zR6SpgwAJ77L
         dyiO6FT3Q1GNg+WHopZb/fPPsOdNg0sMtyzeLyftAPVSWN/+nFPGPiLJYyuwpDRxyTiL
         ZHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkqgY/elZbcrJEMnIsIBOH0HseeBLn/T4w9IKlfYq8Y=;
        b=g4VKaO0TFXbkEZ8rvQcwrsHYcswJdHOIErCqkDZYAK/zC2Wo+0hJlXQkjzs1R/nm4n
         59BIKYgY0uu064Hko8OV3NxcdcsF18MCcRF7aM4jt2ZNd6U+XnkfJ6CHPdgqd6gf+CiY
         4avcfa+TiPRa7vnIX4qAk/ouS3OW0Xwd9yaLfRO1zELuNjASKwcwTRtt85U/VWtP1+Dc
         y1Tw7yJT/twpyGfq9HLzgI35hPKWFI7kMREnnp/uFXcqFaeLGvrpHINc1xis00jiWie3
         i9B6FJ/je+9vChFCVdWId5KKWCcg8ynaMJe547abSiNOyJT3256aIL2Q1Hsv66NdZ3xX
         chig==
X-Gm-Message-State: APjAAAWoWAjC3PtxcBNoVUyG3sFn6V8LJWMLghP5Crds2QLc0iX0QRg1
        FLr+4i2GN90ki4WfOEYg2982Qw/EjUMxNS7Xm3s=
X-Google-Smtp-Source: APXvYqxfCwsmngHDQfK0eX07zlB+QOFZIleWDGPT05DkjS5sQwnRqY7EYnuaZbUlciWr5oGxk+PiXaA3zpBgo5mQDLs=
X-Received: by 2002:a6b:f607:: with SMTP id n7mr37896951ioh.263.1563375217187;
 Wed, 17 Jul 2019 07:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190715201234.13556-1-andrew.smirnov@gmail.com> <20190715220043.55E8A20665@mail.kernel.org>
In-Reply-To: <20190715220043.55E8A20665@mail.kernel.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 17 Jul 2019 07:53:26 -0700
Message-ID: <CAHQ1cqHCbObjpD4p-WVQmoP3Jth=j3ap-qCjuETj416rCBtjLg@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: Sync prototypes for clk_bulk_enable()
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Chris Healy <cphealy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 3:00 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Andrey Smirnov (2019-07-15 13:12:29)
> > No-op version of clk_bulk_enable() should have the same protoype as
> > the real implementation, so constify the last argument to make it so.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
>
> No cover letter, but I'm inclined to squash these all together into one
> patch instead of 6. I'm not sure why each function gets a different
> patch.
>

Sure, will squash all in v2.

Thanks,
Andrey Smirnov
