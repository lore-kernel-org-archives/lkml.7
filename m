Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30415C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C2622CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="OsihSA8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfIDHcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:32:42 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:40132 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfIDHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:32:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id A493C3F364;
        Wed,  4 Sep 2019 09:32:34 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=OsihSA8X;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9lLkUit6PVre; Wed,  4 Sep 2019 09:32:33 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 276693F2FD;
        Wed,  4 Sep 2019 09:32:31 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 99CB036117F;
        Wed,  4 Sep 2019 09:32:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567582351; bh=+HPJwYMkUXNNDiZsZ1mMLmsIhLPoZN+GWDYqMvcXGy0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OsihSA8XiQNtpZi4LHiOjmVKAjfHxhpSkrnaLq3orK8hVpSl/Py8OtmiHGj20Wmwb
         y9LUQeVfzilM5iuRCPUMl3v1Y/pn92u88ghe02GGFXLUsf0p0rPeQctvZZIm6MHp0a
         MdKNeE2NyMS/CI5DYx5qu4/Phd1HiNMQMy7dvJFQ=
Subject: Re: [PATCH v2 1/4] x86/mm: Export force_dma_unencrypted
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com, linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-2-thomas_os@shipmail.org>
 <20190903134627.GA2951@infradead.org>
 <f85e7fa6-54e1-7ac5-ce6c-96349c7af322@shipmail.org>
 <20190903162204.GB23281@infradead.org>
 <558f1224-d157-5848-1752-1430a5b3947e@shipmail.org>
 <20190904065823.GA31794@infradead.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <8698dc21-8679-b4a7-3179-71589fa33ab7@shipmail.org>
Date:   Wed, 4 Sep 2019 09:32:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190904065823.GA31794@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 8:58 AM, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 10:46:18PM +0200, Thomas Hellström (VMware) wrote:
>> What I mean with "from an engineering perspective" is that drivers would end
>> up with a non-trivial amount of code supporting purely academic cases:
>> Setups where software rendering would be faster than gpu accelerated, and
>> setups on platforms where the driver would never run anyway because the
>> device would never be supported on that platform...
> And actually work on cases you previously called academic and which now
> matter to you because your employer has a suddent interest in SEV.
> Academic really is in the eye of the beholder (and of those who pay
> the bills).

But in this particular case we *do* adhere to the dma api, at least as 
far as we can. But we're missing functionality.

>
>> That is not really true. The dma API can't handle faulting of coherent pages
>> which is what this series is really all about supporting also with SEV
>> active. To handle the case where we move graphics buffers or send them to
>> swap space while user-space have them mapped.
> And the only thing we need to support the fault handler is to add an
> offset to the dma_mmap_* APIs.  Which I had planned to do for Christian
> (one of the few grapics developers who actually tries to play well
> with the rest of the kernel instead of piling hacks over hacks like
> many others) anyway, but which hasn't happened yet.

That sounds great. Is there anything I can do to help out? I thought 
this was more or less a dead end since the current dma_mmap_ API 
requires the mmap_sem to be held in write mode (modifying the 
vma->vm_flags) whereas fault() only offers read mode. But that would 
definitely work.

>
>> Still, I need a way forward and my questions weren't really answered by
>> this.
> This is pretty demanding.  If you "need" a way forward just work with
> all the relevant people instead of piling ob local hacks.

But I think that was what I was trying to initiate. The question was

"If it's the latter, then I would like to reiterate that it would be 
better that we work to come up with a long term plan to add what's 
missing to the DMA api to help graphics drivers use coherent memory?"

And since you NAK'd the original patches, I was sort of hoping for a 
point in the right direction.

Thanks,

Thomas




