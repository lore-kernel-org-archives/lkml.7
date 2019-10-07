Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9CAC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05ED020867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfJGIBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:01:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36803 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:01:41 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iHNxY-0001wb-US; Mon, 07 Oct 2019 10:01:36 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iHNxX-0003ly-Hb; Mon, 07 Oct 2019 10:01:35 +0200
Date:   Mon, 7 Oct 2019 10:01:35 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2] firmware: imx: Skip return value check for some
 special SCU firmware APIs
Message-ID: <20191007080135.4e5ljhh6z2rbx5bw@pengutronix.de>
References: <1570410959-32563-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570410959-32563-1-git-send-email-Anson.Huang@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:59:23 up 142 days, 14:17, 94 users,  load average: 0.03, 0.07,
 0.11
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On 19-10-07 09:15, Anson Huang wrote:
> The SCU firmware does NOT always have return value stored in message
> header's function element even the API has response data, those special
> APIs are defined as void function in SCU firmware, so they should be
> treated as return success always.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Use direct API check instead of calling another function to check.
> 	- This patch is based on https://patchwork.kernel.org/patch/11129553/

Thanks for this v2. It would be good to change the callers within this
series.

Regards,
  Marco

> ---
>  drivers/firmware/imx/imx-scu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
> index 869be7a..03b43b7 100644
> --- a/drivers/firmware/imx/imx-scu.c
> +++ b/drivers/firmware/imx/imx-scu.c
> @@ -162,6 +162,7 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_ipc, void *msg)
>   */
>  int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
>  {
> +	uint8_t saved_svc, saved_func;
>  	struct imx_sc_rpc_msg *hdr;
>  	int ret;
>  
> @@ -171,8 +172,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
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
> @@ -191,6 +195,16 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
>  		/* response status is stored in hdr->func field */
>  		hdr = msg;
>  		ret = hdr->func;
> +		/*
> +		 * Some special SCU firmware APIs do NOT have return value
> +		 * in hdr->func, but they do have response data, those special
> +		 * APIs are defined as void function in SCU firmware, so they
> +		 * should be treated as return success always.
> +		 */
> +		if ((saved_svc == IMX_SC_RPC_SVC_MISC) &&
> +			(saved_func == IMX_SC_MISC_FUNC_UNIQUE_ID ||
> +			 saved_func == IMX_SC_MISC_FUNC_GET_BUTTON_STATUS))
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
