Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1DECA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9922087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfJaMAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:00:25 -0400
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:41929 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbfJaMAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:00:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5C90518081312;
        Thu, 31 Oct 2019 12:00:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cub46_2047b2e81a122
X-Filterd-Recvd-Size: 2173
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 31 Oct 2019 12:00:21 +0000 (UTC)
Message-ID: <be4803c67e2e1f9e91e59bfd7b23f938619f66e8.camel@perches.com>
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() +
 WARN_ON_ONCE()
From:   Joe Perches <joe@perches.com>
To:     zhong jiang <zhongjiang@huawei.com>, Borislav Petkov <bp@alien8.de>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 31 Oct 2019 05:00:13 -0700
In-Reply-To: <5DBAC74E.5080001@huawei.com>
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com>
         <20191031110304.GE21133@nazgul.tnic> <5DBAC74E.5080001@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-31 at 19:36 +0800, zhong jiang wrote:
> On 2019/10/31 19:03, Borislav Petkov wrote:
> > On Wed, Oct 30, 2019 at 04:57:18PM +0800, zhong jiang wrote:
> > > WARN_ONCE is more clear and simpler. Just replace it.
[]
> > > diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
[]
> > > @@ -172,9 +172,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
> > >  		return NULL;
> > >  
> > >  	if (!phys_addr_valid(phys_addr)) {
> > > -		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
> > > -		       (unsigned long long)phys_addr);
> > > -		WARN_ON_ONCE(1);
> > > +		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
> > > +			  (unsigned long long)phys_addr);
> > Does
> > 	WARN_ONCE(!phys_addr_valid(phys_addr),
> > 		  "ioremap: invalid physical address %llx\n",
> > 		  (unsigned long long)phys_addr);
> > 
> > work too?
> > 
> Thanks, That is better. Will repost.

Perhaps this is not good patch concept as now each
invalid physical address will not be emitted.

Before:
	each invalid physical address printed
	one stack dump

After:
	one stck dump with first invalid physical address.


