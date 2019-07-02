Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3368CC06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E58206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfGBHf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:35:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50095 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfGBHf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:35:26 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1hiDJz-0001Yv-CL; Tue, 02 Jul 2019 09:35:23 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hiDJy-00009W-PR; Tue, 02 Jul 2019 09:35:22 +0200
Date:   Tue, 2 Jul 2019 09:35:22 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson.Huang@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2] soc: imx-scu: Add SoC UID(unique identifier) support
Message-ID: <20190702073522.blujpmxddw7brr7c@pengutronix.de>
References: <20190628032544.8317-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628032544.8317-1-Anson.Huang@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:31:59 up 45 days, 13:50, 49 users,  load average: 0.13, 0.05,
 0.01
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

On 19-06-28 11:25, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Add i.MX SCU SoC's UID(unique identifier) support, user
> can read it from sysfs:
> 
> root@imx8qxpmek:~# cat /sys/devices/soc0/soc_uid
> 7B64280B57AC1898
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- Improve the comment of skipping SCFW API return value check for getting UID.
> ---
>  drivers/soc/imx/soc-imx-scu.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c
> index 676f612..3eacb54 100644
> --- a/drivers/soc/imx/soc-imx-scu.c
> +++ b/drivers/soc/imx/soc-imx-scu.c
> @@ -27,6 +27,40 @@ struct imx_sc_msg_misc_get_soc_id {
>  	} data;
>  } __packed;
>  
> +struct imx_sc_msg_misc_get_soc_uid {
> +	struct imx_sc_rpc_msg hdr;
> +	u32 uid_low;
> +	u32 uid_high;
> +} __packed;
> +
> +static ssize_t soc_uid_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
> +{
> +	struct imx_sc_msg_misc_get_soc_uid msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	u64 soc_uid;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_MISC;
> +	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
> +	hdr->size = 1;
> +
> +	/*
> +	 * SCU FW API always returns an error even the
> +	 * function is successfully executed, so skip
> +	 * returned value check.
> +	 */
> +	imx_scu_call_rpc(soc_ipc_handle, &msg, true);

Please can you add a TODO: or FIXME: tag and also provide the firmware
version containing the bug? I know that developers are very busy and
follow-up fixes never reach mainline ;)

Regards,
  Marco

> +
> +	soc_uid = msg.uid_high;
> +	soc_uid <<= 32;
> +	soc_uid |= msg.uid_low;
> +
> +	return sprintf(buf, "%016llX\n", soc_uid);
> +}
> +
> +static DEVICE_ATTR_RO(soc_uid);
> +
>  static int imx_scu_soc_id(void)
>  {
>  	struct imx_sc_msg_misc_get_soc_id msg;
> @@ -102,6 +136,11 @@ static int imx_scu_soc_probe(struct platform_device *pdev)
>  		goto free_revision;
>  	}
>  
> +	ret = device_create_file(soc_device_to_device(soc_dev),
> +				 &dev_attr_soc_uid);
> +	if (ret)
> +		goto free_revision;
> +
>  	return 0;
>  
>  free_revision:
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
