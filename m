Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2003AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97A422CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566577893;
	bh=4uBDuZ3Lx8Vomf88LW9Ys3zz8BLIBREusiqkQZzWd8w=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=lqAm4RG9IBhEOpDKsVpBiOfgFXfcczUuY9jGt/OdsT1yye7ljSNvzupEy7dcyYUNn
	 lV5y/eBFtJDdppHuHghcnAvtK1HNel+a62S7tP8YO39H32pSMHvqLS34wBFpPWzhNZ
	 U0ofaG3+/BpT5zJB9UOAIho07jNIvPAvEKC9z2u8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436735AbfHWQbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388826AbfHWQbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:31:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B8F121726;
        Fri, 23 Aug 2019 16:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566577890;
        bh=4uBDuZ3Lx8Vomf88LW9Ys3zz8BLIBREusiqkQZzWd8w=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=mjkSYr6RmiJC0GhN33dx0Y3/zSAByRHlsEKmu6fOigOuNFSZqNX1xcy6b0B/D2QMR
         KHG0jgYo5rJdQf1/MaBxU5BtYRTHeNGcjORLFJmjaPgGkB61hJ+BWtbaVZ26AJv56a
         IgOTyFJ3OijaXpACpkByjE3E5wY6wK8MYLijoeCQ=
Date:   Fri, 23 Aug 2019 17:31:20 +0100
From:   Will Deacon <will@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Li <liwei391@huawei.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Waiman Long <longman@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Grzegorz Halat <ghalat@redhat.com>,
        Len Brown <len.brown@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yury Norov <ynorov@marvell.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/3] fdt: add support for rng-seed
Message-ID: <20190823163120.fojtvjfat2ymxoeo@willie-the-truck>
References: <20190823160612.GJ8130@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823160612.GJ8130@mit.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 12:06:12PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Aug 23, 2019 at 04:41:59PM +0100, Will Deacon wrote:
> > 
> > Given that these aren't functional changes, I've kept Ted's ack from v9
> > and I'll queue these via arm64 assuming they pass testing.
> > 
> > Ted -- please shout if you're not happy about that, and I'll drop the
> > series.
> 
> That's fine, thanks.  I'm thinking about making some changes to
> add_hwgenerator_randomness(), but it's not going to be in the next
> merge window, and it's more important that we get the interfaces (the
> Kconfig options and add_bootloader_randomness() function prototype)
> right for ARM.

Well, on the off-chance that you do need it, I've stuck the series on its
own branch anyway so you can pull in elsewhere if necessary:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/rng

> Now to shanghai some volunteers to get this functionality working for
> x86 (at least for the UEFI and NERF bootloaders).  :-)

Hehe, good luck!

Will
