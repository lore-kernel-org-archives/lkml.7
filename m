Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2F4C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9405205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHMhhTKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfLEKR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:17:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30607 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728707AbfLEKR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575541076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aVe+hiB0NVm35IcQxjwnWoKy5LGQA3iypj6zaIVprpM=;
        b=CHMhhTKdWKdUjrawSozoYlKx3odSfyqN6T+30601BZlW6Ts8JTvLlHOiWhkTpgDfC0lXjO
        GPqHkGYtQv87GNZRLIB2r2VYjUr6+lUdLG6y2BBjHVcLAj+/hwOwV90A3DPmBvxtJEMEGs
        NyCfxXfRMjgk6gUgBONxCVu5QJhR9QU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-AaCBvIRiMr-_FzzHwuVMmg-1; Thu, 05 Dec 2019 05:17:55 -0500
Received: by mail-wm1-f70.google.com with SMTP id f191so702132wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 02:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aVe+hiB0NVm35IcQxjwnWoKy5LGQA3iypj6zaIVprpM=;
        b=ARRfkDy8JIgYx0aVzVcwcB6wJVQra0ESa3+m9JlsyiKXg3l1kcHOVU/sJ4eVCvh41B
         s2LRHzUVigPRwubm9FBNIMVQThhDOpLFl80EY0O2JTm5Jq44eIJMviOEnPlkdAJy0E1b
         7eHqPQwK/0zJnR0mFjI0pBRTReRFtBDyJ24tiSTXpJleZy02lvT32SR9tupp3kXmiZJa
         T3GMK1Qi6vTCPfBL8s/PPLg2kRiaJlCqMu3Rg3XxqfVY7ozfCT7+JfYQCjgRyB9msDpm
         a5KwqVf49xMaQUuh9/t5xGZCBPTC79v6cVrecgplUuPGaQL0p6d3yF1Yx0OqEAFNeICa
         J41Q==
X-Gm-Message-State: APjAAAVuO4CGmV6gz5jmFelnJJ0V0QEfZBB5GR7KqygSqdoavy9J2ZGg
        YSOPATfGA8g6RTZ+k5WVPp0m0LYEts8qYDhfASMOr8VLIG2zecNPHBBfeRAmNzfw6AicfkEivM/
        UKJwtzBjvmxz84CWN8tr1PXIl
X-Received: by 2002:adf:fd91:: with SMTP id d17mr9674011wrr.340.1575541074814;
        Thu, 05 Dec 2019 02:17:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGdy2vE00g8ehE5AMbdnywSsS5LuhGHxYsDEhmqo75DP8TLwpiW3ASkcpj5mz5XJVf2fE86g==
X-Received: by 2002:adf:fd91:: with SMTP id d17mr9673984wrr.340.1575541074592;
        Thu, 05 Dec 2019 02:17:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:541f:a977:4b60:6802? ([2001:b07:6468:f312:541f:a977:4b60:6802])
        by smtp.gmail.com with ESMTPSA id y10sm1264712wmm.3.2019.12.05.02.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 02:17:54 -0800 (PST)
Subject: Re: [PATCH] KVM: vmx: remove unreachable statement in
 vmx_get_msr_feature()
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1575512678-22058-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d252227-4993-d387-1c78-62ac8c32ebd9@redhat.com>
Date:   Thu, 5 Dec 2019 11:17:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1575512678-22058-1-git-send-email-linmiaohe@huawei.com>
Content-Language: en-US
X-MC-Unique: AaCBvIRiMr-_FzzHwuVMmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/19 03:24, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> We have no way to reach the final statement, remove it.
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e7ea332ad1e8..e58a0daf0f86 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1781,8 +1781,6 @@ static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
>  	default:
>  		return 1;
>  	}
> -
> -	return 0;
>  }
>  
>  /*
> 

Queued, thanks.

Paolo

