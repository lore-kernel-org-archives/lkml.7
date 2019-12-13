Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC335C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 03:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE58F2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 03:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2ASXB/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfLMDJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 22:09:22 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37973 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfLMDJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 22:09:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so620727qki.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 19:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yn6UPHNqzAqAhyMUDEs4A49nRxGs97+Efbe0+LADY9U=;
        b=U2ASXB/p0KcIpBfRXiATBa7S7YIWLrGHaOsePzh9kKsODcF39oacUwEJctKodEtMEo
         3SvCq+wAT4G+jY96OsduoDVjxgsGNCTKfNNyAHVdl6gMAtQkQnZBwYHPa2zRylD5lOSs
         LyLcvYCpx4FPneRbKVGCgrW8qqP9GTU76kFccNPFIwLjdOE//vusrNeTvjdt8P5vJBj5
         LZHzTFpvgNDDyX95SkaU1kzOuZ/wqlbvk76LXGA1Gp3YUh4uoOo5mHGpf+gFpsGGgyTV
         2weocqCGhYBvQUmCQP0V8gvxwTI/jZZlW6+R73HL9pWcBDi7ztlrHNlQQ0sSjTI1c3S0
         xrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yn6UPHNqzAqAhyMUDEs4A49nRxGs97+Efbe0+LADY9U=;
        b=jOz/hkN7Hq4GHkvtGfnQdgAJWu9lkQ6cm4UPVon0LlbzK9Ev2k2wrCSAz2Ospswxbo
         gYinvJTTcNjFGj/XRmzznm7aaSs5k5+gAAby9porgvb3TmWjp2ES4805UyIfWy1z9QT9
         aad80jzqvtF6dYZQtjenqpNqQIO83aZfB7zYZ/tShGDpKLpbaW8Q9uOcpnZQSWOUkz1U
         S8CWqOKz48GIIIwp4THyEuxbq5+0qkLpii2zvEDnhk1q33P40OqmRD4yqKSh4mqPOp6J
         p6lgaib6LVcH7G63zsvHmEZlr7x2EnxKeGUYjf8jpzYqjBV+PeBEYO0xW6pc4kJY93uC
         5gmA==
X-Gm-Message-State: APjAAAVO50eDIHp6aRRgsnj/f7J3tQaJYfXxuS/gn2TRjEENHquFGHtS
        8LG/TACFWzv3YrgXp9DijmFWHdLPOcORxdW/tjc=
X-Google-Smtp-Source: APXvYqwfNLv8emQc8zttzX0kdkP85YXsYBGaZxqIXTh8P469k+tB2NI9ziIDYcSlhO5cwf2V8CUQtk7BEvgjlkUMNHI=
X-Received: by 2002:a37:4fd0:: with SMTP id d199mr11826130qkb.103.1576206560366;
 Thu, 12 Dec 2019 19:09:20 -0800 (PST)
MIME-Version: 1.0
References: <1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com>
 <20191212164835.GD10451@ediswmail.ad.cirrus.com> <20191212165311.GK4310@sirena.org.uk>
In-Reply-To: <20191212165311.GK4310@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 13 Dec 2019 11:09:09 +0800
Message-ID: <CAA+D8AP4XNNmQ72xG6gNevtu8i8TJ7AaQMMgXJMCPmv2VO0_HA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8962: fix lambda value
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        kstewart@linuxfoundation.org,
        guennadi.liakhovetski@linux.intel.com,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com, tglx@linutronix.de,
        allison@lohutok.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, Dec 13, 2019 at 12:54 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Dec 12, 2019 at 04:48:35PM +0000, Charles Keepax wrote:
> > On Wed, Dec 11, 2019 at 07:57:22PM +0800, Shengjiu Wang wrote:
> > > According to user manual, it is required that FLL_LAMBDA > 0
> > > in all cases (Integer and Franctional modes).
>
> > How well tested is this change, and is it addressing an issue you
> > have observed? I agree this does better fit the datasheet just a
> > little nervous as its an older part that has seen a lot of usage.
>
> I've got a feeling that requirement might've been added in later
> versions of the datasheet...

We encounter an issue that when Integer mode, the lambda=theta=0,
the output sound is slower than expected. After change lambda=1
the issue is gone.

Best regards
Wang Shengjiu
