Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD0C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0D0218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nncV+N97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfGCJEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:04:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45754 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGCJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:04:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so1281199edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q/EYz2rSpQqq5aTgZ1tZo0aZ4bOY/6+aI3OLsg1wExc=;
        b=nncV+N97AgUiMkEcr3PyqwUVCi/flMy0shrmwVJcLqyjTsaytge8nr7U2CuCK2JDKG
         dFZoJZ/ShU43HlX6Af1U/VfEr6YA0ExzbHURymZaLEVNkQ/1bpgsJirnRaFGE6M+eaSb
         dmuxzpxzeN0PyN2G/AQG0qWQUYmTJ0Ormdd88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q/EYz2rSpQqq5aTgZ1tZo0aZ4bOY/6+aI3OLsg1wExc=;
        b=IYYik4878QuH56v3mLa2r0b1//44xtQOm0IEUnhSkmEzHnZrsQ0+IkTY7W6eLA8cUt
         lFAkfgLM2iVilnU1/VWmvXCmDCdUdQGjHaJNbKIdu2sEzbQHvWaJeMsDWY5IZ7GfZcTy
         B4I1mUdpdstY6NcxdSfNrFZNg2j8LRbOz3CQgvdzVKst12BY1EcffgXW1QnnX7tZC/K7
         yB7HNMkxs4OQOgv1vgthhiSu8Lfx1RD9/eUN/SDViOHJOVE/5rg12Gz6ehh59PbnK8KF
         zITYScjfRu2gewXs7gh6HDN3E1krAOctM4/loLfJ3qyjvOcbmrt7/bVl+D0pWhYLkRdy
         HcnQ==
X-Gm-Message-State: APjAAAW2LBuhhBrlHXVu6ZX40TZ5OeH3pN6NyGsXfi+9pzQp0Pu8vuyL
        9Jv76rxgdV2FPU4nf0uqMCBIgsIPK1cKFg==
X-Google-Smtp-Source: APXvYqzZL65sBn1hdWR3qWu/t3Sq3CCKNKgC3JPGJFUMbHV/AzqJitSJm3JrZzYvaUOhZZUoM8l77Q==
X-Received: by 2002:a17:906:2510:: with SMTP id i16mr33018569ejb.130.1562144676294;
        Wed, 03 Jul 2019 02:04:36 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id f36sm496892ede.47.2019.07.03.02.04.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 02:04:35 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id b2so608114wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 02:04:34 -0700 (PDT)
X-Received: by 2002:adf:f246:: with SMTP id b6mr29292267wrp.92.1562144674125;
 Wed, 03 Jul 2019 02:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190603112835.19661-1-hverkuil-cisco@xs4all.nl> <1cb8cc0c89f0017962226fdb84ae11e763fdd233.camel@ndufresne.ca>
In-Reply-To: <1cb8cc0c89f0017962226fdb84ae11e763fdd233.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 3 Jul 2019 18:04:21 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A0gg4RCKkPd-m2_5=ZyDzZ7hnH9AnTrt7ciXQPPHZU2Q@mail.gmail.com>
Message-ID: <CAAFQd5A0gg4RCKkPd-m2_5=ZyDzZ7hnH9AnTrt7ciXQPPHZU2Q@mail.gmail.com>
Subject: Re: [PATCHv4 0/2] Document memory-to-memory video codec interfaces
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Pawel Osciak <posciak@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 12:19 AM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le lundi 03 juin 2019 =C3=A0 13:28 +0200, Hans Verkuil a =C3=A9crit :
> > Since Thomasz was very busy with other things, I've taken over this
> > patch series. This v4 includes his draft changes and additional changes
> > from me.
> >
> > This series attempts to add the documentation of what was discussed
> > during Media Workshops at LinuxCon Europe 2012 in Barcelona and then
> > later Embedded Linux Conference Europe 2014 in D=C3=BCsseldorf and then
> > eventually written down by Pawel Osciak and tweaked a bit by Chrome OS
> > video team (but mostly in a cosmetic way or making the document more
> > precise), during the several years of Chrome OS using the APIs in
> > production.
> >
> > Note that most, if not all, of the API is already implemented in
> > existing mainline drivers, such as s5p-mfc or mtk-vcodec. Intention of
> > this series is just to formalize what we already have.
> >
> > Thanks everyone for the huge amount of useful comments to previous
> > versions of this series. Much of the credits should go to Pawel Osciak
> > too, for writing most of the original text of the initial RFC.
> >
> > This v4 incorporates all known comments (let me know if I missed
> > something!) and should be complete for the decoder.
> >
> > For the encoder there are two remaining TODOs for the API:
> >
> > 1) Setting the frame rate so bitrate control can make sense, since
> >    they need to know this information.
> >
> >    Suggested solution: require support for ENUM_FRAMEINTERVALS for the
> >    coded pixelformats and S_PARM(OUTPUT). Open question: some drivers
> >    (mediatek, hva, coda) require S_PARM(OUTPUT), some (venus) allow bot=
h
> >    S_PARM(CAPTURE) and S_PARM(OUTPUT). I am inclined to allow both sinc=
e
> >    this is not a CAPTURE vs OUTPUT thing, it is global to both queues.
>
> I agree, as long as it's documented. I can imagine how this could be
> confusing for new users.
>
> >
> > 2) Interactions between OUTPUT and CAPTURE formats.
> >
> >    The main problem is what to do if the capture sizeimage is too small
> >    for the OUTPUT resolution when streaming starts.
> >
> >    Proposal: width and height of S_FMT(OUTPUT) are used to
> >    calculate a minimum sizeimage (app may request more). This is
> >    driver-specific.
> >
> >    V4L2_FMT_FLAG_FIXED_RESOLUTION is always set for codec formats
> >    for the encoder (i.e. we don't support mid-stream resolution
> >    changes for now) and V4L2_EVENT_SOURCE_CHANGE is not
> >    supported. See https://patchwork.linuxtv.org/patch/56478/ for
> >    the patch adding this flag.
> >
> >    Of course, if we start to support mid-stream resolution
> >    changes (or other changes that require a source change event),
> >    then this flag should be dropped by the encoder driver and
> >    documentation on how to handle the source change event should
> >    be documented in the encoder spec. I prefer to postpone this
> >    until we have an encoder than can actually do mid-stream
> >    resolution changes.
> >
> >    If sizeimage of the OUTPUT is too small for the CAPTURE
> >    resolution and V4L2_EVENT_SOURCE_CHANGE is not supported,
> >    then the second STREAMON (either CAPTURE or OUTPUT) will
> >    return -ENOMEM since there is not enough memory to do the
> >    encode.
>
> You seem confident that we will know immediately if it's too small. But
> what I remember is that HW has an interrupt for this, allowing
> userspace to allocate a larger buffer and resume.
>
> Should we make the capture queue independent of the streaming state, so
> that we can streamoff/reqbufs/.../streamon to resume from an ENOMEM
> error ? And shouldn't ENOMEM be returned by the following capture DQBUF
> when such an interrupt is raised ?
>

The idea was that stopping the CAPTURE queue would reset the encoder,
i.e. start encoding a new, independent stream after the streaming
starts again. Still, given that one would normally need to reallocate
the buffers on some significant stream parameter change, that would
normally require emitting all the relevant headers anyway, so it
probably doesn't break anything?

Best regards,
Tomasz
