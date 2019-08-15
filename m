Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97CBC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC0A208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565878349;
	bh=bVo1vM/u9VfDp0fe1xQNLJisI/L3cW+wefdHvp3omfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eC0iazQU4BZLZX1zoYHw9vLkuaEU2m6zJUt558CFt50KBTNX2FYzMDNOmkECQerdq
	 kSmdbJaTTBuUVXXHo9JFV135qXCIzh2jGSUnxW3UF55lrZw+JMoIzyVazH134qf1pY
	 TEpD5ohSsh41/mCzw0lriV99p+l4JvG8191l9S9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbfHOOM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730032AbfHOOM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:12:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD30206C2;
        Thu, 15 Aug 2019 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565878347;
        bh=bVo1vM/u9VfDp0fe1xQNLJisI/L3cW+wefdHvp3omfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v74QQEyp1kd/cBRhv3XVRRHs0/beJQVEF3URg6texKvNTDjx0aMl0FYcHyG1WRDJJ
         fdMVg0lJbOdZEArA6Pp7XFRqQ5p4lWAsa5AFh1iYc2WMA+5D4vvaUFBaG41VizPoMC
         vHEXVix2+MdDH59pepswh+ZWZl+MSWd12zdFSBIc=
Date:   Thu, 15 Aug 2019 16:12:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190815141225.GC23267@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> diff --git a/include/uapi/misc/uacce.h b/include/uapi/misc/uacce.h
> new file mode 100644
> index 0000000..44a0a5d
> --- /dev/null
> +++ b/include/uapi/misc/uacce.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _UAPIUUACCE_H
> +#define _UAPIUUACCE_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define UACCE_CLASS_NAME	"uacce"

Why is this in a uapi file?

> +#define UACCE_DEV_ATTRS		"attrs"

Same here.

> +#define UACCE_CMD_SHARE_SVAS	_IO('W', 0)
> +#define UACCE_CMD_START		_IO('W', 1)
> +#define UACCE_CMD_GET_SS_DMA	_IOR('W', 2, unsigned long)
> +
> +/**
> + * UACCE Device Attributes:
> + *
> + * NOIOMMU: the device has no IOMMU support
> + *	can do share sva, but no map to the dev
> + * PASID: the device has IOMMU which support PASID setting
> + *	can do share sva, mapped to dev per process
> + * FAULT_FROM_DEV: the device has IOMMU which can do page fault request
> + *	no need for share sva, should be used with PASID
> + * SVA: full function device
> + * SHARE_DOMAIN: no PASID, can do share sva only for one process and the kernel
> + */
> +#define UACCE_DEV_NOIOMMU		(1 << 0)
> +#define UACCE_DEV_PASID			(1 << 1)
> +#define UACCE_DEV_FAULT_FROM_DEV	(1 << 2)
> +#define UACCE_DEV_SVA		(UACCE_DEV_PASID | UACCE_DEV_FAULT_FROM_DEV)
> +#define UACCE_DEV_SHARE_DOMAIN	(0)
> +
> +#define UACCE_API_VER_NOIOMMU_SUBFIX	"_noiommu"
> +
> +#define UACCE_QFR_NA ((unsigned long)-1)
> +enum uacce_qfrt {
> +	UACCE_QFRT_MMIO = 0,	/* device mmio region */
> +	UACCE_QFRT_DKO,		/* device kernel-only */
> +	UACCE_QFRT_DUS,		/* device user share */
> +	UACCE_QFRT_SS,		/* static share memory */
> +	UACCE_QFRT_MAX,

These enums need to be explicitly set, as per the documentation,
otherwise they could be messed up when dealing with odd compilers.

> +};
> +#define UACCE_QFRT_INVALID UACCE_QFRT_MAX

Why not just use INVALID instead of MAX?

thanks,

greg k-h
