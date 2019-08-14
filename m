Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A634C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9942083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBBp8OKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfHNLRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:17:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35628 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfHNLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:17:04 -0400
Received: by mail-lj1-f193.google.com with SMTP id l14so14482766lje.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpg3G9Etz4OvVx8IFQ1AOlUEfhUeo6540gz6ahfkyQc=;
        b=NBBp8OKeUdGlXRspVtZwJ2kI+diM9Z8irDSmvjLWSlMQywy/iDOLn5EcBHgEfSEWxr
         Z2gSzonKyTcHG6gUnhDnB1eFo5D5hXbbe48aL8blx8qICeJOJG8HVwjowH+quM8P/I/T
         K8l3T2I4tweMSQsWBChGVUVmZv5DTbaiwPmTLhOSryHxcpofpxwl2R3CzHblxmzkHGkq
         Q2FicIyvRL7qxuNyoHosJXKcHXfvp3GBmjbwa6oH2WhVOST71ON2vFfOSbdwvAvsGBwj
         EYi3RdP2gOM5cwR5tzZ2+qYjCX1QILUBZ1Ye9xl/cpDjh+HiMDNy7uRm/AtVZ6BmOehf
         f+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpg3G9Etz4OvVx8IFQ1AOlUEfhUeo6540gz6ahfkyQc=;
        b=L+CYj/4A5dMVZKX6S5E8nkwU8OML6mJOL0SqHbHv6oj0RAInMQqnThM+kwsE4yYrgX
         Z5PKd9wf8LMV0tLU35W8knGClbCQD5wmiDhtbz1r8i06OwGQQolMkka7+XlsqR2drGU4
         78vWVCLgxy87UnHIbQPD7jTtYJqixdBFGFCTpZv8tCkmPP8Rvh5umkCZsT/EuTZr6h6k
         7fazsXa4tdiD2JrJW/MIR1QAOw4i0EXQPGGc7NgpUjokmVQW8Q9/qwIxCbGEl3zxMzjd
         dWhx1wobwazMj3ZzdzHRrXScF0YL+AeHJcTvRvrLDw4+Qc8CUQJIkP17obxjE4M9c4gL
         82aw==
X-Gm-Message-State: APjAAAVSCTm/692ZV6zA2MZOC5oC7LcxGGLC0pxtux2dzFAVbZm8hNwg
        rz3p44WMNZ58vN+cc4zAxOgysURGYgdRvtiH9/8=
X-Google-Smtp-Source: APXvYqym+y7qghCuVZ7uMfBL4Y09yZokgyk/DRxedzjSbW1CvgLMDhOhWj6uS4zbGCv6Y9EwZB1FMZYrLmlojOLTh1s=
X-Received: by 2002:a2e:978e:: with SMTP id y14mr10027268lji.10.1565781422625;
 Wed, 14 Aug 2019 04:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-13-codekipper@gmail.com>
 <20190814072046.metavychqvhuohwy@flea>
In-Reply-To: <20190814072046.metavychqvhuohwy@flea>
From:   Code Kipper <codekipper@gmail.com>
Date:   Wed, 14 Aug 2019 13:16:51 +0200
Message-ID: <CAEKpxBk4H=N-SVzXpAGkF79xmOhczOmKpJ7rJ9Js9vquw_QE7Q@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] ASoC: sun4i-i2s: Add multi-lane functionality
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 13:08, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Aug 14, 2019 at 08:08:51AM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > The i2s block supports multi-lane i2s output however this functionality
> > is only possible in earlier SoCs where the pins are exposed and for
> > the i2s block used for HDMI audio on the later SoCs.
> >
> > To enable this functionality, an optional property has been added to
> > the bindings.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>
> Wasn't the plan to support only stereo for now?
Stereo HDMI can be introduced on the H3 and later if we get the first
three patches
merged. Post those patches is the work to get multi-channel working.
>
> Either way, that property should be documented.
I can do this...but I'm thinking we should bang our heads together to
find a solution
that we all agree on...especially if we're considering multi-channel
tdm support.
Thanks,
CK
>
> Maxime
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
