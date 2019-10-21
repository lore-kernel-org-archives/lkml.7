Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D88CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7992086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfJURT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:19:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbfJURT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:19:27 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5353806CE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 17:19:26 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id s19so4893541wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ld2sD7K11SrzwjFl9eHxvksw0/zWsi3v0XYvIHwISxY=;
        b=M5Qz4ZK5FmVwMzT3bNahrl1Q2mGwrjtwPwPjJjR1iFlLEAQBqZO1edmBM1ssLgHrEv
         utQRCdXPyIH9zCTbyZsrYf3z8/KDh/CSEfKApcqZ9P/Sx5YMOtvYsjOowKGm4tH1zNtM
         OHc8aH8XHVS/kHNx21pAmGEVw9JDX3g7waelHeC+/VTLd1Vu9MlqxmFH9voxL9byIgId
         ypplCuOT969DKuUA3yDAzCfMx4HgxwY48i+2f6TPWdcP/MLBXopO7lAwTCzoahM2zjPJ
         U0wgGJhnO1ykXyuU55Omu3R2ib9/IVuYbCddgjLkfe51i/q8QtGLGxFjM/AEJ9em0FZY
         DTRQ==
X-Gm-Message-State: APjAAAVBdJZ+W/0HHIOkUwY8aZWtggA5ZmN0opNADr8LsTzd6mxl5IRZ
        Mto/yNCJtfWCF7J1P9UKvrahAMZ0X9oksFyRXb/l/7TCYJFOhCCuOsPsKHPWcVbtJk19HAt04eN
        dLQHnbiyYFbjWwPvulOirwlad
X-Received: by 2002:adf:f686:: with SMTP id v6mr22337050wrp.141.1571678365526;
        Mon, 21 Oct 2019 10:19:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyiywPmg6NJ1czyf6ouMoCYDpKf4Afn/Dv4XonOBOJn93D/U1NSTqiVTKULCWxKEGXSL0j/KA==
X-Received: by 2002:adf:f686:: with SMTP id v6mr22337034wrp.141.1571678365267;
        Mon, 21 Oct 2019 10:19:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:847b:6afc:17c:89dd? ([2001:b07:6468:f312:847b:6afc:17c:89dd])
        by smtp.gmail.com with ESMTPSA id 126sm16138702wma.48.2019.10.21.10.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 10:19:24 -0700 (PDT)
Subject: Re: [PATCH] kvm: clear kvmclock MSR on reset
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     suleiman@google.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1570704617-32285-1-git-send-email-pbonzini@redhat.com>
 <87wod439hq.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <62a31237-8b15-48da-50ef-2649daa20fdb@redhat.com>
Date:   Mon, 21 Oct 2019 19:19:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87wod439hq.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 19:06, Vitaly Kuznetsov wrote:
>>  		/* we verify if the enable bit is set... */
>> +		vcpu->arch.pv_time_enabled = false;
>>  		if (!(data & 1))
>>  			break;
>>  
>>  		if (kvm_gfn_to_hva_cache_init(vcpu->kvm,
>>  		     &vcpu->arch.pv_time, data & ~1ULL,
>>  		     sizeof(struct pvclock_vcpu_time_info)))
>> -			vcpu->arch.pv_time_enabled = false;
>> -		else
>>  			vcpu->arch.pv_time_enabled = true;

Yes...

Paolo
