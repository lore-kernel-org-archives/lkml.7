Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC280C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CF820449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OutQNHoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfC0M6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:58:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42785 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfC0M6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:58:24 -0400
Received: by mail-io1-f65.google.com with SMTP id c4so13928911ioh.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xh2orCj5BZSvNdKGHYK4ruXtT1eX2tXY1HuSqNPSZCs=;
        b=OutQNHoDQX6sN9m5I+0k3Aw647qq2yAa8RYa1jVtiGv0r4g4iZQOhEQ7rpQphvWBcv
         RnSj23iqzerHdelS9i99IwMMk+ioSaa6EvY5Z0g/1YFWQDrz/MeONVJpbRWkM0a5GCBO
         mM/BXxcdJQuuYoEJ7UuoELFvAc30/41s8+hfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xh2orCj5BZSvNdKGHYK4ruXtT1eX2tXY1HuSqNPSZCs=;
        b=uf124kq/b+UH5WSpRxp6nYciVuIvwtB3mnZx0/aBCK9+EsR01CTMt7vpBYb/2IoIL5
         tWOPYwUJ28SIY01sZiH3JeAyAV8we7fvHZVu4lPy1j/B4VMEcvSJ7wuLcBL4PWXEpt8Z
         2g5WMvuMOD4DSsH3+by9z2XEQP56D8lr59uv9jqNBNEzQG0qvggJ1LYDFFuKKBAe1rwx
         Hc9kriJYbjI21vgEe1G3B2TLfipft7ZZNC+47yss9vRvJ0797xKfG/UUCcTudFuj9Fpn
         hh9bxbzRQUVMdrvoP8o+rVX+K3QLXBNIAL4O4yuMcmvyzDnCimU8fyM+ztsGPxzIf1N0
         bu9A==
X-Gm-Message-State: APjAAAVOdym/YqxLOjkvLP608/GGjSBpcRIBge3s6fQJDEwVv0uBHMhj
        V8pF8EG6ZGnqsRPpwjzu/wMB61BeY7nMYv8rBpymog==
X-Google-Smtp-Source: APXvYqxkj680fw14RlsvRc7+2HNIL0m/cjFSKhQapznDR4Skb5r4UIpcI6PCMxPjerXrrUkpwe8kZ57dc4BTGZQ9FBg=
X-Received: by 2002:a6b:d80a:: with SMTP id y10mr23916022iob.114.1553691503732;
 Wed, 27 Mar 2019 05:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190212204109.3528-1-jagan@amarulasolutions.com>
 <20190212204109.3528-2-jagan@amarulasolutions.com> <CAMty3ZA401nRh+nqFUcVMOv+or8NWoYU+y72gUPONy7ovyqgSw@mail.gmail.com>
 <20190218202705.GA19088@ravnborg.org> <CAMty3ZCQY+BSAFe=8Z0X29nK9tRz+7s3BFTiAmQ7CD_eNTL-LQ@mail.gmail.com>
 <CAMty3ZCo7ZEaPqUc=O=4N6XDBe+6tAE7AzH258U=hw8uvj-F_g@mail.gmail.com>
In-Reply-To: <CAMty3ZCo7ZEaPqUc=O=4N6XDBe+6tAE7AzH258U=hw8uvj-F_g@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 27 Mar 2019 18:28:12 +0530
Message-ID: <CAMty3ZCxOWBvdZVyKCLYnWp4KSjeOMQ-SRndyH=g3fLYTfPGsA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI
 LCD panel
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David or Daniel or Thierry,

On Sat, Mar 9, 2019 at 1:48 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Hi,
>
> On Thu, Feb 28, 2019 at 11:02 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Hi Thierry,
> >
> > On Tue, Feb 19, 2019 at 1:57 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Hi Thierry
> > >
> > > > Pleas let me know if you any further comments on this?
> > > No further comments from my side, and I consider it
> > > ready to apply.
> >
> > Would you please pick this?
>
> Gentle ping.

Would any one pick or comment about this? It has been in ML for weeks
with couple of gentle pings and irc queries.

Jagan.
