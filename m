Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24FEC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF65520815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfEPOnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:43:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48250 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfEPOnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:43:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D5461715;
        Thu, 16 May 2019 07:43:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFD003F71E;
        Thu, 16 May 2019 07:43:06 -0700 (PDT)
Date:   Thu, 16 May 2019 15:43:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 2/3] arm64: implement update_fdt_pgprot()
Message-ID: <20190516144303.GF43059@lakrids.cambridge.arm.com>
References: <20190516102817.188519-1-hsinyi@chromium.org>
 <20190516102817.188519-2-hsinyi@chromium.org>
 <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 09:37:05AM -0500, Rob Herring wrote:
> On Thu, May 16, 2019 at 5:28 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Basically does similar things like __fixmap_remap_fdt(). It's supposed
> > to be called after fixmap_remap_fdt() is called at least once, so region
> > checking can be skipped. Since it needs to know dt physical address, make
> > a copy of the value of __fdt_pointer.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  arch/arm64/kernel/setup.c |  2 ++
> >  arch/arm64/mm/mmu.c       | 17 +++++++++++++++++
> >  2 files changed, 19 insertions(+)
> 
> Why not just map the FDT R/W at the start and change it to RO just
> before calling unflatten_device_tree? Then all the FDT scanning
> functions or any future fixups we need can just assume R/W. That is
> essentially what Stephen suggested. However, there's no need for a
> weak function as it can all be done within the arch code.
> 
> However, I'm still wondering why the FDT needs to be RO in the first place.

We want to preserve the original FDT in a pristine form for kexec (and
when exposed to userspace), and mapping it RO was the easiest way to
catch it being randomly modified (e.g. without fixups applied).

I'd prefer to keep it RO once we've removed/cleared certain properties
from the chosen node that don't make sense to pass on for kexec

Thanks,
Mark.
