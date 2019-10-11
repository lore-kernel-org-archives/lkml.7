Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FBCECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D62206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfJKOmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:42:43 -0400
Received: from foss.arm.com ([217.140.110.172]:34514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfJKOml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:42:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DC51142F;
        Fri, 11 Oct 2019 07:42:40 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F2DC3F68E;
        Fri, 11 Oct 2019 07:42:39 -0700 (PDT)
Date:   Fri, 11 Oct 2019 15:42:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: ARM Juno r1 + CONFIG_PROVE_LOCKING=y => boot failure
Message-ID: <20191011144233.GA2438@bogus>
References: <CGME20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b@eucas1p1.samsung.com>
 <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
 <20191011100521.GA5122@bogus>
 <7655fb41-cd13-0bc4-e656-040e0875bab8@arm.com>
 <2bf88cd2-9c4f-11dc-4b70-f717de891cff@samsung.com>
 <20191011131058.GA26061@bogus>
 <0b02b15f-38be-7a63-14cc-eabd288782eb@samsung.com>
 <20191011134354.GA31516@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011134354.GA31516@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 02:43:54PM +0100, Sudeep Holla wrote:
> On Fri, Oct 11, 2019 at 03:15:32PM +0200, Marek Szyprowski wrote:
> > Hi Sudeep
> >
> > On 11.10.2019 15:10, Sudeep Holla wrote:
> > > On Fri, Oct 11, 2019 at 03:02:42PM +0200, Marek Szyprowski wrote:
> > >> Hi James,
> > >>
> > >> On 11.10.2019 12:38, James Morse wrote:
> > >>> Hi guys,
> > >>>
> > >>> On 11/10/2019 11:05, Sudeep Holla wrote:
> > >>>> On Fri, Oct 11, 2019 at 11:26:04AM +0200, Marek Szyprowski wrote:
> > >>>>> Recently I've got access to ARM Juno R1 board and did some tests with
> > >>>>> current mainline kernel on it. I'm a bit surprised that enabling
> > >>>>> CONFIG_PROVE_LOCKING causes a boot failure on this board. After enabling
> > >>>>> this Kconfig option, I get no single message from the kernel, although I
> > >>>>> have earlycon enabled.
> > >>>> I don't have Juno R1 but I tried defconfig + CONFIG_PROVE_LOCKING and
> > >>>> it boots fine.
> > >>> I just tried this on my r1, v5.4-rc1 with this configuration worked just fine.
> > >>>
> > >>> My cmdline is:
> > >>> | root=/dev/sda6 loglevel=9 earlycon=pl011,0x7ff80000 hugepagesz=2M hugepages=512
> > >>> | crashkernel=1G console=ttyAMA0 resume=/dev/sda2 no_console_suspend efi=debug
> > >>>
> > >> That is a bit strange. Here is a boot log from v5.4-rc1 with pure
> > >> defconfig: https://paste.debian.net/1105851/
> > >>
> > > I see from the boot log that both Image.gz and dtb being loaded at the
> > > same address 0x82000000, will u-boot uncompress it elsewhere after loading
> > > it ? Just for my understanding.
> >
> > tftp downloads Image.gz to 0x82000000, then decompress it to
> > $kernel_addr to save transfer time
> >
> > my bootcmd is:
> >
> > tftp ${fdt_addr} juno/Image.gz; unzip ${fdt_addr} ${kernel_addr}; tftp
> > ${fdt_addr} juno/juno-r1.dtb; booti ${kernel_addr} - ${fdt_addr};
> >

If your ${kernel_addr}=0x80000000 or within first 32MB, then it will override
DTB with the image size I had(35MB). Even if kernel fits 32MB, there is a
chance that .bss lies beyond 32MB and it will be cleared during boot resulting
in DTB corruption(Andre P reminded me this)

Can you try setting $${fdt_addr} to 0x84000000 to begin with ?

--
Regards,
Sudeep

