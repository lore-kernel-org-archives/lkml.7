Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70417C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1482084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfDCNXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:23:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32986 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:23:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so14925525edg.0;
        Wed, 03 Apr 2019 06:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SkHx9g3PHF3+4TbNqzZuzU3mCLyBnN10YljkHABBKI=;
        b=tlXB/yx4vPC9m3PVSDcCmo92oMynXxBOpUj0EBFscMpIyyWReD179MwnjiDjQrzT0w
         ZcdNXIZ0MBhswagtKtUk4sCJJTHs+Ywq8KZd9meorhnLD4C862gtibhKJ2H3TYGVEHUT
         xb4pOIR9OyJygONdoxGG7UWV+H9rZYEAgxUoAZZ9otJ69kpuHwwrp+S4UqYzekCoQHj6
         VjM8m4aqJ0YRX5Kg/wB0Xf5FcDviA4/Snsulko6n8s9Otc3WcXC/md2drl6dr0tq82U6
         Pn3R+mW17PEMF0ksF5KUDLMjIJdvvocyAom3x2wrHeHykW2i47OzPgmYrKqP/uX9AAvb
         Ks4A==
X-Gm-Message-State: APjAAAW0isxA52KMY3zSPQ8YPxs/P/SQTOYEm6tsrhMybPXvxZ3v8DUB
        7F5VCx0Em6DRjQoJR7OFsacq86kmKBA=
X-Google-Smtp-Source: APXvYqyjQIiMu+sqLD+3iOO42mru9KltFPnPI/U5vHFuJteS5GuizErj4w0LuU8bb8dFNEstTTK0cQ==
X-Received: by 2002:a50:8854:: with SMTP id c20mr50458483edc.167.1554297785605;
        Wed, 03 Apr 2019 06:23:05 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id l20sm3008899ejb.30.2019.04.03.06.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 06:23:05 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id y197so8231663wmd.0;
        Wed, 03 Apr 2019 06:23:04 -0700 (PDT)
X-Received: by 2002:a1c:dfc5:: with SMTP id w188mr15773wmg.79.1554297784756;
 Wed, 03 Apr 2019 06:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190402210623.14988-1-jernej.skrabec@siol.net>
 <20190402210623.14988-4-jernej.skrabec@siol.net> <20190403075430.4j7sw5vxqop6ptkj@flea>
In-Reply-To: <20190403075430.4j7sw5vxqop6ptkj@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 3 Apr 2019 21:22:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v67dDAun7rnvOEFzGiqY-xpxRm=oe99ktq_+MORxp0Wteg@mail.gmail.com>
Message-ID: <CAGb2v67dDAun7rnvOEFzGiqY-xpxRm=oe99ktq_+MORxp0Wteg@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: sunxi-ng: h6: Allow video & vpu clocks to change
 parent rate
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 3:54 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Apr 02, 2019 at 11:06:23PM +0200, Jernej Skrabec wrote:
> > Video related clocks need to set rate as close as possible to the
> > requested one, so they should be able to change parent clock rate.
> >
> > VPU clock sometimes has to be set to higher than default parent clock
> > rate. This is requ

The commit log looks unfinished. Can you and Jernej fix this up?

> > Add CLK_SET_RATE_PARENT flag to tcon-lcd0, tcon-tv0 and ve.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>
> Applied, thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
