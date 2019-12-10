Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844C2C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591AF2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575989222;
	bh=O6oH7aEbLpR99ICof6cbh0Ucv+JfuHatu8JFDkQm3M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XLhJAxFKiqAPjgZAOw3rY7ikxNBP43RFFru1ve0jtvo9ZylKJgot4WA58dgnE3tiL
	 CAwIkumCMT09+iaEePMT5ZQ2nLVK/O+IsYNEXXf2/KXMkfXNDhiNe0yswFX3gzloVm
	 GFbHRux1gLEO82e653xiMLN/GLgr+2seADXLegzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLJOrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:47:01 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37420 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLJOrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:47:01 -0500
Received: by mail-ed1-f68.google.com with SMTP id cy15so16205311edb.4;
        Tue, 10 Dec 2019 06:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YhaZZr/VtnLO8eSaQcdnch7Ah/fM7ZqN8a+3yLWOzB0=;
        b=TmAhfc5KZel99Qk6C2qwM4/dxmyp0oH1E0QhdgfpEc21/lFhjqnN454inmI9y5OxSS
         Oi1vaAPU/YXV2R06a51Qw9CvCvjkKzjeCiTLdalavQzQp801QdKpAaQYBi85X5uZ4/UP
         HjYkp9PlAE6VEsGckbs6q5pAnwsRn3XoZX4+R8xfnK+Me/iHF5P7h5sKw1PhPMJEa2p0
         7z1V30giJ7clIGROoH+1+xV68e/NVvY4q6khMQDEL9a7aXkC0AyBmR5cMf9bGmpXcL8z
         msfDDJ9t/KGV7DFazepuHT7LlwbCgrSmflowL113Wds1DKO6/4hoPMvZh4PmUuDwlqY1
         2uxA==
X-Gm-Message-State: APjAAAXDLMczuomDg8xnVDo0/CEyzh5ZeKeG85o5x6ZYX4jZaNnlR1ht
        zIirkQ3PQPd0TxMCmHpTx8A=
X-Google-Smtp-Source: APXvYqzN26AGf6Gq95ol7usng2Lc94cprpK12qzMUmBicV9faXvBpRLDu6WMkpMOaxtC2z0oN0dWEg==
X-Received: by 2002:a17:906:5957:: with SMTP id g23mr4155261ejr.187.1575989219144;
        Tue, 10 Dec 2019 06:46:59 -0800 (PST)
Received: from pi3 ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id p14sm110628ejr.40.2019.12.10.06.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:46:58 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:46:56 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] tty: serial: samsung: allow driver to be built by
 anyone
Message-ID: <20191210144656.GA11222@pi3>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 03:36:57PM +0100, Greg Kroah-Hartman wrote:
> There is no need to tie this driver to only the OMAP platform,

s/OMAP/Exynos/

Beside that:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


> especially for build testing.  So add COMPILE_TEST as an option allowing
> it to be built on any platform.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Hyunki Koo <kkoos00@naver.com>
> Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
> Cc: Shinbeom Choi <sbeom.choi@samsung.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 99f5da3bf913..c835e10bd97e 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -237,7 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
>  
>  config SERIAL_SAMSUNG
>  	tristate "Samsung SoC serial support"
> -	depends on PLAT_SAMSUNG || ARCH_EXYNOS
> +	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
>  	select SERIAL_CORE
>  	help
>  	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
> -- 
> 2.24.0
> 
