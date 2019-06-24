Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3714C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CF420665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfFXSni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:43:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35765 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFXSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:43:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id f15so5121461wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GfjEkDFqzgTZBEb7tk5FQBBfhGJ6qrc4fpvCj0iHlvg=;
        b=PEMLzOlh0FhIICOnXDd6MnoSC8ODG7+U6KY9QYqdS6jTEuAtXQIYcUUCFm+Sb2VKKt
         XDH8PziZL5otFnWtD5c8J2FoKoOqOcXTVryoZKhROER/C4M8Un0+846X3PSCjTa5lQXB
         zU01u9ptz6jhB06mRWetGguL7wbGpRuZvj8d00WCds4RlMZ2cs7HpQ4POUU6ztIjzi84
         874Z/7+2kuLAh6lmo0zx1fWXAzSUX4DsGPG7mGoMm12tTSc1sN2qhVjo/askcA0Ad3c2
         tCPFPtdVQN98elu/Ehv1N71MQW8gdqZPqRF4zF1HSwxv34nUXLLVEZflX6UxlVm32Iiu
         B8rA==
X-Gm-Message-State: APjAAAUIoHF83jiDzaFYBYsuMf9flFrn1PP33P+zwv+NiCiYJiLyOac9
        JJ19fEiiprXfC7LDC52KQTZTfw==
X-Google-Smtp-Source: APXvYqw37VJQFJbX+dUabx4CSUB5gIDbQkk/Rk2XlTrf2S7d3VSRR3BHYb/8IS7tK0hRyAS3jV9ftA==
X-Received: by 2002:a5d:66ce:: with SMTP id k14mr45670884wrw.308.1561401815379;
        Mon, 24 Jun 2019 11:43:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45fb:a0de:928e:79e8? ([2001:b07:6468:f312:45fb:a0de:928e:79e8])
        by smtp.gmail.com with ESMTPSA id y19sm397750wmc.21.2019.06.24.11.43.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 11:43:34 -0700 (PDT)
Subject: Re: [PATCH v9 02/17] drivers/net/b44: Align pwol_mask to unsigned
 long for better performance
To:     David Laight <David.Laight@ACULAB.COM>,
        'Fenghua Yu' <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Christopherson Sean J <sean.j.christopherson@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
 <1560897679-228028-3-git-send-email-fenghua.yu@intel.com>
 <fce80c42ba1949fd8d7924786bbf0ec8@AcuMS.aculab.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4cd9d48f-e655-4943-2ec9-1b74a77e317c@redhat.com>
Date:   Mon, 24 Jun 2019 20:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fce80c42ba1949fd8d7924786bbf0ec8@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/19 17:12, David Laight wrote:
> From: Fenghua Yu
>> Sent: 18 June 2019 23:41
>> From: Peter Zijlstra <peterz@infradead.org>
>>
>> A bit in pwol_mask is set in b44_magic_pattern() by atomic set_bit().
>> But since pwol_mask is local and never exposed to concurrency, there is
>> no need to set bit in pwol_mask atomically.
>>
>> set_bit() sets the bit in a single unsigned long location. Because
>> pwol_mask may not be aligned to unsigned long, the location may cross two
>> cache lines. On x86, accessing two cache lines in locked instruction in
>> set_bit() is called split locked access and can cause overall performance
>> degradation.
>>
>> So use non atomic __set_bit() to set pwol_mask bits. __set_bit() won't hit
>> split lock issue on x86.
>>
>> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>> ---
>>  drivers/net/ethernet/broadcom/b44.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
>> index 97ab0dd25552..5738ab963dfb 100644
>> --- a/drivers/net/ethernet/broadcom/b44.c
>> +++ b/drivers/net/ethernet/broadcom/b44.c
>> @@ -1520,7 +1520,7 @@ static int b44_magic_pattern(u8 *macaddr, u8 *ppattern, u8 *pmask, int offset)
>>
>>  	memset(ppattern + offset, 0xff, magicsync);
>>  	for (j = 0; j < magicsync; j++)
>> -		set_bit(len++, (unsigned long *) pmask);
>> +		__set_bit(len++, (unsigned long *)pmask);
>>
>>  	for (j = 0; j < B44_MAX_PATTERNS; j++) {
>>  		if ((B44_PATTERN_SIZE - len) >= ETH_ALEN)
>> @@ -1532,7 +1532,7 @@ static int b44_magic_pattern(u8 *macaddr, u8 *ppattern, u8 *pmask, int offset)
>>  		for (k = 0; k< ethaddr_bytes; k++) {
>>  			ppattern[offset + magicsync +
>>  				(j * ETH_ALEN) + k] = macaddr[k];
>> -			set_bit(len++, (unsigned long *) pmask);
>> +			__set_bit(len++, (unsigned long *)pmask);
> 
> Is this code expected to do anything sensible on BE systems?

Probably not, but it's not wrong in different ways before/after the patch.

Paolo

> Casting the bitmask[] argument to any of the set_bit() functions is dubious at best.
