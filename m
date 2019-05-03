Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400F3C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068432075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgRJrvBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfECHxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:53:53 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43883 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfECHxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:53:53 -0400
Received: by mail-vs1-f67.google.com with SMTP id y196so3025886vsc.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMWUAnDnMENxsx3gkXYG0QVHOF2jolpUUYMA2aKF3DY=;
        b=tgRJrvBIcCBM848M4tf26Grza5PkK+KUyoofRPrKoiF24dE9BG8znZQ4f8htsKCDaA
         2bhmbeIfrhXxDo7cGUKZ4w9A4ymnrY4xnEcKjaDe9JNkKCoXIRxstOnhm0bjS2Ux5a8w
         vSUZk6q1b+h0jp/J9cgYA6uqe/jswUjzULn3AdoAzJzm5a1k8GATJVN+TIehps6hX+Cu
         NpnAQYiYvA5bincxglyzx2I/1dSGYyQqJQcV3/BprVKqIt2MXXM6kZmIDzPffW9NXKVc
         UU1jaXbn5N9dEN53txM0DEHO/BGSkC388PDYMkvJT3zhQ4DuJ+XXYT0LQm8eJI+KCf1U
         s3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMWUAnDnMENxsx3gkXYG0QVHOF2jolpUUYMA2aKF3DY=;
        b=Ya6mh99gk0bCL+nJTtXf2Nw+dX0IZ9Oynxkmilp8b1bPqnNdXPs9viC43iz5rH0B/b
         8zXPkfjO/d7FaTqy9Qp/W+siayibZI1WkpdIbNPxOPCMxGzLCrk2gnbgVTuo6hdHkE0k
         5B4XwxG4FbbDBntp+pJ+bsgWMjeIh0EsBaUzY4ipK/aLslUaZM330QG7kjB/PDgnflWz
         p3gYPSNvbTw1UD42YNEZ37QDI+iWeD89n1efF7LkQWvwFcORFSnrYBLiPZ1kz/khoWJE
         NCFtcsJOocz7rCSXPC531kwBrgRG5nK33Lci4JVBuesBHhb1ZjofhQhP3/TajlBwaL+I
         iEPw==
X-Gm-Message-State: APjAAAXp1QW5xlW6RwWZ57iLJx5YSbxuDJizar9kQs8O7K5rCqecIeVE
        EosiMCV+UbxkoePB1dWKkHFTmgE5qqAcEwiGTlJs//nV
X-Google-Smtp-Source: APXvYqyGpSCJKDzombzhVFE/FHSSj7O7C565rxaZTc/oGaNFNATCUmhcpMaHHi1q1LyViI2TpLsk8/wkO46VSoGct5M=
X-Received: by 2002:a67:de83:: with SMTP id r3mr4427838vsk.236.1556870032231;
 Fri, 03 May 2019 00:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190503073621.GA6992@ogabbay-VM> <20190503075131.GA9785@kroah.com>
In-Reply-To: <20190503075131.GA9785@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 3 May 2019 10:53:27 +0300
Message-ID: <CAFCwf11=Xaehej8TM_5BNetNn58Cfeb9Tr-ktt_EKAmwHaQx7w@mail.gmail.com>
Subject: Re: [git pull] habanalabs next second pull for 5.2
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 10:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 03, 2019 at 10:36:21AM +0300, Oded Gabbay wrote:
> > Hi Greg,
> >
> > This is the second pull request of habanalabs driver for kernel 5.2.
> >
> > As the tag describes, all of the changes are either bug fixes or simple
> > re-factoring of existing code, so they should all be relatively low-risk.
> >
> > Thanks,
> > Oded
> >
> > The following changes since commit 78e6427b4e7b017951785982f7f97cf64e2d624b:
> >
> >   coresight: funnel: Support static funnel (2019-05-02 19:12:21 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-05-03
>
> Pulled and pushed out, thanks.  My tree is now closed for 5.2-rc1 stuff,
> but feel free to queue up bugfixes for me if you want.
>
> thanks,
>
> greg k-h
Sure, np.
Thanks for the fast handling.

Oded
