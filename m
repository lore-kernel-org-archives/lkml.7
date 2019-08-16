Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C308C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1307C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHPG75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:59:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPG74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:59:56 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyWDK-0003lN-HH; Fri, 16 Aug 2019 08:59:54 +0200
Date:   Fri, 16 Aug 2019 08:59:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Helmut Grohne <helmut.grohne@intenta.de>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/sp804: make CONFIG_ARM_TIMER_SP804
 selectable again
In-Reply-To: <20190816064728.52ymq7rflmuqparz@laureti-dev>
Message-ID: <alpine.DEB.2.21.1908160855060.1908@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1908152227590.1908@nanos.tec.linutronix.de> <20190816064728.52ymq7rflmuqparz@laureti-dev>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Helmut,

On Fri, 16 Aug 2019, Helmut Grohne wrote:
> I also note that there are likely more instances for this pattern.
> Should they be fixed in a similar way? You can find a lot using the
> following incantation:
> 
>     $ git describe --tags
>     v5.3-rc4
>     $ git ls-files -- "*/Kconfig" | xargs git grep --cached 'bool .* if COMPILE_TEST$' -- | wc -l
>     185
>     $
> 
> Seems like an anti-pattern to me. It is particularly common in the
> clocksource subtree.

After some rumaging I figured out that the idea behind this is that the
platforms which need those clocksources use 'select $CLOCKSOURCE' which
works despite the 'if COMPILE_TEST'.

The 'if COMPILE_TEST' is there to hide the config option when there is no
platform which needs it and expose it for compile test purposes.

So if your particular platform does not use 'select ARM_TIMER_SP804' then
the right fix is to add it to that platform.

Thanks,

	tglx
