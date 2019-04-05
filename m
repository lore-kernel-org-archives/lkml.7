Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569C8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D43E21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfDEJGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:06:30 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:57352 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730329AbfDEJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:06:29 -0400
X-IronPort-AV: E=Sophos;i="5.60,312,1549954800"; 
   d="scan'208";a="29306587"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Apr 2019 02:06:28 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Fri, 5 Apr 2019
 02:06:28 -0700
Date:   Fri, 5 Apr 2019 11:05:45 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Hao <peng.hao2@zte.com.cn>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: Re: linux-next: manual merge of the at91 tree with the at91-fixes
 tree
Message-ID: <20190405090545.7tdtbbxussybt2yq@M43218.corp.atmel.com>
References: <20190405091519.48aa4098@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190405091519.48aa4098@canb.auug.org.au>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Apr 05, 2019 at 09:15:19AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the at91 tree got a conflict in:
> 
>   arch/arm/mach-at91/pm.c
> 
> between commit:
> 
>   ba5e60c9b75d ("arm/mach-at91/pm : fix possible object reference leak")
> 
> from the at91-fixes tree and commit:
> 
>   c3f5b8fde71f ("ARM: at91: pm: introduce at91_soc_pm structure")
> 
> from the at91 tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/arm/mach-at91/pm.c
> index 2a757dcaa1a5,5571658b3c46..000000000000
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@@ -620,10 -676,8 +676,10 @@@ static int __init at91_pm_backup_init(v
>   	return 0;
>   
>   securam_fail:
>  +	put_device(&pdev->dev);
>  +securam_fail_no_ref_dev:
> - 	iounmap(pm_data.sfrbu);
> - 	pm_data.sfrbu = NULL;
> + 	iounmap(soc_pm.data.sfrbu);
> + 	soc_pm.data.sfrbu = NULL;
>   	return ret;
>   }
>   

Resolution sounds good.

Thanks

Ludovic
