Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5551A20848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfDOTrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:47:47 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43108 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfDOTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:47:47 -0400
Received: by mail-qt1-f193.google.com with SMTP id v32so20584617qtc.10;
        Mon, 15 Apr 2019 12:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/C3t9rgSuWq5OKRvtxUz/xWegl3UdthgeHpxahk+9Q=;
        b=B/MHFvBES3sK1xXZDLW8Gjec+xjKrvW9WyBzIYCeBy5HKUeL5WvSCM12As2U12jb7P
         KUuUw5bBBqyy0Hdek+vdfoJLR4DQgOw3Mod8N0fAW/B66L7XqovbZIe+WYmdWTI3zrhZ
         FenmO43xKpU+3C3O1OvvXCO855uejwDuwcRsj7kTqTbxKe+P6prvrUIXkrnY5HKrKaOx
         bFyP/7KmdTRq9Zyf4+9pXvB+VlanNiIr3TKL5ruNbxdnmibl3P5wMxSNfiXc6XPgiWsI
         hhmbDjQ2g5p9QEuLjCpRs451L5DhV0nUZUMo1nS11ipi6fOs/ZK3nk716BY8KhwIDC2/
         AdrQ==
X-Gm-Message-State: APjAAAVJn3qG4n4yzNJQGmChWs8wmdKw11Bq2J/D/SqUCw4lo1efuxvR
        /twM894DUNSK4oqI9KdMSI11bAfHCIbLFCRRlQ8=
X-Google-Smtp-Source: APXvYqz4SKvbue/y15Z3P53ZnsVQ4k4qqPxK/YjpPhIMm/ubegQZkcu1u5l8IYVF4bBxbN6+DNAh/CvOLpzVHLfFgzQ=
X-Received: by 2002:a0c:9dcb:: with SMTP id p11mr61785825qvf.28.1555357666114;
 Mon, 15 Apr 2019 12:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190415192734.935387-1-arnd@arndb.de> <20190415192734.935387-2-arnd@arndb.de>
 <CO2PR01MB21683E465191EA8246503774D02B0@CO2PR01MB2168.prod.exchangelabs.com>
In-Reply-To: <CO2PR01MB21683E465191EA8246503774D02B0@CO2PR01MB2168.prod.exchangelabs.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Apr 2019 21:47:29 +0200
Message-ID: <CAK8P3a1DSN3jcfGngrJFp93Mt98qsibvKvtJGtjHYjOmcM1kNQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: ep93xx: keypad: stop using mach/platform.h
To:     Hartley Sweeten <HartleyS@visionengravers.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 9:39 PM Hartley Sweeten
<HartleyS@visionengravers.com> wrote:
>
> On Monday, April 15, 2019 12:25 PM, Arnd Bergmann wrote:
> > We can communicate the clock rate using platform data rather than setting a
> > flag to use a particular value in the driver, which is cleaner and avoids the dependency.
> >
> > No platform in the kernel currently defines the ep93xx keypad device structure, so this
> > is a rather pointless excercise.  Any out of tree users are probably dead now, but if not,
> >  they have to change their platform code to match the new platform_data structure.
>
> <snip>
>
> > diff --git a/include/linux/platform_data/keypad-ep93xx.h b/include/linux/platform_data/keypad-ep93xx.h
> > index 0e36818e3680..3054fced8509 100644
> > --- a/include/linux/platform_data/keypad-ep93xx.h
> > +++ b/include/linux/platform_data/keypad-ep93xx.h
> > @@ -9,8 +9,7 @@ struct matrix_keymap_data;
> >  #define EP93XX_KEYPAD_DIAG_MODE              (1<<1)  /* diagnostic mode */
> >  #define EP93XX_KEYPAD_BACK_DRIVE     (1<<2)  /* back driving mode */
> >  #define EP93XX_KEYPAD_TEST_MODE              (1<<3)  /* scan only column 0 */
> > -#define EP93XX_KEYPAD_KDIV           (1<<4)  /* 1/4 clock or 1/16 clock */
> > -#define EP93XX_KEYPAD_AUTOREPEAT     (1<<5)  /* enable key autorepeat */
> > +#define EP93XX_KEYPAD_AUTOREPEAT     (1<<4)  /* enable key autorepeat */
>
> You have re-defined the keypad register bits here.
>
> The KDIV bit changes the clock rate. The AUTOREPEAT bit enables key autorepeat.

As far as I can tell, they are not register bits, just software flags
for communicating between a board file and the driver, so I
assumed I could freely reorganize them.

Did I miss something?

      Arnd
