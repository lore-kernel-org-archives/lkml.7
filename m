Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9BFC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFA0222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="AIBnTVIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfKMKcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:32:11 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39006 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfKMKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6kTYcY6cpyy5llPwJ7N/vU69PHHlS2avthqvOc/6Zi8=; b=AIBnTVIWDXTQwFEx88OnyedhR
        IT7vFNnd6U5b0NBNkjKbK1TYzlbPBJP2sjqTfcD/njKYUoZ81kAbrA1r9D5Wmfu4B29WijtJb/e01
        i+JyhnAF0mH04TbKC/u+v+ZOLBOn+WllY8roxOFz+CDZlsiFKUGOyVEfoWJvRhwHrAeqSa3A+OIov
        lM7uIBp5CO/1FVyflkFTnK82XyjlrWf16yYbTCD4hMHdnXRl4/kaeYpsYGI/SqywT00le0QeURH9e
        PP6AUgHP0CFMRos13UMF9Rg56kVoh1zgOBUlqHUxo1ryUMJV6p8iPQadNDJfNCzEFRir7zHPkpR+Y
        BXMoMGHWA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:34912)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iUpwJ-0003We-59; Wed, 13 Nov 2019 10:31:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iUpwF-0002NO-2l; Wed, 13 Nov 2019 10:31:51 +0000
Date:   Wed, 13 Nov 2019 10:31:51 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Will Deacon <will@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincent Whitchurch <rabinv@axis.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read
 hazard
Message-ID: <20191113103150.GL25745@shell.armlinux.org.uk>
References: <20191112130244.16630-1-vincent.whitchurch@axis.com>
 <20191112160855.GA22025@arrakis.emea.arm.com>
 <20191112180034.GB19889@willie-the-truck>
 <20191112182249.GB22025@arrakis.emea.arm.com>
 <CAHk-=wg4vi27mnMVgZ-rzcEdDAjTXrY1Jyz3+=5STcY0bw4-jQ@mail.gmail.com>
 <20191113102357.GA25875@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113102357.GA25875@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:23:58AM +0000, Will Deacon wrote:
> On Tue, Nov 12, 2019 at 10:39:01AM -0800, Linus Torvalds wrote:
> > On Tue, Nov 12, 2019 at 10:22 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > >
> > > OK, so this includes changing test_bit() to perform a READ_ONCE.
> > 
> > That's not going to happen.
> 
> Ok, I'll stick my neck out here, but if test_bit() is being used to read
> a bitmap that is being concurrently modified (e.g. by set_bit() which boils
> down to atomic_long_or()), then why isn't READ_ONCE() required? Right now,
> test_bit takes a 'const volatile unsigned long *addr' argument, so I don't
> see that you'll get a change in codegen except on alpha and, with this
> erratum, arm32.

I'm not entirely clear what you're suggesting, so I'll just pick the
scenario that I think you're talking about - but I'm not sure it's the
one you're intending.

Using test_bit() in one thread and set_bit() on the same bit in another
thread without locking is going to be racy by definition.  It's entirely
possible for:

	Thread 1			Thread 2
	bit = test_bit(...);
					set_bit(...);
	/* use bit */

and here, bit == 0 but the bit has been set by thread 2.  Use of the
result from test_bit() is inherently a non-atomic operation.

This is why we have test_and_set_bit() and friends that atomically test
that a bit is clear before setting it.  Where this is especially
important is for some filesystems, as they use test_and_xxx_bit() to
manage their allocation bitmaps.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
