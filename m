Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE46C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAB320651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfHSPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:18:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfHSPSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:18:03 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6F91C05975D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:18:02 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id g5so91290wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tFK/2DMY9q6eOmfekCYuwpB3kuZu21btnlVWLmyIxL4=;
        b=aCI/m+VfpO1ckF1OQeM7gWSS8VE7iDT/YyVAkar/tGtnWPxWjhk66tHPBnydyRdJlg
         04bKrZxLVTFGS06WPIlp0mRcHtEM1sDYx+9N6xxnp/82fyHq84je3Lj0tZf9s3z7mFm3
         GqUEH4b4yy4TIVuaVbg17whL8hNqfY7xN8x+RSRAStLZaAkLZIOmKK/BSEyN9BO4cDeu
         dRYHyrGALjtff7qasF4mYQeTgMW52sm5qP7JRDp37AQdhQb/vcn8FDsK5XZ2NFPoFu8B
         6lmFuH7mtu9/wZGB86MioI74gK7Cmlw7UbJyFra74D8oSfuir+eXp8ybkBreLle2B+0t
         iZ4g==
X-Gm-Message-State: APjAAAXSj/Iz6WWv5UizBhvxEWFgl9e0fO1TeKSMfX1p3Tcw65fXn24H
        kWWaTmSdYS3KEfta32jl0OnLvqxNMLb3Y8k+4zROjE3zvjhH8ItBDpE/vbEA+kT/yJ+Sly7R4Ou
        HXAvajdJh5jgGYA1LO1U41IKK
X-Received: by 2002:a1c:9e4b:: with SMTP id h72mr20033979wme.99.1566227881394;
        Mon, 19 Aug 2019 08:18:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwG3aInZcHfj+Xk9fzqy4JDN13omWZpnKB32m676GPtOSbmueYAVxw6y0pJkMhO7pGEM+bJIA==
X-Received: by 2002:a1c:9e4b:: with SMTP id h72mr20033957wme.99.1566227881065;
        Mon, 19 Aug 2019 08:18:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8033:56b6:f047:ba4f? ([2001:b07:6468:f312:8033:56b6:f047:ba4f])
        by smtp.gmail.com with ESMTPSA id o5sm12416090wrv.20.2019.08.19.08.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 08:18:00 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: x86: fix reporting of AMD speculation bug CPUID
 leaf
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
References: <1565854883-27019-1-git-send-email-pbonzini@redhat.com>
 <1565854883-27019-2-git-send-email-pbonzini@redhat.com>
 <CALMp9eQcRbMjQ_=jQ=qaYmh1Lavc3PYvm4Qcf3zY+N8j3zZe-w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e29f624-10f5-7ab5-1823-280f32732b68@redhat.com>
Date:   Mon, 19 Aug 2019 17:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQcRbMjQ_=jQ=qaYmh1Lavc3PYvm4Qcf3zY+N8j3zZe-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/19 23:45, Jim Mattson wrote:
> On Thu, Aug 15, 2019 at 12:41 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The AMD_* bits have to be set from the vendor-independent
>> feature and bug flags, because KVM_GET_SUPPORTED_CPUID does not care
>> about the vendor and they should be set on Intel processors as well.
>> On top of this, SSBD, STIBP and AMD_SSB_NO bit were not set, and
>> VIRT_SSBD does not have to be added manually because it is a
>> cpufeature that comes directly from the host's CPUID bit.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> On AMD systems, aren't AMD_SSBD, AMD_STIBP, and AMD_SSB_NO set by
> inheritance from the host:
> 
> /* cpuid 0x80000008.ebx */
> const u32 kvm_cpuid_8000_0008_ebx_x86_features =
>         F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
>         F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON);
> 
> I am curious why the cross-vendor settings go only one way. For
> example, you set AMD_STIBP on Intel processors that have STIBP, but
> you do not set INTEL_STIBP on AMD processors that have STIBP?
> Similarly, you set AMD_SSB_NO for Intel processors that are immune to
> SSB, but you do not set IA32_ARCH_CAPABILITIES.SSB_NO for AMD
> processors that are immune to SSB?
> 
> Perhaps there is another patch coming for reporting Intel bits on AMD?

I wasn't going to work on it but yes, they should be.  This patch just
fixed what was half-implemented.

Paolo
