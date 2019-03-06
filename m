Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C7920663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="av/E9wUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfCFBQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:16:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfCFBQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uF2s2oN/pA5324ShmIRECBh1pVl3sWAB0R8+ZfXphDk=; b=av/E9wUzwVagWuKpOKY+hdp4/
        A90DIkuzqoq+i8WbCnwv4OMQFonfnpJGaBSz0b/XtvmqY5U6HAADg3fmama72dhOP10wBzlxwkz7F
        crMC2CnS2a31IiZGu1MOgT32b9DNeU9seT2qx5/MfDt3+GEPtPJDoi786tjsjWt74Y0i0qU9vNCYP
        3wK6TT4oAALWD/5avebyR+s00SmVS2HzsOGEp7ACwRrk5s+0zFW6Qm0fqlCAsMSq6M2VyZww5+hph
        71NBSG0kwJotHU4ZSENiE9gZFjLZCmBCKNoq6tqQjD5DPvJtpqq1JVrjnATcg8CT8JsFQ6vUwSWxu
        7gtWdaicA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1LAu-0000Km-UL; Wed, 06 Mar 2019 01:16:48 +0000
Subject: Re: [PATCH v12 3/4] pstore/blk: support pmsg for pstore block
To:     liaoweixiong <liaoweixiong@allwinnertech.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551337948-16451-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1551337948-16451-4-git-send-email-liaoweixiong@allwinnertech.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a7ae72c0-2425-a43a-da53-22f30a173f7e@infradead.org>
Date:   Tue, 5 Mar 2019 17:16:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1551337948-16451-4-git-send-email-liaoweixiong@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/27/19 11:12 PM, liaoweixiong wrote:
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 7dfe00b..b417bf5 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -210,6 +210,27 @@ config PSTORE_BLKOOPS_DMESG_SIZE
>  	     It is the first priority. Take care of that blkoops will take lower
>  	     priority settings if higher priority one do not set.
>  
> +config PSTORE_BLKOOPS_PMSG_SIZE
> +	int "pmsg size in kbytes for blkoops"
> +	depends on PSTORE_BLKOOPS
> +	default 64
> +	help
> +	  This just sets size of pmsg (pmsg_size) for pstore/blk. The value must
> +	  be a multiple of 4096. Pmsg work only if "blkdev" is set.

	                              works

> +
> +	  NOTE that, there are three ways to set parameters of blkoops and
> +	  prioritize according to configuration flexibility. That is
> +	  Kconfig < device tree < module parameters. It means that the value can
> +	  be overwritten by higher priority settings.
> +	  1. Kconfig
> +	     It	just sets a default value.
> +	  2. device tree
> +	     It is set on device tree, which will overwrites value from Kconfig,

	                                          overwrite the value from Kconfig,

> +	     but can also be overwritten by module parameters.
> +	  3. module parameters
> +	     It is the first priority. Take care of that blkoops will take lower
> +	     priority settings if higher priority one do not set.
> +
>  config PSTORE_BLKOOPS_TOTAL_SIZE
>  	int "total size in kbytes for blkoops"
>  	depends on PSTORE_BLKOOPS

cheers.
-- 
~Randy
