Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9DFC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4E020651
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556818038;
	bh=nUrwWPD8ucED90XNkUlUix14ltwwHkXny6E3ImMXWRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FYcLvsQ4XkFI6FL9RV6lKgT2aFD7zJTrUse+UBJJvmkTUbsmBAZtiAWgRgSVvk0zG
	 EEPEwORvy70x1X6vfD48r0h3JJJZfUi1QQyS7otQNP0nsQnBJCFvq8ZibBCg+tECqS
	 AWyeocsJlvDhQqA9Xw4VX1ujgMuksN8jnw2MCkVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfEBR1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 13:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfEBR1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 13:27:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA6420651;
        Thu,  2 May 2019 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556818035;
        bh=nUrwWPD8ucED90XNkUlUix14ltwwHkXny6E3ImMXWRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PF6fFdBzx4hNtuFY4X7GBes3yLTc1ZZ6KV5pnxzb/IFPEfTd+SDcDvTJ+la3Xi/2K
         sssLcj85wn9UVQsfWNgz7/l+VCSNK/tP8uNsL3O4yKSHjNDNRwaccw8K/hISQXfQRc
         C7gYAiBdPg/hDemPuENunbgsltANLZVctsnAJUX0=
Date:   Thu, 2 May 2019 19:27:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V3 07/12] misc: xilinx_sdfec: Add ability to configure
 LDPC
Message-ID: <20190502172713.GD1874@kroah.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-8-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556402706-176271-8-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 11:05:01PM +0100, Dragan Cvetic wrote:
> --- a/include/uapi/misc/xilinx_sdfec.h
> +++ b/include/uapi/misc/xilinx_sdfec.h

<snip>

> +/**
> + * xsdfec_calculate_shared_ldpc_table_entry_size - Calculates shared code
> + * table sizes.
> + * @ldpc: Pointer to the LPDC Code Parameters
> + * @table_sizes: Pointer to structure containing the calculated table sizes
> + *
> + * Calculates the size of shared LDPC code tables used for a specified LPDC code
> + * parameters.
> + */
> +inline void
> +xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_params *ldpc,
> +	struct xsdfec_ldpc_param_table_sizes *table_sizes)
> +{
> +	/* Calculate the sc_size in 32 bit words */
> +	table_sizes->sc_size = (ldpc->nlayers + 3) >> 2;
> +	/* Calculate the la_size in 256 bit words */
> +	table_sizes->la_size = ((ldpc->nlayers << 2) + 15) >> 4;
> +	/* Calculate the qc_size in 256 bit words */
> +	table_sizes->qc_size = ((ldpc->nqc << 2) + 15) >> 4;
> +}

Why do you have an inline function in a user api .h file?  That's really
not a good idea.

thanks,

greg k-h
