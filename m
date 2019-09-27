Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86131C388F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CC8217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfI0QEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:04:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfI0QEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:04:10 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2A518E3C0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 16:04:09 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t11so1298227wrq.19
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zh+Gx5PwwVKdeDWi3jhCdBU5FRDNxnrksZQjh/dlYcc=;
        b=HI5TzP0QW8qeh76CLRixGMPVqrjL0NHYY9scAdvv1tVZOKFSRhH8S2lwfA9PpdbOH3
         vWoUTyg/cWWKr2KtaFyOJ8PaPXntNVeKQbYb7kad5LGyo8IxloX90M3hcvxd9sVhlbBt
         EWYW+IWDtUNKV6JaBbTtbf8bEFXTUqiUQhy/ggQX41l5LaeiZQDj/dymqOgVrDZf7BvV
         W6w4Bv4wCjnA6wVOL/EmW4Xk+8jMCJAqem9I+cGV4pmpZ8K/ya04M6IubESHI9B6vlkm
         h999iQITnUBHTPX0Oc/snOgzjoHDTqVL3+MBtGgNKQI4APgtctCBq3eVtUuhwXTEP6em
         RAYw==
X-Gm-Message-State: APjAAAVvwWkFWtMnp8QLleGpXnfVk3iYtUXj9KRC7IqiPuP52NfzQljb
        DkkELdWe9QGUYP9Wuh6XhqMGYLM4K+Yqy180xutfdur/X7x8dpp7m6XEDOQlqr1ZF+dREwxQVhy
        CdWaymIB2nKvLUF25fyKEm2Nf
X-Received: by 2002:a7b:c44e:: with SMTP id l14mr7651129wmi.54.1569600248349;
        Fri, 27 Sep 2019 09:04:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWCWWEgvtbfP8tFNFrYxTeDjwqqbjb1LcwVpGacnUNRXDDVumsprGOGpdcibQ/fi3YaLe08A==
X-Received: by 2002:a7b:c44e:: with SMTP id l14mr7651099wmi.54.1569600248037;
        Fri, 27 Sep 2019 09:04:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id 79sm9003635wmb.7.2019.09.27.09.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 09:04:06 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Set VMENTER_L1D_FLUSH_NOT_REQUIRED if
 !X86_BUG_L1TF
To:     Borislav Petkov <bp@alien8.de>, Waiman Long <longman@redhat.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190826193023.23293-1-longman@redhat.com>
 <6bc37d29-b691-28d6-d4dc-9402fa82093a@redhat.com>
 <20190927155518.GB23002@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2d6ade0b-a0c1-89d8-49ab-503df9e53266@redhat.com>
Date:   Fri, 27 Sep 2019 18:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927155518.GB23002@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/19 17:55, Borislav Petkov wrote:
> I'd move that logic with the if (boot_cpu_has(X86_BUG_L1TF)) check inside
> vmx_setup_l1d_flush() so that I have this:
> 
>         if (!boot_cpu_has_bug(X86_BUG_L1TF)) {
>                 l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_NOT_REQUIRED;
>                 return 0;
>         }
> 
> 	if (!enable_ept) {
> 		...
> 
> 	}
> 
> inside the function and outside am left with:
> 
> 	r = vmx_setup_l1d_flush(vmentry_l1d_flush_param);
>         if (r) {
> 		vmx_exit();
>                 return r;
> 	}
> 
> only. This way I'm concentrating the whole l1tf_vmx_mitigation picking
> apart in one place.

Right you are, I'm sending v2.

Paolo
