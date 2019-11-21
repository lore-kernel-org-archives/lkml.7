Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF84FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7B4206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKUObo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:31:44 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53189 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:31:43 -0500
Received: from litschi.hi.pengutronix.de ([2001:67c:670:100:feaa:14ff:fe6a:8db5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <m.tretter@pengutronix.de>)
        id 1iXnUL-0002mS-FN; Thu, 21 Nov 2019 15:31:17 +0100
Date:   Thu, 21 Nov 2019 15:31:15 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Rajan Vaja <rajan.vaja@xilinx.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, dan.carpenter@oracle.com,
        gustavo@embeddedor.com, nava.manne@xilinx.com,
        ravi.patel@xilinx.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        m.tretter@pengutronix.de
Subject: Re: [PATCH 3/7] clk: zynqmp: Warn user if clock user are more than
 allowed
Message-ID: <20191121153115.50340e47@litschi.hi.pengutronix.de>
In-Reply-To: <1573564580-9006-4-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com>
        <1573564580-9006-4-git-send-email-rajan.vaja@xilinx.com>
Organization: Pengutronix
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:feaa:14ff:fe6a:8db5
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 05:16:16 -0800, Rajan Vaja wrote:
> Warn user if clock is used by more than allowed devices.
> This check is done by firmware and returns respective
> error code. Upon receiving error code for excessive user,
> warn user for the same.
> 
> This change is done to restrict VPLL use count. It is
> assumed that VPLL is used by one user only.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  drivers/clk/zynqmp/pll.c             | 9 ++++++---
>  drivers/firmware/xilinx/zynqmp.c     | 2 ++
>  include/linux/firmware/xlnx-zynqmp.h | 1 +
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
> index a541397..2f4ccaa 100644
> --- a/drivers/clk/zynqmp/pll.c
> +++ b/drivers/clk/zynqmp/pll.c
> @@ -188,9 +188,12 @@ static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  		frac = (parent_rate * f) / FRAC_DIV;
>  
>  		ret = eemi_ops->clock_setdivider(clk_id, m);
> -		if (ret)
> -			pr_warn_once("%s() set divider failed for %s, ret = %d\n",
> -				     __func__, clk_name, ret);
> +		if (ret) {
> +			if (ret == -EUSERS)
> +				WARN(1, "More than allowed devices are using the %s, which is forbidden\n", clk_name);
> +			pr_err("%s() set divider failed for %s, ret = %d\n",
> +			       __func__, clk_name, ret);
> +		}

In case of -EUSERS this prints the warning and the error. This seems a
bit excessive to me. Isn't it enough to leave the existing
pr_warn_once() for the new error code? If not, then add a new warning
for the -EUSERS error, but leave the existing warning as it is.

Michael

>  
>  		eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, f, NULL);
>  
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 0137bf3..ecc339d 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -53,6 +53,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
>  		return -EACCES;
>  	case XST_PM_ABORT_SUSPEND:
>  		return -ECANCELED;
> +	case XST_PM_MULT_USER:
> +		return -EUSERS;
>  	case XST_PM_INTERNAL:
>  	case XST_PM_CONFLICT:
>  	case XST_PM_INVALID_NODE:
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 25bedd2..f019d1c 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -96,6 +96,7 @@ enum pm_ret_status {
>  	XST_PM_INVALID_NODE,
>  	XST_PM_DOUBLE_REQ,
>  	XST_PM_ABORT_SUSPEND,
> +	XST_PM_MULT_USER = 2008,
>  };
>  
>  enum pm_ioctl_id {
