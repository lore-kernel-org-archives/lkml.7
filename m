Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37688C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA7020840
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0wF09O3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFHEuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 00:50:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53320 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFHEuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 00:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gwZHN6g8rrJZZNXc5XgsWcgNpvLcubn0e/88oGuv6nA=; b=Q0wF09O3nya3WaZACBVPt/lVP
        UxWlscZ4Ii2/bdHaA47KI7ySk2JnjiSpsFyrdjtW57qnC7JiYFXDt/0TN4bx04QSZphix1/xhgZPD
        Bnmqo+95y/pkeohfeD/h/QD8SXP9mODnBy8wMSvUAQ7AMCP6TvMfNNyjbPLNqMgCrKBrjWjFZGCQE
        Geql4V7BmpM566hjQcUr2essMDn1Q6thYrsEwhkKtFRCTHOmVogJvb7orUP0+vTiiaTOdy8jXIvV4
        aKXPA03ijb9l4XW8LiogXE6vnA8Uo9mcuIWKML52Z6h0Qz/dm5RJBqe5QTx00IidFPn+ZVDyJUq6L
        tuSAozzXg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZTIq-0003jj-6K; Sat, 08 Jun 2019 04:50:04 +0000
Subject: Re: [PATCHv16 3/3] ARM:drm ivip Intel FPGA Video and Image Processing
 Suite
To:     "Hean-Loong, Ong" <hean.loong.ong@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, chin.liang.see@intel.com,
        Ong@vger.kernel.org
References: <20190607143022.427-1-hean.loong.ong@intel.com>
 <20190607143022.427-4-hean.loong.ong@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bc42cad0-8c03-4e22-4475-c25f2e824944@infradead.org>
Date:   Fri, 7 Jun 2019 21:50:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607143022.427-4-hean.loong.ong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/19 7:30 AM, Hean-Loong, Ong wrote:
> diff --git a/drivers/gpu/drm/ivip/Kconfig b/drivers/gpu/drm/ivip/Kconfig
> new file mode 100644
> index 000000000000..1b2af85fe757
> --- /dev/null
> +++ b/drivers/gpu/drm/ivip/Kconfig
> @@ -0,0 +1,14 @@
> +config DRM_IVIP
> +        tristate "Intel FGPA Video and Image Processing"
> +        depends on DRM && OF
> +        select DRM_GEM_CMA_HELPER
> +        select DRM_KMS_HELPER
> +        select DRM_KMS_FB_HELPER
> +        select DRM_KMS_CMA_HELPER
> +        help
> +		Choose this option if you have an Intel FPGA Arria 10 system
> +		and above with an Intel Display Port IP. This does not support
> +		legacy Intel FPGA Cyclone V display port. Currently only single
> +		frame buffer is supported. Note that ACPI and X_86 architecture
> +		is not supported for Arria10. If M is selected the module will be
> +		called ivip.

According to Documentation/process/coding-style.rst, Kconfig help text should be
indented with 1 tab + 2 spaces, not 2 tabs.

-- 
~Randy
