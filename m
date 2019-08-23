Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC02EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38E02133F
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbfHWQIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:08:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57901 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732466AbfHWQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:08:07 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7NG6CTJ028584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 12:06:13 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 26F9942049E; Fri, 23 Aug 2019 12:06:12 -0400 (EDT)
Date:   Fri, 23 Aug 2019 12:06:12 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Will Deacon <will@kernel.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
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
Message-ID: <20190823160612.GJ8130@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Will Deacon <will@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
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
        Rik van Riel <riel@surriel.com>, Waiman Long <longman@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Grzegorz Halat <ghalat@redhat.com>, Len Brown <len.brown@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Yury Norov <ynorov@marvell.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Mukesh Ojha <mojha@codeaurora.org>, linux-kernel@vger.kernel.org
References: <20190823062452.127528-1-hsinyi@chromium.org>
 <20190823062452.127528-3-hsinyi@chromium.org>
 <20190823154158.wgcnxfzpcttpnhga@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823154158.wgcnxfzpcttpnhga@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 04:41:59PM +0100, Will Deacon wrote:
> 
> Given that these aren't functional changes, I've kept Ted's ack from v9
> and I'll queue these via arm64 assuming they pass testing.
> 
> Ted -- please shout if you're not happy about that, and I'll drop the
> series.

That's fine, thanks.  I'm thinking about making some changes to
add_hwgenerator_randomness(), but it's not going to be in the next
merge window, and it's more important that we get the interfaces (the
Kconfig options and add_bootloader_randomness() function prototype)
right for ARM.

Now to shanghai some volunteers to get this functionality working for
x86 (at least for the UEFI and NERF bootloaders).  :-)

Thanks!!

						- Ted
