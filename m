Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A23C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653DD205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfCVIW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:22:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10469 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfCVIW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:22:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F2B8C057F3E;
        Fri, 22 Mar 2019 08:22:26 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-25.pek2.redhat.com [10.72.13.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7EC15D9C5;
        Fri, 22 Mar 2019 08:22:20 +0000 (UTC)
Date:   Fri, 22 Mar 2019 16:22:16 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Joerg Roedel <jroedel@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190322082216.GA23356@dhcp-128-65.nay.redhat.com>
References: <20190220094146.GA8597@dhcp-128-65.nay.redhat.com>
 <20190221171321.GD12997@zn.tnic>
 <20190222021101.GA11654@dhcp-128-65.nay.redhat.com>
 <20190222084241.GC8380@suse.de>
 <20190222130026.GA30766@zn.tnic>
 <20190225110043.GA5884@suse.de>
 <20190225111216.GA9276@dhcp-128-65.nay.redhat.com>
 <20190225113003.GE26145@zn.tnic>
 <CAFgQCTvP-YDUEcHTgupr+ar+qeoj5rw1y8k+6kzrzHPzTqBkaw@mail.gmail.com>
 <CAFgQCTs9pJ=3Jt1YLv6RmBWeViH8cmuMcKG+2Aj-Vo2Kh-Wcog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTs9pJ=3Jt1YLv6RmBWeViH8cmuMcKG+2Aj-Vo2Kh-Wcog@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 22 Mar 2019 08:22:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pingfan, 

Thanks for the effort,
On 03/01/19 at 11:19am, Pingfan Liu wrote:
> On Fri, Mar 1, 2019 at 11:04 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > Hi Borislav,
> >
> > Do you think the following patch is good at present?
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 81f9d23..9213073 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -460,7 +460,7 @@ static void __init
> > memblock_x86_reserve_range_setup_data(void)
> >  # define CRASH_ADDR_LOW_MAX    (512 << 20)
> >  # define CRASH_ADDR_HIGH_MAX   (512 << 20)
> >  #else
> > -# define CRASH_ADDR_LOW_MAX    (896UL << 20)
> > +# define CRASH_ADDR_LOW_MAX    (1 << 32)
> >  # define CRASH_ADDR_HIGH_MAX   MAXMEM
> >  #endif
> >
> Or patch lools like:
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3d872a5..ed0def5 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -459,7 +459,7 @@ static void __init
> memblock_x86_reserve_range_setup_data(void)
>  # define CRASH_ADDR_LOW_MAX    (512 << 20)
>  # define CRASH_ADDR_HIGH_MAX   (512 << 20)
>  #else
> -# define CRASH_ADDR_LOW_MAX    (896UL << 20)
> +# define CRASH_ADDR_LOW_MAX    (1 << 32)
>  # define CRASH_ADDR_HIGH_MAX   MAXMEM
>  #endif
> 
> @@ -551,6 +551,15 @@ static void __init reserve_crashkernel(void)
>                                                     high ? CRASH_ADDR_HIGH_MAX
>                                                          : CRASH_ADDR_LOW_MAX,
>                                                     crash_size, CRASH_ALIGN);
> +#ifdef CONFIG_X86_64
> +               /*
> +                * crashkernel=X reserve below 4G fails? Try MAXMEM
> +                */
> +               if (!high && !crash_base)
> +                       crash_base = memblock_find_in_range(CRASH_ALIGN,
> +                                               CRASH_ADDR_HIGH_MAX,
> +                                               crash_size, CRASH_ALIGN);
> +#endif
> 
> which tries 0-4G, the fall back to 4G above

This way looks good to me, I will do some testing with old kexec-tools,
Once testing done I can take up this again and repost later with some documentation
update.  Also will split to 2 patches  one to drop the old limitation,
another for the fallback.

Thanks
Dave
