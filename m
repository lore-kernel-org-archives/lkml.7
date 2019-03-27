Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1EBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B8B2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NlOTsPYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfC0JF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:05:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52164 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbfC0JFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:05:55 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 29F5E1EC0B3D;
        Wed, 27 Mar 2019 10:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553677554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9PChJgtM34ZbomqEZ8kyVfA1Pp+gvOK2R0JJ23U5L5Y=;
        b=NlOTsPYkRX8eGg5M6hF26V57furoJHQsGRK3ij7DJRQqvx1Z2uf1PWM7yTKj1JVpH6kR4L
        u5umxLmzFeHYD+PHsK6B0x2Uc92dYh/kNUxwdXvKTtJ2YlY3ehbuZ6HVrSIwyU/C6yBK+t
        6lw/Co/jvZGlCQm1lmuagPPmqN/DDcg=
Date:   Wed, 27 Mar 2019 10:05:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/realmode: don't leak kernel addresses
Message-ID: <20190327090556.GA32571@zn.tnic>
References: <20190324190504.29906-1-mcroce@redhat.com>
 <20190326161457.GN1867@zn.tnic>
 <CAGnkfhwtXdjaHFChFBMNiSnh+cpDRi=e20J0EZ039xWuRTcouQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGnkfhwtXdjaHFChFBMNiSnh+cpDRi=e20J0EZ039xWuRTcouQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:36:48PM +0100, Matteo Croce wrote:
> Got it, sent a v3 with the printk removed.
> Anyway, I wonder if we can remove the 'size' argument and/or moving
> set_real_mode_mem() into realmode.h to have it inlined.
> Or maybe it's not worth it.

Sure, why not. Making the code simpler is always a GoodThing(tm). :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
