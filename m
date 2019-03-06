Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A731C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F6A20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DIBg7Mfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfCFRBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:01:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfCFRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:01:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id e74so6627796wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m4qqq+h3urdW5I3z39Vx8K2gd5APyGw16EX5wb5NSvw=;
        b=DIBg7MfjFQKEHIuDOXubaZ7jDtx48RQRdlc+ZUFlW6UfvRHl2ia1urOtRdmymadvgM
         WE5THFba5CTtX0xcf9GqsyBM6+7Arar+BPjAv+Xl4IJSF+IY7B80E6uoYeyzgm7HjDFx
         f/axutjP1FCt1nmMkmPGLa0PL4QdIJNlIoH7xIwspNo0IBf7eE2wzraiRDcsDIWE3r0b
         q/btLYzbVSVO8AiJH7z1PgGYAcPBxClQB7zFDrAEWDpwKrtCDOgqaufhzz2I1vBSdwLI
         Xkug4Lz+Ujz1wX7BSRHqlkpMcsX7az5aYM/hq3vnBmRjy1g0EctBikR0qkUOeqQw9Uwl
         H2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m4qqq+h3urdW5I3z39Vx8K2gd5APyGw16EX5wb5NSvw=;
        b=NlydwIbqCqRgxNv6tIG+KEfgUOtieXXyluEcEwhW2ll56stidXkER/IKTsyahMoznu
         rwb2R7CNq97gaj4k5jxpbYZATdY6yxsEyWViQT4ijAwbgen9NXC1r/8/+xNEGUrQZXTn
         ibQ0fvXfRLBM9dTYl/GTJ0SRbsDZS8waEIloTZK9ZodQo68KgKI/nruPl85yaz5UQIbF
         O1cDUR7gsADPZg9GO5Rqti/ahFjGcvCcCDxCjg5N6tUaeuF8HQgN7ZQSze9LuOxaLXuf
         MyjnfKre7RTBmohauZhp4Qp2SKcEAnq+PCeg2cxz4ZoNG+F3sla0Ytaj2lThYKkyEawh
         DVbA==
X-Gm-Message-State: APjAAAVGM6kkUty3c3eJhL830Zuad9D8fz50WAept//ealZkw5zT9uY3
        CM51dIvjkzTJphTNeoKFp7NDhL9CuOUURveaFKB+Fg==
X-Google-Smtp-Source: APXvYqwwMtPbMoZ95mw3y9qRXUH32Vhj8SvEmijcwaoPr14AdXG8oFjkYLdIFlYG7uv5zmp6oEpgAgA4CGjv99IlX9Y=
X-Received: by 2002:a1c:3b06:: with SMTP id i6mr2985833wma.55.1551891679224;
 Wed, 06 Mar 2019 09:01:19 -0800 (PST)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-6-git-send-email-john.stultz@linaro.org> <CA+M3ks6AUmmYbXscjTRo+Vr-6cV8okafsDn2Tg3tskvzrV_dbA@mail.gmail.com>
In-Reply-To: <CA+M3ks6AUmmYbXscjTRo+Vr-6cV8okafsDn2Tg3tskvzrV_dbA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 6 Mar 2019 09:01:07 -0800
Message-ID: <CALAqxLWxpExDpiKbNGQ6Oz5h=FUPNLvehm34JdrntLQjFed41w@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/5 v2] kselftests: Add dma-heap test
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 8:14 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> Le mar. 5 mars 2019 =C3=A0 21:54, John Stultz <john.stultz@linaro.org> a =
=C3=A9crit :
> > +
> > +       printf("Allocating 1 MEG\n");
> > +       ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> > +       if (ret)
> > +               goto out;
> > +
> > +       /* DO SOMETHING WITH THE DMABUF HERE? */
>
> You can do a call to mmap and write a pattern in the buffer.

Yea. I can also do some invalid allocations to make sure things fail proper=
ly.

But I was talking a bit w/ Sumit about the lack of any general dmabuf
tests, and am curious if we need to have a importer device driver that
can validate its a real dmabuf and exercise more of the dmabuf ops.

thanks
-john
