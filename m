Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B35C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0951E20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfHMQPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:15:01 -0400
Received: from ale.deltatee.com ([207.54.116.67]:50680 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbfHMQPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:15:01 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hxZRj-0008W3-Gj; Tue, 13 Aug 2019 10:14:52 -0600
To:     Greentime Hu <green.hu@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>, paul.walmsley@sifive.com,
        Olof Johansson <olof@lixom.net>, greentime.hu@sifive.com,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190109203911.7887-1-logang@deltatee.com>
 <20190109203911.7887-3-logang@deltatee.com>
 <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com>
 <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com>
 <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com>
 <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com>
 <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com>
 <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com>
 <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com>
 <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com>
 <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5506c875-9387-acc9-a7fe-5b7c10036c40@deltatee.com>
Date:   Tue, 13 Aug 2019 10:14:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, michaeljclark@mac.com, linux-riscv@lists.infradead.org, greentime.hu@sifive.com, olof@lixom.net, paul.walmsley@sifive.com, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, green.hu@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-08-13 12:04 a.m., Greentime Hu wrote:
> I think  flat mem doesn't support memory-with-hole scenario.
> In mm/Kconfig, it says
> "
>           For systems that have holes in their physical address
>           spaces and for features like NUMA and memory hotplug,
>           choose "Sparse Memory"
> "
> IMHO, the memory-with-hole scenario should only be tested for sparse
> mem but flat mem.

Fair enough.

> The generic pfn_valid() is just for non-mmu arches. 

The generic pfn_valid() in asm-generic is only for non-mmu arches.

> Every architecture
> with mmu defines their own pfn_valid().

Not true. Arm64, for example just uses the generic implementation in
mmzone.h. My main question is whether we can just do that. If we can't
we should probably structure it like powerpc where they only use the
arch-specific helper for CONFIG_FLATMEM instead of when CONFIG_SPARSEMEM
isn't set.

Logan
