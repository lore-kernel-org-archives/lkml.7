Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7112C072B1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5EE2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfE2B37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:29:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40353 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfE2B37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:29:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id 15so366486wmg.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 18:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+bGedX5o6nE+Y5FXR8KV1S9iuqLVRpYMqTJ+aAu2NM=;
        b=ScIGPY5JNb/HmKUCkAQeO+p4Rj5LMpArIDpGw//VL5NZXm6bZQ/+17BkyyTR6E7YpR
         S7madk5ZDmUDMNH0XPGBN+qxZAxUAjePzMuGK1J72qhTy/EZFgKejYUsbryQJNQmcd9z
         683/l7et/RDYHweGWd0lJxsd4qVoDMGpxpamkrzq2QIwRogYVb10I1brNs5bDcbkc6tc
         juo8lXtNudjD9diH6NlW0Sd1eFmFmaOi8pBREMnxQbZp/9ao5y9/4S3sh7enXqBFrE5T
         T8T5/cqfZzqcIImHC/K4kNzp2Wf6ppZNeqJh5M8zAE3pqCq26oR6uhbOR8gkO8MHgo0t
         crcA==
X-Gm-Message-State: APjAAAUCTp1OFqopKlsLx60K6vT+I6bOpoquJX7WxAwbrKRHzKgLi2AU
        tXpouwTcHYsABshl0Vck3L3kAg==
X-Google-Smtp-Source: APXvYqx7CoRBGsCUgLmAD6bmavoIJXGvbBLl4jlFCFwYsR96PCBp0L0QpXGHgsUTRsYeE1z5tZgL0g==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr4862856wmc.17.1559093397185;
        Tue, 28 May 2019 18:29:57 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id i17sm12789322wrr.46.2019.05.28.18.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 18:29:56 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] KVM: vmx: Emulate MSR IA32_UMWAIT_CONTROL
To:     Tao Xu <tao3.xu@intel.com>, rkrcmar@redhat.com, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jingqi.liu@intel.com
References: <20190524075637.29496-1-tao3.xu@intel.com>
 <20190524075637.29496-3-tao3.xu@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9f5050a-6144-adbc-25ef-8a7543176ac6@redhat.com>
Date:   Wed, 29 May 2019 03:29:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524075637.29496-3-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/19 09:56, Tao Xu wrote:
> +
> +	if (rdmsrl_safe(MSR_IA32_UMWAIT_CONTROL, &host_umwait_control))
> +		return;
> +

Does the host value ever change?  If not, this can perhaps be read once
when kvm_intel is loaded.  And if it changes often, it should be
shadowed into a percpu variable.

Paolo
