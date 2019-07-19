Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF01C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 21:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314672184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 21:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbfGSVjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 17:39:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54321 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfGSVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 17:39:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so29992006wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 14:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vcXUuA84+iXxhogPbUZNrkN9nPoDqv5s4mRiBH5fbBo=;
        b=mqzMsO7JcoAIMxv9nSJqU+/yGlrgyFeXUYri2h0VhppxkjmieNOWhUBPcisDFcJvKf
         Un8wWZU9fdjB29x6BQtrzNUpgtItv5nHoe/J/jcFIah0ukDyY5jajW1tEPSSblGI2Vuq
         8G+HBjhGNmp1W15saB3e+Lgtz8EahtRXNTPROtnswgcFnaCuP87atvTZ65lBVUBhmOEg
         kTBg2afdRaS3dnaqQmrkrDbjVn6Qpkgr1R674Pq2OA/bbX+tvEtfWVl4gd20rMPgVygO
         bV0Vq72Z6e72SPYrWDx8Us0J6UyXfOHTvXP2YDHT/zHgEMJ21N9DlHB4S3DAhXpzVVl0
         fYhw==
X-Gm-Message-State: APjAAAXy1JnrB6Tfx6i9QpdMxFmHereAxyJjv9WKYb7DUuCpTNc7J6sH
        orG4/VcpW1g/Tzv+Lt6bQ3b14qLEU/U=
X-Google-Smtp-Source: APXvYqxczDHRIF/87Qgt/TsyiyVejkmUIaSMnN810bvoZvxfDLqgN9MDpP3Ea+9x7uUHxmIUo7+r4w==
X-Received: by 2002:a05:600c:291:: with SMTP id 17mr48600620wmk.32.1563572345611;
        Fri, 19 Jul 2019 14:39:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8501:6b03:f18c:74f8? ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
        by smtp.gmail.com with ESMTPSA id f17sm27295784wmf.27.2019.07.19.14.39.04
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 14:39:04 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: do not use dangling shadow VMCS after guest
 reset
To:     Liran Alon <liran.alon@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1563554534-46556-3-git-send-email-pbonzini@redhat.com>
 <6D1C57BE-1A1B-4714-B4E5-E0569A60FD1F@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2a84f9d3-f58f-bcf3-56ef-a40fcbbaf8af@redhat.com>
Date:   Fri, 19 Jul 2019 23:39:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6D1C57BE-1A1B-4714-B4E5-E0569A60FD1F@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/19 23:01, Liran Alon wrote:
> 
> 
>> On 19 Jul 2019, at 19:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> If a KVM guest is reset while running a nested guest, free_nested will
>> disable the shadow VMCS execution control in the vmcs01.  However,
>> on the next KVM_RUN vmx_vcpu_run would nevertheless try to sync
>> the VMCS12 to the shadow VMCS which has since been freed.
>>
>> This causes a vmptrld of a NULL pointer on my machime, but Jan reports
>> the host to hang altogether.  Let's see how much this trivial patch fixes.
>>
>> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> First, nested_release_vmcs12() also sets need_vmcs12_to_shadow_sync
> to false explicitly. This can now be removed.
> 
> Second, I suggest putting a WARN_ON_ONCE() on copy_vmcs12_to_shadow()
> in case shadow_vmcs==NULL.
Both good ideas.  Thanks for the quick review!

Paolo

> To assist catching these kind of errors more easily in the future.
> 
> Besides that, the fix seems correct to me.
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> 
> -Liran
> 
>> ---
>> arch/x86/kvm/vmx/nested.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index 6e88f459b323..6119b30347c6 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -194,6 +194,7 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
>> {
>> 	secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_SHADOW_VMCS);
>> 	vmcs_write64(VMCS_LINK_POINTER, -1ull);
>> +	vmx->nested.need_vmcs12_to_shadow_sync = false;
>> }
>>
>> static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
>> -- 
>> 1.8.3.1
>>
> 

