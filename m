Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E0CC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9B520862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="hEs9/pzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfEPO2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:28:02 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:42460 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfEPO2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:28:02 -0400
Received: by mail-oi1-f170.google.com with SMTP id w9so842918oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4x/0z94RkEH7qnNh1ar1v+FYD4KQFu3kNcvlVqxawww=;
        b=hEs9/pzgTmayDkZAx/COHFiBNPrX5KxeCcyULrZ0Rir3lATGKmSiVs6OAgptMMMgkD
         MMmeMTwkFTovgBIuiPtJq41bOAZZa2Js8KxpCW/xCZ4ZDDRcOTUMsi2fXo5m96D6CV0L
         HdC0Gz7JwTBVd2I2viBw9enqNkNiYxlbXs61w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4x/0z94RkEH7qnNh1ar1v+FYD4KQFu3kNcvlVqxawww=;
        b=Z1J6HwE+x17L4GKN5Uye7uc39Uvu9qTsbb77oX28wmJCwrPf2umBAjXC7f1hXrotoO
         tKbnuYtlvIUad0EQan2dSDkVoicDhdTBEkc/xPWX/uNk1sZq49mwNYeo5SYFWI6D+C1Z
         hOi49kkirgURwxeqhrshrUii82jiKoUOOhoz0GfVp8mnhfmF/5FdqONZ7ruY9r54psum
         UYaSj7+17znmGjtWIGvOv7rkl1GOGFhFvxA9E9Rjaaj0lhyz3/OVkhwt/FivTOb4dTbf
         W9KSmjh6AqjZl3HHYHRemzVcrWcOgoYCkWqWnl76yPAnLmbpM6HHFEMGisEwGP0DxHEJ
         7F7Q==
X-Gm-Message-State: APjAAAUqtU/VtUoTG9dQu9Xh3MjkTJdgjg72ASuqNVa0l05PK0Rlp4Te
        02AQ8lQuYBCwgOeIWeCN7ObUM5BlSjvVJV+GxK/Sz3/to/SayQ==
X-Google-Smtp-Source: APXvYqx6Mhh1cAVHSBlbeqHeB6XhpldkqP160VLPmAiojbgzjTImwJfvUrmMIuPBsatW8cpykT/ZgaCwa2nDY4V9ScA=
X-Received: by 2002:aca:af4a:: with SMTP id y71mr10475319oie.55.1558016881294;
 Thu, 16 May 2019 07:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
 <20190509111343.rvmy5noqlf4os3zk@box> <CAO9zADww2v2ckHsNDwRgiyMr9b3JH1xOOSiRJ0Uh2XZT5c=MEQ@mail.gmail.com>
 <CAO9zADyq44Sn0kYZBC55C0ykpHaASzp+27K3BofbkEniK6af-w@mail.gmail.com>
In-Reply-To: <CAO9zADyq44Sn0kYZBC55C0ykpHaASzp+27K3BofbkEniK6af-w@mail.gmail.com>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Thu, 16 May 2019 10:27:50 -0400
Message-ID: <CAO9zADw_PnZMyVJKek-GT96esPXdh007hnzenveawOAM3CvK9g@mail.gmail.com>
Subject: Re: 5.1 kernel: khugepaged stuck at 100%
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 10:17 AM Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>
> On Thu, May 16, 2019 at 10:14 AM Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> >
> > On Tue, May 14, 2019 at 9:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > > Could you check what khugepaged doing?
> > >
> > > cat /proc/$(pidof khugepaged)/stack
> >
> > It is doing it again, 10:12am - 2019-05-16
> >
> >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> >    77 root      39  19       0      0      0 R 100.0   0.0  92:06.94 khugepaged
> >
> > Kernel: 5.1.2
> >
> > $ sudo cat /proc/$(pidof khugepaged)/stack
> > [<0>] 0xffffffffffffffff
> >

As a workaround/in the meantime--I will add the following to lilo/grub:
transparent_hugepage=never

Justin
