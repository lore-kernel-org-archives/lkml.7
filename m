Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0828BC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD0920879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YVQ1DWmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfCYQtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:49:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46661 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:49:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id z26so8407379lja.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TSu+7eh+WHhiOyxrpR+jDb94Ny4QcqZ5nwvvFOPIHqU=;
        b=YVQ1DWmzTarF0YxkIoB5HN6U0KEZAZhpaKOJi33kikE3jIrftdvz8+63Di7bit4iJV
         i1oTmOdMkytpfjOqVQOMZuyzK/Pxy/QiOTEelu0rPywW6l/LS6H2BVhbCCDGAUAv9h3h
         QWh1XbHxueiuwPW8L9p6X8i6f1ez/It9YSlK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TSu+7eh+WHhiOyxrpR+jDb94Ny4QcqZ5nwvvFOPIHqU=;
        b=FsX9i+BYTsCiY+kOtpLpOIN6IwR5PYYZJO1nnVrg7iX2LbtebBvEGE9hN5C+jSfPoj
         XYBaCHYaRAGzXDjk1Mr40vpGMvgOrqqG/hU5NJWsBTV4LSnCy9oO3pWmh8sC4bQDxuk3
         +pJcTKnNV48GB10tvEPXNK8qAizildc0+nQ7DvcFMrF8Fzs3WQGZxVdhv5MWj0RIRM2X
         9nOGgduxwYLs3iSZUo2giVHm7S2I85I/Ulu8/dSMKbUl8/9bg6HHI/3X44Irz2eWGX/Y
         JhG9GaIHcmrtX9doHJHhQFoovO53He/AXSiZ0Hd9XC74i4XL2CEwoWNi7qLKI4MyXPoD
         e6Uw==
X-Gm-Message-State: APjAAAWlKFn+o1DTOVq/ggc8TcJrgmwC+kmOA1WRxBwGh816FiwKkWsk
        2vw3k/fxDyTD+smL1J59h5dzOuWNZS0=
X-Google-Smtp-Source: APXvYqyE8EE01qFTxPzfqqIWxI1Xk/m1hEhTLTu3F34U1WGrf3WvXSVXnIGVDj8uvDz4IJVM0cZEiQ==
X-Received: by 2002:a2e:6507:: with SMTP id z7mr366544ljb.147.1553532559124;
        Mon, 25 Mar 2019 09:49:19 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id l4sm3124062lfp.29.2019.03.25.09.49.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 09:49:17 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id y6so8467503ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:49:17 -0700 (PDT)
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr4516002lja.68.1553532557114;
 Mon, 25 Mar 2019 09:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <362a9b5f-8908-17f5-3594-6c3c68789dea@molgen.mpg.de>
 <CAEJqkggKGTn0ojWzuYGfoYehDnOf=je5L-7-M1kWogutPGMg3g@mail.gmail.com>
 <874l8ic0l4.fsf@codeaurora.org> <CAEJqkgjYRu1Az6ec1ksQfLZ71fa062Us7XkOzw8BZ2bEoUe8BQ@mail.gmail.com>
 <87wol97hvp.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87wol97hvp.fsf@kamboji.qca.qualcomm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 25 Mar 2019 09:49:05 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOcbSGJs3Xk_SjjsAA87fcwrx_JB_mB9cyV=9u6V+FZ_A@mail.gmail.com>
Message-ID: <CA+ASDXOcbSGJs3Xk_SjjsAA87fcwrx_JB_mB9cyV=9u6V+FZ_A@mail.gmail.com>
Subject: Re: Warning at drivers/net/wireless/ath/ath10k/mac.c:5625 ath10k_bss_info_changed
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Gabriel C <nix.or.die@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalle,

On Fri, Mar 8, 2019 at 2:58 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> Gabriel C <nix.or.die@gmail.com> writes:
> > Am Mo., 4. M=C3=A4rz 2019 um 12:59 Uhr schrieb Kalle Valo <kvalo@codeau=
rora.org>:
> >> Gabriel C <nix.or.die@gmail.com> writes:
> >> > I reported that twice and no one seems to care about.
> >> >
> >> > http://lists.infradead.org/pipermail/ath10k/2018-November/012398.htm=
l
> >> > http://lists.infradead.org/pipermail/ath10k/2018-December/012658.htm=
l
> >>
> >> Does this patch help:
> >>
> >> ath10k: Drop WARN_ON()s that always trigger during system resume
> >>
> >> https://patchwork.kernel.org/patch/10837139/
> >>
> >
> > Without to test this patch I can confirm it will help , I dropped the
> > WARN_ON()'s in 4.19 already.
> > If I remember right 4.19 has one WARN_ON() triggers while 4.20 got two.
>
> Ok, thanks. I'll try to get this patch to 5.1.

Ping? Is there any solution queued anywhere? It's kinda sad how long
this has sat here.

Brian
