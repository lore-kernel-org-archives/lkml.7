Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AB2C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D916426213
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DLH2JYbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfE3VzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:55:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49572 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfE3VzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cMVlGTvXkUveUITBldNsm2wqtZ0vfwdSAKndguUBaOQ=; b=DLH2JYbeHwq/YpEbWMtT0JGBL
        spO2pEc/2hmPltlibpNfKJ2Ih/2Rm4G0phN5i2XSKks3aWtbDZz/GjR3JOGCj0DN/EFFNJYoQcgdY
        KCaXkwyYwGjN4/dPWIvnF995pitZOxwUX3cRQdPGcd08tJMbDelcgzPTaceo+3xiEu6bQ9l0KxDmW
        A6ERMXUYjHd+RHWZrpMMqsX0zPrTCj1eb0FZ12RnJMUJ3c1CbH3/iBVkW/k/nJ87VxzdpYmPFA/Bj
        w8HefDp2VNcdyksBGBu0eg9AnsJHYltB0rlhwyOs9x/BKnj7EROswpX3bRDMtwawd5XTsxhzCT215
        893fQ6/Cw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56076)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWSpD-0005E4-3f; Thu, 30 May 2019 22:43:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWSp5-0005jk-2U; Thu, 30 May 2019 22:42:55 +0100
Date:   Thu, 30 May 2019 22:42:54 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/7] Documentation: DT: arm: add support for sockets
 defining package boundaries
Message-ID: <20190530214254.tuxsnyv52a2fyhck@shell.armlinux.org.uk>
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <20190529211340.17087-2-atish.patra@wdc.com>
 <49f41e62-5354-a674-d95f-5f63851a0ca6@ti.com>
 <20190530115103.GA10919@e105550-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530115103.GA10919@e105550-lin.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 12:51:03PM +0100, Morten Rasmussen wrote:
> On Wed, May 29, 2019 at 07:39:17PM -0400, Andrew F. Davis wrote:
> > On 5/29/19 5:13 PM, Atish Patra wrote:
> > >From: Sudeep Holla <sudeep.holla@arm.com>
> > >
> > >The current ARM DT topology description provides the operating system
> > >with a topological view of the system that is based on leaf nodes
> > >representing either cores or threads (in an SMT system) and a
> > >hierarchical set of cluster nodes that creates a hierarchical topology
> > >view of how those cores and threads are grouped.
> > >
> > >However this hierarchical representation of clusters does not allow to
> > >describe what topology level actually represents the physical package or
> > >the socket boundary, which is a key piece of information to be used by
> > >an operating system to optimize resource allocation and scheduling.
> > >
> > 
> > Are physical package descriptions really needed? What does "socket" imply
> > that a higher layer "cluster" node grouping does not? It doesn't imply a
> > different NUMA distance and the definition of "socket" is already not well
> > defined, is a dual chiplet processor not just a fancy dual "socket" or are
> > dual "sockets" on a server board "slotket" card, will we need new names for
> > those too..
> 
> Socket (or package) just implies what you suggest, a grouping of CPUs
> based on the physical socket (or package). Some resources might be
> associated with packages and more importantly socket information is
> exposed to user-space. At the moment clusters are being exposed to
> user-space as sockets which is less than ideal for some topologies.

Please point out a 32-bit ARM system that has multiple "socket"s.

As far as I'm aware, all 32-bit systems do not have socketed CPUs
(modern ARM CPUs are part of a larger SoC), and the CPUs are always
in one package.

Even the test systems I've seen do not have socketed CPUs.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
