Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2028C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F05217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3N5dXiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfFNU0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:26:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37042 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNU0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:26:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id t76so2893201oih.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hu6UH6SAxMoZ+zdg3c2COyOtX79gFZR/VtwmhecH8dA=;
        b=o3N5dXiKLQ9PbDeRIB98rfVh15PxoVFa/1ufQzJRNpgABUqbXosiApy2K7CWnu2aFD
         lptSKRX1xOc2/Zt5x5tc1uypFmRuOfUjlR1XzP+CMxmQijfWhcAJWJ6hQZO/28zmqhMu
         ZZWs09so+lam17Oqi0ATZLBRk2R90J8lyxq5m2cKDJ6z0QdTrYTWgX2CG6kbO5VtTq/C
         HVVB4iWvAUoIhVRd1sRZmKBbAV4u+Gs+PblKIbCyDifVZ8qXaUf9fpXu+R7YQS4sOVgV
         SYMWYwzNgoKTsz+wYF2ceul3EWIC8IquOZzyX5r46poJ2lIi8oFLO9yWjpaoOZfsyK6p
         aZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hu6UH6SAxMoZ+zdg3c2COyOtX79gFZR/VtwmhecH8dA=;
        b=ZJfQ5Wuxbl16O3cEac8QNUHV+8EIv7/X/6XbHOBIzjaQ+d/VIwBMlLGedLH/ElyBA5
         T1bWd5LIBGwpfuuKHTOLyTxjQLkqLzhTwdHN6h8G5RpnW/z/Zox7/5qDuJ8EBOUMwcQZ
         tlM8visKWJEiYqrUEDxMAr9Lk2OOAPSr7clUj1WFgDGnBMo8W2Tp+iyL5uT+XVnlQ5Uf
         VH79XGNYIq40TPEg8d4sQS6frJJ7PI1cl/GIeojZTeOoKtlCVc5wwpQQm6F3iOZuceID
         NLHpgwnTFtBooQDrZViPM3+3aAdOoKmwaJeHhX/8W9H3v7CucPsTYC6EC2AvRU9fzSli
         29ng==
X-Gm-Message-State: APjAAAVRFP2zPo3ncFMjNPlpGa/h550zTCuNAGXsp69eva3saJLJvtb0
        V+O23WKn2ANXTLFyNwwxwHEbpFAu
X-Google-Smtp-Source: APXvYqypZyd7CSFEGroYYb1iKjlsO3SWJUCtaP6WveZciRKaw0cfbgSxgbaQDgwzxZnfKZpsek1gNw==
X-Received: by 2002:aca:3d54:: with SMTP id k81mr2811911oia.111.1560543992838;
        Fri, 14 Jun 2019 13:26:32 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id q2sm1532873oia.45.2019.06.14.13.26.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 13:26:32 -0700 (PDT)
Subject: Re: [PATCH] powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Mathieu Malaterre <malat@debian.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190613082446.18685-1-hch@lst.de>
 <CA+7wUswMtpVCoX0H5eF=GUY8jWDAEWa9Z223tKiKHiL69hhHtQ@mail.gmail.com>
 <20190614191532.GC27145@darkstar.musicnaut.iki.fi>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <d508cc9c-435f-4108-17ac-6db74640514c@lwfinger.net>
Date:   Fri, 14 Jun 2019 15:26:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614191532.GC27145@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/19 2:15 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Jun 14, 2019 at 09:24:16AM +0200, Mathieu Malaterre wrote:
>> On Thu, Jun 13, 2019 at 10:27 AM Christoph Hellwig <hch@lst.de> wrote:
>>> With the strict dma mask checking introduced with the switch to
>>> the generic DMA direct code common wifi chips on 32-bit powerbooks
>>> stopped working.  Add a 30-bit ZONE_DMA to the 32-bit pmac builds
>>> to allow them to reliably allocate dma coherent memory.
>>>
>>> Fixes: 65a21b71f948 ("powerpc/dma: remove dma_nommu_dma_supported")
>>> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>   arch/powerpc/include/asm/page.h         | 7 +++++++
>>>   arch/powerpc/mm/mem.c                   | 3 ++-
>>>   arch/powerpc/platforms/powermac/Kconfig | 1 +
>>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
>>> index b8286a2013b4..0d52f57fca04 100644
>>> --- a/arch/powerpc/include/asm/page.h
>>> +++ b/arch/powerpc/include/asm/page.h
>>> @@ -319,6 +319,13 @@ struct vm_area_struct;
>>>   #endif /* __ASSEMBLY__ */
>>>   #include <asm/slice.h>
>>>
>>> +/*
>>> + * Allow 30-bit DMA for very limited Broadcom wifi chips on many powerbooks.
>>
>> nit: would it be possible to mention explicit reference to b43-legacy.
>> Using b43 on my macmini g4 never showed those symptoms (using
>> 5.2.0-rc2+)
> 
> According to Wikipedia Mac mini G4 is limited to 1 GB RAM, so that's
> why you don't see the issue.

He wouldn't see it with b43. Those cards have 32-bit DMA.

Larry


