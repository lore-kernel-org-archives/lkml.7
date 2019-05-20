Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47505C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F40020863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHD4K5/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfETT7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:59:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:53661 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfETT7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:59:45 -0400
Received: by mail-it1-f194.google.com with SMTP id m141so1078544ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 12:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VVW9wD/qxMbb1dV3/1vl/BKh7b6QCqLkCa88/L/fMdE=;
        b=XHD4K5/qHii8YIULZlh3fl3uulbU8JGAJR1V8KgW858HapYARaDH8bLwjPqyccwr87
         qSxee6YFzJ/AscPA0JEIfmxlA1FHjXCR195sPKocydebYX7aE+ed2uqAJCf4vTWa6pdT
         P92YkSfgUChnukOk9283EjvJv/cChX488FOTIBVy87wx8/qj2XY+OHCiYVQ08RFlRT4/
         pNTvkKbHcxu4Hc+9NbASZhL6NX5jdY+cRlgFVzAnnEmbQvtD4/u1S9d//W4hsaPcw0jx
         8VnwmymQ85Ubrg21gK04PtucAwN4RNk26K+uUaTaK3dhXUB/0n+xOZVBZBovuE+eOtLj
         xE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VVW9wD/qxMbb1dV3/1vl/BKh7b6QCqLkCa88/L/fMdE=;
        b=Xm8AfRJ/X2zLhqzyK+CpmL0L584LUXdIX+UPzOhaGleoGzxFVIeZwV0PsOIpNl3U4A
         c9vi17ftL32ka8xcVaNir0jPquZB0lgLXeJzhOnrflM27MzFQt+vJrePQCdHrB5uE5TU
         WNqRQT3jHwqUmYmbHmGFhoNnyab1d8034lCXzqBDbloOFtSzLPBdXufd9uqUYXrh2kDo
         n3Z22KkQQDX8iEcFLoP0V6vv/v7Iv5ppbsmCuVKQD0+k4uFPY6geHD48ny8Vd27Ws9sy
         6s+CEAfH3cjA8SOxiDmKPCmiHYxSn1Sll3rUWh1imMUGU0J0HA7iIu4pqN5sSdjvgRAe
         NrAw==
X-Gm-Message-State: APjAAAWo0fhPaX7qJifBaTE7ADI+UaoYz5udJHZjPNlfym7Q97jwk4+H
        a1tHkNU4KgwfIdCKvza03nVZw1YfVnXhQmKs244=
X-Google-Smtp-Source: APXvYqw+JTSio1QmKKLc3SXdlT+4eq6mkw0FklRjcsewxKjdEsoC4iDutSx4sLkL0+2iud+NEj7/Q/BMG1iKqMaUNGg=
X-Received: by 2002:a02:9381:: with SMTP id z1mr11574837jah.130.1558382384204;
 Mon, 20 May 2019 12:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <1558115396-3244-1-git-send-email-oscargomezf@gmail.com>
 <CAGngYiUZmfnuj5WUnwk18szijmsQjF27j=OxQfJtp5bNORppRQ@mail.gmail.com> <CAGngYiUCedv6oqTPOS+eFwnQJajor3hwKjxeNRcKq031giZeXg@mail.gmail.com>
In-Reply-To: <CAGngYiUCedv6oqTPOS+eFwnQJajor3hwKjxeNRcKq031giZeXg@mail.gmail.com>
From:   Oscar Gomez Fuente <oscargomezf@gmail.com>
Date:   Mon, 20 May 2019 21:59:08 +0200
Message-ID: <CALtfCQbccsEioqWRZn_cnQZmykXYce6Xc8qAdxYubN9CuJMW9A@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: solve warning incorrect type dev_core.c
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

Yes.

Oscar Gomez Fuente


=C3=93scar G=C3=B3mez Fuente
Electronic Engineer & Degree in Physical Sciences
Mobile: 659.28.97.90
Email: oscargomezf@gmail.com
Website: www.oscargomezf.com



On Mon, 20 May 2019 at 21:39, Sven Van Asbroeck <thesven73@gmail.com> wrote=
:
>
> On Mon, May 20, 2019 at 2:35 PM Sven Van Asbroeck <thesven73@gmail.com> w=
rote:
> >
> > Hi Oscar, thank you for your contribution! I have a question, see inlin=
e.
> >
> > On Fri, May 17, 2019 at 1:50 PM Oscar Gomez Fuente
> > <oscargomezf@gmail.com> wrote:
> > >
> > > These changes solve a warning realated to an incorrect type inilizer =
in the function
> > > fieldbus_poll.
> > >
>
> This warning was generated by sparse, right?
>
> $ make C=3D2 drivers/staging/fieldbus/
> <snip>
>   CHECK   drivers/staging/fieldbus/dev_core.c
> drivers/staging/fieldbus/dev_core.c:232:27: warning: incorrect type in
> initializer (different base types)
> drivers/staging/fieldbus/dev_core.c:232:27:    expected restricted
> __poll_t ( *poll )( ... )
> drivers/staging/fieldbus/dev_core.c:232:27:    got unsigned int (
> *<noident> )( ... )
> <snip>
>
> I will test your patch on actual h/w, probably tomorrow.
> I don't expect to see any problems.
>
> Sven
