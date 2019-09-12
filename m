Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5BCC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766B32084F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="m7EarGvP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbfILI3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:29:37 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:42115 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbfILI3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:29:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 675743F91C;
        Thu, 12 Sep 2019 10:29:33 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=m7EarGvP;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lpajRat96fZa; Thu, 12 Sep 2019 10:29:32 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 187F93F90F;
        Thu, 12 Sep 2019 10:29:25 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 4FB84360187;
        Thu, 12 Sep 2019 10:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1568276965; bh=luKDkBGIFmeg9bXDWjkTh1tEq+rY9j/prCNGFv7UA68=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m7EarGvPqZJGHyI5Mku4zUjIPhls4jBtfan2rMTPFQrq21B4f42Y0Kt4NG7VFrOmQ
         dwPEx0Ms6F8kyFFKJ/7uhNgTmSYZrF3CscC9oht0cJfcPWTR3cnVMJvlR6vsJJ1rri
         GzJePCNSVwIBO+qKLF1HjOH+Zj5jGnwp8WkymGy8=
Subject: Re: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        pv-drivers@vmware.com, Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
 <10185AAF-BFB8-4193-A20B-B97794FB7E2F@amacapital.net>
 <92171412-eed7-40e9-2554-adb358e65767@shipmail.org>
 <CALCETrWEzctRxiv9AY0hhPGNPhv8k0POCMzMi30Bgh2aPY7R3w@mail.gmail.com>
 <76f89b46-7b14-9483-e552-eb52762adca0@shipmail.org>
 <CALCETrVKg=xjG5qyHbCY7P1H17v8LBV3FmQmqGKsPz_4qovFZQ@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <2d7a87c5-a5b2-2df4-5fd6-486fe2df2928@shipmail.org>
Date:   Thu, 12 Sep 2019 10:29:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALCETrVKg=xjG5qyHbCY7P1H17v8LBV3FmQmqGKsPz_4qovFZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 8:03 PM, Andy Lutomirski wrote:
>
>> That distinction is important because if it ever comes to a choice
>> between adding a new lock to protect vm_page_prot (and consequently slow
>> down the whole vm system) and using the WRITE_ONCE solution in TTM, we
>> should know what the implications are. As it turns out previous choices
>> in this area actually seem to have opted for the lockless WRITE_ONCE /
>> READ_ONCE / ptl solution. See __split_huge_pmd_locked() and
>> vma_set_page_prot().
> I think it would be even better if the whole thing could work without
> ever writing to vm_page_prot.  This would be a requirement for vvar in
> the unlikely event that the vvar vma ever supported splittable huge
> pages.  Fortunately, that seems unlikely :)

Yeah, for TTM the situation is different since we want huge vm pages  at 
some point.

But I re-read __split_huge_pmd_locked() and it actually looks like 
vm_page_prot is only accessed for anonymous vmas. For other vmas, it 
appears it just simply zaps the PMD, relying on re-faulting the page 
table enries if necessary (as also suggested by Christian in another 
thread).

So perhaps we should be good never writing to vm_page_prot.

/Thomas


