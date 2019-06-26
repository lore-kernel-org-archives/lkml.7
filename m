Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F8FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8690C20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfFZMB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:01:56 -0400
Received: from foss.arm.com ([217.140.110.172]:59558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfFZMBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:01:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC56360;
        Wed, 26 Jun 2019 05:01:55 -0700 (PDT)
Received: from [10.162.40.140] (p8cg001049571a15.blr.arm.com [10.162.40.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A35C3F718;
        Wed, 26 Jun 2019 05:01:53 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190626214125.6d313c15@canb.auug.org.au>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9e850319-8564-5b1f-2e1b-7d327215043f@arm.com>
Date:   Wed, 26 Jun 2019 17:32:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190626214125.6d313c15@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

On 06/26/2019 05:11 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the akpm-current tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ld: lib/ioremap.o: in function `.ioremap_huge_init':
> ioremap.c:(.init.text+0x3c): undefined reference to `.arch_ioremap_p4d_supported'

I believe this might be caused by a patch for powerpc enabling HAVE_ARCH_HUGE_VMAP
without an arch_ioremap_p4d_supported() definition.

> 
> Caused by commit
> 
>   749940680d0b ("mm/ioremap: probe platform for p4d huge map support")
> 
> I have reverted that commit for today.

All it needs is a powerpc definition for arch_ioremap_p4d_supported() which can just
return false if it is not supported. Shall I send a patch for the powerpc fix or just
re-spin the original patch which added arch_ioremap_p4d_supported(). Please suggest.

Today's linux-next (next-20190625) does not have powerpc subscribing HAVE_ARCH_HUGE_VMAP.
Could you please point to the branch I should pull for this failure. Thanks !

- Anshuman

