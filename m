Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1779C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75208217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558420344;
	bh=ZshP8rr+U+KG2zbDeHbOGcRJBSaS1gDqRvgJbWlilIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lt4Ebir+fYQgC3nfBNtl7teL1TP762j8UDDCORnD5b5uNhhYElzY1R/uREaTbF8pS
	 9jObrWzISCZs+TDAkHApa6CMknGJF7vt2Pl1vRsOjSgOK5crtKyrHzsxrPMHbFXO9m
	 6pIfh0KVrq/rr8P4bEfpj36ANtw2my9/MEigxcuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfEUGcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfEUGcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:32:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31ADE2173C;
        Tue, 21 May 2019 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558419873;
        bh=ZshP8rr+U+KG2zbDeHbOGcRJBSaS1gDqRvgJbWlilIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A/egFiqsIZW1N0Uw03GJahczQcAmMMW9SO+vfStlvHvrDZjM7cGIVPKKLe4N5mY0M
         lwacbLuTBuecVsR/mbQCVWmIDUc53d+Aidtm8iQPEinHj7s9Xu9e9WJNXRgwZDX/bU
         tNXboyHWpBw1E+2X4UTGvZwcFHedzHhOoRtz5QzA=
Date:   Tue, 21 May 2019 08:24:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Ojaswin Mujoo <ojaswin25111998@gmail.com>
Subject: Re: [PATCH 6/7] staging: vt6656: clean-up registers initialization
 error path
Message-ID: <20190521062430.GA13860@kroah.com>
References: <20190520163844.1225-1-quentin.deslandes@itdev.co.uk>
 <20190520163844.1225-7-quentin.deslandes@itdev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520163844.1225-7-quentin.deslandes@itdev.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:39:04PM +0000, Quentin Deslandes wrote:
> Avoid discarding function's return code during register initialization.
> Handle it instead and return 0 on success or a negative errno value on
> error.
> 
> Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
> ---
>  drivers/staging/vt6656/main_usb.c | 163 ++++++++++++++++++------------
>  1 file changed, 96 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
> index 5fd845cbdd52..8ed96e8eedbe 100644
> --- a/drivers/staging/vt6656/main_usb.c
> +++ b/drivers/staging/vt6656/main_usb.c
> @@ -109,33 +109,38 @@ static void vnt_set_options(struct vnt_private *priv)
>   */
>  static int vnt_init_registers(struct vnt_private *priv)
>  {
> +	int ret = 0;

Minor nit here, no need to set this to 0 as you instantly set it with
this call:

>  	struct vnt_cmd_card_init *init_cmd = &priv->init_command;
>  	struct vnt_rsp_card_init *init_rsp = &priv->init_response;
>  	u8 antenna;
>  	int ii;
> -	int status = STATUS_SUCCESS;
>  	u8 tmp;
>  	u8 calib_tx_iq = 0, calib_tx_dc = 0, calib_rx_iq = 0;
>  
>  	dev_dbg(&priv->usb->dev, "---->INIbInitAdapter. [%d][%d]\n",
>  		DEVICE_INIT_COLD, priv->packet_type);
>  
> -	if (!vnt_check_firmware_version(priv)) {
> -		if (vnt_download_firmware(priv) == true) {
> -			if (vnt_firmware_branch_to_sram(priv) == false) {
> -				dev_dbg(&priv->usb->dev,
> -					" vnt_firmware_branch_to_sram fail\n");
> -				return false;
> -			}
> -		} else {
> -			dev_dbg(&priv->usb->dev, "FIRMWAREbDownload fail\n");
> -			return false;
> +	ret = vnt_check_firmware_version(priv);

You can fix that up in a later patch :)

At first glance, these all look really good, thanks for doing this work.

greg k-h
