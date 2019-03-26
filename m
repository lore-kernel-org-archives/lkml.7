Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE71C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382DB2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="erHndOcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfCZAt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:49:27 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41794 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbfCZAtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:49:24 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so7368626lfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFP2jZU8cYxTAE12oUDWp0lSFiuDMdFVz8HpXQukEdA=;
        b=erHndOcm/9WDEIMAly50XEVIigCRogpN9KLIR+Nzbm/kXgpqJM/Wcr8p5b6IdZQgB9
         oOHmjXBakMM8yUOeobBFKjBiTGkrDe9KgT6KuEihJN34ObiUnM4+F27uubFIp92Xj9tL
         IUP43vt9WHQ/gYFvjcYFwcFiU5DHNwc9Axv4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFP2jZU8cYxTAE12oUDWp0lSFiuDMdFVz8HpXQukEdA=;
        b=DZp2Yf4Me0NYoNryKlhbJR0+EWMBGQTz63PdruSQ9YwFQCuX/JmL1B8YdF8OdBsUDc
         M4+ed/R4BfQ/EKSqUnU/TmxPEZ/Gxy3K6eQ7cpfoMRxTvmjkxnREk4SK/VI1kZbzUKxa
         uH81lKGBv6QaET9bBSCmmMSXvgWXY34U+0OgN3nGe14vtxQ8gnrKJBa3gHvxmpXIN9oP
         ccBVnQ076mNR1magyRA+T+DQjG/sPnmf6yii1CpFQJwV5xFLqvh5joNOfovwiFItADxa
         3Qh/yixUeRrPCUE9R48icwkLwY3Vycj1mCeCe+xeZroSqE07yu6E9ScOBBdeoP+NMYfO
         2nTw==
X-Gm-Message-State: APjAAAUEbEEQy4kIwYDOmk9TiW9FRMhNHeMGQzsvMZ1KFVPqL+mw7/ap
        aNITQJKvplKB2RyLZA2cpss35QziFUs=
X-Google-Smtp-Source: APXvYqwTij+/5/kNj83sEC4qQHRRlzDf8yqwhlfz5/kwSJKCVH+q7psRCMNl3DufB1IFNUPfaDCfYQ==
X-Received: by 2002:a19:9101:: with SMTP id t1mr774853lfd.165.1553561361189;
        Mon, 25 Mar 2019 17:49:21 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m19sm3674613lfb.78.2019.03.25.17.49.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 17:49:20 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id r25so7359147lfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:49:19 -0700 (PDT)
X-Received: by 2002:a19:4b14:: with SMTP id y20mr13438544lfa.36.1553561359526;
 Mon, 25 Mar 2019 17:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214730.6545-1-valleau@chromium.org> <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
 <CA+ASDXMcnEfZzTjDGsDbZxX2Xknv6dt3H-3kN79WdKFzif2zsA@mail.gmail.com>
 <caee30e2-ddc4-0076-907e-558dbcfe7c52@kernel.org> <CA+ASDXOzTkXk_JtBDa4zkMhy3NyWv7Wn1i6YYtwRdeF8j_c2nA@mail.gmail.com>
 <23918a77-2694-fdae-4300-0882c7c940cf@kernel.org> <CA+ASDXOEkG36W-6rONqDntzChtq65=cQh6JVyjWhftBykXVTbw@mail.gmail.com>
 <20190326001353.GA4315@kroah.com>
In-Reply-To: <20190326001353.GA4315@kroah.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 25 Mar 2019 17:49:07 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMR_HPSnAWRGYV_fDq6kSR7WdgTq3pgW9VaTwA7fA7=qA@mail.gmail.com>
Message-ID: <CA+ASDXMR_HPSnAWRGYV_fDq6kSR7WdgTq3pgW9VaTwA7fA7=qA@mail.gmail.com>
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel versions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     shuah <shuah@kernel.org>, David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Mar 25, 2019 at 5:35 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 3.18 was released at the end of 2014, and as the tool that came with
> that kernel still works just fine, you are just pushing the boundry here
> really hard :)

For some reason, we're focusing on 3.18, when the last breakage we're
currently aware of was as recent as 4.13. So we (Chrom{ium,e} OS) also
dealing with 4.4, which is still getting active LTS releases (thanks!)
and is in heavy use.

> Why do you want to update your userspace tool and not update your
> kernel?  What is forcing your userspace tool to be updated?

I tried to downplay that part: we're primarily interested in finding
some way to utilize the *same* tool on all kernels in question. It
doesn't have to be the latest. But it's currently impossible, mostly
due to commit 1c9de5bf4286 ("usbip: vhci-hcd: Add USB3 SuperSpeed
support").

We also certainly have flexibility to hack things on our own and don't
need upstream to care about everything we care about (e.g.,
sufficiently old kernels), but I did want to have this conversation at
least, so that people are aware of the breakages they are making, and
so we can understand what to expect.

> Not to say that this shouldn't be fixed if at all possible, but realize
> that this is not the "normal" case of "we do not break userspace" here,
> given the tool involved, and the apis being used.

I think I sort of understand what you're going for here, but can you
elaborate so I don't have to assume?

Thanks,
Brian
