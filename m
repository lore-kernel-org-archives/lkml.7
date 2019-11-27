Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963FAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FC420722
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfK0PO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:14:29 -0500
Received: from foss.arm.com ([217.140.110.172]:48926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbfK0PO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:14:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 158B0328;
        Wed, 27 Nov 2019 07:14:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 544BC3F68E;
        Wed, 27 Nov 2019 07:14:25 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:14:23 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        xen-devel@lists.xenproject.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 2/3] arm64: remove uaccess_ttbr0 asm macros from cache
 functions
Message-ID: <20191127151423.GD51937@lakrids.cambridge.arm.com>
References: <20191122022406.590141-1-pasha.tatashin@soleen.com>
 <20191122022406.590141-3-pasha.tatashin@soleen.com>
 <20191127150137.GB51937@lakrids.cambridge.arm.com>
 <CA+CK2bBvgDe5zVur7EYJgYhoZesuQkZVeyRxPCBSySqsR=-YPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBvgDe5zVur7EYJgYhoZesuQkZVeyRxPCBSySqsR=-YPQ@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:10:07AM -0500, Pavel Tatashin wrote:
> Hi Mark,
> 
> Thank you for reviewing this work.
 
> > The 'arch_' prefix should probably be 'asm_' (or have an '_asm' suffix),
> > since this is entirely local to the arch code, and even then should only
> > be called from the C wrappers.
> 
> Sure, I can change it to asm_*, I was using arch_* to be consistent
> with __arch_copy_from_user() and friends.

FWIW, that naming was from before the common uaccess code took on the
raw_* anming for the arch functions, and I was expecting that the arch_*
functions would end up being called from core code.

For now it's probably too churny to change that existing case.

Thanks,
Mark.
