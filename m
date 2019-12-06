Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF39C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 11:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFB721823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575632594;
	bh=c7EjslI+4pNqXJD3VTk18zxOcydEr3dkPS5ZXAZV/qs=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=bM1O0l5zNCbhXZkBVxh46oN3/dCLgOBQ+B0m7lEN6BIJthL7b6EL2oXm7QW/eHXM3
	 v1X4GyWvdB+dXju3POX8LyIZ2MTAUz9cj1lBjVFRjVKEeqU2xmfEXuomp8E4m3E0Rg
	 myViVzc8j1wX9j9cu8Y+LRLPuqVypMgHuIza9z94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLFLnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:43:13 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:55209 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbfLFLnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 06:43:13 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1idC0j-0001qF-ES; Fri, 06 Dec 2019 12:43:01 +0100
To:     linmiaohe <linmiaohe@huawei.com>
Subject: Re: [PATCH] KVM: arm: get rid of unused arg in  =?UTF-8?Q?cpu=5Finit=5Fhyp=5Fmode=28=29?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Dec 2019 11:43:01 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <pbonzini@redhat.com>, <rkrcmar@redhat.com>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>
In-Reply-To: <1574320559-5662-1-git-send-email-linmiaohe@huawei.com>
References: <1574320559-5662-1-git-send-email-linmiaohe@huawei.com>
Message-ID: <2ca295ccc30b53b4d57098d9718f8aa3@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linmiaohe@huawei.com, pbonzini@redhat.com, rkrcmar@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-21 07:15, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> As arg dummy is not really needed, there's no need to pass
> NULL when calling cpu_init_hyp_mode(). So clean it up.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  virt/kvm/arm/arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
> index 86c6aa1cb58e..a5470f1b1a19 100644
> --- a/virt/kvm/arm/arm.c
> +++ b/virt/kvm/arm/arm.c
> @@ -1315,7 +1315,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  	}
>  }
>
> -static void cpu_init_hyp_mode(void *dummy)
> +static void cpu_init_hyp_mode(void)
>  {
>  	phys_addr_t pgd_ptr;
>  	unsigned long hyp_stack_ptr;
> @@ -1349,7 +1349,7 @@ static void cpu_hyp_reinit(void)
>  	if (is_kernel_in_hyp_mode())
>  		kvm_timer_init_vhe();
>  	else
> -		cpu_init_hyp_mode(NULL);
> +		cpu_init_hyp_mode();
>
>  	kvm_arm_init_debug();

Applied, thanks.

         M.
-- 
Jazz is not dead. It just smells funny...
