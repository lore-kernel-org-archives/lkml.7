Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9524C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760E6204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554217169;
	bh=1+ox9KmxBAfYApWCQmyunO6xk4Ie0reeruGa71hrh7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HJiHeBBUU5x2IEAECG3KSeU48Ul9vBiHx7tzZOgPzgJT74C0Iod15A4FrHzxmnuQT
	 9ObpMH5J5s6fXHd+Wd/2TCegqJMEd0Hxz7MUATTAHNZ2MAbFHf2WirDirx8Mb41naN
	 Ze6Fnpi/+OAq7koCzn+edhat8gvw5tGjwGCxfH3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfDBO72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:59:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33306 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfDBO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:59:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id e5so10755917oii.0;
        Tue, 02 Apr 2019 07:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xWX6f0JZfWeGkSxnTaaeYO2L1I/Qhqr7srvTenf9DTA=;
        b=uGlzW8Va7aHBEDzVQzXY2Ea5WZBRXHJ/WJNhorwSAO+wsBBLPD/qq053ounUEo7wz0
         7w7nc3pW7F22keGiSzeLh7AJONPIK3Zvz7v86e8iWW6RBPmziFH+T+n+iQQwZdqPXRba
         /hm3EFDLz1QfB0vkhozTSuzb4xr4cjilA6ZPo4MJmK06rekgbZV61mQ0Dls8kp8p7SiI
         GZLBOIWp0y5pc0DYJMKob6blbs5tBQeDsP4JMrE5cgteIGdcEUN/+Q7J80eXk0XrrvVV
         KtvK8Gl+4LmX8vRPuWNinO4V9eq3ijFD0IbeNiirnrH+KooQjw9AcKA7mzDc1l+kZSOV
         VJgw==
X-Gm-Message-State: APjAAAV6DMhFpRKTHJDLnZ8NOTX3gq+FWaIU3j+KV2CX3ehNYAlCdB9z
        +d+svLSy0gWFxa3PUNCJWJ0=
X-Google-Smtp-Source: APXvYqzzTO+EDrrJZcrBeOUA650tuR3/yLxK2A15NfsG6HmpZ/OD/dGmatYAgZFK3YDLKXU/wtSF/A==
X-Received: by 2002:aca:dcc4:: with SMTP id t187mr17562529oig.3.1554217166999;
        Tue, 02 Apr 2019 07:59:26 -0700 (PDT)
Received: from localhost ([130.164.62.212])
        by smtp.gmail.com with ESMTPSA id w187sm5580965oif.36.2019.04.02.07.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 07:59:26 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:59:25 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 14/17] fpga: dfl: fme: add thermal management support
Message-ID: <20190402145925.GA15773@archbook>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
 <1553483264-5379-15-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553483264-5379-15-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wu,

On Mon, Mar 25, 2019 at 11:07:41AM +0800, Wu Hao wrote:
> This patch adds support to thermal management private feature for DFL
> FPGA Management Engine (FME). As thermal throttling is handled by
> hardware automatically per pre-defined thresholds, this private
> feature driver only provides read-only sysfs interfaces for user
> to read temperature, thresholds, threshold policy and other info.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-platform-dfl-fme |  56 +++++++
>  drivers/fpga/dfl-fme-main.c                      | 202 +++++++++++++++++++++++
>  2 files changed, 258 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> index b8327e9..d3aeb88 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> @@ -44,3 +44,59 @@ Description:	Read-only. It returns socket_id to indicate which socket
>  		this FPGA belongs to, only valid for integrated solution.
>  		User only needs this information, in case standard numa node
>  		can't provide correct information.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/temperature
> +Date:		March 2019
> +KernelVersion:  5.2
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. It returns temperature (in Celsius) of this FPGA
> +		device.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/threshold1
> +Date:		March 2019
> +KernelVersion:  5.2
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. Read this file to get the temperature threshold1
> +		(in Celsius).
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/threshold2
> +Date:		March 2019
> +KernelVersion:  5.2
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. Read this file to get the temperature threshold2
> +		(in Celsius).
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/trip_threshold
> +Date:		March 2019
> +KernelVersion:  5.2
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. It returns trip threshold (in Celsius), once FPGA
> +		temperature reaches trip threshold, it triggers a fatal event
> +		to board management controller (BMC) to shutdown FPGA.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/threshold1_status
> +Date:		March 2019
> +KernelVersion:  5.2
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. It returns 1 if temperature reaches threshold1,
> +		otherwise 0. Once temperature reaches threshold1, hardware
> +		will automatically enter throttling state (AP1 - 50%
> +		or AP2 - 90% throttling, see 'threshold1_policy').
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/threshold2_status
> +Date:		March 2019
> +KernelVersion:  5.2
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. It returns 1 if temperature reaches threshold2,
> +		otherwise 0. Once temperature reaches threshold2, hardware
> +		will automatically enter the deepest throttling state (AP6
> +		- 100% throttling).
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/thermal_mgmt/threshold1_policy
> +Date:		March 2019
> +KernelVersion:  5.2
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. Read this file to get the policy of temperature
> +		threshold1. It only supports two value (policy):
> +		    0 - AP2 state (90% throttling)
> +		    1 - AP1 state (50% throttling)

These look like they could directly map to the linux thermal framework,
any reason you can't use the thermal framework?

The trip stuff literally maps 1:1 to what a thermal driver does, I think
that's something you'd wanna consider.

Cheers,
Moritz
