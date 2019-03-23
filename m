Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FBFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1B8218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 09:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qzYr7/IM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCWJXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 05:23:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59984 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfCWJXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 05:23:37 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A4FE1EC00FF;
        Sat, 23 Mar 2019 10:23:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553333015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=my9tgc/yGxXqoruhF1BPgrv8mw0y9KhqQ61s1C7BKE0=;
        b=qzYr7/IMYbmrRHsFn/1FRQfNlusiEQP07aXiZKKS2kZG53TU7tTiaCgTKCp0Z62fQs9Nxz
        d/osXDERCNk2s/peeJA0WSA8H54PFEhfzlifyR8mz91ehwCtdHL4uTUbF9WscpuVDN7PVR
        0a4UW8l7TKkDC40OZCIIidENLODoKSw=
Date:   Sat, 23 Mar 2019 10:23:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rui Zhao <ruizhao@outlook.com>,
        "james.morse@arm.com" <james.morse@arm.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        Rui Zhao <ruizhao@microsoft.com>
Subject: Re: [PATCH v2 1/2] EDAC: add EDAC driver for DMC520
Message-ID: <20190323092342.GD23698@zn.tnic>
References: <BN7PR08MB5572D3A5217C4749AC4E7DC4AE4C0@BN7PR08MB5572.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN7PR08MB5572D3A5217C4749AC4E7DC4AE4C0@BN7PR08MB5572.namprd08.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some initial comments. The general direction of this should be
looked at by James.

On Thu, Mar 07, 2019 at 01:24:01AM +0000, Rui Zhao wrote:
> From: Rui Zhao <ruizhao@microsoft.com>
> 
> New driver supports error detection and correction on
> the devices with ARM DMC-520 memory controller.
> 
> Signed-off-by: Rui Zhao <ruizhao@microsoft.com>
> ---
>  MAINTAINERS                |   6 +
>  drivers/edac/Kconfig       |   7 +
>  drivers/edac/Makefile      |   1 +
>  drivers/edac/dmc520_edac.c | 619 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 633 insertions(+)
>  create mode 100644 drivers/edac/dmc520_edac.c

...

> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 716096d..793d64f 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
> +obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
> diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
> new file mode 100644
> index 0000000..c70ce4e
> --- /dev/null
> +++ b/drivers/edac/dmc520_edac.c
> @@ -0,0 +1,619 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// EDAC driver for DMC-520

No "//" commenting in .c files. Make sure to have a cursory look at

Documentation/process/submitting-patches.rst

Also, this patch doesn't apply - please redo it against:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=for-next

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
