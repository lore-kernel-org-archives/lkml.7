Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E061DC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12272068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faTaDHM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLIPYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:24:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30924 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbfLIPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575905044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUyKBa+6w/X0SFxnoHv5d6eKbbOBp+7aIKnhyd8PFa4=;
        b=faTaDHM7LjO2OZrfpBfq87TjH7JA6iUkK+OqYXo1/pqSY/npHCYB7qkSrqILmu2Mlqkrw/
        PfmvwYjjZLmCQb9RBOlGXHPBUHtSx72W2HX/puGYJglm+VbVzT1N6vTC61aCEaWBEIfc9k
        /ZiKmZB9jlqhtbXDxHnxurZi4Tgw1rw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-My02kDJ8NJ-AR9Eq3_5uGQ-1; Mon, 09 Dec 2019 10:23:18 -0500
Received: by mail-wm1-f71.google.com with SMTP id y125so60189wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 07:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cUyKBa+6w/X0SFxnoHv5d6eKbbOBp+7aIKnhyd8PFa4=;
        b=QmxcA2XKItjiTOgrqy3BMS5zTi33hcCq9ZD92h2RaWpp2BTzfH1xSAPjjx06t6qIEC
         LQodR9gy26vNhHwO3oI4W4eOnswNKGic02KeV1pcTLx2zQT/esK1V8pG0UABJuHrrkKN
         HH+eLvHWOPQu65b8xX4lcxwHL+zmqwQq1f1oa/Ct2XE/e9ssdCvyi49sH+lcGuYJ4SJ/
         FH8YjVco0J+ojqq0g0QopkV1QyRPSLno4O0B/CBqQF/UfQou7uI7rj33Ki+iSLUpB0+S
         wvuZT6r1mRNYBS7R9eI0hxVwfTrrbqaujt0yqEanoNYEUAJXF+Gmm+68z0Chd4GK2a9E
         FTOQ==
X-Gm-Message-State: APjAAAXZ+mh7aDY6Wb51HSqwswLWFvzCipmLLI0hgb7eO5c3MwPmoaKc
        m24k5bCrK8C3pk2vog262hSPbQ+iflQk4MAZKLllnLm+SEe9cSw6TZxzY5T5AIY3zJbHWf+Uley
        Fm4CfwRjcj7mC9asywiEomjNv
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr2789655wrx.153.1575904997175;
        Mon, 09 Dec 2019 07:23:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0NPr9yEyNrwcLoT342Axfuw2Fk6VGQtA0whJ8WufzbYGTUyCLQ/P9d/nSqFiXLn6bdXvtHg==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr2789639wrx.153.1575904996946;
        Mon, 09 Dec 2019 07:23:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id d16sm29936960wrg.27.2019.12.09.07.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 07:23:16 -0800 (PST)
Subject: Re: [PATCH 0/3] Reanme the definitions of INTERRUPT_PENDING,
 NMI_PENDING and TSC_OFFSETING
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20191206084526.131861-1-xiaoyao.li@intel.com>
 <20191206204747.GD5433@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2beeb1fb-7d3a-d829-38e0-ddf76b65bd3c@redhat.com>
Date:   Mon, 9 Dec 2019 16:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191206204747.GD5433@linux.intel.com>
Content-Language: en-US
X-MC-Unique: My02kDJ8NJ-AR9Eq3_5uGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/19 21:47, Sean Christopherson wrote:
>> When reading the codes, I find the definitions of interrupt-window exiting
>> and nmi-window exiting don't match the names in latest intel SDM.
> I prefer KVM's names even though they diverge from the SDM.  The "window
> exiting" terminology is very literal, which is desirable for the SDM
> because it doesn't leave any wiggle room.  But for software, IMO the
> "event pending" terminology is preferable as it's more descriptive of the
> intended use of the control, e.g. KVM sets VIRTUAL_{INTR,NMI}_PENDING when
> it has a virtual event to inject and clears it after injecting said event.
> 

On the other hand:

static void enable_irq_window(struct kvm_vcpu *vcpu)
{
        exec_controls_setbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_INTR_PENDING);
}

static void enable_nmi_window(struct kvm_vcpu *vcpu)
{
        if (!enable_vnmi ||
            vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & GUEST_INTR_STATE_STI) {
                enable_irq_window(vcpu);
                return;
        }

        exec_controls_setbit(to_vmx(vcpu), CPU_BASED_VIRTUAL_NMI_PENDING);
}

so we're already using a lot the "window" nomenclature in KVM.  I've applied Xiaoyao's patches.

Paolo

