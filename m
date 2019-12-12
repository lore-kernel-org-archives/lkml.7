Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551BEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206FA21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fea64jzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfLLAdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:33:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49769 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726673AbfLLAdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:33:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576110830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxaQEzM6oe0SiXHNkoXFhJo/PdqrG74qMgwC+pUR+EA=;
        b=fea64jzyLVvJiy0anhIysxzOE8z4ENwtMdRvA5xVklDDEHUKhsKNjTUgnN2kbMEmHUegon
        SMn2bPsfwqiDVFWl2cKSlYQCd+D/zOPRxxZFQnYmDjwV6wt6UiY4QrR9f3bY1l3cXf5Bnj
        q7pKx22lJplKxorPefSOHIQCzeOoeT0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-CBopdrhNO5ugP9w1f7LILg-1; Wed, 11 Dec 2019 19:33:49 -0500
X-MC-Unique: CBopdrhNO5ugP9w1f7LILg-1
Received: by mail-wm1-f71.google.com with SMTP id q26so82121wmq.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 16:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kxaQEzM6oe0SiXHNkoXFhJo/PdqrG74qMgwC+pUR+EA=;
        b=sIkuCtbhdTEqAc6WDjHWOIqbUXt6X4MyhbWcfsQo559cA69QiLlqytGV1xcoy1t/qb
         2E+vNbFd8ZQpIZnOFtcya1CFCIzmztwp+ktA4W/7j9oMUNUKxS/55JYf7nYDnuDAl6dI
         SaryrCXB27RkNGAQCR5cA3xcNeEvVDTze780GC46ZIs/fJARDZJOp2oAG4Dx+XVmALGG
         zZZ7VxGiRNQzQlTHWx2k56App4mI94uVIZtI1lOPD8yIumqXYqViERyzk92YFyq+BaXu
         Yu4Cq9EB3q8KeW1mbbh35+E39rvi36VT1p4oYRW0gBGXP2zkUlUQ7XlH5UR8URbjo99B
         Rumw==
X-Gm-Message-State: APjAAAW2tG9vM8F7dNV20Uydp6pt0XB37C0Z62xDUWMj9/JoOXAe2ZP6
        vPdMfAQkKy1sTwwKZ61GLRQtzXZBbdIkbn5mqZojeFecgiiwfFj0PKzhh92mOVgpLVXPlt57Bgt
        6MVRIh2vPAgBjJ/sAV885O8St
X-Received: by 2002:a7b:cb06:: with SMTP id u6mr2810624wmj.59.1576110828053;
        Wed, 11 Dec 2019 16:33:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyD0amd5WvU7gq7wzj8WYH1A6wG/po1G1jtnvaFUH1dPZs63RNPSrP3jOjG29NHFqZXaTnK6A==
X-Received: by 2002:a7b:cb06:: with SMTP id u6mr2810593wmj.59.1576110827817;
        Wed, 11 Dec 2019 16:33:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id l22sm3975613wmj.42.2019.12.11.16.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 16:33:47 -0800 (PST)
Subject: Re: [PATCH v2 1/3] KVM: x86: assign two bits to track SPTE kinds
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Junaid Shahid <junaids@google.com>
References: <1569582943-13476-1-git-send-email-pbonzini@redhat.com>
 <1569582943-13476-2-git-send-email-pbonzini@redhat.com>
 <CANgfPd8G194y1Bo-6HR-jP8wh4DvdAsaijue_pnhetjduyzn4A@mail.gmail.com>
 <20191211191327.GI5044@linux.intel.com>
 <4e850c10-ff14-d95e-df22-0d0fd7427509@redhat.com>
 <20191212002902.GM5044@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c39ee9b-3b58-f1c9-889d-6e012bbbac6c@redhat.com>
Date:   Thu, 12 Dec 2019 01:33:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191212002902.GM5044@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 01:29, Sean Christopherson wrote:
>>   */
>> -#define MMIO_SPTE_GEN_MASK		GENMASK_ULL(18, 0)
>> +#define MMIO_SPTE_GEN_MASK		GENMASK_ULL(17, 0)
>>  
>>  #define MMIO_SPTE_GEN_LOW_START		3
>>  #define MMIO_SPTE_GEN_LOW_END		11
>>  #define MMIO_SPTE_GEN_LOW_MASK		GENMASK_ULL(MMIO_SPTE_GEN_LOW_END, \
>>  						    MMIO_SPTE_GEN_LOW_START)
>>  
>> -#define MMIO_SPTE_GEN_HIGH_START	52
>> -#define MMIO_SPTE_GEN_HIGH_END		61
>> +/* Leave room for SPTE_SPECIAL_MASK.  */
>> +#define MMIO_SPTE_GEN_HIGH_START	PT64_SECOND_AVAIL_BITS_SHIFT
> I'd rather have GEN_HIGH_START be an explicit bit number and then add
> a BUILD_BUG_ON(GEN_HIGH_START < PT64_SECOND_AVAIL_BITS_SHIFT) to ensure
> the MMIO gen doesn't overlap other stuff.  That way we get a build error
> if someone changes PT64_SECOND_AVAIL_BITS_SHIFT, otherwise the MMIO gen
> will end up who knows where and probably overwrite NX or EPT.SUPPRESS_VE.
> 

Fair enough.  While at it I'll also add MMIO_SPTE_GEN_BITS (
	MMIO_SPTE_GEN_LOW_END - MMIO_SPTE_GEN_LOW_START + 1
	+ MMIO_SPTE_GEN_HIGH_END - MMIO_SPTE_GEN_HIGH_START + 1) and use it in
MMIO_SPTE_GEN_MASK.

Paolo

