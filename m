Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51668C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 15:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23731214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 15:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr5ayy0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbfIOPMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 11:12:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37828 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731146AbfIOPMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 11:12:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id c22so3600879ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAx9CazxVD+2EMzZ/lZkcxY69ny3xVHSpQj5D2mK4Uw=;
        b=Mr5ayy0/TC7tpybu8laITyS6x6IHn/pnad7LiWUGnFq4l9zP8FJPBC2PgQoVnuTECg
         l0atzS7DZ0YR7binUwjXXfFDtw2AIfuGPLcZhpKHHOQMgyuypGe0OJtg0UsDVEa2vo2X
         pisSnLD6s53uOiDcrVzoDWT2CFuQPMrf4wGHczm3k+2XASjNc+TTzP8T+/Or5F8P3pIK
         y5Q19ukwYmt8ebECJ1mQhDr4VyxpLk7qAMWqBk/vGDe7hJmqq0i/4fPuliUcDDowxUyJ
         1otchPoR+K3Tb4DxAACRU027rhO1ZeO/Q2YPT+io687FcQwts7aXohwQvnkmx5ss5RIn
         KSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAx9CazxVD+2EMzZ/lZkcxY69ny3xVHSpQj5D2mK4Uw=;
        b=tRKYKghth4GNbMcc1SfYgrE3lOGHbPqUSnUcXyOZNRCa4beTaZHSf+FAUNl41iT24p
         12tDoKlp8KlRNXruWpaJ//ujW78T6mHoSB8rvBPmZoUswCLeTKuyKGBuHtE3P1eKScmB
         YsrHmXH7xVbVlkKalWDBnorRr7qe78Iw1133Q3OfR5Plpkw3kzyYyW++u9qEjy+AvA97
         Gk8Ly7hG3HiKwcYVcb5wifc2b7pQGV61C4oKAEmn1GOCjcKfgdCDvAbD61lA4YqFZ+E9
         wsba6ri0pLBRcuy0yhUQAkSLNHKRCM2F3g2zfUtcHbGy5nSoi15rIFLeVpyBULkwD5cB
         C7BQ==
X-Gm-Message-State: APjAAAWu2FmGjOuLvfa55e90116EI1j3cAWAM1G5zonQqH7z4s2DvKx6
        sN6Hp4PYs5v+mYR8carsRcQ1l6yYEznufF80nq0=
X-Google-Smtp-Source: APXvYqwr95m+GptBpafCvbvDk9od9USENUa3h2bzPgCqbJySv3j0EJpADl5I4kac6CF3+FkpCUGWJYEvBoYOqrMGnsQ=
X-Received: by 2002:a2e:95cd:: with SMTP id y13mr34653420ljh.188.1568560361938;
 Sun, 15 Sep 2019 08:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tws0GHMQd0Byunw3XJXq2vqsbbkoR-rqOxfL3f+Rptscw@mail.gmail.com>
 <CAHk-=wja+f_PCuibu+NqkTD_YL1AY2x4wgX6EwQ3oxCyMTw_9w@mail.gmail.com>
In-Reply-To: <CAHk-=wja+f_PCuibu+NqkTD_YL1AY2x4wgX6EwQ3oxCyMTw_9w@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 16 Sep 2019 01:12:30 +1000
Message-ID: <CAPM=9tzo2HfwPsffe6wXGsyPhE-G+Ha7gpF=ONWUOLidxefV-Q@mail.gmail.com>
Subject: Re: drm fixes for 5.3-rc9
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2019 at 04:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Sep 12, 2019 at 8:56 AM Dave Airlie <airlied@gmail.com> wrote:
> >
> > Hey Linus,
> >
> > From the maintainer summit, just some last minute fixes for final,
> > details in the tag.
>
> So because my mailbox was more unruly than normal (because of same
> maintainer summit travel), I almost missed this email entirely.
>
> Why? Because you don't have the normal "git pull" anywhere in the
> email, so it doesn't trigger my search for important emails.
>
> There's a "git" in the email body, but there's not a "pull" anywhere.
> Could you add either a "please pull" or something to the email body -
> or to make things _really_ obvious, add the "[GIT PULL]" prefix to the
> subject line? Or anything, really, to whatever script or workflow you
> use to generate these?

I've been manually writing the subject lines, seems I need to fix my brain.

The reason I do that is I generate on one machine the body, and send
it via the gmail webui on whatever machine I'm using. This helps
avoids google tagging my emails as spam for generating them using
someone elses smtp servers. I should probably setup properly sending
gmail to avoid that.

Dave.
