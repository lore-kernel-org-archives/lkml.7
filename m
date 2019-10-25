Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F371CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE8021D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438921AbfJYJn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:43:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48011 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438841AbfJYJn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:43:56 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7055F4E83E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:43:56 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id l184so643277wmf.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQMby8CZSJniqh4uopuVoL0d2iSgxdS4fKi9gs56q5c=;
        b=bzheGcpyyxx3gdpD8Ab9XDp7FG20jl6gBQzPw08RCE0cQQjNeOR5ZFw9yxfA34TES6
         7DYhosuJv5vzLOPB0HvYeqAzR+entF8RuykfZIEPoalw9B7i8zSRaWGhaaNNdBaPN3HE
         yaDTiWuSUvbN4t1AMpZubDn9B43xHuiZVKfW9lFu5wD3VdtQ6o1vLmxZUPYuiwVDPTwm
         s1I2O4aI6Zx+/W8445e8TpQUCaNJo06DIpNHvsKkn5GrRYIE/s4SR9AGmg+G2lGAcqSV
         nPpA6A6ALdyobPhOrB2IyhqQcIViuasEt5jI3sU36/JGN7gAZ0qsDI8haDfmcpxmav+u
         hE6w==
X-Gm-Message-State: APjAAAUVQhpM1vdLAdZFoJlmbGZxfRz7wSa+pCNYlKc3cpM1HnF+XYc9
        NsOb0TZOOM6x5upYodTJm8hUMaWA5L9BG8K/Q6BmXxAY0qiPvIMqht0efXvEG+/cOy18JyQmwVB
        3mzkAVKtsSH28wxfJ4LkPA8bM
X-Received: by 2002:a1c:7e57:: with SMTP id z84mr2736431wmc.84.1571996634788;
        Fri, 25 Oct 2019 02:43:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4P0x3HWNFBaL87i3kllo1EHrbNDatuCnfoVLYIXHeIIElpykyGmW+yCU7P+vw8tejmbzgmw==
X-Received: by 2002:a1c:7e57:: with SMTP id z84mr2736400wmc.84.1571996634474;
        Fri, 25 Oct 2019 02:43:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:302c:998e:a769:c583? ([2001:b07:6468:f312:302c:998e:a769:c583])
        by smtp.gmail.com with ESMTPSA id u1sm1850401wru.90.2019.10.25.02.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 02:43:54 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: get rid of odd out jump label in pdptrs_changed
To:     Miaohe Lin <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1571968878-10437-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ecd5eb9a-938b-a8f3-ed69-76d2343bfdcc@redhat.com>
Date:   Fri, 25 Oct 2019 11:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571968878-10437-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/19 04:01, Miaohe Lin wrote:
> -	if (r < 0)
> -		goto out;
> -	changed = memcmp(pdpte, vcpu->arch.walk_mmu->pdptrs, sizeof(pdpte)) != 0;
> -out:
> +	if (r >= 0)
> +		changed = memcmp(pdpte, vcpu->arch.walk_mmu->pdptrs,
> +				 sizeof(pdpte)) != 0;
>  
>  	return changed;

Even better:

	if (r < 0)
		return true;

	return memcmp(...) != 0;

Paolo
