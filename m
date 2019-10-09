Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F04DECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4D520B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfJILA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:00:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbfJILA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:00:27 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AD04C04D293
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 11:00:27 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 4so534089wmj.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 04:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9UqErDD43mG5SKxbp+McxigQPLmUudq5RASPl2m5uPA=;
        b=olVjRTEpFBMHhHG+cQz8f8FlYC4hKw06B94AAUhVe2OgQanbDYadG8+PeVh5gf2glA
         sWh61bfGyy1Sr2unQ7bAdxY+PAa5JJnEKHi9vSvWur56FW65ueiv9e9s5KjHoR1TwNW+
         ZVG95dRtF1+QfWZX4ALxNjI1ytDF+C3QUgF6VbMKInwJqPmGXedOGqPcxRDjvkNsQUmM
         wYm2yYprDupFMlaFV2kiN0Ni2sdafmN67D2yDJ/1fsX5Ab4h+od84/a9owcDERy/fAKN
         lIuCJf4uemh4xW6Cg3dTohBgPzrWjvpNasqWcv2mdHw/K0fIUANfojsDqW/BCBcyGFC+
         OwyQ==
X-Gm-Message-State: APjAAAWcZovc2bttIW7g26FFcnHRqYWRokS1Zaijz1r6eH6KFVey4351
        k9v70bP8E8tVBiCPZjPn1jZFeW0LjdE/UffyiggaAGXwmlqoB/wvfB7vzX6CVIxAciyVjhQm5xl
        3sVF9C3HVULCqmCPH5toSG3rA
X-Received: by 2002:a1c:7311:: with SMTP id d17mr2011549wmb.49.1570618825896;
        Wed, 09 Oct 2019 04:00:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqweL8Kb0PbyoP7eI4TqxXo2aLMgPodvhxLW/eM5SrCLDlTwol4G+3OmyXdf6S62kdmehbv0lw==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr2011527wmb.49.1570618825635;
        Wed, 09 Oct 2019 04:00:25 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id c17sm2489079wrc.60.2019.10.09.04.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 04:00:25 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] KVM: x86: Add helpers to test/mark reg
 availability and dirtiness
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com>
 <20190927214523.3376-8-sean.j.christopherson@intel.com>
 <87d0fi3zai.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f874f2c0-2f9f-935b-fc4f-2b70a5b5520a@redhat.com>
Date:   Wed, 9 Oct 2019 13:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87d0fi3zai.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/19 11:32, Vitaly Kuznetsov wrote:
>> +static inline void kvm_register_mark_dirty(struct kvm_vcpu *vcpu,
>> +					   enum kvm_reg reg)
>> +{
>> +	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
>> +	__set_bit(reg, (unsigned long *)&vcpu->arch.regs_dirty);
>> +}
>> +
> Personal preference again, but I would've named this
> "kvm_register_mark_avail_dirty" to indicate what we're actually doing
> (and maybe even shortened 'kvm_register_' to 'kvm_reg_' everywhere as I
> can't see how 'reg' could be misread).
> 

I think this is okay, a register can be either not cached, available or
dirty.  But dirty means we have to write it back, so it implies
availability.

Paolo
