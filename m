Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E14C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54405222C5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 07:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfIZH7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 03:59:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49499 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbfIZH7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 03:59:19 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iDOgF-0004ax-0i; Thu, 26 Sep 2019 09:59:15 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iDOgE-0006lM-8C; Thu, 26 Sep 2019 09:59:14 +0200
Date:   Thu, 26 Sep 2019 09:59:14 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] firmware: imx: Skip return value check for some special
 SCU firmware APIs
Message-ID: <20190926075914.i7tsd3cbpitrqe4q@pengutronix.de>
References: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:53:40 up 131 days, 14:11, 85 users,  load average: 0.03, 0.21,
 0.16
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19-09-25 18:07, Anson Huang wrote:
> The SCU firmware does NOT always have return value stored in message
> header's function element even the API has response data, those special
> APIs are defined as void function in SCU firmware, so they should be
> treated as return success always.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> 	- This patch is based on the patch of https://patchwork.kernel.org/patch/11129553/
> ---
>  drivers/firmware/imx/imx-scu.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index 869be7a..ced5b12 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -78,6 +78,11 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] = {
>  	-EIO,	 /* IMX_SC_ERR_FAIL */
>  };
>  
> +static const struct imx_sc_rpc_msg whitelist[] = {
> +	{ .svc = IMX_SC_RPC_SVC_MISC, .func = IMX_SC_MISC_FUNC_UNIQUE_ID },
> +	{ .svc = IMX_SC_RPC_SVC_MISC, .func = IMX_SC_MISC_FUNC_GET_BUTTON_STATUS },
> +};

Is this going to be extended in the near future? I see some upcoming
problems here if someone uses a different scu-fw<->kernel combination as
nxp would suggest.

Regards,
  Marco

> +
>  static struct imx_sc_ipc *imx_sc_ipc_handle;
>  
>  static inline int imx_sc_to_linux_errno(int errno)
> @@ -157,11 +162,24 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_ipc, void *msg)
>  	return 0;
>  }
>  
> +static bool imx_scu_call_skip_return_value_check(uint8_t svc, uint8_t func)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(whitelist); i++)
> +		if (svc == whitelist[i].svc &&
> +			func == whitelist[i].func)
> +			return true;
> +
> +	return false;
> +}
> +
>  /*
>   * RPC command/response
>   */
>  int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
>  {
> +	uint8_t saved_svc, saved_func;
>  	struct imx_sc_rpc_msg *hdr;
>  	int ret;
>  
> @@ -171,8 +189,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
>  	mutex_lock(&sc_ipc->lock);
>  	reinit_completion(&sc_ipc->done);
>  
> -	if (have_resp)
> +	if (have_resp) {
>  		sc_ipc->msg = msg;
> +		saved_svc = ((struct imx_sc_rpc_msg *)msg)->svc;
> +		saved_func = ((struct imx_sc_rpc_msg *)msg)->func;
> +	}
>  	sc_ipc->count = 0;
>  	ret = imx_scu_ipc_write(sc_ipc, msg);
>  	if (ret < 0) {
> @@ -190,7 +211,16 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
>  
>  		/* response status is stored in hdr->func field */
>  		hdr = msg;
> -		ret = hdr->func;
> +		/*
> +		 * Some special SCU firmware APIs do NOT have return value
> +		 * in hdr->func, but they do have response data, those special
> +		 * APIs are defined as void function in SCU firmware, so they
> +		 * should be treated as return success always.
> +		 */
> +		if (!imx_scu_call_skip_return_value_check(saved_svc, saved_func))
> +			ret = hdr->func;
> +		else
> +			ret = 0;
>  	}
>  
>  out:
> -- 
> 2.7.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
