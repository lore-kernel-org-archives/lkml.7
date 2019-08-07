Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BB6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7637219BE
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfHGHEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:04:43 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:53251 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfHGHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:04:42 -0400
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7F6B9200006;
        Wed,  7 Aug 2019 07:04:40 +0000 (UTC)
Subject: Re: [PATCH] riscv: kbuild: add virtual memory system selection
To:     Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.9999.1907261259420.26670@viisi.sifive.com>
 <20190802084453.GA1410@infradead.org>
 <alpine.DEB.2.21.9999.1908061648220.13971@viisi.sifive.com>
 <20190807054246.GB1398@infradead.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <c331e389-5f33-634a-f62f-e48251ca4cfe@ghiti.fr>
Date:   Wed, 7 Aug 2019 09:04:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190807054246.GB1398@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 7:42 AM, Christoph Hellwig wrote:
> On Tue, Aug 06, 2019 at 05:02:03PM -0700, Paul Walmsley wrote:
>> The rationale is to encourage others to start laying the groundwork for
>> future Sv48 support.  The immediate trigger for it was Alex's mmap
>> randomization support patch series, which needs to set some Kconfig
>> options differently depending on the selection of Sv32/39/48.
> Writing a formal todo list is much better encouragement than adding
> dead code.  Th latter has a tendency of lingering around forever and
> actually hurting people.
>
>>> but actively harmful, which is even worse.
>> Reflecting on this assertion, the only case that I could come up with is
>> that randconfig or allyesconfig build testing could fail.  Is this the
>> case that you're thinking of, or is there a different one?  If that's the
>> one, I do agree that it would be best to avoid this case, and it looks
>> like there's no obvious way to work around that issue.
> randconfig or just a user thinking bigger is better and picking it.
>
>>> Even if we assume we want to implement Sv48 eventually (which seems
>>> to be a bit off), we need to make this a runtime choice and not a
>>> compile time one to not balloon the number of configs that distributions
>>> (and kernel developers) need to support.
>> The expectation is that kernels that support multiple virtual memory
>> system modes at runtime will probably incur either a performance or a
>> memory layout penalty for doing so.  So performance-sensitive embedded
>> applications will select only the model that they use, while distribution
>> kernels will likely take the performance hit for broader single-kernel
>> support.
> Even if we want to support Sv39 only or Sv39+Sv39 the choice in the
> patch doesn't make any sense.  So better do the whole thing when its
> ready than doing false "groundwork".


I took a look at how x86 deals with 5-level page table: it allows to handle
5-level and 4-level at runtime by folding the last page table level (cf
Documentation/x86/x86_64/5level-paging.rst). So we might want to be able to
do the same and deal with that at runtime.

Regarding my series about mmap, x86 does not care about the width of the
the address space and sets values of ARCH_MMAP_RND_BITS_MIN/MAX based
on 32bit or 64bit (but then does not respect the magic formula as in arm64).

And FYI my series and your patch are already in linux-next.

Thanks,

Alex


> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
