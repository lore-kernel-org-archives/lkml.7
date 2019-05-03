Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC57EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC662081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfECM5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:57:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46851 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:57:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id i31so6468990qti.13;
        Fri, 03 May 2019 05:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Sdy9iaHURUvZLe2z2TWslaL2IkPLpsKGDTPao4Xq9w=;
        b=Btt9LaDwVDIWkSnUke/4wYUA7hf8qmyb5U5UET06HJie3i2Ox4DFKBtcYJ/VpYjgkw
         tjUdjcwWVEPAWllnLhtnUARmxb1QVYhEU5uO+NyEJY6k3ynAYtQIh58SvIovyyzynghz
         uQ0Wb+o0iNPulYP2mBkwCjPwkgYne333WjrHHY8TH0c3U7HzxUYB/ynxMRKIfQmep+um
         Sjqm1Zu7OLO2h6t09SvQfvY3PiltoInjk5YvWUD3DccIiF4ejx4p5hRL3NZNovdy4uzb
         Bb/QX/GNalLU/Tal1n6spa63XVS1SPmAWlhIk3mH3NGoTkw+/3PJTLfjU6CxLZl/cNP+
         YmWA==
X-Gm-Message-State: APjAAAVH7L6appFYNDdfZownH/Scg+bQZi5B2P3AaujuCWamkl4ow60T
        nWrydnGEDvlr7iQ2yiX4qu2CRRT81+GXAHUwTnM=
X-Google-Smtp-Source: APXvYqz4I66pwqVNkia+5QmCH0JMxT1NXFZAqd7SA9VcuUTPzK6FTtjijdQ+px26v/oRzFFrRi75cZp5kQT3vJ2MYQI=
X-Received: by 2002:a0c:980b:: with SMTP id c11mr8129691qvd.115.1556888273217;
 Fri, 03 May 2019 05:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190430092839.767e5bf8@canb.auug.org.au> <CACRpkdYBuBf7jA2nUitiZWRriXVTPWCyB93q2CzmP4tbVZXqHA@mail.gmail.com>
In-Reply-To: <CACRpkdYBuBf7jA2nUitiZWRriXVTPWCyB93q2CzmP4tbVZXqHA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 May 2019 08:57:35 -0400
Message-ID: <CAK8P3a1dy92NYX=bo6LYUGkFmKjGq65HjomOq7cCYDgx6ceoaA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc tree
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 2:49 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Apr 30, 2019 at 12:28 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> > After merging the arm-soc tree, today's linux-next build
> > (x86_64 allmodconfig) produced this warning:
> >
> > drivers/clocksource/timer-ixp4xx.c:78:20: warning: 'ixp4xx_read_sched_clock' defined but not used [-Wunused-function]
> >  static u64 notrace ixp4xx_read_sched_clock(void)
> >                     ^~~~~~~~~~~~~~~~~~~~~~~
>
> This is kind of normal for timer drivers, as the sched_clock() call is #ifdef:ed
> for CONFIG_ARM, it is not uniformly available on all archs. This appears
> as a side effect of COMPILE_TEST which I think is fair to produce
> things like this.

Could you send a fixup patch to mark the function __maybe_unused or
move it into the #ifdef?

         Arnd
