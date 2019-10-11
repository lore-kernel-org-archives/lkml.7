Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E08ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490482084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfJKK71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:59:27 -0400
Received: from foss.arm.com ([217.140.110.172]:56512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfJKK71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:59:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BF3428;
        Fri, 11 Oct 2019 03:59:26 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2293E3F703;
        Fri, 11 Oct 2019 03:59:25 -0700 (PDT)
Date:   Fri, 11 Oct 2019 11:59:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: ARM Juno r1 + CONFIG_PROVE_LOCKING=y => boot failure
Message-ID: <20191011105923.GB5122@bogus>
References: <CGME20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b@eucas1p1.samsung.com>
 <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
 <20191011100521.GA5122@bogus>
 <7655fb41-cd13-0bc4-e656-040e0875bab8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7655fb41-cd13-0bc4-e656-040e0875bab8@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:38:17AM +0100, James Morse wrote:
> Hi guys,
>
> On 11/10/2019 11:05, Sudeep Holla wrote:
> > On Fri, Oct 11, 2019 at 11:26:04AM +0200, Marek Szyprowski wrote:
> >> Recently I've got access to ARM Juno R1 board and did some tests with
> >> current mainline kernel on it. I'm a bit surprised that enabling
> >> CONFIG_PROVE_LOCKING causes a boot failure on this board. After enabling
> >> this Kconfig option, I get no single message from the kernel, although I
> >> have earlycon enabled.
>
> > I don't have Juno R1 but I tried defconfig + CONFIG_PROVE_LOCKING and
> > it boots fine.
>
> I just tried this on my r1, v5.4-rc1 with this configuration worked just fine.
>
> My cmdline is:
> | root=/dev/sda6 loglevel=9 earlycon=pl011,0x7ff80000 hugepagesz=2M hugepages=512
> | crashkernel=1G console=ttyAMA0 resume=/dev/sda2 no_console_suspend efi=debug
>
>
> >> I've did my test with default defconfig and current linux-next,
> >> v5.4-rc1, v5.3 and v4.19. In all cases the result is the same. I'm
> >> booting kernel using a precompiled uboot from Linaro release and TFTP
> >> download.
>
> > OK, I use UEFI+GRUB but I don't think that should cause any issue.
>
> ... same ... this uboot binary looks like the main difference.
> Is it using u-boots UEFI support? Is it possible to turn that off?
>

Did give a quick try with mainline uboot on my Juno R2 and it boots fine.
Not sure if EFI support is default there. I am using vexpress_aemv8a_juno_defconfig

> It may that lockdep is just perturbing the size of the binary. It adds an
> extra 4MB for me.

The image size was 35MB.

I was thinking if it has some wrongly configured firmware, but since
defconfig works, it must have sane firmware.

--
Regards,
Sudeep
