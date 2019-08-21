Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ACAC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 06:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575362087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 06:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfHUGBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:01:32 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:42600 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfHUGBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:01:31 -0400
Received: by mail-ed1-f45.google.com with SMTP id m44so1498883edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 23:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hs9Q4JQ4sAzVdPQmb3HqoJDxpZfogEn9LhSdqe880xI=;
        b=BCuwwW9ez3ERCUBGNaqeN32iUi5KQNLxtXcwTr8r62xHq4RDWgOEYMPdjRVxRwVOCV
         KB+REHsCj5PdRGrLS63eb08EyasS8115OSX9QwdPuYZmgteCKhUXXJ+ohH861gl+0zt6
         uw/Flgr2H1DG9FUYo1o66eVG2bBH1vP6LrC8HNTnXFyUmEenvtOcxLeNabp6oRUi/irT
         hHYJHxtWT91yClHRspfQrTelv488nU1LXCIMh53JBL2HS/MzQngw5YtKpZbZnOU9y5VT
         dnWwuRPVQOh55jXFU4cMIXVNeO0bjw+8/W8v+/rNgCp8o7Xviz5e63AUbZHS0u4hv8BS
         I/FQ==
X-Gm-Message-State: APjAAAUXFaQmkK099YjHTkVlF8gd+L81t5kiODjnUyE7FSvYCE4bypW1
        Dxyw+OdoneNFZjxsvqjC9O34k0pHc08=
X-Google-Smtp-Source: APXvYqwVHVJoKR+7+nltmNBRW1cR5CWte2/5A704Fo8Jxn+Cmu1S1eQ/5j+epuFBSHqDNnFEHO9Cjw==
X-Received: by 2002:aa7:c484:: with SMTP id m4mr21907608edq.174.1566367288986;
        Tue, 20 Aug 2019 23:01:28 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id t16sm2957060ejj.48.2019.08.20.23.01.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 23:01:28 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id g67so829989wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 23:01:28 -0700 (PDT)
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr3726750wmf.47.1566367288272;
 Tue, 20 Aug 2019 23:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-10-codekipper@gmail.com>
 <CAGb2v65+-OB4zEyW8f7hcWHkL7DtfEB1YK2B1nOKdgNdNqC0kQ@mail.gmail.com> <CAEKpxBnxf=iejk887A7qFkzt3BXVxiRS1PeA45aZYR9DsBAU4Q@mail.gmail.com>
In-Reply-To: <CAEKpxBnxf=iejk887A7qFkzt3BXVxiRS1PeA45aZYR9DsBAU4Q@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 21 Aug 2019 14:01:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v65CueHKeZMCsMFjwWA1vo7ne3K8uVu2_yGOsXChY371ew@mail.gmail.com>
Message-ID: <CAGb2v65CueHKeZMCsMFjwWA1vo7ne3K8uVu2_yGOsXChY371ew@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 09/15] clk: sunxi-ng: h6: Allow I2S to
 change parent rate
To:     Code Kipper <codekipper@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 1:52 PM Code Kipper <codekipper@gmail.com> wrote:
>
> Thanks....I've added to my next patch series but if you could add it
> when applying that would be great.

Please reply with an explicit SoB to put it on the record.

ChenYu

> BR,
> CK
>
> On Wed, 21 Aug 2019 at 06:07, Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Wed, Aug 14, 2019 at 2:09 PM <codekipper@gmail.com> wrote:
> > >
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > I2S doesn't work if parent rate couldn't be change. Difference between
> > > wanted and actual rate is too big.
> > >
> > > Fix this by adding CLK_SET_RATE_PARENT flag to I2S clocks.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > This lacks your SoB. Please reply and I can add it when applying.
> >
> > ChenYu
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/CAEKpxBnxf%3Diejk887A7qFkzt3BXVxiRS1PeA45aZYR9DsBAU4Q%40mail.gmail.com.
