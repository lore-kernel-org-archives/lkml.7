Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1301CC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D520921920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569933853;
	bh=HUG7D2L1xMpD+wT6zwC93RGUDy/6NzX8Tq3e8RB2A9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p+ROJ6YhJESz6/5tg1vseMKc5ijOZmhzUrYgDd44R6na9uvWnKBke8fKlSc2Wpkk1
	 +ghrKONlze+Fc5m9o8dkea7127sk52eIrgqaswJZFXjKGOMHpaqJ9Plhc0dob7SSgf
	 PqJ80sRrj37s3AyU66CWNjzNz/02GPoBq7ysr5+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbfJAMoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387921AbfJAMoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:44:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DEEB20842;
        Tue,  1 Oct 2019 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569933852;
        bh=HUG7D2L1xMpD+wT6zwC93RGUDy/6NzX8Tq3e8RB2A9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kVPf4/IdPv+EoVEk/aOd4bL+2UIL477WEqSv9yEk5h3ggjFAiR458XXEECVf/Gz73
         C+fVY/EW178yKkmm2kJFJtKW4qo//2v2fByBJPQVcjpa5cG6D2Or7TaLhFQgHA23Ra
         /u/V+f88X7OV5wcv/m3B0kjJZZoKqRvBUNXbFZPQ=
Date:   Tue, 1 Oct 2019 14:44:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 12/22] thunderbolt: Add Display Port CM handshake for
 Titan Ridge devices
Message-ID: <20191001124409.GG2954373@kroah.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-13-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001113830.13028-13-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:38:20PM +0300, Mika Westerberg wrote:
> Titan Ridge devices and newer need an additional connection manager
> handshake in order to do proper Display Port tunneling so implement it
> here.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/tb_regs.h |  3 +++
>  drivers/thunderbolt/tunnel.c  | 44 +++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index 3a39490a954b..8d11b4a2d552 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -252,6 +252,9 @@ struct tb_regs_port_header {
>  #define ADP_DP_CS_3_HDPC			BIT(9)
>  #define DP_LOCAL_CAP				0x04
>  #define DP_REMOTE_CAP				0x05
> +#define DP_STATUS_CTRL				0x06
> +#define DP_STATUS_CTRL_CMHS			BIT(25)
> +#define DP_STATUS_CTRL_UF			BIT(26)
>  
>  /* PCIe adapter registers */
>  #define ADP_PCIE_CS_0				0x00
> diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
> index 3353396e0806..369800110e5e 100644
> --- a/drivers/thunderbolt/tunnel.c
> +++ b/drivers/thunderbolt/tunnel.c
> @@ -6,6 +6,7 @@
>   * Copyright (C) 2019, Intel Corporation
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/list.h>
>  
> @@ -242,6 +243,41 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
>  	return tunnel;
>  }
>  
> +static int tb_dp_cm_handshake(struct tb_port *in, struct tb_port *out)
> +{
> +	int timeout = 10;
> +	u32 val;
> +	int ret;
> +
> +	/* Both ends need to support this */
> +	if (!tb_switch_is_tr(in->sw) || !tb_switch_is_tr(out->sw))
> +		return 0;

So if the ends are both "Titan Ridge", matches your changelog text, but
where is the "and newer" comment being checked here?

thanks,

greg k-h
