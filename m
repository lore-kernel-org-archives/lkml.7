Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB45C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDD5213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kuJlC1K0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfCMUf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:35:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfCMUf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6hrYi8NEcU0I1WBfG9SubrvUs+kMLXFHyDHGSXABtkA=; b=kuJlC1K05clRxxGvTpMRKZl47
        vlnszZLfYMees3kwC3fkxCtreS7brkzrDjOFcIScDkdkKbIvj8rcjvnQQnhhSznPay6/KDn7Vyyde
        YIBaQ25b3b5IxtXscrOk3qjmiEugBw/dPdtk5G7H+zjzy7MdevNgg0H+RjlYCFvzDy6/pWg9VbGXB
        I7WS+7NbDZBCs+auFHTXi33TMRnZgXyY50FublB3RZOmpdkyc2jlSGNCW1swQgO+Ng8TM2Mknaeay
        k89k/4Y5bujWwU7p3rgg/VO2Ccc7oyyBNZXQB24Y8qbevUAqrKdidMqU8C5Fk+861IDb2G4paC1V7
        H4GUlHpCg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4AbS-0002Qz-GL; Wed, 13 Mar 2019 20:35:54 +0000
Subject: Re: [PATCHv14 3/3] ARM:drm ivip Intel FPGA Video and Image Processing
 Suite
To:     "Hean-Loong, Ong" <hean.loong.ong@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, chin.liang.see@intel.com,
        Ong@vger.kernel.org
References: <20190313202206.921-1-hean.loong.ong@intel.com>
 <20190313202206.921-4-hean.loong.ong@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fe101dca-2b39-fe0e-9bee-279abab9db8a@infradead.org>
Date:   Wed, 13 Mar 2019 13:35:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313202206.921-4-hean.loong.ong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/19 1:22 PM, Hean-Loong, Ong wrote:
> diff --git a/drivers/gpu/drm/ivip/Kconfig b/drivers/gpu/drm/ivip/Kconfig
> new file mode 100644
> index 0000000..1d08b90
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
> +		  Choose this option if you have an Intel FPGA Arria 10 system
> +		  and above with an Intel Display Port IP. This does not support
> +		  legacy Intel FPGA Cyclone V display port. Currently only single
> +		  frame buffer is supported. Note that ACPI and X_86 architecture
> +		  is not supported for Arria10. If M is selected the module will be
> +		  called ivip.

Hi,
If you make any changes to this series, the help text here is
indented too much.  Just use one tab + 2 spaces, not 2 tabs + 2 spaces.

thanks.
-- 
~Randy
