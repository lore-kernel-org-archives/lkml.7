Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59414C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC092075E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="I1M5VzyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKUK7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:59:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43724 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfKUK7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:59:24 -0500
Received: from zn.tnic (p200300EC2F0F07006553A4184595DC73.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:700:6553:a418:4595:dc73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E3F31EC0CE5;
        Thu, 21 Nov 2019 11:59:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574333959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QhsFZCXrb1b4ERZRWtn5IkK6bsH9IOyVY2ulQt2IjIg=;
        b=I1M5VzyS/+wDFhWcVQugJqlf1BgdxtOdJJWBIARqrZG6pXKpqHmawFxdDLSRbG7Q+ew9UC
        +8jG/8ji9Bb+Fr0kORmuojafVT6cJKxEoNn7lbGQkI/Dz4JeX6vE6MX7BfBfUDQrYNfc7t
        f5oWVyDDI1wQ2UjrrT1G11rLCHQFWZY=
Date:   Thu, 21 Nov 2019 11:59:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lin, Jing" <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
Message-ID: <20191121105913.GB6540@zn.tnic>
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic>
 <247008b5-6d33-a51b-0caa-7f1991a94dbd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <247008b5-6d33-a51b-0caa-7f1991a94dbd@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 05:10:41PM -0700, Dave Jiang wrote:
> I'll add the check on the destination address. The call is modeled after
> __iowrite64_copy() / __iowrite32_copy() in lib/iomap_copy.c. Looks like
> those functions do not check for the alignment requirements either.

So just because they don't check, you don't need to check either?

Can you guarantee that all callers will always do the right thing?

I mean, if you don't care too much, why even write "(must be 512-bit
aligned)"? Who cares then if the data is aligned or not...

> > > + * @dst: destination, in MMIO space (must be 512-bit aligned)
> > > + * @src: source
> > > + * @count: number of 512 bits quantities to submit
> > 
> > Where's that check on the data?
> 
> I don't follow?

What do you do if the caller doesn't submit data in 512 bits quantities?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
