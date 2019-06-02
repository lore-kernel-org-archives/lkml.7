Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CCDC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764DD27975
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Ns2Y8lqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfFBQfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:35:43 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:42384 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFBQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:35:43 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E74AF5C13F9;
        Sun,  2 Jun 2019 18:35:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1559493339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLPIFtw8wW5Uo7zTBt1EGjS3mHTdYvG1RP4d99oqY1k=;
        b=Ns2Y8lqdIvcdhIyuckIZwJ4ao1UebMtbGultA9s+Oqd4ibbZsli9+xMYVU935rmTtDMLj7
        5WU9x7SfGvuXUEdnd2F5KixEes/5ypLmw6mTVPaSRbLDxS7qXzmOIRcL9HEr8tTVjEx0ia
        HK8fW42HsJpV3bD86r4KvNeHAO8al64=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 02 Jun 2019 18:35:39 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Olof Johansson <olof@lixom.net>
Cc:     arm@kernel.org, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>, nico@fluxnic.net,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, Rob Herring <robh@kernel.org>,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        tony@atomide.com, Marc Gonzalez <marc.w.gonzalez@free.fr>,
        mans@mansr.com, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] ARM: OMAP2: drop explicit assembler architecture
In-Reply-To: <CAKwvOdmsHxyPU2O1vZ-Mah-E5vTtEWKHStp2EQCiE4A55D8xDQ@mail.gmail.com>
References: <c0ca465daa7c7663c19b0bcb848c70e8da22baff.1558996564.git.stefan@agner.ch>
 <5ead0fe96f7e5729e4a82f432022b16cb84458a6.1558996564.git.stefan@agner.ch>
 <CAKwvOdmsHxyPU2O1vZ-Mah-E5vTtEWKHStp2EQCiE4A55D8xDQ@mail.gmail.com>
Message-ID: <fa06b27eeea796f70f1e243096b86117@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.05.2019 22:02, Nick Desaulniers wrote:
> On Mon, May 27, 2019 at 3:41 PM Stefan Agner <stefan@agner.ch> wrote:
>>
>> OMAP2 depends on ARCH_MULTI_V6, which makes sure that the kernel is
>> compiled with -march=armv6. The compiler frontend will pass the
>> architecture to the assembler. There is no explicit architecture
>> specification necessary.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> ---
>> Changes since v2:
>> - New patch
>>
>> Changes since v3:
>> - Rebase on top of v5.2-rc2
> 
> Hi Stefan, looks like both patches are ack'd.  Are you waiting for an
> explicit reviewed by tag to submit to
> https://www.armlinux.org.uk/developer/patches/?

This should go through arm-soc, it missed the last merge window, see
Olofs message:
https://lore.kernel.org/lkml/20190516214819.dopw4eiumt6is46e@localhost/T/#u

Should be still early enough to make it in this merge window.

--
Stefan
