Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B1CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DEC2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="NpihaS58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfICVFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:05:33 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:57979 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICVFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:05:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 30F0C3F3EF;
        Tue,  3 Sep 2019 23:05:31 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=NpihaS58;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XIBw9yZbCl08; Tue,  3 Sep 2019 23:05:30 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 350063F333;
        Tue,  3 Sep 2019 23:05:26 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 6380C360160;
        Tue,  3 Sep 2019 23:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567544726; bh=/li7YegAhw6RYebLGGt/o3WJvHeG1ytUqRCNCZ9yHwo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NpihaS584vAezzYGEJFzcCqhRmOPFt5+xrYeQK5B9B2tNMdEtQQufvDy2twLS8/Lr
         +V1hvYJ9E3E+XhWlmlOQ8pnECLnM3I0Js1Zpog+5Cv/TNXfjxsNpvQLHiloHigHe8c
         RCbL+v7L5SnK7SFv5+0MrTxSTs78rki5TArr4mNM=
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD
 memory encryption
To:     Dave Hansen <dave.hansen@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>, pv-drivers@vmware.com,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-4-thomas_os@shipmail.org>
 <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com>
 <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com>
 <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com>
 <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org>
 <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org>
Date:   Tue, 3 Sep 2019 23:05:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 10:51 PM, Dave Hansen wrote:
> On 9/3/19 1:36 PM, Thomas Hellström (VMware) wrote:
>> So the question here should really be, can we determine already at mmap
>> time whether backing memory will be unencrypted and adjust the *real*
>> vma->vm_page_prot under the mmap_sem?
>>
>> Possibly, but that requires populating the buffer with memory at mmap
>> time rather than at first fault time.
> I'm not connecting the dots.
>
> vma->vm_page_prot is used to create a VMA's PTEs regardless of if they
> are created at mmap() or fault time.  If we establish a good
> vma->vm_page_prot, can't we just use it forever for demand faults?

With SEV I think that we could possibly establish the encryption flags 
at vma creation time. But thinking of it, it would actually break with 
SME where buffer content can be moved between encrypted system memory 
and unencrypted graphics card PCI memory behind user-space's back. That 
would imply killing all user-space encrypted PTEs and at fault time set 
up new ones pointing to unencrypted PCI memory..

>
> Or, are you concerned that if an attempt is made to demand-fault page
> that's incompatible with vma->vm_page_prot that we have to SEGV?
>
>> And it still requires knowledge whether the device DMA is always
>> unencrypted (or if SEV is active).
> I may be getting mixed up on MKTME (the Intel memory encryption) and
> SEV.  Is SEV supported on all memory types?  Page cache, hugetlbfs,
> anonymous?  Or just anonymous?

SEV AFAIK encrypts *all* memory except DMA memory. To do that it uses a 
SWIOTLB backed by unencrypted memory, and it also flips coherent DMA 
memory to unencrypted (which is a very slow operation and patch 4 deals 
with caching such memory).

/Thomas




