Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6711C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0FA207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 16:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfI0QCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 12:02:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbfI0QCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 12:02:10 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60F66C08C321
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 16:02:10 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a15so1308476wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 09:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4PbefLzpSAtONZJJIIROFydpszw7sXdei5rCTJaRwY=;
        b=AGwI7d5BBDPX9/hgcrGO2oiRA+FbF0YSu2Ljn90M3pNYtMQMBoTJlppB3nscCv9Vgx
         caD3xXTaqOcDDZW6uf1TKb8vorjxjFLiI451thIq63nsxL4a74bD06JNhrkGEroIw5PQ
         JuNYwrXUhxDGvNg3Of74LHrf4EydvjPt793Ls6M2hrRDpzbjzmez+js6aOn2SFQsgWL7
         dqdPsDiMbLzYIYf0f0GztopStmtVS6UR0p6OVaWzPBFVS5fpLgYNxEXycfENaOp/LMVs
         gxRaGDz8Aw1lvJSD0SSwgc/4dqzfMKuISVbAB8+qVdEQu7bgnDGN99kmijz1uMspx7Xb
         2edQ==
X-Gm-Message-State: APjAAAWXvAFXhxu0eKe/pr0JGPb4F84pCBz1KH0gsotOV9PIvACc28Ud
        sYeroHqDz1BL56Os1JHomqCEq1hjnY5E2ACqbEEAncBX0cQiRX04m4TjJKuGY53WOZP9LxLoAFL
        jzD3lhG4dP0maeFp3/VSVwLbx
X-Received: by 2002:adf:e410:: with SMTP id g16mr3318120wrm.297.1569600128544;
        Fri, 27 Sep 2019 09:02:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzEKYsKgnVro8P+Ze/5n9ou5KpdYkn8SFSZf8bABTUb0f2m8lV6wdSqvHKlpEei/5C0k1VI0w==
X-Received: by 2002:adf:e410:: with SMTP id g16mr3318092wrm.297.1569600128295;
        Fri, 27 Sep 2019 09:02:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id w18sm6277327wmc.9.2019.09.27.09.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 09:02:07 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Set VMENTER_L1D_FLUSH_NOT_REQUIRED if
 !X86_BUG_L1TF
To:     Waiman Long <longman@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190826193023.23293-1-longman@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3f639295-9597-c644-f3bb-90c6d606689b@redhat.com>
Date:   Fri, 27 Sep 2019 18:02:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826193023.23293-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/19 21:30, Waiman Long wrote:
> The l1tf_vmx_mitigation is only set to VMENTER_L1D_FLUSH_NOT_REQUIRED
> when the ARCH_CAPABILITIES MSR indicates that L1D flush is not required.
> However, if the CPU is not affected by L1TF, l1tf_vmx_mitigation will
> still be set to VMENTER_L1D_FLUSH_AUTO. This is certainly not the best
> option for a !X86_BUG_L1TF CPU.
> 
> So force l1tf_vmx_mitigation to VMENTER_L1D_FLUSH_NOT_REQUIRED to make it
> more explicit in case users are checking the vmentry_l1d_flush parameter.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 42ed3faa6af8..a00ce3d6bbfd 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7896,6 +7896,8 @@ static int __init vmx_init(void)
>  			vmx_exit();
>  			return r;
>  		}
> +	} else {
> +		l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_NOT_REQUIRED;
>  	}
>  
>  #ifdef CONFIG_KEXEC_CORE
> 

Queued (for -rc2), thanks.

Paolo
