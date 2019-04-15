Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A550C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BEA2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfDOOj0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:39:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33569 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:39:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id d55so14128231ede.0;
        Mon, 15 Apr 2019 07:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hmJsJeNNfh+93dB7/T+Nj58jE4CDvzJ6YUnZ1kMFnf4=;
        b=SpirkLRBdd4/vA579uHeZriFs2G2R2m7mrb8rkH+aIaurW9KdD1HWqNFJoUPMIRWBY
         xCC64YQaNTkWFMqk+6pNXSnB0tmk2TWtCa+u9T3eHY0+h3IKvdMd7lmSH0TH2Ba5i31A
         CFJJ/AHNfxyd87st9Ad9oDeBEGYXYFUwkWWVFCMoMe8ZSU72IR/+ZQgSgyQQWNySuClN
         i2TaiEIcrnMSOxyPu1Mz9wyMq08Qbyo7lMCZbEYKItEuacxJx4CGpGmTGInnZ0pP893p
         HVpxN2Cpz/WBpeJRzOZw4Stj/ZYkP6mIiDKq9XBbdq+sAgHmDwJ5bjpTa+LOLHvpr6tN
         7Mmg==
X-Gm-Message-State: APjAAAXkJLtBZ968/qlCH214Ks1JqqeppO2b9cClPcXHZaB/f3aCgi8o
        QH+g3YDGg5zGfjPTI7jfNuzDgMtHJYg=
X-Google-Smtp-Source: APXvYqxPq5ouQd7gXbHAZQAFWUClkbhCJglynytotmoaUy2e5k+2xMTeD/76uU9tJDlkW0yLfaPSkQ==
X-Received: by 2002:a50:8b95:: with SMTP id m21mr16293745edm.178.1555339161716;
        Mon, 15 Apr 2019 07:39:21 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id p4sm8794741edr.55.2019.04.15.07.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:39:21 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id n25so20815487wmk.4;
        Mon, 15 Apr 2019 07:39:20 -0700 (PDT)
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr22582843wml.24.1555339160744;
 Mon, 15 Apr 2019 07:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190412120730.473-1-megous@megous.com> <CAGb2v66cbpsoHJoiFJkBwhZ5SbO+uO+Kf6gtnA3kPFQZq0329Q@mail.gmail.com>
 <20190415142222.cytlvz7z3mjf7slm@core.my.home> <20190415143304.dxpmyh73qxzaybtc@flea>
In-Reply-To: <20190415143304.dxpmyh73qxzaybtc@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 15 Apr 2019 22:39:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v66dY40zkQcVcyORZ-7RAkC1ATB9fTyRzabf-NyDKAustw@mail.gmail.com>
Message-ID: <CAGb2v66dY40zkQcVcyORZ-7RAkC1ATB9fTyRzabf-NyDKAustw@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 0/3] Add basic support for RTC on Allwinner
 H6 SoC
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 10:33 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Mon, Apr 15, 2019 at 04:22:22PM +0200, Ondřej Jirman wrote:
> > DT would still probably need a re-work in the future, if the PRCM clock
> > modeling the gate would be needed.
>
> Just reacting to that bit.
>
> I know we're pretty bad at this, and the documentation doesn't make it
> any easier, but if you have any idea of how it should be modelled
> next, then do that.

It seems to be just a clock gate, judging by previous (A80/A83T) SoCs.
However since we lack documents for the PRCM, we might need to poke
around to verify that it's actually there.

Or maybe we could ask Allwinner very specific questions, like:

  - Does the PRCM have a gate controlling XO?
  - Is it bit 2 in register 0x44 in the PRCM?

ChenYu

> There's no reason to push it to a later time, it makes everyone's life
> harder.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
