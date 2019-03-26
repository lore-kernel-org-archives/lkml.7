Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4A2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C118F2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbfCZVWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:22:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfCZVWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:22:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE3AF30718C1;
        Tue, 26 Mar 2019 21:22:35 +0000 (UTC)
Received: from ovpn-118-18.phx2.redhat.com (ovpn-118-18.phx2.redhat.com [10.3.118.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6E9960160;
        Tue, 26 Mar 2019 21:22:34 +0000 (UTC)
Message-ID: <580c6c604d3915c105f076fc7f22ab5da98598fc.camel@redhat.com>
Subject: Re: [PATCH 03/17] fpga: dfl: fme: support 512bit data width PR
From:   Scott Wood <swood@redhat.com>
To:     Alan Tull <atull@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Date:   Tue, 26 Mar 2019 16:22:34 -0500
In-Reply-To: <CANk1AXSBHAudsLfNkSK1OuE6R9bogo6jW9bYmmZdvweTt3eCiA@mail.gmail.com>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
         <1553483264-5379-4-git-send-email-hao.wu@intel.com>
         <127a9356a7bf597d35dd361f2b16bf80460f0370.camel@redhat.com>
         <655bf2991a4f8bf6a473c91218d6dba7748520aa.camel@redhat.com>
         <CANk1AXSBHAudsLfNkSK1OuE6R9bogo6jW9bYmmZdvweTt3eCiA@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 26 Mar 2019 21:22:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 14:33 -0500, Alan Tull wrote:
> On Mon, Mar 25, 2019 at 5:58 PM Scott Wood <swood@redhat.com> wrote:
> 
> Hi Scott,
> 
> > On Mon, 2019-03-25 at 17:53 -0500, Scott Wood wrote:
> > > On Mon, 2019-03-25 at 11:07 +0800, Wu Hao wrote:
> > > > +#if defined(CONFIG_X86) && defined(CONFIG_AS_AVX512)
> > > > +
> > > > +#include <asm/fpu/api.h>
> > > > +
> > > > +static inline void copy512(void *src, void __iomem *dst)
> > > > +{
> > > > +   kernel_fpu_begin();
> > > > +
> > > > +   asm volatile("vmovdqu64 (%0), %%zmm0;"
> > > > +                "vmovntdq %%zmm0, (%1);"
> > > > +                :
> > > > +                : "r"(src), "r"(dst));
> > > > +
> > > > +   kernel_fpu_end();
> > > > +}
> > > 
> > > Shouldn't there be some sort of check that AVX512 is actually
> > > supported
> > > on the running system?
> > > 
> > > Also, src should be const, and the asm statement should have a memory
> > > clobber.
> > > 
> > > > +#else
> > > > +static inline void copy512(void *src, void __iomem *dst)
> > > > +{
> > > > +   WARN_ON_ONCE(1);
> > > > +}
> > > > +#endif
> > > 
> > > Likewise, this will be called if a revision 2 device is used on non-
> > > x86
> > > (or on x86 with an old binutils).  The driver should fall back to 32-
> > > bit
> > > in such cases.
> > 
> > Sorry, I missed the comment about revision 2 only being on integrated
> > devices -- but will that always be the case?  Seems worthwhile to check
> > for
> > AVX512 support anyway.  And there's still the possibility of being built
> > with an old binutils such that CONFIG_AS_AVX512 is not set, or running
> > on a
> > kernel where avx512 was disabled via a boot option.
> 
> The code checks for CONFIG_AS_AVX512 above.

That just indicates that binutils supports it.  Plus, the code does not
check for CONFIG_AS_AVX512 when deciding whether to set pr_datawidth to 64
(and thus call copy512), so you'll get a WARN_ON rather than falling back to
32-bit.

> What boot option are you referring to?

clearcpuid=304

-Scott


