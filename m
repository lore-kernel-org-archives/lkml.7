Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525F2C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B3A21920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569933659;
	bh=ILvLxn6jQBpRSKKm7Mvvv9Sle6/zDhJRDSEywI3wlg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A47UfMhHbjseXUiMH4VEPVAY2Pu+BrMJFpnc12z3N4Zg/EBo6/rLTT6UuMVzd5WXj
	 zkvM0m8NKyMID/AWgWA+NGVrn8gNRmauDWIBNT84a9wbxFv8U9efXbmBWGDRs97dBJ
	 A76PIs6uGoiE1+TCOp6DpZ3taGtrUSjo0/0PCWt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbfJAMk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJAMk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:40:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5785E20842;
        Tue,  1 Oct 2019 12:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569933656;
        bh=ILvLxn6jQBpRSKKm7Mvvv9Sle6/zDhJRDSEywI3wlg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UgBRko8j4MAD/TQhQx078rO+EMRXt2mrXfb7W8fRL+cXKEWHNYrb3UDD3zoP/CYGk
         yNNDoTjrwG/nU/+8J6IfexmhgRWQCbFvXho2ut+yILFmUkry3v6oSbaAr4dmZVbXgT
         yhgjBFKRMPfafwFsY6i3DxPjccfSNLv6joNcgxwg=
Date:   Tue, 1 Oct 2019 14:40:54 +0200
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
Subject: Re: [RFC PATCH 08/22] thunderbolt: Add downstream PCIe port mappings
 for Alpine and Titan Ridge
Message-ID: <20191001124054.GC2954373@kroah.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-9-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001113830.13028-9-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 02:38:16PM +0300, Mika Westerberg wrote:
> In order to keep PCIe hierarchies consistent across hotplugs, add
> hard-coded PCIe downstream port to Thunderbolt port for Alpine Ridge and
> Titan Ridge as well.

Oh, that makes me nervous, how could a hard-coded pcie port ever get set
up incorrectly :)

How do we "know" that this is correct?  Is there any ACPI guarantees
that this "always will be so"?  If not, we all know someone will mess
this up...

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/tb.c |  4 +++-
>  drivers/thunderbolt/tb.h | 25 +++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index dbbe9afb9fb7..704455a4f763 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -344,10 +344,12 @@ static struct tb_port *tb_find_pcie_down(struct tb_switch *sw,
>  		 * Hard-coded Thunderbolt port to PCIe down port mapping
>  		 * per controller.
>  		 */
> -		if (tb_switch_is_cr(sw))
> +		if (tb_switch_is_cr(sw) || tb_switch_is_ar(sw))
>  			index = !phy_port ? 6 : 7;
>  		else if (tb_switch_is_fr(sw))
>  			index = !phy_port ? 6 : 8;
> +		else if (tb_switch_is_tr(sw))
> +			index = !phy_port ? 8 : 9;
>  		else
>  			goto out;
>  
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index e641dcebd50a..dbab06551eaa 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -632,6 +632,31 @@ static inline bool tb_switch_is_fr(const struct tb_switch *sw)
>  	}
>  }
>  
> +static inline bool tb_switch_is_ar(const struct tb_switch *sw)

"ar"?  Can you spell it out?

> +{
> +	switch (sw->config.device_id) {
> +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE:
> +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_BRIDGE:
> +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE:
> +	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_BRIDGE:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static inline bool tb_switch_is_tr(const struct tb_switch *sw)

Same for "tr" please.

thanks,

greg k-h
