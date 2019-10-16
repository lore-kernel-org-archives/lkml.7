Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E47FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D12E21928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406351AbfJPQiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:38:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbfJPQit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:38:49 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07E69C0546D5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:38:49 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id i10so11969140wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vjbKDvVFPL0th2krdx8wMvub7uxuN9FX2tXsWBpSZGA=;
        b=WZKn6sCBQ24KO019zMjKMvll4v7PAVBBtxOG3Sq5o2E8+81FXvQJL/Nrzun4UVxZPa
         /gSzjuTpA1GZC3aSHXZ4jhc4lNfGgZvg8EZ9HlWaAA73L7eH4p1gh9aCTfQALr3/uBWp
         UshYEgWtvrx0dVdiM3jf2yJcFiiI7+4c4BQd/Ai9Jh5t1CU6Ix0em018g24AE2TkTdII
         gCj6mPo/2s3QJY8a3ED6R/4r4dGpSXEckdPsGzLWL97rtS7Z1zzEH7FXVngZ8FKewJcQ
         +hsWia8dcMlXR2nM/Vc848Q0p/uw/1VBTHoolLGeYzTACKP6+7o39V/OO9HfB2j6Hbt8
         CNWQ==
X-Gm-Message-State: APjAAAU/rpLYhT39d6HUpO5Kh6AcuK3+i8rJatAChrNyddDaMcincsBn
        NlUUa1XAvKlPfqLMIs5cjakbJVyAl+hD5a1kI0G61Bql8k11/tQQw9jbpv5HLT+h3bSou/HzqKn
        Am8mQsaR6IphUANzUDdG1luE8
X-Received: by 2002:a1c:1bc5:: with SMTP id b188mr4397254wmb.88.1571243927616;
        Wed, 16 Oct 2019 09:38:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTRKkY7xojuOdJ8XLJRUq8YBcEngwDEOfnwMsHIoBx2ccVCj7UoQkvx5J80rejnnTYAPIXcw==
X-Received: by 2002:a1c:1bc5:: with SMTP id b188mr4397221wmb.88.1571243927350;
        Wed, 16 Oct 2019 09:38:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d001:591b:c73b:6c41? ([2001:b07:6468:f312:d001:591b:c73b:6c41])
        by smtp.gmail.com with ESMTPSA id b62sm4008159wmc.13.2019.10.16.09.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 09:38:46 -0700 (PDT)
Subject: Re: [PATCH v9 09/17] x86/split_lock: Handle #AC exception for split
 lock
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
References: <1560897679-228028-1-git-send-email-fenghua.yu@intel.com>
 <1560897679-228028-10-git-send-email-fenghua.yu@intel.com>
 <alpine.DEB.2.21.1906262209590.32342@nanos.tec.linutronix.de>
 <20190626203637.GC245468@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1906262338220.32342@nanos.tec.linutronix.de>
 <20190925180931.GG31852@linux.intel.com>
 <3ec328dc-2763-9da5-28d6-e28970262c58@redhat.com>
 <alpine.DEB.2.21.1910161142560.2046@nanos.tec.linutronix.de>
 <57f40083-9063-5d41-f06d-fa1ae4c78ec6@redhat.com>
 <c3ff2fb3-4380-fb07-1fa3-15896a09e748@intel.com>
 <d30652bb-89fa-671a-5691-e2c76af231d0@redhat.com>
 <8808c9ac-0906-5eec-a31f-27cbec778f9c@intel.com>
 <alpine.DEB.2.21.1910161519260.2046@nanos.tec.linutronix.de>
 <ba2c0aab-1d7c-5cfd-0054-ac2c266c1df3@redhat.com>
 <bea889c5-1599-1eb8-ff3a-3bde1e58afa3@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f9735fb8-650e-c263-36a7-61390ccbb662@redhat.com>
Date:   Wed, 16 Oct 2019 18:38:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bea889c5-1599-1eb8-ff3a-3bde1e58afa3@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/19 18:25, Xiaoyao Li wrote:
>>
>>    3 | Y         |     Y       |  N  |   Y     |   x   | Switch
>> MSR_TEST_CTRL on
>>      |           |             |     |         |       | enter/exit,
>> plus:
>>      |           |             |     |         |       | A) #AC
>> forwarded to guest.
>>      |           |             |     |         |       | B) SIGBUS or
>> KVM exit code
>>
> 
> I just want to get confirmed that in (3), we should split into 2 case:
> 
> a) if host has it enabled, still apply the constraint that guest is
> forcibly enabled? so we don't switch MSR_TEST_CTL.
> 
> b) if host has it disabled, we can switch MSR_TEST_CTL on enter/exit.

That's doable, yes.

Paolo
