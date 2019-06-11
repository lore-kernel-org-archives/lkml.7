Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79452C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B350206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390988AbfFKOg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:36:57 -0400
Received: from foss.arm.com ([217.140.110.172]:34522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387551AbfFKOg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:36:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 093FC346;
        Tue, 11 Jun 2019 07:36:56 -0700 (PDT)
Received: from [10.1.29.141] (e121487-lin.cambridge.arm.com [10.1.29.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187C33F557;
        Tue, 11 Jun 2019 07:36:54 -0700 (PDT)
Subject: Re: [PATCH 02/17] mm: stub out all of swapops.h for !CONFIG_MMU
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190610221621.10938-1-hch@lst.de>
 <20190610221621.10938-3-hch@lst.de>
 <516c8def-22db-027c-873d-a943454e33af@arm.com>
 <20190611141841.GA29151@lst.de>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <80d01a1d-b6b0-18e8-811c-71af14cba3b9@arm.com>
Date:   Tue, 11 Jun 2019 15:36:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611141841.GA29151@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 3:18 PM, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 11:15:44AM +0100, Vladimir Murzin wrote:
>> On 6/10/19 11:16 PM, Christoph Hellwig wrote:
>>> The whole header file deals with swap entries and PTEs, none of which
>>> can exist for nommu builds.
>>
>> Although I agree with the patch, I'm wondering how you get into it?
> 
> Without that the RISC-V nommu blows up like this:
> 
> 
> In file included from mm/vmscan.c:58:
> ./include/linux/swapops.h: In function ‘pte_to_swp_entry’:
> ./include/linux/swapops.h:71:15: error: implicit declaration of function ‘__pte_to_swp_entry’; did you mean ‘pte_to_swp_entry’? [-Werror=implicit-function-declaration]
>   arch_entry = __pte_to_swp_entry(pte);
>                ^~~~~~~~~~~~~~~~~~
>                pte_to_swp_entry
> ./include/linux/swapops.h:71:13: error: incompatible types when assigning to type ‘swp_entry_t’ {aka ‘struct <anonymous>’} from type ‘int’
>   arch_entry = __pte_to_swp_entry(pte);
>              ^
> ./include/linux/swapops.h:72:19: error: implicit declaration of function ‘__swp_type’; did you mean ‘swp_type’? [-Werror=implicit-function-declaration]
>   return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
>                    ^~~~~~~~~~
>                    swp_type
> ./include/linux/swapops.h:72:43: error: implicit declaration of function ‘__swp_offset’; did you mean ‘swp_offset’? [-Werror=implicit-function-declaration]
>   return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
>                                            ^~~~~~~~~~~~
>                                            swp_offset
> ./include/linux/swapops.h: In function ‘swp_entry_to_pte’:
> ./include/linux/swapops.h:83:15: error: implicit declaration of function ‘__swp_entry’; did you mean ‘swp_entry’? [-Werror=implicit-function-declaration]
>   arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
>                ^~~~~~~~~~~
>                swp_entry
> ./include/linux/swapops.h:83:13: error: incompatible types when assigning to type ‘swp_entry_t’ {aka ‘struct <anonymous>’} from type ‘int’
>   arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
>              ^
> ./include/linux/swapops.h:84:9: error: implicit declaration of function ‘__swp_entry_to_pte’; did you mean ‘swp_entry_to_pte’? [-Werror=implicit-function-declaration]
>   return __swp_entry_to_pte(arch_entry);
>          ^~~~~~~~~~~~~~~~~~
>          swp_entry_to_pte
> ./include/linux/swapops.h:84:9: error: incompatible types when returning type ‘int’ but ‘pte_t’ {aka ‘struct <anonymous>’} was expected
>   return __swp_entry_to_pte(arch_entry);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[1]: *** [scripts/Makefile.build:278: mm/vmscan.o] Error 1
> make: *** [Makefile:1071: mm] Error 2
> make: *** Waiting for unfinished jobs....
> 

It looks like NOMMU ports tend to define those. For ARM they are:

#define __swp_type(x)           (0)
#define __swp_offset(x)         (0)
#define __swp_entry(typ,off)    ((swp_entry_t) { ((typ) | ((off) << 7)) })
#define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
#define __swp_entry_to_pte(x)   ((pte_t) { (x).val })

Anyway, I have no strong opinion on which is better :)

Cheers
Vladimir
