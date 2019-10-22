Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6181CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926922184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbfJVKvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:51:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388372AbfJVKvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:51:05 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B06E4E92A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 10:51:04 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id u17so1710940wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 03:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vdKl6DDKIlJEFdLjcPMS36s2s1FJIcIbFPms1LIdy0I=;
        b=IxEfcWdHXw5jKgHbcwDMhygYzkdxhbUGR+ReFVqWSY+5Nt7TgLsKb87fmhzIy3J/Yw
         EZvSMiJIrL7M89UBynVCjlTHXp6ni2j71sCgYG7qh1ZncvvUayE+McAo1HsmKFiZT+FY
         05RYQKSBOlgahF2gs1I2YiJV8rTralBB9xWfuUgr4tTMRFzCS7w9O9Ze1OGnnobnhjGf
         VKn56q+QqlH8oAp/di2SuuRGyo/RQ899VYks/eTdtcyakoWdSWMn3g9tbchjwimDkTo/
         JHLX/Ov6sORU5rC1k6SQb+7cg3h5yefKCQy3x/U84Qdg1YGHrvHKJoVzjxH323ITMv20
         Gp/Q==
X-Gm-Message-State: APjAAAUK2ZKmFECn7pJho5eoKtG9lhUtKCyPzz4sT95uiqgmsuiIzb4X
        AGU2eD1a5QBnIMJaoBAaOTJG36ncWsKB7bSCxiP7/Pn8OAfwQN5cOcREY/c5DwWeNq2D1uac0PQ
        BlinolHF251WSADlCzJ1NG3ye
X-Received: by 2002:adf:e446:: with SMTP id t6mr2862396wrm.7.1571741463185;
        Tue, 22 Oct 2019 03:51:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwLRJDFeoklnPCvIdpTLdkWG0AASVA51wAqpaeBkfAXh2wTKGAZAwI2bUd5RCu2qeXwOkem1Q==
X-Received: by 2002:adf:e446:: with SMTP id t6mr2862368wrm.7.1571741462908;
        Tue, 22 Oct 2019 03:51:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:45c:4f58:5841:71b2? ([2001:b07:6468:f312:45c:4f58:5841:71b2])
        by smtp.gmail.com with ESMTPSA id b62sm25553598wmc.13.2019.10.22.03.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 03:51:02 -0700 (PDT)
Subject: Re: [PATCH v2 05/16] KVM: VMX: Drop initialization of
 IA32_FEATURE_CONTROL MSR
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org
References: <20191021234632.32363-1-sean.j.christopherson@intel.com>
 <20191022000820.1854-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <59cbc79a-fb06-f689-aa24-0ba923783345@redhat.com>
Date:   Tue, 22 Oct 2019 12:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022000820.1854-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/19 02:08, Sean Christopherson wrote:
> Remove the code to initialize IA32_FEATURE_CONTROL MSR when KVM is
> loaded now that the MSR is initialized during boot on all CPUs that
> support VMX, i.e. can possibly load kvm_intel.
> 
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 48 +++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 29 deletions(-)

I am still not sure about this...  Enabling VMX is adding a possible
attack vector for the kernel, we should not do it unless we plan to do a
VMXON.  Why is it so important to operate with locked
IA32_FEATURE_CONTROL (so that KVM can enable VMX and the kernel can
still enable SGX if desired).

Paolo
