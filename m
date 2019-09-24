Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B8EC4360C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439D92064A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 00:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503594AbfIXAPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 20:15:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503581AbfIXAPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 20:15:43 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 045EBC049E23
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 00:15:43 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id h6so24616wrh.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 17:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hhPTSVV7Ljq+kvFH1rF6tm4Uro9YskXd35cRRez5krA=;
        b=V4fpnKERweTGbE3zZhIsAbUHNWjJqrEvfayfN6urZ0uE3DZ2wpiASwLlJtvJhw8BTS
         9An2IStafIyPXaktWdSD8GuCzxcp7tQbZccS259KTAm4RVLZq/x0ldPu5VY17vRQbozI
         D5ZOI+fLqr8gG5au4xElW3190ya2qtLz3cjdA2b4w/+vvgkYva+qL5AUYwBHS1FvG/LB
         pIYaXRngzCMPP6kroBWavUYaiB7K9TKj//vviM/VTbX6cZcZ06VnCOCYy462kMCAjLY6
         Qed/wjJEQQZx5bfVeUpRcQxQJtxvVS4ZXEsVuC3TtFmr0qxWHmQ1/YSFQx4w66oT5Oap
         9NAA==
X-Gm-Message-State: APjAAAWvy+OcxnoqN5xjYH9egXsgHQxZh5kj7pySDvs9RSBM55amFgMS
        l3418bo/IATypRH+MwUAXnHUsT87MvNck9H8grmoC4kir4cPQ68buZbj0RNuIH8Qg61SP6AWYtZ
        nBHcajrL+jKZ4ARLTz68d7PYk
X-Received: by 2002:a1c:c742:: with SMTP id x63mr154260wmf.126.1569284141477;
        Mon, 23 Sep 2019 17:15:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwwcyNABkvGGY5zjzh+d1Nvb5uPVQbuCrvHOUy7k0svqrNAU8kQctD8Ji9xWiw/ma2dHQ2ktQ==
X-Received: by 2002:a1c:c742:: with SMTP id x63mr154239wmf.126.1569284141164;
        Mon, 23 Sep 2019 17:15:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id 33sm56960wra.41.2019.09.23.17.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 17:15:40 -0700 (PDT)
Subject: Re: [PATCH 15/17] KVM: retpolines: x86: eliminate retpoline from
 vmx.c exit handlers
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-16-aarcange@redhat.com>
 <87o8zb8ik1.fsf@vitty.brq.redhat.com>
 <7329012d-0b3b-ce86-f58d-3d2d5dc5a790@redhat.com>
 <20190923190514.GB19996@redhat.com> <20190923202349.GL18195@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ccfa85b7-b484-7052-f991-78ad05ce7fe7@redhat.com>
Date:   Tue, 24 Sep 2019 02:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923202349.GL18195@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/19 22:23, Sean Christopherson wrote:
>  
> +int nested_vmx_handle_vmx_instruction(struct kvm_vcpu *vcpu)
> +{
> +	switch (to_vmx(vcpu)->exit_reason) {
> +	case EXIT_REASON_VMCLEAR:
> +		return handle_vmclear(vcpu);
> +	case EXIT_REASON_VMLAUNCH:
> +		return handle_vmlaunch(vcpu);
> +	case EXIT_REASON_VMPTRLD:
> +		return handle_vmptrld(vcpu);
> +	case EXIT_REASON_VMPTRST:
> +		return handle_vmptrst(vcpu);
> +	case EXIT_REASON_VMREAD:
> +		return handle_vmread(vcpu);
> +	case EXIT_REASON_VMRESUME:
> +		return handle_vmresume(vcpu);
> +	case EXIT_REASON_VMWRITE:
> +		return handle_vmwrite(vcpu);
> +	case EXIT_REASON_VMOFF:
> +		return handle_vmoff(vcpu);
> +	case EXIT_REASON_VMON:
> +		return handle_vmon(vcpu);
> +	case EXIT_REASON_INVEPT:
> +		return handle_invept(vcpu);
> +	case EXIT_REASON_INVVPID:
> +		return handle_invvpid(vcpu);
> +	case EXIT_REASON_VMFUNC:
> +		return handle_vmfunc(vcpu);
> +	}
> +

Do you really need that?  Why couldn't the handle_* functions simply be
exported from nested.c to vmx.c?

Paolo
