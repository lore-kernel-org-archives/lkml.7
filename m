Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12663C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80A52070D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfHSOqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:46:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSOqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:46:53 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A4A1C00F7E6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:46:53 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id k14so5367422wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eTAKwnUWv77j3jpgf1dY2BGrKvsemf3lKryFUSYGVp8=;
        b=CZbaMZY16+6yWZKDiFOZ2hbMr3XNb4UW2a6cjY3DxqfHaoxKrDz7Lhwjcm3QkVMf7J
         4JBVmJKnNEVQo8U0bWtnau5yEa1c8ULRxTCIxqZ3hFwE7wByH7XtstUB3AoIWBkyQ423
         XMxAInO+zy8cZvYBxIZUa10h3sMGKuMkjUi6R2qVr5Q7JjH3IimpN6jraUoveypS86C/
         lKtK8SuqM00ANp3hdpb5JZVEi379A91N7+0WRWXKNjEWFRw339jiFQh9I+xdEnyfnCZO
         Y57eodKd1tKwrSb7kymNfj7wCsVRtFauEh4IEVa/bPHYT7YUNL8sXl9YyPmRsFSu7/m7
         G8Gg==
X-Gm-Message-State: APjAAAWzOEgbXnszvJJXPNN1UI2/RlFjwwZ2i0j5wUIjLw9BAv52rstG
        oZCbpawqAdajejpT5jqSNAKnurf/pS3mPPoV+tA/MzYxn72lyRliy/JVAsk+rEQS/TM1zrTcVhL
        J4ps2cksUZzgsHcwvaXO3457X
X-Received: by 2002:a1c:a80a:: with SMTP id r10mr11865992wme.103.1566226011765;
        Mon, 19 Aug 2019 07:46:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5wmYrUldf5g0ppZ7OXdDZ2F/3C6VWfdEi/LkIbuWOQoIu7FObZ7g0uK2YnFjnL/LNfQeVcg==
X-Received: by 2002:a1c:a80a:: with SMTP id r10mr11865952wme.103.1566226011502;
        Mon, 19 Aug 2019 07:46:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f? ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
        by smtp.gmail.com with ESMTPSA id c201sm29402270wmd.33.2019.08.19.07.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 07:46:51 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 8/9] KVM: MMU: Enable Lazy mode SPPT setup
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com
Cc:     mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        yu.c.zhang@intel.com, alazar@bitdefender.com
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-9-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63f8952b-2497-16ec-ff55-1da017c50a8c@redhat.com>
Date:   Mon, 19 Aug 2019 16:46:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814070403.6588-9-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/19 09:04, Yang Weijiang wrote:
> +
> +	if (vcpu->kvm->arch.spp_active && level == PT_PAGE_TABLE_LEVEL)
> +		kvm_enable_spp_protection(vcpu->kvm, gfn);
> +

This would not enable SPP if the guest is backed by huge pages.
Instead, either the PT_PAGE_TABLE_LEVEL level must be forced for all
pages covered by SPP ranges, or (better) kvm_enable_spp_protection must
be able to cover multiple pages at once.

Paolo
