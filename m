Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D0FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FCE218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfDYGes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:34:48 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:64034 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDYGer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:34:47 -0400
X-IronPort-AV: E=Sophos;i="5.60,392,1549954800"; 
   d="scan'208";a="30632859"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 Apr 2019 23:34:46 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Wed, 24 Apr 2019
 23:34:46 -0700
Date:   Thu, 25 Apr 2019 08:34:16 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <Eugen.Hristev@microchip.com>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND] can: m_can: implement errata "Needless activation
 of MRAF irq"
Message-ID: <20190425063416.iuwbtqdhffuidaju@M43218.corp.atmel.com>
Mail-Followup-To: Eugen.Hristev@microchip.com, wg@grandegger.com,
        mkl@pengutronix.de, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1554209445-19879-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1554209445-19879-1-git-send-email-eugen.hristev@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 12:56:18PM +0000, Eugen.Hristev@microchip.com wrote:
> 
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> During frame reception while the MCAN is in Error Passive state
> and the Receive Error Counter has thevalue MCAN_ECR.REC = 127, it may happen
> that MCAN_IR.MRAF is set although there was no Message RAM access failure.
> If MCAN_IR.MRAF is enabled, an interrupt to the Host CPU is generated.
> Work around:
> The Message RAM Access Failure interrupt routine needs to check whether
>  MCAN_ECR.RP = '1' and MCAN_ECR.REC = '127'.
> In this case, reset MCAN_IR.MRAF. No further action is required.
> This affects versions older than 3.2.0
> 
> Errata explained on Sama5d2 SoC which includes this hardware block:
> http://ww1.microchip.com/downloads/en/DeviceDoc/SAMA5D2-Family-Silicon-Errata-and-Data-Sheet-Clarification-DS80000803B.pdf chapter 6.2
> 
> Reproducibility: If 2 devices with m_can are connected back to back,
> configuring different bitrate on them will lead to interrupt storm on the
> receiving side, with error "Message RAM access failure occurred".
> Another way is to have a bad hardware connection. Bad wire connection can lead
> to this issue as well.
> 
> This patch fixes the issue according to provided workaround.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Sounds good.

Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/net/can/m_can/m_can.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 9b44940..deb274a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -822,6 +822,27 @@ static int m_can_poll(struct napi_struct *napi, int quota)
>  	if (!irqstatus)
>  		goto end;
>  
> +	/* Errata workaround for issue "Needless activation of MRAF irq"
> +	 * During frame reception while the MCAN is in Error Passive state
> +	 * and the Receive Error Counter has the value MCAN_ECR.REC = 127,
> +	 * it may happen that MCAN_IR.MRAF is set although there was no
> +	 * Message RAM access failure.
> +	 * If MCAN_IR.MRAF is enabled, an interrupt to the Host CPU is generated
> +	 * The Message RAM Access Failure interrupt routine needs to check
> +	 * whether MCAN_ECR.RP = ’1’ and MCAN_ECR.REC = 127.
> +	 * In this case, reset MCAN_IR.MRAF. No further action is required.
> +	 */
> +	if ((priv->version <= 31) && (irqstatus & IR_MRAF) &&
> +	    (m_can_read(priv, M_CAN_ECR) & ECR_RP)) {
> +		struct can_berr_counter bec;
> +
> +		__m_can_get_berr_counter(dev, &bec);
> +		if (bec.rxerr == 127) {
> +			m_can_write(priv, M_CAN_IR, IR_MRAF);
> +			irqstatus &= ~IR_MRAF;
> +		}
> +	}
> +
>  	psr = m_can_read(priv, M_CAN_PSR);
>  	if (irqstatus & IR_ERR_STATE)
>  		work_done += m_can_handle_state_errors(dev, psr);
> -- 
> 2.7.4
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
