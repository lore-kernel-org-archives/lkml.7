Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C14C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722A222CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="oGwXq3VO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfICUgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:36:33 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:23255 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfICUgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:36:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 2742D3F4B4;
        Tue,  3 Sep 2019 22:36:31 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=oGwXq3VO;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a1UEQTFtaoN1; Tue,  3 Sep 2019 22:36:30 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 1C9363F491;
        Tue,  3 Sep 2019 22:36:25 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 4CD58360160;
        Tue,  3 Sep 2019 22:36:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567542985; bh=30C0D3xa5wm2cg0OGQm+1PBEP9X+l+G7kGUCDwu6i+8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oGwXq3VOKGwMnq6LfU7OlqajMa3c7ku9er9mvyXT2gc71QJP06oiNV0qu3h+O1Hyc
         yj8hnYKahdp7ZKvPMSpDDvs0PHAo1fnlshtS2lfq8WUW9VlXYRxtKE3JNchBYQRbC7
         Ij4eAvKNLJigD2PMEuGNMWRX9UyvV21LyhOHiBrA=
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
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org>
Date:   Tue, 3 Sep 2019 22:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/19 9:55 PM, Dave Hansen wrote:
> On 9/3/19 12:51 PM, Daniel Vetter wrote:
>>> The thing we need to stop is having mixed encryption rules under one VMA.
>> The point here is that we want this. We need to be able to move the
>> buffer between device ptes and system memory ptes, transparently,
>> behind userspace back, without races. And the fast path (which is "no
>> pte exists for this vma") must be real fast, so taking mmap_sem and
>> replacing the vma is no-go.
> So, when the user asks for encryption and we say, "sure, we'll encrypt
> that", then we want the device driver to be able to transparently undo
> that encryption under the covers for device memory?  That seems suboptimal.
>
> I'd rather the device driver just say: "Nope, you can't encrypt my VMA".
>   Because that's the truth.

The thing here is that it's the underlying physical memory that define 
the correct encryption flags. If it's DMA memory and SEV is active or 
PCI memory. It's always unencrypted. User-space in a SEV vm should 
always, from a data protection point of view, *assume* that graphics 
buffers are unencrypted. (Which will of course limit the use of gpus and 
display controllers in a SEV vm). Platform code sets the vma encryption 
to on by default.

So the question here should really be, can we determine already at mmap 
time whether backing memory will be unencrypted and adjust the *real* 
vma->vm_page_prot under the mmap_sem?

Possibly, but that requires populating the buffer with memory at mmap 
time rather than at first fault time.

And it still requires knowledge whether the device DMA is always 
unencrypted (or if SEV is active).

/Thomas




