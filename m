Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7AEC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A4F2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 05:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfEUFvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 01:51:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:48626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbfEUFvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 01:51:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3270AEE3;
        Tue, 21 May 2019 05:51:17 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 7F528E0184; Tue, 21 May 2019 07:51:17 +0200 (CEST)
Date:   Tue, 21 May 2019 07:51:17 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] kvm: make kvm_vcpu_(un)map dependency on
 CONFIG_HAS_IOMEM explicit
Message-ID: <20190521055117.GC25473@unicorn.suse.cz>
References: <20190520164418.06D1CE0184@unicorn.suse.cz>
 <CAOCOHw6rm1hvj1MDoMw=GArEafcPr-dnw4D18=baTcSdypbu0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCOHw6rm1hvj1MDoMw=GArEafcPr-dnw4D18=baTcSdypbu0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 03:45:29PM -0700, Bjorn Andersson wrote:
> On Mon, May 20, 2019 at 9:44 AM Michal Kubecek <mkubecek@suse.cz> wrote:
> >
> > Recently introduced functions kvm_vcpu_map() and kvm_vcpu_unmap() call
> > memremap() and memunmap() which are only available if HAS_IOMEM is enabled
> > but this dependency is not explicit, so that the build fails with HAS_IOMEM
> > disabled.
> >
> > As both function are only used on x86 where HAS_IOMEM is always enabled,
> > the easiest fix seems to be to only provide them when HAS_IOMEM is enabled.
> >
> > Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> 
> Hi Michal,
> 
> I see the same build issue on arm64 and as CONFIG_HAS_IOMEM is set
> there this patch has no effect on solving that. Instead I had to
> include linux/io.h in kvm_main.c to make it compile.

This sounds like a different problem which was already resolved in
mainline by commit c011d23ba046 ("kvm: fix compilation on aarch64")
which is present in v5.2-rc1. The issue I'm trying to address is link
time failure (unresolved reference to memremap()/memunmap()) when
CONFIG_HAS_IOMEM is disabled (in our case it affects a special
minimalistic s390x config for zfcpdump).

Michal
