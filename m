Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8A82075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="OQVEGkLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfCDPrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:47:35 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:58458 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfCDPrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:47:35 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 44Ckrz1jCBzKB;
        Mon,  4 Mar 2019 16:46:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1551714372; bh=caHjAZYP83S7Cjq1/DL8i5Esl6rwwZEIADSBqPL4jxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQVEGkLYaxelJDQrQYbBactba7+i2CAwwNVBF5JNE9ciMXaBKiFBDZcbnVaMe9wJ0
         dcsy5+oeqsGR7mUly2eZmqq9xtmQS/81nqEpSxDdGRsowbiLjx3m2kUqyg2DNkn1g3
         qcJm2hLk/a0ObxfepBgpFjQ5X3W9rXmVM3xEXY7nv5D7ritI5SIXPiBrLKbpfSNumg
         +YmaIvDHGB0pLz8T+mIg8REFAkB58c/rTzosEXNFQJtH69/2AegbJmF7Rcq5gXxD7C
         9zimzXYf1Zdb4pl/t2BMGjJ/HTrqYoE5tQeMpaHTumHZYNpjUZ50I99asRR2rgf3io
         60OUrnDENZsgA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at mail
Date:   Mon, 4 Mar 2019 16:47:29 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/7] ARM: trusted_foundations: Support L2 cache
 maintenance
Message-ID: <20190304154729.GA13794@qmqm.qmqm.pl>
References: <20190303171214.24821-1-digetx@gmail.com>
 <20190303171214.24821-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190303171214.24821-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 08:12:08PM +0300, Dmitry Osipenko wrote:
> Implement L2 cache initialization firmware callback that should be
> invoked early during boot in order to set up the required outer cache
> driver's callbacks and add the callback required for L2X0 maintenance.
[...]
> @@ -43,6 +46,11 @@ void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
>  void of_register_trusted_foundations(void);
>  
>  #else /* CONFIG_TRUSTED_FOUNDATIONS */
> +static inline void tf_dummy_write_sec(unsigned long val, unsigned int reg)
> +{
> +	if (reg == L2X0_CTRL && val == L2X0_CTRL_EN)
> +		pr_err("Trusted Foundations unavailable, ignoring request to enable L2C\n");
> +}
>  
>  static inline void register_trusted_foundations(
>  				   struct trusted_foundations_platform_data *pd)
> @@ -53,6 +61,10 @@ static inline void register_trusted_foundations(
>  	 */
>  	pr_err("No support for Trusted Foundations, continuing in degraded mode.\n");
>  	pr_err("Secondary processors as well as CPU PM will be disabled.\n");
> +#if IS_ENABLED(CONFIG_CACHE_L2X0)
> +	pr_err("L2X0 cache will be disabled.\n");
[...]

I guess this is redundant since tf_dummy_write_sec() will say the same
thing when trying to enable the cache.

Best Regards,
Micha³ Miros³aw
