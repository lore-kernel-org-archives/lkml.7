Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A882070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bfoo41Ws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfC0LtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:49:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49490 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfC0LtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:49:17 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58F8D1EC014B;
        Wed, 27 Mar 2019 12:49:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553687356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YWgQL6NnX4XYeyup95DGbobB7jXrFU02gxP1axHpfF4=;
        b=bfoo41Ws/m4UZIIIkrXwywjcUGZChm0GUaAQERG7ielcE0MiIVkBbLWPZV//7ooDnr5GhK
        DXdnvbPpKnIwg1OUFJjQre1W13LiBEyP8tdXmW5YeYmbZSseFMqlNXKWht4yFNv815ROsb
        aB4W/3nRNfbG+2bknB26CG6En8MxgM4=
Date:   Wed, 27 Mar 2019 12:49:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Message-ID: <20190327114917.GD32571@zn.tnic>
References: <20190327090905.5588-1-leon@kernel.org>
 <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
 <20190327093844.GO22899@mtr-leonro.mtl.com>
 <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
 <20190327095337.GP22899@mtr-leonro.mtl.com>
 <20190327101133.GQ22899@mtr-leonro.mtl.com>
 <20190327101815.GB32571@zn.tnic>
 <20190327105024.GR22899@mtr-leonro.mtl.com>
 <20190327111452.GC32571@zn.tnic>
 <20190327113628.GS22899@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190327113628.GS22899@mtr-leonro.mtl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 01:36:28PM +0200, Leon Romanovsky wrote:
> At the end, it is reduced to our usage, we are running QEMU inside
> docker to test kernel changes with limitation on number of CPUs to use.
> The systems are optimized to boot kernel as soon as possible in order
> to run tests and on my machine (64 CPUs) reduce is visible: from ~2.6
> sec to ~2.3 sec from execution to kernel boot.

You're kidding, right?

0.3 sec boot time "improvement" for a kernel on which you run tests
which take orders of magnitude longer (I assume). And you want to hide
this message in the upstream kernel because you want to minimally speed
up *your* *specific* usage ?

And we still are wasting time talking about this?!

Oh boy.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
