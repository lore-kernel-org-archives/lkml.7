Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E209FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CBC206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553628874;
	bh=/KBG1Y6DveuMq0Zr4sxYKpDClR/xgbJ7AmXr4IPbNWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1Sh4PG2JnYLpT7hl8ODZT+9VZV5ArqK8q9UFWHJpeBlcudBNkSA0ruh9ylkSQU6PH
	 EgdnqOiPSozjRQ/g7vRV4gqUPpHCxTfB0Ar4PVFNO/iypb7zLz3LXCFcxja9CdygrU
	 eWwExjJrG4bdeSTRNqIQpza2fRiQzrLmtiNQVU8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732057AbfCZTed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCZTed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:34:33 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D533C20823;
        Tue, 26 Mar 2019 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553628872;
        bh=/KBG1Y6DveuMq0Zr4sxYKpDClR/xgbJ7AmXr4IPbNWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=enhrMGV326WWllTxiJ09sa3zh041IZM1VPlz/khoxns7qHl1jVgoGSkDMJ91reGgx
         KIab5mm3K620BLSCvEXEvJMi+iX02jOikR3+WV6XgI00+CIEK/7jBKRY6U1oWRro1C
         XJKEwyZ5TgjEAgZ4B+N219+Y/NBIPsrAZcThtDyM=
Received: by mail-ed1-f44.google.com with SMTP id d26so11834221ede.10;
        Tue, 26 Mar 2019 12:34:31 -0700 (PDT)
X-Gm-Message-State: APjAAAV9KyxqTrwH8OhWjSfzO/WEeWououW21Ol7GxOIrGO4kfxGNACe
        CUWdVIAdcu/5w0bHyl1MHjw+bvu7dWtP2+k5tdk=
X-Google-Smtp-Source: APXvYqyMylqv9pgdmhE3kW/TzFmhTC/UF+45a5V/WooVJXJJuTFyoOm1/XHBnPCAMWlcyxzL6Qp0vpVxP+sJXFExpOk=
X-Received: by 2002:aa7:c70a:: with SMTP id i10mr21594763edq.153.1553628870403;
 Tue, 26 Mar 2019 12:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-4-git-send-email-hao.wu@intel.com> <127a9356a7bf597d35dd361f2b16bf80460f0370.camel@redhat.com>
 <655bf2991a4f8bf6a473c91218d6dba7748520aa.camel@redhat.com>
In-Reply-To: <655bf2991a4f8bf6a473c91218d6dba7748520aa.camel@redhat.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 26 Mar 2019 14:33:54 -0500
X-Gmail-Original-Message-ID: <CANk1AXSBHAudsLfNkSK1OuE6R9bogo6jW9bYmmZdvweTt3eCiA@mail.gmail.com>
Message-ID: <CANk1AXSBHAudsLfNkSK1OuE6R9bogo6jW9bYmmZdvweTt3eCiA@mail.gmail.com>
Subject: Re: [PATCH 03/17] fpga: dfl: fme: support 512bit data width PR
To:     Scott Wood <swood@redhat.com>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:58 PM Scott Wood <swood@redhat.com> wrote:

Hi Scott,

>
> On Mon, 2019-03-25 at 17:53 -0500, Scott Wood wrote:
> > On Mon, 2019-03-25 at 11:07 +0800, Wu Hao wrote:
> > > In early partial reconfiguration private feature, it only
> > > supports 32bit data width when writing data to hardware for
> > > PR. 512bit data width PR support is an important optimization
> > > for some specific solutions (e.g. XEON with FPGA integrated),
> > > it allows driver to use AVX512 instruction to improve the
> > > performance of partial reconfiguration. e.g. programming one
> > > 100MB bitstream image via this 512bit data width PR hardware
> > > only takes ~300ms, but 32bit revision requires ~3s per test
> > > result.
> > >
> > > Please note now this optimization is only done on revision 2
> > > of this PR private feature which is only used in integrated
> > > solution that AVX512 is always supported.
> > >
> > > Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > ---
> > >  drivers/fpga/dfl-fme-main.c |  3 ++
> > >  drivers/fpga/dfl-fme-mgr.c  | 75 +++++++++++++++++++++++++++++++++++++-
> > > --
> > > -----
> > >  drivers/fpga/dfl-fme-pr.c   | 45 ++++++++++++++++-----------
> > >  drivers/fpga/dfl-fme.h      |  2 ++
> > >  drivers/fpga/dfl.h          |  5 +++
> > >  5 files changed, 99 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > > index 086ad24..076d74f 100644
> > > --- a/drivers/fpga/dfl-fme-main.c
> > > +++ b/drivers/fpga/dfl-fme-main.c
> > > @@ -21,6 +21,8 @@
> > >  #include "dfl.h"
> > >  #include "dfl-fme.h"
> > >
> > > +#define DRV_VERSION        "0.8"
> >
> > What is this going to be used for?  Under what circumstances will the
> > driver version be bumped?  What does it have to do with 512-bit writes?
> >
> > > +#if defined(CONFIG_X86) && defined(CONFIG_AS_AVX512)
> > > +
> > > +#include <asm/fpu/api.h>
> > > +
> > > +static inline void copy512(void *src, void __iomem *dst)
> > > +{
> > > +   kernel_fpu_begin();
> > > +
> > > +   asm volatile("vmovdqu64 (%0), %%zmm0;"
> > > +                "vmovntdq %%zmm0, (%1);"
> > > +                :
> > > +                : "r"(src), "r"(dst));
> > > +
> > > +   kernel_fpu_end();
> > > +}
> >
> > Shouldn't there be some sort of check that AVX512 is actually supported
> > on the running system?
> >
> > Also, src should be const, and the asm statement should have a memory
> > clobber.
> >
> > > +#else
> > > +static inline void copy512(void *src, void __iomem *dst)
> > > +{
> > > +   WARN_ON_ONCE(1);
> > > +}
> > > +#endif
> >
> > Likewise, this will be called if a revision 2 device is used on non-x86
> > (or on x86 with an old binutils).  The driver should fall back to 32-bit
> > in such cases.
>
> Sorry, I missed the comment about revision 2 only being on integrated
> devices -- but will that always be the case?  Seems worthwhile to check for
> AVX512 support anyway.  And there's still the possibility of being built
> with an old binutils such that CONFIG_AS_AVX512 is not set, or running on a
> kernel where avx512 was disabled via a boot option.

The code checks for CONFIG_AS_AVX512 above.

What boot option are you referring to?

Alan

>
> What about future revisions >= 2?  Currently the driver will treat them as
> if they were revision < 2.  Is that intended?
>
> -Scott
>
>
