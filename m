Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A95C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38FC2081C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbfETKjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:39:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbfETKjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:39:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so14024565wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LSXvvjLM2HBXWG9qhIrfISHU3rhydRFpcgUUVJCwNBc=;
        b=VZraEzg68ZpC+WzQY6ikz0XG/B+q+Dn81e1b80dZfXXXzl1tAzMv40S++tVXJT+xB3
         R/HbsHVDVIRXW07Fwk5osNzS11/+TfZevUhqvTRJWQe4dQc2Hm5rQtNidgadunKuug4H
         CrTEHX+59cO1VEkGq1X89SWGfFT81SoXLVUulnk+TU38Zq4tbCczgG7EEnyLy2vC7s0V
         bhJJVeGOQkd5nRo5nNrP1zUSMr/vSPb1XlDsTw04LlBpTER1e7qrEWiAxn/dWx0/KW9k
         OR0l2mMJyrILejF3y3OJ4qnqh9ucR48OiQCcm14UMTk3YQgNUlhU+nZERBq7YwG13UZ0
         2CVg==
X-Gm-Message-State: APjAAAVL1KHiNhU9ySnK7Fo8S7U5r56qpUkDYv1cWMncXiFbcHPY4dJq
        M0lBZAIIB0YtvmPy7kH8RWb+IS8aFQXBkA==
X-Google-Smtp-Source: APXvYqxfM+AbzlMq4FVA03dUQrFO7n+VwiQjUOMIWGa8PFwNSVyl0na3x5bC/WWRAhmCS1nkMNk3pA==
X-Received: by 2002:a5d:5743:: with SMTP id q3mr5645987wrw.92.1558348771961;
        Mon, 20 May 2019 03:39:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id z202sm2751084wmc.18.2019.05.20.03.39.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 03:39:31 -0700 (PDT)
Subject: Re: [PATCH] kvm: vmx: Fix -Wmissing-prototypes warnings
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1558326467-48530-1-git-send-email-wang.yi59@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4babb584-27d6-a5be-c8a9-828079920130@redhat.com>
Date:   Mon, 20 May 2019 12:39:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558326467-48530-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/19 06:27, Yi Wang wrote:
> We get a warning when build kernel W=1:
> arch/x86/kvm/vmx/vmx.c:6365:6: warning: no previous prototype for ‘vmx_update_host_rsp’ [-Wmissing-prototypes]
>  void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
> 
> Add the missing declaration to fix this.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  arch/x86/kvm/vmx/vmx.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index f879529..9cd72de 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -314,6 +314,7 @@ struct kvm_vmx {
>  void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
>  struct shared_msr_entry *find_msr_entry(struct vcpu_vmx *vmx, u32 msr);
>  void pt_update_intercept_for_msr(struct vcpu_vmx *vmx);
> +void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp);
>  
>  #define POSTED_INTR_ON  0
>  #define POSTED_INTR_SN  1
> 

Queued, thanks.

Paolo
