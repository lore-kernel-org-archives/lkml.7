Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC54C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595692080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392747AbfITP2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:28:22 -0400
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:52282 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729019AbfITP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:28:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8364D18224510;
        Fri, 20 Sep 2019 15:28:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rings76_2abf686031616
X-Filterd-Recvd-Size: 2580
Received: from XPS-9350 (unknown [113.22.183.150])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Sep 2019 15:28:13 +0000 (UTC)
Message-ID: <0f291158f7d788c001212bcbb13843fbff571eeb.camel@perches.com>
Subject: Re: [PATCH 07/32] x86: Use pr_warn instead of pr_warning
From:   Joe Perches <joe@perches.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Robert Richter <rric@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Date:   Fri, 20 Sep 2019 08:28:11 -0700
In-Reply-To: <7a517b43-7e86-79ba-5954-dd746c309c87@huawei.com>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
         <20190920062544.180997-8-wangkefeng.wang@huawei.com>
         <20190920092850.26usohzmatmqrlor@rric.localdomain>
         <7a517b43-7e86-79ba-5954-dd746c309c87@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-20 at 19:57 +0800, Kefeng Wang wrote:
> On 2019/9/20 17:28, Robert Richter wrote:
> > On 20.09.19 14:25:19, Kefeng Wang wrote:
> > > As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> > > pr_warning"), removing pr_warning so all logging messages use a
> > > consistent <prefix>_warn style. Let's do it.
[]
> > > diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
[]
> > > @@ -665,7 +664,7 @@ static __init int init_amd_gatt(struct agp_kern_info *info)
> > >  
> > >   nommu:
> > >  	/* Should not happen anymore */
> > > -	pr_warning("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
> > > +	pr_warn("PCI-DMA: More than 4GB of RAM and no IOMMU\n"
> > >  	       "falling back to iommu=soft.\n");
> > This indentation should be fixed too, while at it.
> Will update later, thanks.

trivia:

likely better as a single line output:

	pr_warn("PCI-DMA: More than 4GB of RAM and no IOMMU - falling back to iommu=soft\n");


