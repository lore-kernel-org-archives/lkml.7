Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A64C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1C7205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbfFKOTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:19:11 -0400
Received: from verein.lst.de ([213.95.11.211]:51618 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387551AbfFKOTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:19:11 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3E91868B02; Tue, 11 Jun 2019 16:18:42 +0200 (CEST)
Date:   Tue, 11 Jun 2019 16:18:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] mm: stub out all of swapops.h for !CONFIG_MMU
Message-ID: <20190611141841.GA29151@lst.de>
References: <20190610221621.10938-1-hch@lst.de> <20190610221621.10938-3-hch@lst.de> <516c8def-22db-027c-873d-a943454e33af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <516c8def-22db-027c-873d-a943454e33af@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:15:44AM +0100, Vladimir Murzin wrote:
> On 6/10/19 11:16 PM, Christoph Hellwig wrote:
> > The whole header file deals with swap entries and PTEs, none of which
> > can exist for nommu builds.
> 
> Although I agree with the patch, I'm wondering how you get into it?

Without that the RISC-V nommu blows up like this:


In file included from mm/vmscan.c:58:
./include/linux/swapops.h: In function ‘pte_to_swp_entry’:
./include/linux/swapops.h:71:15: error: implicit declaration of function ‘__pte_to_swp_entry’; did you mean ‘pte_to_swp_entry’? [-Werror=implicit-function-declaration]
  arch_entry = __pte_to_swp_entry(pte);
               ^~~~~~~~~~~~~~~~~~
               pte_to_swp_entry
./include/linux/swapops.h:71:13: error: incompatible types when assigning to type ‘swp_entry_t’ {aka ‘struct <anonymous>’} from type ‘int’
  arch_entry = __pte_to_swp_entry(pte);
             ^
./include/linux/swapops.h:72:19: error: implicit declaration of function ‘__swp_type’; did you mean ‘swp_type’? [-Werror=implicit-function-declaration]
  return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
                   ^~~~~~~~~~
                   swp_type
./include/linux/swapops.h:72:43: error: implicit declaration of function ‘__swp_offset’; did you mean ‘swp_offset’? [-Werror=implicit-function-declaration]
  return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
                                           ^~~~~~~~~~~~
                                           swp_offset
./include/linux/swapops.h: In function ‘swp_entry_to_pte’:
./include/linux/swapops.h:83:15: error: implicit declaration of function ‘__swp_entry’; did you mean ‘swp_entry’? [-Werror=implicit-function-declaration]
  arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
               ^~~~~~~~~~~
               swp_entry
./include/linux/swapops.h:83:13: error: incompatible types when assigning to type ‘swp_entry_t’ {aka ‘struct <anonymous>’} from type ‘int’
  arch_entry = __swp_entry(swp_type(entry), swp_offset(entry));
             ^
./include/linux/swapops.h:84:9: error: implicit declaration of function ‘__swp_entry_to_pte’; did you mean ‘swp_entry_to_pte’? [-Werror=implicit-function-declaration]
  return __swp_entry_to_pte(arch_entry);
         ^~~~~~~~~~~~~~~~~~
         swp_entry_to_pte
./include/linux/swapops.h:84:9: error: incompatible types when returning type ‘int’ but ‘pte_t’ {aka ‘struct <anonymous>’} was expected
  return __swp_entry_to_pte(arch_entry);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[1]: *** [scripts/Makefile.build:278: mm/vmscan.o] Error 1
make: *** [Makefile:1071: mm] Error 2
make: *** Waiting for unfinished jobs....
