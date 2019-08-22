Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1756C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8549922DD3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfHVBbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 21:31:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730328AbfHVBbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:31:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3BE710F23EC;
        Thu, 22 Aug 2019 01:31:04 +0000 (UTC)
Received: from localhost (ovpn-12-48.pek2.redhat.com [10.72.12.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C02EA3DB3;
        Thu, 22 Aug 2019 01:31:03 +0000 (UTC)
Date:   Thu, 22 Aug 2019 09:31:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com, Dave Jiang <dave.jiang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
Message-ID: <20190822013100.GC2588@MiWiFi-R3L-srv>
References: <1565991345.8572.28.camel@lca.pw>
 <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
 <0FB85A78-C2EE-4135-9E0F-D5623CE6EA47@lca.pw>
 <CAPcyv4h9Y7wSdF+jnNzLDRobnjzLfkGLpJsML2XYLUZZZUPsQA@mail.gmail.com>
 <E7A04694-504D-4FB3-9864-03C2CBA3898E@lca.pw>
 <CAPcyv4gofF-Xf0KTLH4EUkxuXdRO3ha-w+GoxgmiW7gOdS2nXQ@mail.gmail.com>
 <0AC959D7-5BCB-4A81-BBDC-990E9826EB45@lca.pw>
 <1566421927.5576.3.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566421927.5576.3.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 22 Aug 2019 01:31:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/19 at 05:12pm, Qian Cai wrote:
> > > Does disabling CONFIG_RANDOMIZE_BASE help? Maybe that workaround has
> > > regressed. Effectively we need to find what is causing the kernel to
> > > sometimes be placed in the middle of a custom reserved memmap= range.
> > 
> > Yes, disabling KASLR works good so far. Assuming the workaround, i.e.,
> > f28442497b5c
> > (“x86/boot: Fix KASLR and memmap= collision”) is correct.
> > 
> > The only other commit that might regress it from my research so far is,
> > 
> > d52e7d5a952c ("x86/KASLR: Parse all 'memmap=' boot option entries”)
> > 
> 
> It turns out that the origin commit f28442497b5c (“x86/boot: Fix KASLR and
> memmap= collision”) has a bug that is unable to handle "memmap=" in
> CONFIG_CMDLINE instead of a parameter in bootloader because when it (as well as
> the commit d52e7d5a952c) calls get_cmd_line_ptr() in order to run
> mem_avoid_memmap(), "boot_params" has no knowledge of CONFIG_CMDLINE. Only later
> in setup_arch(), the kernel will deal with parameters over there.

Yes, we didn't consider CONFIG_CMDLINE during boot compressing stage. It
should be a generic issue since other parameters from CONFIG_CMDLINE could
be ignored too, not only KASLR handling. Would you like to cast a patch
to fix it? Or I can fix it later, maybe next week.

Thanks
Baoquan
