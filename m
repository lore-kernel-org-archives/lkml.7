Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA8DCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA13421734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DHuiYqjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfKARSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:18:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41308 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKARSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:18:54 -0400
Received: by mail-io1-f66.google.com with SMTP id r144so11667724iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 10:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gsPQETmgTl7NAIWAe0p+amO0Xpuf42Sg5sA03PkK6fA=;
        b=DHuiYqjtLEwqyLc8KBlcA9F87Trr8KlR7lQJupob2JvW1qt4IaBr8dS/t93oO8kXMx
         rBldwNzx5Bfy/DNuhhr5XthFjVwEy1vHvByiPxaQDAzxGzfTbhAaVl0tuYACCY0WONO3
         jXIPHzTezjByu4wkcAQNK+Yfgf0uGL8aewFnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gsPQETmgTl7NAIWAe0p+amO0Xpuf42Sg5sA03PkK6fA=;
        b=Jq3E6gHK+HeRLbMhAR2pF/iYnlPpyHRVG2SLZjTAsuSQdWYFxAjkEErhsDVP7esaOc
         HEvM5n2XpDpHJ6vyB3LCeyPttCqCPCGAoAd/TI9+5WpciPHxRoFB+a7yw2332Og99PPf
         SseAsFhuHjoAVMtjfGsAWarKnF8ufoaxwL1b/v1s5a/fh1SHFhWRnGcNPDzhxPhrErSY
         +cy5EBLT/p5QdIQ1PpZc24Keb7V9gEkErNhAmDSJod1zTePi1poZxmW64FF0MjUpzDVu
         htMJaycT904sTywurp6yCAXzTnQ5mKKFsQP1+qsysgmg3klfpnaBn1Vmf9yrM6eA1lOR
         ob5g==
X-Gm-Message-State: APjAAAUO9NzRGW5cjewefMrfslkV2YHy+RBnCKZaCSVcYyXl7/Cj2cI8
        oOSZQgVPiY6gdwTx1DZVvLk/nKTfiyhS3K93h8W8gQ==
X-Google-Smtp-Source: APXvYqzXiC7EL678+PXm0OrA280csP8J0SZXUGEUAnJ/ik++qiGdw5SRlWYaLOt1/bpVHe7UCsf7VcAlx4eKOCsSzv8=
X-Received: by 2002:a5d:8d95:: with SMTP id b21mr2294351ioj.61.1572628729457;
 Fri, 01 Nov 2019 10:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <075b3fa6-dab7-5fec-df68-b53f32bf061b@fivetechno.de>
In-Reply-To: <075b3fa6-dab7-5fec-df68-b53f32bf061b@fivetechno.de>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 1 Nov 2019 22:48:38 +0530
Message-ID: <CAMty3ZDSK4mJk0bkQ_e3m1=Ar+NnGZS7q8zFYJJHtZY3HeBkfw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Split rk3399-roc-pc for with and
 without mezzanine board.
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 10:24 PM Markus Reichl <m.reichl@fivetechno.de> wrote:
>
> For rk3399-roc-pc is a mezzanine board available that carries M.2 and
> POE interfaces. Use it with a separate dts.

Thanks for the patch. Indeed have an impression to go this via overlay
rather than a separate dts since it is HAT for base board, does it
make sense? or is this the way it is handling in rockchip dts files?
