Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCF4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC3B21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLROzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:55:31 -0500
Received: from foss.arm.com ([217.140.110.172]:49046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727384AbfLROzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:55:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0F430E;
        Wed, 18 Dec 2019 06:55:30 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48613F719;
        Wed, 18 Dec 2019 06:55:28 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:55:26 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: Re: [PATCH 1/5] firmware: xilinx: Adds new eemi call for reg access
Message-ID: <20191218145526.GB12525@bogus>
References: <1575502159-11327-1-git-send-email-jolly.shah@xilinx.com>
 <1575502159-11327-2-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575502159-11327-2-git-send-email-jolly.shah@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 03:29:15PM -0800, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> This patch adds new EEMI call which is used for CSU/PMU register
> access from linux.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 183 +++++++++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |   9 ++
>  2 files changed, 192 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index fd3d837..56431ad 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -24,6 +24,8 @@
>  #include <linux/firmware/xlnx-zynqmp.h>
>  #include "zynqmp-debug.h"
>  
> +static unsigned long register_address;
> +
>  static const struct zynqmp_eemi_ops *eemi_ops_tbl;
>  
>  static const struct mfd_cell firmware_devs[] = {
> @@ -664,6 +666,26 @@ static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
>  				   qos, ack, NULL);
>  }
>  
> +/**
> + * zynqmp_pm_config_reg_access - PM Config API for Config register access
> + * @register_access_id:	ID of the requested REGISTER_ACCESS
> + * @address:		Address of the register to be accessed
> + * @mask:		Mask to be written to the register
> + * @value:		Value to be written to the register
> + * @out:		Returned output value
> + *
> + * This function calls REGISTER_ACCESS to configure CSU/PMU registers.
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +
> +static int zynqmp_pm_config_reg_access(u32 register_access_id, u32 address,
> +				       u32 mask, u32 value, u32 *out)
> +{
> +	return zynqmp_pm_invoke_fn(PM_REGISTER_ACCESS, register_access_id,
> +				   address, mask, value, out);
> +}
> +

If you have this API, can you remove all other APIs and implement them
using these ? This kills the EEMI abstraction.

NACK for this and any attempts to provide direct reas/write access to
the PM config space. EEMI should have better abstraction than this.

--
Regards,
Sudeep
