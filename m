Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC14CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011C820640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfJUIRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:17:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33647 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfJUIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:17:11 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iMSrp-0004FX-Ek; Mon, 21 Oct 2019 10:16:41 +0200
Date:   Mon, 21 Oct 2019 10:16:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: remove redundant code in kvm_arch_vm_ioctl
In-Reply-To: <1571626376-11357-1-git-send-email-linmiaohe@huawei.com>
Message-ID: <alpine.DEB.2.21.1910211015260.1904@nanos.tec.linutronix.de>
References: <1571626376-11357-1-git-send-email-linmiaohe@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Miaohe Lin wrote:
> If we reach here with r = 0, we will reassign r = 0
> unnecesarry, then do the label set_irqchip_out work.
> If we reach here with r != 0, then we will do the label
> work directly. So this if statement and r = 0 assignment
> is redundant.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 661e2bf38526..0b3ebc2afb3d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4916,9 +4916,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		if (!irqchip_kernel(kvm))
>  			goto set_irqchip_out;
>  		r = kvm_vm_ioctl_set_irqchip(kvm, chip);
> -		if (r)
> -			goto set_irqchip_out;
> -		r = 0;
>  	set_irqchip_out:
>  		kfree(chip);
>  		break;

Can you please get rid of that odd jump label completely?

  		if (irqchip_kernel(kvm))
			r = kvm_vm_ioctl_set_irqchip(kvm, chip);

Hmm?


Thanks,

	tglx
