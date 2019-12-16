Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F91C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5D120684
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/J/iNuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfLPNSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:18:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35520 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfLPNSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:18:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1838741plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDTG1dtuof8oohV+ZDjnkTKA+QbTtPXocHHBYvIWtYU=;
        b=S/J/iNuzrRNSlcoVOoFAosx1pTi88JQTvUDIvkDwjAvXTjmXKPJ+OY4ApQT00OvL3T
         BihH2XEs9CCbEwTg5bdsJ5JzMng+nXSqV27hrzRCNGYnl5j/pXS3xCnHab5m3tZ6lfdS
         fVC8ESr3EjvsR8tKYP9Fiy5zwxgVnslVyb57oNetnP2OwrBlIKqff4Ebb8UZ1NwS7qHi
         4ng9ekKWSPIz15ZgFpQUXh3CSH6OW29DsvxB5Y+aywtmQtx5nvxSOWQxq3KZoQiM8hD8
         B66/8OtrhB7y+cyji/kKZQpgSpbAOU3q9F7IysssNwFVfmWs0fJ9KVJ93S050e6tMU+B
         /2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDTG1dtuof8oohV+ZDjnkTKA+QbTtPXocHHBYvIWtYU=;
        b=N81Q7nih3Z/BP0et8ddvrXYwkDptpzkjSx2ZvF1etz5w214O0ttL5R3TintE1YT0tZ
         2GiHNz2LnBGrDlCGkOFb5WOfMzS7GUW8fxLgYdL8p6Q1fIoES3mdd/5R1RAxVQXvo2AQ
         5aAHU68pWUkLUbmImG9YDjVNr71pl85qvlyTiForDMvdKblKGUbEGJPkydM3yghUKdwk
         BCp4H4+A28f+xbGw6iKNtQIywYzJKjprxncFskXkMC7gfroUkHzV6X6XJXN0Ygal981s
         cwOrTiJncvjPhQK0Cy1uf8GAP1g1BvLwJfnPjSoLPxETvfyT6aOdw/yuwrB/EQBgNsfC
         6VNg==
X-Gm-Message-State: APjAAAWTLfVd9DNsR+TKd/Aj2Ns2DJXHmaPn1sud3ENwsp/o8MC3ujRL
        IQGVooPDqJJg3n7Mhm4Fkk4/pW4u/HuRjFYD7YDSvA==
X-Google-Smtp-Source: APXvYqyU6prPxVR6gNSNaVAUcL5V++4eeLFe5K9rpahXPgNvA2HzUtv8aCtb6oKq0CyPcRLFn+BQdhyiEUMOptdlRdE=
X-Received: by 2002:a17:90b:150:: with SMTP id em16mr17350598pjb.123.1576502283682;
 Mon, 16 Dec 2019 05:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20191108154838.21487-1-will@kernel.org> <20191108155503.GB15731@pendragon.ideasonboard.com>
 <20191216121651.GA12947@willie-the-truck>
In-Reply-To: <20191216121651.GA12947@willie-the-truck>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 16 Dec 2019 14:17:52 +0100
Message-ID: <CAAeHK+xdVmEFtK78bWd2Odn0uBynqnt5UT9jZJFvqGL=_9NU2w@mail.gmail.com>
Subject: Re: [PATCH RESEND RESEND] media: uvc: Avoid cyclic entity chains due
 to malformed USB descriptors
To:     Will Deacon <will@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 1:16 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Laurent,
>
> On Fri, Nov 08, 2019 at 05:55:03PM +0200, Laurent Pinchart wrote:
> > Thank you for the patch.
> >
> > I'm sorry for the delay, and will have to ask you to be a bit more
> > patient I'm afraid. I will leave tomorrow for a week without computer
> > access and will only be able to go through my backlog when I will be
> > back on the 17th.
>
> Gentle reminder on this, now you've been back a month ;)

Hi Will,

I think we now have a reproducer for this issue that syzbot just reported:

https://syzkaller.appspot.com/bug?extid=0a5c96772a9b26f2a876

You can try you patch on it :)

There's also another one, which looks related:

https://syzkaller.appspot.com/bug?extid=0b0095300dfeb8a83dc8

Thanks!
