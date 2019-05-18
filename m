Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4605C46470
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B34B216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 07:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="vIa7qd4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfERHgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 03:36:25 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40951 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfERHgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 03:36:25 -0400
Received: by mail-ua1-f68.google.com with SMTP id d4so3591856uaj.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A5RwhDAP7/J1pDvTAiUDBR+MHgpw4LlKX0b6CEjmItY=;
        b=vIa7qd4so/Vd21TmmtOdwuMHc3kXNhGCSCPFnGLt8oHHd6zkIXgQGmuQRaLELWbU3q
         Wg702o/CWej3i12w0EGiMyO6YyJEt2qbM4pyTV0Q5FOG5WlKLlbybEd0DMnrOVcWS8fp
         DuzJECGhlpP5RykRyvIx/LwIPn3buQd8dt1QTeUIZQ9KRHdMrztYgAePkFE1bhKTieCw
         wUgeCC/BOoSImurLRiQ8ST0/pmSL8zlgoZ+q9LqqPH0Cj7/KIXixUrLtz9XRl4e+69xr
         9OdRSxVxrJBxaW5PMZ0appMng0Hkv5m4evgETN+YLvibsg0mcQRAFmHhSH5zrK3Al1N2
         dmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A5RwhDAP7/J1pDvTAiUDBR+MHgpw4LlKX0b6CEjmItY=;
        b=ODEBPCcuBQ2ox0LmdX9t2J/FsY32aD0QwPRx1/cr+PWqcGQByg63oJmcReljxVGbaZ
         K9F7EHoIUr9t2u0dtdaBB/tyQ7Hi/e+zefzQoURa1YfHjPqo1j9+nV6d1svO5XXjtBaG
         NLxFPCN4BHgBWYXJMixpJOrYb65iv2ihlvyVKoD67A1cdnX6bOtRzWo5h9xhuTpV73w2
         7G0qvqDR6522xkpWL79XQaoBbF3mnqIKAuyenkDFCVZGyOWkNBuwFpnoBKWLq7NLwUhK
         Vu0L8yajLx9G1fpfkRm9GDOmPXEZf5Bt3v3aDWNIi55dXGMdcHiVJpM4h/tcslw0HJlE
         fIIw==
X-Gm-Message-State: APjAAAV94RyZoKPuqyd2WDmdHZo7ZcJvkvnUmM0YHXKQ5Nr3kSOytNVF
        T48njeHebF0Z6eNDUmZV9Ceu60oqa97wQNR6Rtx+BA==
X-Google-Smtp-Source: APXvYqyQ3Z9FjlYf6e3EPpIIi/tS6QFWFUTVOX/BEDU6KhGJZajaaWWHlUvyLoVOQlW3V24I5M8CcgwGTrjbgRPwPfg=
X-Received: by 2002:ab0:5930:: with SMTP id n45mr17287080uad.87.1558164983986;
 Sat, 18 May 2019 00:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190418133913.9122-1-gilad@benyossef.com> <CAOtvUMd9WUZAFgTqVH0U2ZZp8bbHXNg9Ae_ZFvGKJTSKNct8JA@mail.gmail.com>
 <20190517145235.GB10613@kroah.com>
In-Reply-To: <20190517145235.GB10613@kroah.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sat, 18 May 2019 10:36:11 +0300
Message-ID: <CAOtvUMc++UtTP3fvXofuJA4JpdT86s5gbSx6WRtDK=sWnuUZrg@mail.gmail.com>
Subject: Re: [PATCH 00/35] crypto: ccree: features and bug fixes for 5.2
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, May 17, 2019 at 5:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Apr 21, 2019 at 11:52:55AM +0300, Gilad Ben-Yossef wrote:
> > On Thu, Apr 18, 2019 at 4:39 PM Gilad Ben-Yossef <gilad@benyossef.com> =
wrote:
> > >
> > > A set of new features, mostly support for CryptoCell 713
> > > features including protected keys, security disable mode and
> > > new HW revision indetification interface alongside many bug fixes.
> >
> > FYI,
> >
> > A port of those patches from this patch series which have been marked
> > for stable is available at
> > https://github.com/gby/linux/tree/4.19-ccree
>
> Hm, all I seem to need are 2 patches that failed to apply.  Can you just
> provide backports for them?

Sure, I'll send them early next week.

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
