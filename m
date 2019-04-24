Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65778C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2923E218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556112531;
	bh=j/DYxn69slBsMS5sBzngRnW7mY/Ai5Z5oOBTxtONHMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1tTlRpOtyI4S8wdnfXwxR0lPNvmq8dOTmr1SqMP+86u+zu1lXkYqRynJGcYal/ecS
	 JQPgpxcqQDnrI1n/+VwqDOfKnAU6cmCS/1cH/p8Q1lZZa8YJ4nQBuVvX3YkawOJu5k
	 HeInjDshPxPs0i4GFplTxvR1+BH/u/YF7p3o8tzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfDXN2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfDXN2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:28:49 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E5DE21773;
        Wed, 24 Apr 2019 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556112528;
        bh=j/DYxn69slBsMS5sBzngRnW7mY/Ai5Z5oOBTxtONHMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQwdyp2HpjHIqRBEr9bCnMlQfASYeukOSHkbVbzMJu/idG+RoAetBw77Xj8y/w7zo
         dwqhCEWSUrL43eB7KPOKkn7vuX+StnbqomlNtcaayVbR74EUoxsMhGzzXocqPQD/uZ
         i8PtHDkOrmXNXu8de6FfohIA2A3Fu6cxG/GpK8oM=
Date:   Wed, 24 Apr 2019 15:28:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        heikki.krogerus@linux.intel.com, f.fainelli@gmail.com,
        rpjday@crashcourse.ca, dvhart@infradead.org
Subject: Re: [PATCH] mod_devicetable: helper macro for declaring oftree
 module device table
Message-ID: <20190424132846.GA19385@kroah.com>
References: <1556104081-16217-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556104081-16217-1-git-send-email-info@metux.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 01:08:01PM +0200, Enrico Weigelt, metux IT consult wrote:
> Little helper macro that declares an oftree module device table,
> if CONFIG_OF is enabled. Otherwise it's just noop.
> 
> This is also helpful if some drivers can be built w/ or w/o
> oftree support.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

As I said before, please drop all "non-name" information from your s-o-b
line.



> ---
>  include/linux/mod_devicetable.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 448621c..853e301 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -245,6 +245,15 @@ struct of_device_id {
>  	const void *data;
>  };
>  
> +/*
> + * macro for adding the of module device table only if CONFIG_OF enabled
> + */
> +#ifdef CONFIG_OF
> +#define MODULE_DEVICE_TABLE_OF(name)	MODULE_DEVICE_TABLE(of,name)
> +#else
> +#define MODULE_DEVICE_TABLE_OF(name)
> +#endif /* CONFIG_OF */

Do you have a real user of this?  We need that for any type of apis that
people are supposed to use, we do not just add them without users if at
all possible.

And did you run it through checkpatch.pl before sending this?  :(

thanks,

greg k-h
