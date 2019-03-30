Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB750C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 10:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9305B205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 10:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HCSZsszM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YXlhrLVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfC3KYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 06:24:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfC3KYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 06:24:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 40DF66087A; Sat, 30 Mar 2019 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553941476;
        bh=c6w/vatA4fK1daMlMWy7NENrUDUs12PCSFvza7TioPc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HCSZsszM9TPCGa3tXf5imqKAGYoTQfWo+pFvb9y84G2z7tfglmYgWtrUcix9nK0RO
         eY/gOkqY9U9PLFQv099HYF/0JM+K/dvV7d2N4/Rv+TDiRbNy2AotVxszPCKkB4lEnk
         HJpi1EzAzls6BwNHcGjM8uo6ryl41B1F6aISo2zM=
Received: from [10.79.169.73] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01DFD6085C;
        Sat, 30 Mar 2019 10:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553941475;
        bh=c6w/vatA4fK1daMlMWy7NENrUDUs12PCSFvza7TioPc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YXlhrLVKtRAtE7QncKfrNGPZIsALIfuwE6jurIq6cetf3UUD46t28Lh/5+Dy3McRf
         C9du0kVdO2Qe5eWjugtB6vO0C5Hu0vGtxrGCO+Tj5ct0vbilH/QQo2P948zOXHAVqu
         dBJ+g9/GYvVsncU2P5tb0hoOuzVWTf2L0yG94mQc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01DFD6085C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] x86/calgary: fix bitcast type warnings
To:     Jann Horn <jannh@google.com>
Cc:     Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        iommu@lists.linux-foundation.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
References: <20190328225925.241998-1-jannh@google.com>
 <530a0823-5dcd-9006-2057-ae5b9da2389a@codeaurora.org>
 <CAG48ez01TR7xBRgdAyvoHBjttn-ffr-8KBS8sJ904TDm4FLH+Q@mail.gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c1c85afd-fbfb-01cd-a1d2-fc5474dee740@codeaurora.org>
Date:   Sat, 30 Mar 2019 15:54:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez01TR7xBRgdAyvoHBjttn-ffr-8KBS8sJ904TDm4FLH+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2019 3:15 AM, Jann Horn wrote:
> On Fri, Mar 29, 2019 at 9:19 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
>> On 3/29/2019 4:29 AM, Jann Horn wrote:
>>> The sparse checker attempts to ensure that all conversions between
>>> fixed-endianness numbers and numbers with native endianness are explicit.
>>> However, the calgary code reads and writes big-endian numbers from/to IO
>>> memory using {read,write}{l,q}(), which return native-endian numbers.
>>>
>>> This could be addressed by putting __force casts all over the place, but
>>> that would kind of defeat the point of the warning. Instead, create new
>>> helpers {read,write}{l,q}_be() for big-endian IO that convert from/to
>>> native endianness.
>>>
>>> Most of this patch is a straightforward conversion; the following parts
>>> aren't just mechanical replacement:
>>>
>>>    - ->tar_val is now a native-endian number instead of big-endian
>>>    - calioc2_handle_quirks() did `cpu_to_be32(readl(target))` when it
>>>      intended to do `be32_to_cpu(readl(target))` (but that has no actual
>>>      effects outside of type warnings)
>>>
>>> This gets rid of 108 lines of sparse warnings.
>>>
>>> Signed-off-by: Jann Horn <jannh@google.com>
>>> ---
>>> compile-tested only
>>>
>>>    arch/x86/kernel/pci-calgary_64.c | 108 ++++++++++++++++++-------------
>>>    1 file changed, 64 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
>>> index c70720f61a34..36cd66d940fb 100644
>>> --- a/arch/x86/kernel/pci-calgary_64.c
>>> +++ b/arch/x86/kernel/pci-calgary_64.c
>>> @@ -534,6 +534,26 @@ static inline int is_cal_pci_dev(unsigned short device)
>>>        return (is_calgary(device) || is_calioc2(device));
>>>    }
>>
>> Can the existing api's not be used here like iowrite64be/ioread64be/ or
>> similar variant in "include/asm-generic/io.h"
> Given what Logan said, I think it probably makes sense to keep the patch as-is?

Sure go ahead, will have a look at this patch one more time.



