Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE814C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A40206E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfKMSUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:20:18 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:54680 "EHLO
        4.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfKMSUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:20:18 -0500
X-Greylist: delayed 4199 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 13:20:17 EST
Received: from player792.ha.ovh.net (unknown [10.109.159.139])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id B59F01B1309
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 18:00:53 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
        (Authenticated sender: clg@kaod.org)
        by player792.ha.ovh.net (Postfix) with ESMTPSA id B5E55C0CFAD3;
        Wed, 13 Nov 2019 17:00:36 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] KVM: PPC: Book3S HV: XIVE: Fix potential page leak
 on error path
To:     Greg Kurz <groug@kaod.org>, Paul Mackerras <paulus@ozlabs.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Lijun Pan <ljp@linux.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Laurent Vivier <lvivier@redhat.com>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <157366357346.1026356.14522564753643067538.stgit@bahia.lan>
 <157366357929.1026356.18181561111939034621.stgit@bahia.lan>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e49f522e-c265-4f00-f6f8-57f8583e7d8a@kaod.org>
Date:   Wed, 13 Nov 2019 18:00:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157366357929.1026356.18181561111939034621.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3946560650099067671
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefuddgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2019 17:46, Greg Kurz wrote:
> We need to check the host page size is big enough to accomodate the
> EQ. Let's do this before taking a reference on the EQ page to avoid
> a potential leak if the check fails.
> 
> Cc: stable@vger.kernel.org # v5.2
> Fixes: 13ce3297c576 ("KVM: PPC: Book3S HV: XIVE: Add controls for the EQ configuration")
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  arch/powerpc/kvm/book3s_xive_native.c |   13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
> index 0e1fc5a16729..d83adb1e1490 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -630,12 +630,6 @@ static int kvmppc_xive_native_set_queue_config(struct kvmppc_xive *xive,
>  
>  	srcu_idx = srcu_read_lock(&kvm->srcu);
>  	gfn = gpa_to_gfn(kvm_eq.qaddr);
> -	page = gfn_to_page(kvm, gfn);
> -	if (is_error_page(page)) {
> -		srcu_read_unlock(&kvm->srcu, srcu_idx);
> -		pr_err("Couldn't get queue page %llx!\n", kvm_eq.qaddr);
> -		return -EINVAL;
> -	}
>  
>  	page_size = kvm_host_page_size(kvm, gfn);
>  	if (1ull << kvm_eq.qshift > page_size) {
> @@ -644,6 +638,13 @@ static int kvmppc_xive_native_set_queue_config(struct kvmppc_xive *xive,
>  		return -EINVAL;
>  	}
>  
> +	page = gfn_to_page(kvm, gfn);
> +	if (is_error_page(page)) {
> +		srcu_read_unlock(&kvm->srcu, srcu_idx);
> +		pr_err("Couldn't get queue page %llx!\n", kvm_eq.qaddr);
> +		return -EINVAL;
> +	}
> +
>  	qaddr = page_to_virt(page) + (kvm_eq.qaddr & ~PAGE_MASK);
>  	srcu_read_unlock(&kvm->srcu, srcu_idx);
>  
> 

