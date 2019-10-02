Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F5FECE58B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FE821A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570005410;
	bh=Fz3G6JDNACXQd2RhNujXk869SixEzsjL+NkZV4Cq0F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bIGJSyn0uwadsk3elXsTdepYKmd7KbIKXq4os4V+sVpTf6wc754PefcHussYwwU6t
	 Nc4hCohQVJvFRFecJe+1rYP9oNQ2O+8LmMpQRYdatoJO58PcONi7IFbxSyW6R52gTh
	 IBDTo/vv5NNuhr35Qccm1pcV8d/yBL2kGsk4sJCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfJBIgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbfJBIgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:36:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737A1206C0;
        Wed,  2 Oct 2019 08:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570005409;
        bh=Fz3G6JDNACXQd2RhNujXk869SixEzsjL+NkZV4Cq0F8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/cyj4XQuDZuUnYggEFCdOaT7QbbspwnS2Z+e4L/x6JPny9+x8KuJ/grHK9Tcn3UG
         uZ24/Ko13j82XZps2OqX7mJDgI6Q8bz6dllZ73XqRfTJWv899MzPCAJPs5Bp7oTX6s
         RVq3R17S8RhweG9EeeoVQrCLW6iZmAJivn5SeHWE=
Date:   Wed, 2 Oct 2019 10:36:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     alsa-devel@alsa-project.org, Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soundwire: depend on ACPI || OF
Message-ID: <20191002083646.GB1687317@kroah.com>
References: <20191002081717.GA4015@kitsune.suse.cz>
 <91e2fc425e0dea92d7f131da890e52af273de36c.1570005196.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91e2fc425e0dea92d7f131da890e52af273de36c.1570005196.git.msuchanek@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 10:33:30AM +0200, Michal Suchanek wrote:
> Now devicetree is supposrted for probing sondwire as well.
> 
> Fixes: a2e484585ad3 ("soundwire: core: add device tree support for slave devices")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  drivers/soundwire/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index c73bfbaa2659..c8c80df090d1 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -5,7 +5,7 @@
>  
>  menuconfig SOUNDWIRE
>  	tristate "SoundWire support"
> -	depends on ACPI
> +	depends on ACPI || OF
>  	help
>  	  SoundWire is a 2-Pin interface with data and clock line ratified
>  	  by the MIPI Alliance. SoundWire is used for transporting data
> -- 
> 2.23.0
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
