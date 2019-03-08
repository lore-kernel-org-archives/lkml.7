Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B29A20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uR2yPQQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCHJyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:54:23 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33528 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCHJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5fKh3hchjUPNIXZL7EWi+Y6pzOPbfVdj6s/lIJoN2Vw=; b=uR2yPQQs3ljLft6xQ9XWfjTOR
        oj44ZdEZzLrSaxmvvWstI8uP54xeAZBqivWc4DPbAlhQIa24Rk/zR0ywClAn74FLmWI9BBiVzYhgg
        FpTvS+/d6+waKXfxOoNt6N5TxLCQ8YHq83HCddT0PPRZDe9/v9UZ/mMHEcLsFTD/u+d9fanhhlfbh
        ushHzYFfq2TFdcOyoHQVrGN8XJ7ODSAGKocbUzU7xeNP4QJ7gxBHuAxtN1m7FzWLeCs2cs1y0tNGG
        qcN+2aFGMHV66tUANVaGn8TiexE1hVPT90jbMudq8i9Ziqf2W2AukwIJdb9U7SJGSaguo7p1ezlHP
        YcqLEjVgg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51660)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h2CCf-00036j-8T; Fri, 08 Mar 2019 09:54:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h2CCd-0005fh-JL; Fri, 08 Mar 2019 09:54:07 +0000
Date:   Fri, 8 Mar 2019 09:54:07 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Mikael Pettersson <mikpe@it.uu.se>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
Message-ID: <20190308095407.zfezalaysgjialpy@shell.armlinux.org.uk>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
 <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk>
 <CAKwvOdnTLSUmuwtJTGqZpiu9DfRoK8NW88CaouezqZ-y8RDmmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnTLSUmuwtJTGqZpiu9DfRoK8NW88CaouezqZ-y8RDmmg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 04:04:23PM -0800, Nick Desaulniers wrote:
> On Thu, Mar 7, 2019 at 3:49 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Mar 07, 2019 at 11:39:08AM -0800, Nick Desaulniers wrote:
> > > Underspecification of constraints to extended inline assembly is a
> > > common issue exposed by other compilers (and possibly but in-effect
> > > infrequently compiler upgrades).
> >
> > I don't see what is "underspecified" in the original constraints.
> > Please explain.
> 
> From the link:
> 
> The problem is that in the T(streq) insn, %3 and %4 MUST be different registers,
> but nothing in the asm() constrains them to be different.

Thanks, but that is not what I'm asking.  See my reply to Ard.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
