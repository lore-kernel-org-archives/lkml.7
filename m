Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E4C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693232081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8ZW8Ewd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfLDPgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:36:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35369 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728238AbfLDPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575473781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQOOeXeSC4acVeDbgVDeAqxSN0LyEEhsWxQonnVcIBc=;
        b=S8ZW8EwdT7uzSYnGXRFwP/tzp0mHsw82eFOF1pnJhOO/5jDzBLVdtzYMqoGcTqn799z+ev
        JGGpnefNZueaRoeEJX6+4Tiqal1E7TtGEc6YmKo52BSQwoiOUauORtY7ypWaDk4J2wE67B
        FaPswPC/wIJ1yFw3OtZfqkkHTfGq2fU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-fM31UP6BMHykjpLk_RLZmg-1; Wed, 04 Dec 2019 10:36:20 -0500
Received: by mail-wm1-f71.google.com with SMTP id p2so2335345wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:36:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iQOOeXeSC4acVeDbgVDeAqxSN0LyEEhsWxQonnVcIBc=;
        b=F37FYfHzGhIERHSFUv9SGZYyHl/RMjXKP1h4WZQ4P7Mkn/BCqLV+LRuu/TXdfSP46p
         GottSU+7YNBQhUv05Yek1SCYVrbtmKaSY9TMIK9CbiEu6U/RXBd1FVylFpBZGsaamIMD
         PEbOi4xSvK/FSphJHGVhw93fIZ2HuRE3Lpbt6NpaQa7tgEqfiRQFdLKCKx4aNhaeCEuQ
         e5w/pU74iA2eUHPuBMYRta7vpT2lRtlqDmow7v7pKnRpaHYGy9/2xRxUILo/2TtRA6IM
         /FNpYDRvvep28WIKwPBvzcifCsrSyhD+NYTqwLyyL0Gz+UkIT/O2VxMwnkVoHMcs41+I
         0vLw==
X-Gm-Message-State: APjAAAX7YRcZsVcQVqJXcQwwdTyvxdQM7dzBwyMshW+OWbfwzO2C0tKy
        ID4rNBQkRv++iiMZ32vu5nd/ajh68+zaCosFztS3YPbS+7qAuUiMnrVhxGY7xxrV/WXst1SSsLB
        UeiDlOjUcxniE0GiWHNLFVVoD
X-Received: by 2002:adf:e984:: with SMTP id h4mr4581507wrm.275.1575473779566;
        Wed, 04 Dec 2019 07:36:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqy/M5MWOKcaMYIoGibWVUMRdDrTEapMHfZlP1x2J2svqUsmIkTvIxs8nBkMZJD5A0y+qXkVRg==
X-Received: by 2002:adf:e984:: with SMTP id h4mr4581491wrm.275.1575473779351;
        Wed, 04 Dec 2019 07:36:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id n188sm8242847wme.14.2019.12.04.07.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 07:36:18 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: use CPUID to locate host page table reserved
 bits
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
References: <1575471060-55790-1-git-send-email-pbonzini@redhat.com>
 <20191204152942.GB6323@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d46bd0a8-5743-4665-85ea-14351fd85cdd@redhat.com>
Date:   Wed, 4 Dec 2019 16:36:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191204152942.GB6323@linux.intel.com>
Content-Language: en-US
X-MC-Unique: fM31UP6BMHykjpLk_RLZmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/19 16:29, Sean Christopherson wrote:
> 
> The extra bit of paranoia doesn't cost much, so play it safe?  E.g.:
> 
> 	if (unlikely(boot_cpu_data.extended_cpuid_level < 0x80000008)) {
> 		WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_TME) || SME?);
> 		return boot_cpu_data.x86_phys_bits;
> 	}
> 
> 	return cpuid_eax(0x80000008) & 0xff;

Sounds good.  I wouldn't bother with the WARN even.

Paolo

