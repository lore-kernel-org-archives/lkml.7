Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D9FC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF00720882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="PoEHNFkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438003AbfITKOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:14:44 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:46625 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393353AbfITKOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:14:43 -0400
Received: by mail-ed1-f54.google.com with SMTP id t3so5820384edw.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hjasgk/DjD1JUROz7kXE34h90cVJHQtVcYSmt8ORqnM=;
        b=PoEHNFkOqWu3Zc1DzPXNcCsr139HVIhuZoyA79RX13aymTCwtfWmzKjvn4+iqJpMMo
         ksODwrQNiOmh/ZFF1ueDRyEqnURsCJwzKTHjQaJyvdbhMgYXilesgm1EoF/I3iYI0B7n
         2kvU2/LJXzewYw5ZCgll8CFa1R7UEkyZhqu0CCeoYypP7F9pUu+UcRlharVmLm2OWxgo
         /2s4znvzJsqHW+tT9cs8iUQfpFnWfm47gLPC0vcV2Yc8sdoUbaZJRt0rkbTvx+9cD4Ds
         3hBFbIXYlv/Cf2OMjDtRrFyCGRCxrXTgTWl7fZ8VzE4saleFN9f4xjW9hRfRdoOY0h7w
         raTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hjasgk/DjD1JUROz7kXE34h90cVJHQtVcYSmt8ORqnM=;
        b=RSeZDw/y6CyA/IWWTVF3r3M0H3dq/go6Kv1IZ38UtB5HOKVStRnhgYXlQN2sfY/pK7
         2uFTylqMEbBI5KTygQUcLywBFWIIumR2MaemLta/b/Cp08qNAe4rdO7bGIw0Urijznpu
         psh0A7OwTmy/99Sz/RyKrl5R2XzbYSSHe1OS8CVBq+kvqkBuuqv8xw+Wg6sTL7DBR7uE
         i3xyV6rjs5eTR736HrOWliyvA3yAlJIPy43XHAdQig+mgovB5D2+Y1VRAbJRaphW7sNI
         a+BxmE83XCGGdmZNFf/iLTqqHxTnBzihX22/hmPDgon7tkpEt1neB3WwE+bsSOuW2Wq9
         Hbjw==
X-Gm-Message-State: APjAAAW0k6Jd2Sg9YGbkowJiOLDF2wqQgDMbKHkhFwkdaa9/82EYdgi8
        fgrZ9oONHN8lwnyYKGxT+ik9eEywGHiBCoao6otV1w==
X-Google-Smtp-Source: APXvYqx8/++XVqD15cX3Ink+XcYzh//k998D/dsHETYlNmGKbJTJGg9//ytq/CjW59OyR93N3bNTu/MA1/bWhfBmyZs=
X-Received: by 2002:a17:906:4c4c:: with SMTP id d12mr18325248ejw.174.1568974482036;
 Fri, 20 Sep 2019 03:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190918110541.38124-1-roman.stratiienko@globallogic.com>
 <9229663.7SG9YZCNdo@jernej-laptop> <20190920062020.zyt5ng6cxtu6muye@gilmour>
In-Reply-To: <20190920062020.zyt5ng6cxtu6muye@gilmour>
From:   Roman Stratiienko <roman.stratiienko@globallogic.com>
Date:   Fri, 20 Sep 2019 13:14:30 +0300
Message-ID: <CAODwZ7sJ9g4fycde5Yk1sRYW6WuNtsgXOf34GJMma0rKMyc0QQ@mail.gmail.com>
Subject: Re: drm/sun4i: Add missing pixel formats to the vi layer
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 9:20 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, Sep 19, 2019 at 08:53:10PM +0200, Jernej =C5=A0krabec wrote:
> > Dne sreda, 18. september 2019 ob 13:05:41 CEST je
> > roman.stratiienko@globallogic.com napisal(a):
> > > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > >
> > > According to Allwinner DE2.0 Specification REV 1.0, vi layer supports=
 the
> > > following pixel formats:  ABGR_8888, ARGB_8888, BGRA_8888, RGBA_8888
> >
> > It's true that DE2 VI layers support those formats, but it wouldn't cha=
nge
> > anything because alpha blending is not supported by those planes. These
> > formats were deliberately left out because their counterparts without a=
lpha
> > exist, for example ABGR8888 <-> XBGR8888. It would also confuse user, w=
hich
> > would expect that alpha blending works if format with alpha channel is
> > selected.
>
> I'm not too familiar with the DE2 code, but why is alpha not working
> if the VI planes support formats with alpha?

Good question. It mentioned in the datasheet
https://linux-sunxi.org/images/7/7b/Allwinner_DE2.0_Spec_V1.0.pdf
on page 95: "All ui layers' alpha is useless"
And my experiments proves it.

My assumption that vi uses post-processing that cuts out alpha values.

>
> Thanks!
> Maxime



--=20
Best regards,
Roman Stratiienko
Global Logic Inc.
