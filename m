Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EE8C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F862082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHSPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:05:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfHSPFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:05:20 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85C88C08EC01
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:05:20 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id q9so5377004wrc.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bmeTxHw//EIz7MDBf48uvsF9/9rAGn75Ch54N3RQf+c=;
        b=jzj01HN36MMcpnqFsZEzqjzJHtiNzCQ7IcLAsuiraf0bofPEy/syouSBlXzi0me5JS
         a8JG+IWALqyByVKLR0Mc4EwAPrxp1GuUTKcFO/XZcQLzhW6a01tFfYwbYProZzGr8Z/r
         SWOMX6EcREjYYWLl/wE4dFVZboKYC5CPBpP3pmErwFiBaf7VA8+ORK68f8FLW+n5dExj
         rFLlq2VaaND8Y0Kqd6ZhTd4aktE2EIlkWQG2jd9wGQjZfcf58fifpKSBUIYhSHR1dtvG
         mYyksveD1wgg0YkUmCMVHxP1uITML74TqOS+X3oCnyqA2uAvLKg0HIToE8gsj3yuXt+O
         czWA==
X-Gm-Message-State: APjAAAWd+E7BWzcgjj951iedELUfK9DLfUwFwJz5sEx1dxqDNLQjXiYh
        SiWM8pembc7uJVOD8o232HNWTUrNEq1z40CfTZ0R8g8a1XChGkgEFOu7OOWD1gR6GSfaosGVt4D
        bnEiuYG72e0vctDNtOZ4Pn06Y
X-Received: by 2002:adf:e78c:: with SMTP id n12mr27328055wrm.83.1566227119169;
        Mon, 19 Aug 2019 08:05:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwswmEoLm6iU6z7NMMScqjY1STar/e01s0ghk+Sod0rrzWGNQUnVO7hfMTZiHRwYAO8dTiwCw==
X-Received: by 2002:adf:e78c:: with SMTP id n12mr27328013wrm.83.1566227118905;
        Mon, 19 Aug 2019 08:05:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f? ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
        by smtp.gmail.com with ESMTPSA id l62sm13358486wml.13.2019.08.19.08.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:05:18 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 5/9] KVM: VMX: Add init/set/get functions for
 SPP
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com
Cc:     mst@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        yu.c.zhang@intel.com, alazar@bitdefender.com
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-6-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e235b490-0932-3ebf-dee0-f3359216ed9f@redhat.com>
Date:   Mon, 19 Aug 2019 17:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814070403.6588-6-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/19 09:03, Yang Weijiang wrote:
> +
> +int kvm_mmu_get_subpages(struct kvm *kvm, struct kvm_subpage *spp_info,
> +			 bool mmu_locked)
> +{
> +	u32 *access = spp_info->access_map;
> +	gfn_t gfn = spp_info->base_gfn;
> +	int npages = spp_info->npages;
> +	struct kvm_memory_slot *slot;
> +	int i;
> +	int ret;
> +
> +	if (!kvm->arch.spp_active)
> +	      return -ENODEV;
> +
> +	if (!mmu_locked)
> +	      spin_lock(&kvm->mmu_lock);
> +

Do not add this argument.  Just lock mmu_lock in the callers.

Paolo
