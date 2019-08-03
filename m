Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45208C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2442A2166E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 06:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfHCGg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 02:36:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44160 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfHCGg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 02:36:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so79292386wrf.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 23:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CxBS9dU0c4bmMBQFrGHmBgCL8Xa1VLsfjnTYVWRb6Mo=;
        b=YzFQz58CQLy0NGe3XnwGbBIMH2enaFcJPojlWTK47oMcjx8UDO0FhEF/cQw7yAEolU
         Q0K6dKQ/bZJNAqvXQhJ3wca3iptdDQ5ro1L3CfBkl0kU5EFXRwRgeU46//VFohALzf5D
         tq648EFSvm1HZqsgC3k3S7rcRUMlN8HhGXXkF4hMhE/G+3SSKLbRKZmDMwJd5NNuce6Z
         3SLJF0ceI3fzGImq6Fi1w9qslVHwmOwAM1QX9NzeV+GwDHqh+rtW8V/pukfyuJkyrU9U
         aR1MXAGqd3lfwDVhlQc00XZr8qCd/n3jAaO5XTsqkuUXLM1FPHnWbOpIT34AIybXOxSu
         dZSw==
X-Gm-Message-State: APjAAAUkXr9Ms51iA0QN+g9xjUjZiAtkaIZdQdeczqR9o0UuEXC2fGxH
        zcI1AQjg6+n6paxPKQMwsc698g==
X-Google-Smtp-Source: APXvYqzZQCJeHqyLw20M7N2TNmKBi8IwDHr1fSzkT1RENNvynG3/SjhC6PDSr6O2Hjklu3bZBeMSuA==
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr47230220wrx.82.1564814186606;
        Fri, 02 Aug 2019 23:36:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff? ([2001:b07:6468:f312:4013:e920:9388:c3ff])
        by smtp.gmail.com with ESMTPSA id s10sm94948121wmf.8.2019.08.02.23.36.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 23:36:25 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] KVM: Fix leak vCPU's VMCS value into other pCPU
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>, stable@vger.kernel.org
References: <1564630214-28442-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a2900ee5-61cf-a35b-7ae5-b326052e0a6d@redhat.com>
Date:   Sat, 3 Aug 2019 08:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564630214-28442-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/19 05:30, Wanpeng Li wrote:
> +bool kvm_arch_dy_runnable(struct kvm_vcpu *vcpu)
> +{
> +	if (READ_ONCE(vcpu->arch.pv.pv_unhalted))
> +		return true;
> +
> +	if (kvm_test_request(KVM_REQ_NMI, vcpu) ||
> +	    (READ_ONCE(vcpu->arch.nmi_pending) &&
> +	     kvm_x86_ops->nmi_allowed(vcpu)))

You cannot check kvm_x86_ops->nmi_allowed(vcpu), so just use
kvm_test_request.

> +		return true;
> +
> +	if (kvm_test_request(KVM_REQ_SMI, vcpu) ||
> +	    (READ_ONCE(vcpu->arch.smi_pending) && !is_smm(vcpu)))
> +		return true;

Same here, if only for simplicity.

> +	if (kvm_test_request(KVM_REQ_EVENT, vcpu))
> +		return true;
> +
> +	if (vcpu->arch.apicv_active && kvm_x86_ops->apicv_test_pi_on(vcpu))
> +		return true;

Let's call it apicv_has_pending_interrupt instead.

Also, please add a comment in kvm_main.c saying that
kvm_arch_dy_runnable is called outside vcpu_load/vcpu_put.

Paolo

> +
> +	return false;
> +}
