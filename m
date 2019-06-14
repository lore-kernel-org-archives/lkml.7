Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6528FC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48711217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfFNJtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:49:17 -0400
Received: from verein.lst.de ([213.95.11.211]:45603 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfFNJtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:49:16 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8158F227A86; Fri, 14 Jun 2019 11:48:48 +0200 (CEST)
Date:   Fri, 14 Jun 2019 11:48:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] mm: stub out all of swapops.h for !CONFIG_MMU
Message-ID: <20190614094847.GI17292@lst.de>
References: <20190610221621.10938-1-hch@lst.de> <20190610221621.10938-3-hch@lst.de> <516c8def-22db-027c-873d-a943454e33af@arm.com> <20190611141841.GA29151@lst.de> <80d01a1d-b6b0-18e8-811c-71af14cba3b9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d01a1d-b6b0-18e8-811c-71af14cba3b9@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 03:36:53PM +0100, Vladimir Murzin wrote:
> It looks like NOMMU ports tend to define those. For ARM they are:
> 
> #define __swp_type(x)           (0)
> #define __swp_offset(x)         (0)
> #define __swp_entry(typ,off)    ((swp_entry_t) { ((typ) | ((off) << 7)) })
> #define __pte_to_swp_entry(pte) ((swp_entry_t) { pte_val(pte) })
> #define __swp_entry_to_pte(x)   ((pte_t) { (x).val })
> 
> Anyway, I have no strong opinion on which is better :)

It just seems a lot easier to stub out swapops.h rather than providing
stubs in each arch so that inlines which we are never going to use can
build.  I can look into dropping this from the other nommu ports for
the next merge window, though.
