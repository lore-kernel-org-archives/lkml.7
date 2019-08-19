Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8311C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C603C2082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfHSOnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:43:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfHSOnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:43:31 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7F18C05AA58
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:43:30 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id n13so312292wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vy5qJGgg/EWAtVC39C9kZNd1jY+63gY/oCqRox6uDxE=;
        b=KPxLRI0nh4M7LUHzir23ljmCQAbp9cevw7rwvrHSqJIKd8/VqcqnWfL8qIFw3LgTIm
         LXc328NhgepbgT8cSeUbSm3/Gfsl41vQDhkSfaHB5Fn+X0UBqF8r1eP1UhhgU6hVCyMo
         qh4PwPlLJss9rDq15yxHY4iSF7oYGFi3hceVVmgtjZsXtgeaxRXot7Q+PkU9VlhLWo0W
         acESE8dsTaDGQNapv/rXGNj9dirTaCRgh7LaEnxoao1i9cR7OF64AWS5ECRU3otrM0M0
         LwQ/fdFKw4dkBe7FlXL+f7ZcMV9RUrVYIG4ePY3mTXdDNTeB+ravNO5qNN5EP2xopbky
         Ghow==
X-Gm-Message-State: APjAAAWbtG4U4sYPXFXmwWDWUXH1Htk9hozOOOnhnXXYsJ5vbGEUBLIY
        CCfmQugHYgM0bqs/hSftGGt5BF4jj0YXYzMg2Oj+urAqc7aSevpJrLycmBo5Ihhd+4fg2usHHef
        PAesoSIu+h7Bag+6gvzRZ4GSM
X-Received: by 2002:adf:fc51:: with SMTP id e17mr27848060wrs.348.1566225809326;
        Mon, 19 Aug 2019 07:43:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPD8E4pfzsD6lNAVTvslP3BefYn5k7Fw+gz99Gu/AIMAYkfS55sCrwFQGfa1MWklnzgdSsVw==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr27848027wrs.348.1566225809018;
        Mon, 19 Aug 2019 07:43:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f? ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
        by smtp.gmail.com with ESMTPSA id s19sm16503316wrb.94.2019.08.19.07.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 07:43:28 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 7/9] KVM: VMX: Handle SPP induced vmexit and
 page fault
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com
Cc:     mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        yu.c.zhang@intel.com, alazar@bitdefender.com
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-8-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f6ba406-17c4-a552-2352-2ff50569aac0@redhat.com>
Date:   Mon, 19 Aug 2019 16:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814070403.6588-8-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/19 09:04, Yang Weijiang wrote:
> +			/*
> +			 * Record write protect fault caused by
> +			 * Sub-page Protection, let VMI decide
> +			 * the next step.
> +			 */
> +			if (spte & PT_SPP_MASK) {

Should this be "if (spte & PT_WRITABLE_MASK)" instead?  That is, if the
page is already writable, the fault must be an SPP fault.

Paolo

> +				fault_handled = true;
> +				vcpu->run->exit_reason = KVM_EXIT_SPP;
> +				vcpu->run->spp.addr = gva;
> +				kvm_skip_emulated_instruction(vcpu);
> +				break;
> +			}
> +
>  			new_spte |= PT_WRITABLE_MASK;

