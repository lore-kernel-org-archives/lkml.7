Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD92C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1089206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556224112;
	bh=gZifByYJgdooXt4kQ6MZrP2zFplJNerVD2GHIfJwJII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yLd17w6TmGvw6rP/keCE3wSbeLOcRZ56zwllawUuhKwuhMeyPymq/G9xRs7l8aSXX
	 kPX2mSibNmFI8q3g1UpavNYu9EU2APbYnumac221ZwEzdkXuxN28514d8ayY+PGqgT
	 wMelwJnDVBP89KtizR8srBCgHTaH6sf3yPlWT/vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfDYU2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfDYU2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:28:30 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F38206A3;
        Thu, 25 Apr 2019 20:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556224109;
        bh=gZifByYJgdooXt4kQ6MZrP2zFplJNerVD2GHIfJwJII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9+wxuK5aT8aRSyD1zP0vuN28o0E5V9TLlRB4c4fyldeGItdv6MDzmpqso2tynmSC
         H4jRSBJlryI9xpjuk6L0iYzToPBt7lD3LlOASf62IgwdGLSMJzTPpEVxQzb8fRw+pX
         vujC1EbnkzQfV/e/TjdRcIRq53Q6G2Y5bHx9RFlE=
Date:   Thu, 25 Apr 2019 22:28:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 5/6] firmware: rsu: document sysfs interface
Message-ID: <20190425202827.GD22307@kroah.com>
References: <1554835562-25056-1-git-send-email-richard.gong@linux.intel.com>
 <1554835562-25056-6-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554835562-25056-6-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 01:46:01PM -0500, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Describe Intel Stratix10 Remote System Update (RSU) device attributes
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Reviewed-by: Alan Tull <atull@kernel.org>
> ---
>  .../testing/sysfs-devices-platform-stratix10-rsu   | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> new file mode 100644
> index 0000000..cb461ee
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
> @@ -0,0 +1,78 @@
> +		Intel Stratix10 Remote System Update (RSU) device attributes
> +
> +What:		/sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/current_image
> +Date:		April 2019
> +KernelVersion:	5.2
> +Contact:	Richard Gong <richard.gong@intel.com>
> +Description:
> +		(RO) the address of image currently running in flash.
> +
> +What:           /sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/fail_image
> +Date:           April 2019
> +KernelVersion:  5.2
> +Contact:        Richard Gong <richard.gong@intel.com>
> +Description:
> +		(RO) the address of failed image in flash.
> +
> +What:           /sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/state
> +Date:           April 2019
> +KernelVersion:  5.2
> +Contact:        Richard Gong <richard.gong@intel.com>
> +Description:
> +		(RO) the state of RSU system.
> +		The state field has two parts: major error code in upper 16 bits and minor error code
> +		in lower 16 bits.
> +		1. Major error code
> +			0xF001 -- bitstream error
> +			0xF002 -- hardware access failure
> +			0xF003 -- bitstream corruption
> +			0xF004 -- internal error
> +			0xF005 -- device error
> +			0xF006 -- HPS watchdog timeout
> +			0xF007 -- internal unknown error
> +		2: Minor error code
> +			Currently used only when major error is 0xF006 (HPS watchdog timeout), in which
> +		case the minor error code is the value reported by HPS to firmware through the RSU notify
> +		command before the watchdog timeout occurs.

Properly wrap your lines at 72 colums.
