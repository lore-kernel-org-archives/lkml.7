Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF508C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B1D20652
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hznqjuWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfFXPar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:30:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36590 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfFXPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e2lpl/1sZSKODxPM1Dl/3HkA1NQ+D7tlNhA9hB5flvI=; b=hznqjuWWiKm4k4LOSKiQKuSth
        r3JZisFuNnxz0KINf8QqglF4TbK4CsLfrIueptqfS/ECm0+IymVSxeiilgJzvxCimb0Xg2u/XKYtT
        KWV75an6a7XA+Yca/bsgCaqmucieQgXxYRdoo1w2q1UiyXi7rjw8BoRvhTBQT899HLrWlSBmJST1t
        IL2HtpyufdhXaIAAslC3ua+UTFG09+Z66wF5tEG/0gW4ksz8Z2+s1g3+r+jOPdOP6hyTsEY3N5DAD
        xeawZlYAPE0E3+uFk1QwNKNV/RzRPKJd8HeUtZCygpVQwZLfp2luXlg+FEH6rR+hSg05F52LTWkTw
        9Qzxflbgw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:58958)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hfQva-0000XB-9k; Mon, 24 Jun 2019 16:30:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hfQvR-0006PW-FB; Mon, 24 Jun 2019 16:30:33 +0100
Date:   Mon, 24 Jun 2019 16:30:33 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 4/7] arm: Use common cpu_topology structure and
 functions.
Message-ID: <20190624153033.3jpdd7vsekdiltmb@shell.armlinux.org.uk>
References: <20190617185920.29581-1-atish.patra@wdc.com>
 <20190617185920.29581-5-atish.patra@wdc.com>
 <20190619121057.GE1360@e107155-lin>
 <20190624150658.GA1623@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624150658.GA1623@e107155-lin>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 04:06:58PM +0100, Sudeep Holla wrote:
> On Wed, Jun 19, 2019 at 01:10:57PM +0100, Sudeep Holla wrote:
> > Hi Russell,
> >
> > On Mon, Jun 17, 2019 at 11:59:17AM -0700, Atish Patra wrote:
> > > Currently, ARM32 and ARM64 uses different data structures to represent
> > > their cpu topologies. Since, we are moving the ARM64 topology to common
> > > code to be used by other architectures, we can reuse that for ARM32 as
> > > well.
> > >
> > > Take this opprtunity to remove the redundant functions from ARM32 and
> > > reuse the common code instead.
> > >
> > > To: Russell King <linux@armlinux.org.uk>
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > Tested-by: Sudeep Holla <sudeep.holla@arm.com> (on TC2)
> > > Reviewed-by : Sudeep Holla <sudeep.holla@arm.com>
> > >
> > > ---
> > > Hi Russell,
> > > Can we get a ACK for this patch ? We are hoping that the entire
> > > series can be merged at one go.
> >
> > It would be nice to get this in for v5.3 as it's almost there.
> > Are you fine with these changes ?
> >
> 
> Do you have any objections with this patch ? We plan to merge through
> RISC-V tree, please let us know. It has been acked-by all the other
> maintainers.

I have no interest in the CPU topology code; as far as I know I have
no systems that are able to exercise this code in any way.  Therefore,
I don't know this code, I have no way to test it, and so it is not
appropriate for me to ack patches for it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
