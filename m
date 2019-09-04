Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC28C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5810822CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="EGZENqDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfIDInG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:43:06 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:45684 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfIDInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:43:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 6215F3F451;
        Wed,  4 Sep 2019 10:42:54 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=EGZENqDo;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eB6SS69d0euV; Wed,  4 Sep 2019 10:42:53 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 771E33F364;
        Wed,  4 Sep 2019 10:42:52 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 15D5E36117F;
        Wed,  4 Sep 2019 10:42:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1567586572; bh=bvaCLcoiKAN+kaSJwJSs748y7pmwvtoRcbFA8sPkOoQ=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=EGZENqDo0T0nXeX8QLQKz0QHlFvnNkfp/NPEBRK44uKklAMzP69qwaru8+XVSrF8W
         MyF8rkd4B1aoE77MvVNIi0l1NoU5Rf2O5ELSRy4OUbplA7znBawKXFRq7qgqXJZO0j
         K+JyEuGr5SZ3lTWdI0jjUztelaOJ8JxwIIhkSxCo=
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD
 memory encryption
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-4-thomas_os@shipmail.org>
 <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com>
 <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com>
 <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com>
 <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org>
 <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com>
 <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org>
 <cfe46eda-66b5-b40d-6721-84e6e0e1f5de@amd.com>
 <94113acc-1f99-2386-1d42-4b9930b04f73@shipmail.org>
Organization: VMware Inc.
Message-ID: <6f92f5d2-ba2d-ebb2-ed77-37cebb39bfa4@shipmail.org>
Date:   Wed, 4 Sep 2019 10:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <94113acc-1f99-2386-1d42-4b9930b04f73@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/19 10:19 AM, Thomas Hellström (VMware) wrote:
> Hi, Christian,
>
> On 9/4/19 9:33 AM, Koenig, Christian wrote:
>> Am 03.09.19 um 23:05 schrieb Thomas Hellström (VMware):
>>> On 9/3/19 10:51 PM, Dave Hansen wrote:
>>>> On 9/3/19 1:36 PM, Thomas Hellström (VMware) wrote:
>>>>> So the question here should really be, can we determine already at 
>>>>> mmap
>>>>> time whether backing memory will be unencrypted and adjust the *real*
>>>>> vma->vm_page_prot under the mmap_sem?
>>>>>
>>>>> Possibly, but that requires populating the buffer with memory at mmap
>>>>> time rather than at first fault time.
>>>> I'm not connecting the dots.
>>>>
>>>> vma->vm_page_prot is used to create a VMA's PTEs regardless of if they
>>>> are created at mmap() or fault time.  If we establish a good
>>>> vma->vm_page_prot, can't we just use it forever for demand faults?
>>> With SEV I think that we could possibly establish the encryption flags
>>> at vma creation time. But thinking of it, it would actually break with
>>> SME where buffer content can be moved between encrypted system memory
>>> and unencrypted graphics card PCI memory behind user-space's back.
>>> That would imply killing all user-space encrypted PTEs and at fault
>>> time set up new ones pointing to unencrypted PCI memory..
>> Well my problem is where do you see encrypted system memory here?
>>
>> At least for AMD GPUs all memory accessed must be unencrypted and that
>> counts for both system as well as PCI memory.
>
> We're talking SME now right?
>
> The current SME setup is that if a device's DMA mask says it's capable 
> of addressing the encryption bit, coherent memory will be encrypted. 
> The memory controllers will decrypt for the device on the fly. 
> Otherwise coherent memory will be decrypted.
>
>>
>> So I don't get why we can't assume always unencrypted and keep it 
>> like that.
>
> I see two reasons. First, it would break with a real device that 
> signals it's capable of addressing the encryption bit.
>
> Second I can imagine unaccelerated setups (something like vkms using 
> prime feeding a VNC connection) where we actually want the TTM buffers 
> encrypted to protect data.
>
> But at least the latter reason is way far out in the future.
>
> So for me I'm ok with that if that works for you?

Hmm, BTW,

Are you sure the AMD GPUs use unencrypted system memory rather than 
relying on the memory controllers to decrypt?

In that case it seems strange that they get away with encrypted TTM 
PTEs, whereas vmwgfx don't...

/Thomas

>
> /Thomas
>
>
>>
>> Regards,
>> Christian.
>
>

