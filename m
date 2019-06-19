Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13283C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F012084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfFSGHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:07:13 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33853 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730756AbfFSGHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:07:13 -0400
Received: by mail-ua1-f65.google.com with SMTP id c4so8623226uad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 23:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7O7qmxDa1+JZ1Dry7qEOvSBzhak1PoCcmHKeNT1e3A=;
        b=QXX1rqEauMzaFl9ODWKKdQhrNUxifyagXrlzNU01YgHH368TaxvQT1+TWuTH/zp+i4
         dXRviN3aI6EHzoXxq2bQ4+RAeNNRvRVgvQh631Z2j40zHwgAvPAmdRgTjMJm5fD4OTIN
         EJPsWsQjCupepcDUc6r8BsHpMX04KGar7CtKLM5GGcx88mLVjW7K4G6pBOPZh0TEXmT4
         lwSazCJldaLXsJXC4Lf+X3Q1Gr2E0mMlGMnjeqoV7kYXR7P4iKlqrX8bVd3oRYLjlFHE
         PqWJIbg/OVxE1TEP4HMAqXMsjh/oQIePq2U4QdQMLOMLnjhzGbMexfDyUhYA/mPzrexC
         lLzw==
X-Gm-Message-State: APjAAAX96DUC0lmPeho+yE0eIVffKExX7/zkk9mTAEsPB87Nuji0RygL
        dT4LT9jkFW13CrMRb/U1HzhZc13B8KxrXuIgJ0U=
X-Google-Smtp-Source: APXvYqznQPXDIKRXoJvK3+CwHCpZWFSP/RAkMIJMI+24ug7p/kTDAhLtwibkBeVBbwT5pg09jFCvdFfX5IqIFV81Gsw=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr13162830uad.15.1560924431935;
 Tue, 18 Jun 2019 23:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190614024957.GA9645@jagdpanzerIV> <20190619050811.GA15221@jagdpanzerIV>
 <CAKb7UvhdN=RUdfrnWswT4ANK5UwPcM-upDP85=84zsCF+a5-bg@mail.gmail.com> <20190619054826.GA2059@jagdpanzerIV>
In-Reply-To: <20190619054826.GA2059@jagdpanzerIV>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Wed, 19 Jun 2019 02:07:00 -0400
Message-ID: <CAKb7UvgkEXtmJV67EXeBctgaOxM1D91fBbKw9oFMUaB1ZViZQg@mail.gmail.com>
Subject: Re: nouveau: DRM: GPU lockup - switching to software fbcon
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 1:48 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> On (06/19/19 01:20), Ilia Mirkin wrote:
> > On Wed, Jun 19, 2019 at 1:08 AM Sergey Senozhatsky
> > <sergey.senozhatsky.work@gmail.com> wrote:
> > >
> > > On (06/14/19 11:50), Sergey Senozhatsky wrote:
> > > > dmesg
> > > >
> > > >  nouveau 0000:01:00.0: DRM: GPU lockup - switching to software fbcon
> > > >  nouveau 0000:01:00.0: fifo: SCHED_ERROR 0a [CTXSW_TIMEOUT]
> > > >  nouveau 0000:01:00.0: fifo: runlist 0: scheduled for recovery
> > > >  nouveau 0000:01:00.0: fifo: channel 5: killed
> > > >  nouveau 0000:01:00.0: fifo: engine 6: scheduled for recovery
> > > >  nouveau 0000:01:00.0: fifo: engine 0: scheduled for recovery
> > > >  nouveau 0000:01:00.0: firefox[476]: channel 5 killed!
> > > >  nouveau 0000:01:00.0: firefox[476]: failed to idle channel 5 [firefox[476]]
> > > >
> > > > It lockups several times a day. Twice in just one hour today.
> > > > Can we fix this?
> > >
> > > Unusable
> >
> > Are you using a GTX 660 by any chance? You've provided rather minimal
> > system info.
>
> 01:00.0 VGA compatible controller: NVIDIA Corporation GK208B [GeForce GT 730] (rev a1)

Quite literally the same GPU I have plugged in...

02:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK208B
[GeForce GT 730] [10de:1287] (rev a1)

Works great here! Only other thing I can think of is that I avoid
applications with the letters "G" and "K" in their names, and I'm
using xf86-video-nouveau ddx, whereas you might be using the "modeset"
ddx with glamor.

If all else fails, just remove nouveau_dri.so and/or boot with
nouveau.noaccel=1 -- should be perfect.

Cheers,

  -ilia
