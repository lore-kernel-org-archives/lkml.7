Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E01C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E89214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfHNRqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:46:31 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38028 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfHNRqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:46:31 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hxxLt-00009q-1D; Wed, 14 Aug 2019 11:46:25 -0600
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <green.hu@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>, linux-mm@vger.kernel.org,
        Olof Johansson <olof@lixom.net>, greentime.hu@sifive.com,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190109203911.7887-1-logang@deltatee.com>
 <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com>
 <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com>
 <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com>
 <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com>
 <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com>
 <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com>
 <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com>
 <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com>
 <5506c875-9387-acc9-a7fe-5b7c10036c40@deltatee.com>
 <alpine.DEB.2.21.9999.1908130921170.30024@viisi.sifive.com>
 <e1f78a33-18bb-bd6e-eede-e5e86758a4d0@deltatee.com>
 <CAEbi=3f+JDywuHYspfYKuC8z2wm8inRenBz+3DYbKK3ixFjU_g@mail.gmail.com>
 <0d81412d-73fc-fa56-6f84-dedda72b9cc6@deltatee.com>
 <alpine.DEB.2.21.9999.1908141035020.18249@viisi.sifive.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <26594413-227b-2cc8-0f61-232a6a3907d0@deltatee.com>
Date:   Wed, 14 Aug 2019 11:46:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.9999.1908141035020.18249@viisi.sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: hch@lst.de, michaeljclark@mac.com, linux-riscv@lists.infradead.org, greentime.hu@sifive.com, olof@lixom.net, linux-mm@vger.kernel.org, sbates@raithlin.com, linux-kernel@vger.kernel.org, palmer@sifive.com, andrew@sifive.com, aou@eecs.berkeley.edu, robh@kernel.org, green.hu@gmail.com, paul.walmsley@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-08-14 11:40 a.m., Paul Walmsley wrote:
> On Wed, 14 Aug 2019, Logan Gunthorpe wrote:
> 
>> On 2019-08-14 7:35 a.m., Greentime Hu wrote:
>>
>>> Maybe this commit explains why it used HAVE_ARCH_PFN_VALID instead of SPARSEMEM.
>>> https://github.com/torvalds/linux/commit/7b7bf499f79de3f6c85a340c8453a78789523f85
>>>
>>> BTW, I found another issue here.
>>> #define FIXADDR_TOP            (VMALLOC_START)
>>> #define FIXADDR_START           (FIXADDR_TOP - FIXADDR_SIZE)
>>> #define VMEMMAP_END    (VMALLOC_START - 1)
>>> #define VMEMMAP_START  (VMALLOC_START - VMEMMAP_SIZE)
>>> These 2 regions are overlapped.
>>>
>>> How about this fix? Not sure if it is good for everyone.
>>
>> Yes, this looks good to me. I can fold these changes into my patch and
>> send a v5 to the list.
> 
> The change to FIXADDR_TOP should be separated out into its own patch - it 
> probably needs to go up as a fix.

I don't think so... VMEMMAP_START doesn't exist until the sparsemem
patch so it can't be changed until after the sparsemem patch and no
sense adding a bug in the sparsemem patch...

Logan

