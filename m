Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E841AECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB68720873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390968AbfJPHfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:35:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfJPHfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:35:53 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 601ABC05686D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 07:35:53 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id i10so11302386wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aUXJNZ56uDHpmR3Fqr2a3QUcW9MnHGC8oqVaiGxbnxg=;
        b=WnkGiRdE279E+dvLT2beOuL47kQyk+iHhfAv5b3t3Dtgnl0ZQL33g4o2h9njx/zcYe
         hJBfmtAyDZWciMkWRQkcPAy8hzXhpZAxbaME+zqON2Un6KLwPiQZ0oRWGsRTP4Co5u8V
         CPqTSLS8DDv6fde0Nyn1pEQddBpiFeMALqWOvi6iXy1l/DOUvCJg9bRJDvp/VykN+1vT
         u//xgYgBf0VFljXI+2tPvW8++1t6ktj56VR18g2UMQKbxE2saY4B0nqedaCT2As6CPGt
         WAEzJqdYZ17kH4G5ZGa7QQLm2R4N5mnYycSiifhAinC0xaSmkoUkZBMfFvOLUCw9o2FV
         sZCQ==
X-Gm-Message-State: APjAAAULSKIGOXgeXoTrQ0XpflvlWlbiz0KYu7qSb8zrn8VidK1b7olc
        x+HY45iJM89P7z8+3AvCj4cZ+sWRuWSyLnoZvM0SaamKdchSYMnc0Lj8S3FVjz3Xu78rmJGDn5N
        WAjwoF5d9iomcVccVdhg8uSsv
X-Received: by 2002:a5d:490e:: with SMTP id x14mr1455258wrq.340.1571211352069;
        Wed, 16 Oct 2019 00:35:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxVESOIpGmDYbT+E/ZmD/y+tEKXgRYk+koZUWFQ+1lzfxFmsQ9uc1tZvxNWkaCqI4f6sHLF6w==
X-Received: by 2002:a5d:490e:: with SMTP id x14mr1455234wrq.340.1571211351806;
        Wed, 16 Oct 2019 00:35:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e? ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
        by smtp.gmail.com with ESMTPSA id e9sm7079487wme.3.2019.10.16.00.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 00:35:51 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Make fpu allocation a common function
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
References: <20191014162247.61461-1-xiaoyao.li@intel.com>
 <87y2xn462e.fsf@vitty.brq.redhat.com>
 <d14d22e2-d74c-ed73-b5bb-3ed5eb087deb@redhat.com>
 <6cc430c1-5729-c2d3-df11-3bf1ec1272f8@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <245dcfe2-d167-fdec-a371-506352d3c684@redhat.com>
Date:   Wed, 16 Oct 2019 09:35:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6cc430c1-5729-c2d3-df11-3bf1ec1272f8@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 03:52, Xiaoyao Li wrote:
>>
>> user_fpu could be made percpu too...  That would save a bit of memory
>> for each vCPU.  I'm holding on Xiaoyao's patch because a lot of the code
>> he's touching would go away then.
> 
> Sorry, I don't get clear your attitude.
> Do you mean the generic common function is not so better that I'd better
> to implement the percpu solution?

I wanted some time to give further thought to the percpu user_fpu idea.
 But kvm_load_guest_fpu and kvm_put_guest_fpu are not part of vcpu_load,
so it would not be so easy.  I'll just apply your patch now.

Paolo
