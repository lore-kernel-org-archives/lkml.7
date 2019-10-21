Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEC7CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD3A206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfJUI7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfJUI7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:59:08 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83F9AC057F2E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 08:59:08 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id c188so4235034wmd.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 01:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ydaHKAhxNtxQS4VcAKhbtvq4PL0/S2Byn9H2tf5UTNA=;
        b=ZcuYf7Hfzn+gsNLl3YwsTujlmJ47soruZjhD5NlW9njoqhcXq/QYLDU4sT3srgemf3
         ILHrhCmVm8bQAhNyTRgbElxMxfNQL1Fz7EpdkrMsQBJdPtg4XgZU0dSOTEi/4w8btKTC
         ahgKUhbmlXwXtqBu9BuyltW2CubutRPaeysc3w8hOmaBNOZi8k1OItmkINTROK/oapt7
         064BH71GwK27D78vN9GYpprcD2/zF+MyPeFKmZD1zPBHZpD5pszUcv3Aup31jVtYgHHN
         8jh2LYVI2hE6ZwmUU6Re4mfiTQ+zqSGXp19gcSCHda5CQnUWeN2CL/xxl44W41wQLd+N
         Vmug==
X-Gm-Message-State: APjAAAUli6DyBTpwC+eFjHjZe5Eb6OS5JbH9IZKY93TqREP8Brf64d3f
        SabdlNosn8dKqcKgOliP4iuN/4Q4UJsKJachgD5lVj66RqWFar/o+YLS3AmLz/puNlrFU2C5yU3
        Etdn8fPXD2d+JEtEdnJbfCdHd
X-Received: by 2002:adf:e30a:: with SMTP id b10mr17977920wrj.44.1571648347077;
        Mon, 21 Oct 2019 01:59:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzvTfGD2A4X2sMdz7QRyHNFtWkUa7wDlh66llhXCckLy8S8kW8+WYi24WlZubZvheN7zmlhjg==
X-Received: by 2002:adf:e30a:: with SMTP id b10mr17977887wrj.44.1571648346781;
        Mon, 21 Oct 2019 01:59:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:566:fc24:94f2:2f13? ([2001:b07:6468:f312:566:fc24:94f2:2f13])
        by smtp.gmail.com with ESMTPSA id z9sm14958800wrl.35.2019.10.21.01.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 01:59:06 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: remove redundant code in kvm_arch_vm_ioctl
To:     Miaohe Lin <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1571647973-18657-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e7b65d0a-8c68-10b6-5178-decfcea54e04@redhat.com>
Date:   Mon, 21 Oct 2019 10:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571647973-18657-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/19 10:52, Miaohe Lin wrote:
> If we reach here with r = 0, we will reassign r = 0
> unnecesarry, then do the label set_irqchip_out work.
> If we reach here with r != 0, then we will do the label
> work directly. So this if statement and r = 0 assignment
> is redundant. We remove them and therefore we can get rid
> of odd set_irqchip_out lable further pointed out by tglx.

While Thomas's suggestion certainly makes sense, I prefer to keep the
get and set cases similar to each other, so I queued your v1 patch.
Thanks for making the KVM code cleaner!

Paolo

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 661e2bf38526..cd4ca8c2f7de 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4913,13 +4913,8 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		}
>  
>  		r = -ENXIO;
> -		if (!irqchip_kernel(kvm))
> -			goto set_irqchip_out;
> -		r = kvm_vm_ioctl_set_irqchip(kvm, chip);
> -		if (r)
> -			goto set_irqchip_out;
> -		r = 0;
> -	set_irqchip_out:
> +		if (irqchip_kernel(kvm))
> +			r = kvm_vm_ioctl_set_irqchip(kvm, chip);
>  		kfree(chip);
>  		break;
>  	}
> 

