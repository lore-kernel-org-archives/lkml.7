Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C4DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28914233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566574931;
	bh=BDjfteW/QU9KMSbRapMH7R8D4vRCcjKAbhun5quyEHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VXCYdzTiooODHdiTBMjSxyslSplSgHRZOfo8CsH4gTPyHeSvAIHlkoM+7mKq11WIe
	 UP8gBAvsj4JX0rz+0AoUwE827t8HpGHtAlJQPeFStlfjt8XNVw1ZNITI03IdnaQeKH
	 y7nOGmZfbwtavJDJPLk5A6nfWcjvoZnHG9dMoLZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405895AbfHWPmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:42:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbfHWPmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:42:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A1B621019;
        Fri, 23 Aug 2019 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566574928;
        bh=BDjfteW/QU9KMSbRapMH7R8D4vRCcjKAbhun5quyEHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKcFN0VRwM4eDlY9+q1YP1NyK92TfhpVYPLSA7KszQyoFiO3TUUaA5e73plzmSMGr
         1z1h+vmeQsi4l3fFTdxEG/DAdboXAfPBqj6JkL2fUd5obOBiA6P+d/xQhEs4ZLt1sk
         9olUyYc+Ulu+ot1ZnxtocySEJH/F8mJAUV4XgxPo=
Date:   Fri, 23 Aug 2019 16:41:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>, tytso@mit.edu
Cc:     linux-arm-kernel@lists.infradead.org,
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
Message-ID: <20190823154158.wgcnxfzpcttpnhga@willie-the-truck>
References: <20190823062452.127528-1-hsinyi@chromium.org>
 <20190823062452.127528-3-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823062452.127528-3-hsinyi@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 02:24:51PM +0800, Hsin-Yi Wang wrote:
> Introducing a chosen node, rng-seed, which is an entropy that can be
> passed to kernel called very early to increase initial device
> randomness. Bootloader should provide this entropy and the value is
> read from /chosen/rng-seed in DT.
> 
> Obtain of_fdt_crc32 for CRC check after early_init_dt_scan_nodes(),
> since early_init_dt_scan_chosen() would modify fdt to erase rng-seed.
> 
> Add a new interface add_bootloader_randomness() for rng-seed use case.
> Depends on whether the seed is trustworthy, rng seed would be passed to
> add_hwgenerator_randomness(). Otherwise it would be passed to
> add_device_randomness(). Decision is controlled by kernel config
> RANDOM_TRUST_BOOTLOADER.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Change from v9:
> * reword kconfig
> * use IS_ENABLED for config

Given that these aren't functional changes, I've kept Ted's ack from v9
and I'll queue these via arm64 assuming they pass testing.

Ted -- please shout if you're not happy about that, and I'll drop the
series.

Thanks,

Will
