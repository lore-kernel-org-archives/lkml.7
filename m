Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4DCC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34C32067B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="YRaz4L/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbfIEQlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:41:10 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:57322 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbfIEQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:41:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 3CBE9402D7;
        Thu,  5 Sep 2019 18:41:03 +0200 (CEST)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=YRaz4L/H;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M_JX_DVyuU9R; Thu,  5 Sep 2019 18:41:01 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id AEC0A3F3E6;
        Thu,  5 Sep 2019 18:40:59 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 455FE360160;
        Thu,  5 Sep 2019 18:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567701659; bh=ayKRPYZ+CmfcKZJe9cQlEdmv7Yf28QhP6pPc0p/MAdo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YRaz4L/H+NNuyFpurOwnxOfHXmulBAkLeXmItetqYzC4E7rqKx8k0Uw/t3SKSD1pL
         ZsUvgpEG5ZbTfCmjnH5Q35hAsqPbYLh+e7fqHf55bmYxDHNj9SJ3a30I4G/hmRK21P
         lzI6GdGknYhzyoH/q0GuT2tG/IKXRpB7fZk0uqOw=
Subject: Re: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20190905103541.4161-1-thomas_os@shipmail.org>
 <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com>
 <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <20190905152438.GA18286@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <86b48953-69a2-c211-2b48-b796c07426bc@shipmail.org>
Date:   Thu, 5 Sep 2019 18:40:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190905152438.GA18286@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 5:24 PM, Christoph Hellwig wrote:
> On Thu, Sep 05, 2019 at 05:21:24PM +0200, Thomas Hellström (VMware) wrote:
>> On 9/5/19 4:15 PM, Dave Hansen wrote:
>>> Hi Thomas,
>>>
>>> Thanks for the second batch of patches!  These look much improved on all
>>> fronts.
>> Yes, although the TTM functionality isn't in yet. Hopefully we won't have to
>> bother you with those though, since this assumes TTM will be using the dma
>> API.
> Please take a look at dma_mmap_prepare and dma_mmap_fault in this
> branch:
>
> 	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-mmap-improvements
>
> they should allow to fault dma api pages in the page fault handler.  But
> this is totally hot off the press and not actually tested for the last
> few patches.  Note that I've also included your two patches from this
> series to handle SEV.

Thanks, Christoph.

I'll get to this tomorrow.

/Thomas


