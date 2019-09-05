Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AB3C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6B021883
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbfIEKYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:24:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41558 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbfIEKYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:24:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id j10so2116417qtp.8;
        Thu, 05 Sep 2019 03:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTvF8zjGmq/0EMeGlHa1T87FqGqS6SItRz22+XKCJwU=;
        b=j1oRRml530b3Pg29tRbCvLM5uEQv6NFHoEINS2vN6d0/tjKSvRFAgi65R/il6z2j5P
         xZ7SLHu0TIHVwSZziA+g3iCp6kRfBGUisIVtTyyZ2RSZVrcFZu22YbaFBbC43+j8V7gc
         x4y+rzSbE3nGYZ6mdVWBQyEH1fsgFj8CEabsuzO0bJggEsb3r5uhZF725LXLL05PfW1L
         AhmZeHKIQMx/mIMRWLkvdbKnIyvC+OZbNS6CtG55PAkozONnPIhCr6YxHTa33Xu25WsV
         n1l2RLtVEvN0NU4ARYJUGf8ET6pZ+X5pPaiSfmd3eswqvNjxjyklmvXHGsDLa1uWDIvZ
         BjDQ==
X-Gm-Message-State: APjAAAVgKvU9tNFkZZFmvgNATE81F0jcbt8i9W5kUKlCPSyvbkXRYHmQ
        9Z0kHg9gQug2vqfnmnhLlA8FIcCItqk56uNYExM=
X-Google-Smtp-Source: APXvYqxkEWxnSb9+QHBkg5tCdGDmyuWzLiorsbR4YMGIMMSACe2z+j0WfCG2ir1sARPeqZ2V1OnVrbTAvXqPisM4J/U=
X-Received: by 2002:ac8:32ec:: with SMTP id a41mr2636284qtb.18.1567679060868;
 Thu, 05 Sep 2019 03:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190830220743.439670-1-lkundrak@v3.sk>
In-Reply-To: <20190830220743.439670-1-lkundrak@v3.sk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Sep 2019 12:24:04 +0200
Message-ID: <CAK8P3a0Jq93AVYau_7odZz73ZL22buVCveiHoC6oGf=Oy6KEKQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] Initial support for Marvell MMP3 SoC
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     "To : Olof Johansson" <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Cc : Rob Herring" <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 12:08 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> this is the third spin of a patch set that adds support for the Marvell
> MMP3 processor, that I'd eventually love to see land in the Arm SoC
> tree. MMP3 is used in OLPC XO-4 laptops, Panasonic Toughpad FZ-A1 tablet
> and Dell Wyse 3020/Tx0D thin clients.
>
> Compared to v2, there's a handful of fixes in response to reviews. Four
> irqchip patches have been removed because they've been applied to the
> irqchip-next tree. Details in individual patches.

I just looked at the series, looks great overall, but the timing means
this is going to be 5.5 material by now. Please send a pull request
to soc@kernel.org cc:lakml after -rc1 is out.

I replied with a couple of comments for details I noticed.

       Arnd
