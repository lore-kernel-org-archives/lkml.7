Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3D6C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F902409E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559588965;
	bh=v3DbUlOjumJJH58tAn84ookMKQ1r9+DBtCPDYVGrw7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xPgP/OVG0QiUe/ZnAX0GjMhHibvt2pF/iJaujPdZ7S+WvQP01AUkAHy8ri5ee8hfE
	 evkm5eN6vC8TFUi2gVosLiJ6pyN3Unqmysnd5CxTRf8bwULMD64wGzsg14GfN2+AUq
	 MPlEHNEMJFk8e4BSF3uDXlnDRhN4ABkxVBUuVJrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfFCTJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFCTJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:09:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83FB923D66;
        Mon,  3 Jun 2019 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559588964;
        bh=v3DbUlOjumJJH58tAn84ookMKQ1r9+DBtCPDYVGrw7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5+hrVjPlZHNRVtoe6GznUPUSoj9eXuqYIT5KUOsoHc/O4pmRxSIH3jsW5GNkGyLA
         RsfGRzNEQ6Xr18QRKmVtlKtTRz7xEiN7VYaMHypRq+JwZ4mqQoqwIX9JQBraokbCz4
         jpUHFmnYWBD1uDDA4WO0fPVtHFV2oSLYCP0jq/QU=
Date:   Mon, 3 Jun 2019 21:09:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Corey Minyard <minyard@acm.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 02/57] drivers: ipmi: Drop device reference
Message-ID: <20190603190921.GC6487@kroah.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559577023-558-3-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:49:28PM +0100, Suzuki K Poulose wrote:
> Drop the reference to a device found via bus_find_device()
> 
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/char/ipmi/ipmi_si_platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> index f2a91c4..ff82353 100644
> --- a/drivers/char/ipmi/ipmi_si_platform.c
> +++ b/drivers/char/ipmi/ipmi_si_platform.c
> @@ -442,6 +442,7 @@ void ipmi_remove_platform_device_by_name(char *name)
>  				      pdev_match_name))) {
>  		struct platform_device *pdev = to_platform_device(dev);
>  
> +		put_device(dev);
>  		platform_device_unregister(pdev);

So you drop the reference, and then actually use the pointer?

The drop needs to be _after_ the call to platform_device_unregister().

thanks,

greg k-h
