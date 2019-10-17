Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDF5ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1099A214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436765AbfJQNmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:42:54 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:57832 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfJQNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:42:54 -0400
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iL63F-0007wo-MD; Thu, 17 Oct 2019 14:42:49 +0100
Message-ID: <d1022cda6bd6ce73e9875644a5a2c65e4d554f37.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH v6 10/43] compat_ioctl: move rtc handling into
 rtc-dev.c
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Oct 2019 14:42:48 +0100
In-Reply-To: <20191009191044.308087-10-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
         <20191009191044.308087-10-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 21:10 +0200, Arnd Bergmann wrote:
> We no longer need the rtc compat handling to be in common code, now that
> all drivers are either moved to the rtc-class framework, or (rarely)
> exist in drivers/char for architectures without compat mode (m68k,
> alpha and ia64, respectively).
> 
> I checked the list of ioctl commands in drivers, and the ones that are
> not already handled are all compatible, again with the one exception of
> m68k driver, which implements RTC_PLL_GET and RTC_PLL_SET, but has no
> compat mode.
>
> Since the ioctl commands are either compatible or differ in both structure
> and command code between 32-bit and 64-bit, we can merge the compat
> handler into the native one and just implement the two common compat
> commands (RTC_IRQP_READ, RTC_IRQP_SET) there.
[...]

I don't think this can work properly on s390, because some of them take
integers and some take pointers.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

