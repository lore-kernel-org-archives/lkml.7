Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6902EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C0721738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 21:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="T4WqQqKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfDDVCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 17:02:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44688 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbfDDVCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 17:02:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id d24so3659427otl.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DrsGVUC4CyXvDtjSn1pg35i8ssXhg0MFwCOyyl15ho=;
        b=T4WqQqKYK6FMJ1y32LoSrxeA+KO0QpDj1ISaVQLh2tPAsPni+zmP0inWEuDw/xB3kI
         Dul6rR8vQ9Jja1D10S8Et2qKWkkRBsq3vpXJXWkhuhy7kmVr26AK5iOptICGkOJU4Ha1
         zH8tiyg15L76OrapwbxB9PcC+9PUAb9VtdUH8vz2PrwJnic3YlK+UJZKaSSEeIGG13yN
         OcMDzJPWEXqNJMaKjR3w1PsDXR07bPoic71WK+9UU6vnrEgpICixDNZdk5CeoxrPssK6
         Kl6St+YQJ1fKHQT8fi2KkJgdpGqfqCynTKB6y+WgNW2Q/iQKwoefucD8SjYzHt91iACR
         tkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DrsGVUC4CyXvDtjSn1pg35i8ssXhg0MFwCOyyl15ho=;
        b=TOMicoq1OOtQoCASfglWINOxHom/3mwz3E2l4csZwaY38IB3DS7JZ0uCBv8e0wFGvN
         5WtlmIUkx8UwHmq53ootZPLSLkvrY1H4UMURkeBB6pwquhGkjLDPdbxWsPOG2I4+TSFM
         AAvyzuLgmw5GMH0OOoI4yv1pZug8mAE1OJUVuSJ9aZc5jfmOYhfIEzjBqKKA0lO/dB3X
         kDjiHhF1OoH7lw0ufINLDToWE03/AyOzL9kht+62YorsC+WD9QgKuFYjU+5e5B/tzgNg
         CfxsLXCXwzKTODiHmVB9o0Mg//oUtN6yfZiQ2UYMPMjc+VQjRmOSEQEAYsy9H/hCkgnv
         MFWA==
X-Gm-Message-State: APjAAAVWnj3+JZIuN5qMLwC7N68PsuE8qYp6ezvrJ4AicEJYVaoqWKBC
        A+XPa5Yarn0EGza7Q4D4U3BZXKGJ0m18Xzfe5RZUgQ==
X-Google-Smtp-Source: APXvYqxIBXEFW2Oy96NM35Uo/yMBoE4dKe5/MW9hq8vfTI0GX74IQg8bFAmtM8KkdIDrIdLtElSUadW0IP3KmaaUMDI=
X-Received: by 2002:a9d:5c86:: with SMTP id a6mr5763686oti.118.1554411761776;
 Thu, 04 Apr 2019 14:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440491849.3190322.17551464505265122881.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190404193211.GK22763@bombadil.infradead.org>
In-Reply-To: <20190404193211.GK22763@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 4 Apr 2019 14:02:30 -0700
Message-ID: <CAPcyv4hruLHWpEq_fT=_uFeO8X6KLjLsR2=s577iXey+NUFz4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] lib/memregion: Uplevel the pmem "region" ida to a
 global allocator
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 12:32 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Apr 04, 2019 at 12:08:38PM -0700, Dan Williams wrote:
> > +++ b/lib/Kconfig
> > @@ -318,6 +318,12 @@ config DECOMPRESS_LZ4
> >  config GENERIC_ALLOCATOR
> >       bool
> >
> > +#
> > +# Generic IDA for memory regions
> > +#
>
> Leaky abstraction -- nobody needs know that it's implemented as an IDA.
> Suggest:
>
> # Memory region ID allocation
>

Looks good to me.

> ...
>
> > +++ b/lib/memregion.c
> > @@ -0,0 +1,22 @@
> > +#include <linux/idr.h>
> > +#include <linux/module.h>
> > +
> > +static DEFINE_IDA(region_ida);
> > +
> > +int memregion_alloc(void)
> > +{
> > +     return ida_simple_get(&region_ida, 0, 0, GFP_KERNEL);
> > +}
> > +EXPORT_SYMBOL(memregion_alloc);
> > +
> > +void memregion_free(int id)
> > +{
> > +     ida_simple_remove(&region_ida, id);
> > +}
> > +EXPORT_SYMBOL(memregion_free);
> > +
> > +static void __exit memregion_exit(void)
> > +{
> > +     ida_destroy(&region_ida);
> > +}
> > +module_exit(memregion_exit);
>
>  - Should these be EXPORT_SYMBOL_GPL?

I don't see the need. These are simple wrappers around existing
EXPORT_SYMBOL() exports, and there's little concern that these
interfaces might disappear in the future causing us pain with out of
tree modules as these don't touch anything in the core.

>  - Can we use the new interface, ida_alloc() and ida_free()?

Sure.

>  - Do we really want memregion_exit() to happen while there are still IDs
>    allocated in the IDA?  I think this might well be better as:
>
>         BUG_ON(!ida_empty(&region_ida));

True, or just delete the module_exit because this functionality can't
be built as a module, so the exit path is already dead code.

> Also, do we really want to call the structure the region_ida?  Why not
> region_ids?

Sure, sounds good.
