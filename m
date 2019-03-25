Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64933C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F78F206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfCYWxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:53:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729552AbfCYWxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:53:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6556C308338E;
        Mon, 25 Mar 2019 22:53:51 +0000 (UTC)
Received: from ovpn-118-18.phx2.redhat.com (ovpn-118-18.phx2.redhat.com [10.3.118.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 997E0100194A;
        Mon, 25 Mar 2019 22:53:50 +0000 (UTC)
Message-ID: <127a9356a7bf597d35dd361f2b16bf80460f0370.camel@redhat.com>
Subject: Re: [PATCH 03/17] fpga: dfl: fme: support 512bit data width PR
From:   Scott Wood <swood@redhat.com>
To:     Wu Hao <hao.wu@intel.com>, atull@kernel.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Date:   Mon, 25 Mar 2019 17:53:50 -0500
In-Reply-To: <1553483264-5379-4-git-send-email-hao.wu@intel.com>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
         <1553483264-5379-4-git-send-email-hao.wu@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 25 Mar 2019 22:53:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 11:07 +0800, Wu Hao wrote:
> In early partial reconfiguration private feature, it only
> supports 32bit data width when writing data to hardware for
> PR. 512bit data width PR support is an important optimization
> for some specific solutions (e.g. XEON with FPGA integrated),
> it allows driver to use AVX512 instruction to improve the
> performance of partial reconfiguration. e.g. programming one
> 100MB bitstream image via this 512bit data width PR hardware
> only takes ~300ms, but 32bit revision requires ~3s per test
> result.
> 
> Please note now this optimization is only done on revision 2
> of this PR private feature which is only used in integrated
> solution that AVX512 is always supported.
> 
> Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-fme-main.c |  3 ++
>  drivers/fpga/dfl-fme-mgr.c  | 75 +++++++++++++++++++++++++++++++++++++---
> -----
>  drivers/fpga/dfl-fme-pr.c   | 45 ++++++++++++++++-----------
>  drivers/fpga/dfl-fme.h      |  2 ++
>  drivers/fpga/dfl.h          |  5 +++
>  5 files changed, 99 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 086ad24..076d74f 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -21,6 +21,8 @@
>  #include "dfl.h"
>  #include "dfl-fme.h"
>  
> +#define DRV_VERSION	"0.8"

What is this going to be used for?  Under what circumstances will the
driver version be bumped?  What does it have to do with 512-bit writes?

> +#if defined(CONFIG_X86) && defined(CONFIG_AS_AVX512)
> +
> +#include <asm/fpu/api.h>
> +
> +static inline void copy512(void *src, void __iomem *dst)
> +{
> +	kernel_fpu_begin();
> +
> +	asm volatile("vmovdqu64 (%0), %%zmm0;"
> +		     "vmovntdq %%zmm0, (%1);"
> +		     :
> +		     : "r"(src), "r"(dst));
> +
> +	kernel_fpu_end();
> +}

Shouldn't there be some sort of check that AVX512 is actually supported
on the running system?

Also, src should be const, and the asm statement should have a memory
clobber.

> +#else
> +static inline void copy512(void *src, void __iomem *dst)
> +{
> +	WARN_ON_ONCE(1);
> +}
> +#endif

Likewise, this will be called if a revision 2 device is used on non-x86
(or on x86 with an old binutils).  The driver should fall back to 32-bit
in such cases.

> @@ -200,21 +228,32 @@ static int fme_mgr_write(struct fpga_manager *mgr,
>  			pr_credit = FIELD_GET(FME_PR_STS_PR_CREDIT,
> pr_status);
>  		}
>  
> -		if (count < 4) {
> +		if (count < priv->pr_datawidth) {
>  			dev_err(dev, "Invalid PR bitstream size\n");
>  			return -EINVAL;

Shouldn't this have become a WARN_ON in patch 2 given that the kernel
already pads the buffer?

>  		}
>  
> -		pr_data = 0;
> -		pr_data |= FIELD_PREP(FME_PR_DATA_PR_DATA_RAW,
> -				      *(((u32 *)buf) + i));
> -		writeq(pr_data, fme_pr + FME_PR_DATA);
> -		count -= 4;
> +		switch (priv->pr_datawidth) {
> +		case 4:
> +			pr_data = 0;
> +			pr_data |= FIELD_PREP(FME_PR_DATA_PR_DATA_RAW,
> +					*((u32 *)buf));

I know it's not new, but why not just "pr_data = FIELD..."?  Const should
also be preserved in the cast, and you can drop one set of parentheses.

> +			writeq(pr_data, fme_pr + FME_PR_DATA);
> +			break;
> +		case 64:
> +			copy512((void *)buf, fme_pr + FME_PR_512_DATA);
> +			break;

Unnecessary cast.

> +		default:
> +			ret = -EFAULT;
> +			goto done;

How is it EFAULT?  Any other value for pr_datawidth should be WARN_ON
since it's set by kernel code.

> @@ -159,13 +161,10 @@ static int fme_pr(struct platform_device *pdev,
> unsigned long arg)
>  		fpga_bridges_put(&region->bridge_list);
>  
>  	put_device(&region->dev);
> -unlock_exit:
> -	mutex_unlock(&pdata->lock);
>  free_exit:
>  	vfree(buf);
> -	if (copy_to_user((void __user *)arg, &port_pr, minsz))
> -		return -EFAULT;
> -

Why is the copy_to_user being removed?

-Scott

