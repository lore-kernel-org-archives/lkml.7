Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC20FC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAAE2166E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565441640;
	bh=njHYZZXMKTzUEYjv2o8G2NbXyJxmklMU+2bijuE/EsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gI7Ct9/puCb0KwqTBv1Ef2ZNdUtICYPjJi2aCIul8RbbFz6hxoc0QDMOr+hGeRWWY
	 jNY9TpuFj8/9IX+D1Qmo180Bu9dysCuOOayN2QCH4rC8CROw5feAIx/1dzlpMX1+hP
	 d2bV/AOzPTVRnUVQo1+h1zpwGDEaGKWwnWmnx+wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfHJMxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 08:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfHJMxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 08:53:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F2A2166E;
        Sat, 10 Aug 2019 12:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565441626;
        bh=njHYZZXMKTzUEYjv2o8G2NbXyJxmklMU+2bijuE/EsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=04El1JU6taSdQD40sFbqLmAyJSStuvBSuPl8+DgDmYTtII8wAAbcS+W1fugFKHNPU
         c660cISJCq38kQFAQo1IDtE83ynZ+mf1hkizh8IUUEQtMj0EL0vABdcXO4cWH49Nr+
         2jsCQH0wzmlE6qwNRBPL2dPsSNR+v5q492iv7mVs=
Date:   Sat, 10 Aug 2019 14:53:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Subject: Re: [PATCH] habanalabs: print to kernel log when reset is finished
Message-ID: <20190810125344.GE15251@kroah.com>
References: <20190810123808.13845-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810123808.13845-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 03:38:08PM +0300, Oded Gabbay wrote:
> Now that we don't print the queue testing messages, we need to print when
> the reset is finished so whoever looks at the kernel log will know the
> reset process was finished successfully and the driver is not stuck.
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> index 9a5926888b99..1fac808c2546 100644
> --- a/drivers/misc/habanalabs/device.c
> +++ b/drivers/misc/habanalabs/device.c
> @@ -907,6 +907,8 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
>  	else
>  		hdev->soft_reset_cnt++;
>  
> +	dev_info(hdev->dev, "Successfully finished resetting the device\n");

Really?  For doing things "properly" there is no need to spam the kernel
log.  Only spit stuff out if an error happens.

thanks,

greg k-h
