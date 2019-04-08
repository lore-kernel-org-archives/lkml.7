Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07644C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C663120883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDHGdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:33:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51363 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHGdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:33:40 -0400
Received: from p5492ee6e.dip0.t-ipconnect.de ([84.146.238.110] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hDNpr-0002VI-W7; Mon, 08 Apr 2019 08:32:52 +0200
Date:   Mon, 8 Apr 2019 08:32:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
cc:     Hanjun Guo <guohanjun@huawei.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        x86 <x86@kernel.org>, linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] normalize IOMMU dma mode boot options
In-Reply-To: <5CAABD03.9000301@huawei.com>
Message-ID: <alpine.DEB.2.21.1904080829490.1840@nanos.tec.linutronix.de>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com> <b20fd8a6-88ce-7d26-8eb0-ed9f095988a6@huawei.com> <5CAABD03.9000301@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019, Leizhen (ThunderTown) wrote:
> > 
> > This will break systems using boot options as now, and I think
> > this is unacceptable. If you want to do so, just introduce iommu.dma_mode
> > on top of those iommu boot options with dma mode boot options unchanged,
> > and iommu.dma_mode is for all archs but compatible with them.
> 
> I just changed the boot options name, but keep the function no change. I added
> all related maintainers/supporters in the "to=" list, maybe we can disuss this.

Changing the name _IS_ the problem. Think about unattended updates.

> Should I add some "obsoleted" warnings for old options and keep them for a while?

No, just keep the old options around for backwards compatibilty sake. We
just do not add new arch specific options in the future. New options need
to use the generic iommu.dma_mode name space.

Thanks,

	tglx
