Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53C3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC10F2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfDPGAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:00:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48166 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfDPGAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:00:55 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4F4A6260C42;
        Tue, 16 Apr 2019 07:00:53 +0100 (BST)
Date:   Tue, 16 Apr 2019 08:00:49 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     linux-i3c@lists.infradead.org, joao.pinto@synopsys.com,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] i3c: add mixed limited bus mode
Message-ID: <20190416080049.5a6053b0@collabora.com>
In-Reply-To: <a3bf32dadd9b0135442526cc77fec5726e6e617d.1555350118.git.vitor.soares@synopsys.com>
References: <cover.1555350118.git.vitor.soares@synopsys.com>
        <a3bf32dadd9b0135442526cc77fec5726e6e617d.1555350118.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitor,

On Mon, 15 Apr 2019 20:46:42 +0200
Vitor Soares <vitor.soares@synopsys.com> wrote:

> The i3c bus spec define a bus configuration where the i2c devices

		   ^defines			    I2C devices...

> doesn't have the 50ns filter yet they allow the SDR max speed.

  ^don't	^ a 50ns filter but support SCL running at SDR max
rate (12MHz).

> 
> This patch introduce the limited bus mode so the users can use

	     ^introduces		    ^ so that users

> a higher speed on presence of i2c devices index 1.

		 ^in

> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---
>  drivers/i3c/master.c       | 5 +++++
>  include/linux/i3c/master.h | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 1c4a86a..46d3774 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -463,6 +463,7 @@ static int i3c_bus_init(struct i3c_bus *i3cbus)
>  static const char * const i3c_bus_mode_strings[] = {
>  	[I3C_BUS_MODE_PURE] = "pure",
>  	[I3C_BUS_MODE_MIXED_FAST] = "mixed-fast",
> +	[I3C_BUS_MODE_MIXED_LIMITED] = "mixed-limited",
>  	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
>  };
>  
> @@ -575,6 +576,7 @@ int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
>  			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
>  		break;
>  	case I3C_BUS_MODE_MIXED_FAST:
> +	case I3C_BUS_MODE_MIXED_LIMITED:
>  		if (!i3cbus->scl_rate.i3c)
>  			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
>  		if (!i3cbus->scl_rate.i2c)
> @@ -2481,6 +2483,9 @@ int i3c_master_register(struct i3c_master_controller *master,
>  				mode = I3C_BUS_MODE_MIXED_FAST;
>  			break;
>  		case I3C_LVR_I2C_INDEX(1):
> +			if (mode < I3C_BUS_MODE_MIXED_LIMITED)
> +				mode = I3C_BUS_MODE_MIXED_LIMITED;
> +			break;
>  		case I3C_LVR_I2C_INDEX(2):
>  			if (mode < I3C_BUS_MODE_MIXED_SLOW)
>  				mode = I3C_BUS_MODE_MIXED_SLOW;
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 44fb3cf..740235e 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -250,12 +250,17 @@ struct i3c_device {
>   *			     the bus. The only impact in this mode is that the
>   *			     high SCL pulse has to stay below 50ns to trick I2C
>   *			     devices when transmitting I3C frames
> + * @I3C_BUS_MODE_MIXED_LIMITED: I2C devices without 50ns spike filter are
> + *				present on the bus. However they allows
> + *				compliance up to the maximum SDR SCL clock
> + *				frequency.

						    However they support
				SCL clock running at maximum SDR rate
				(12.5MHz).

>   * @I3C_BUS_MODE_MIXED_SLOW: I2C devices without 50ns spike filter are present
>   *			     on the bus
>   */
>  enum i3c_bus_mode {
>  	I3C_BUS_MODE_PURE,
>  	I3C_BUS_MODE_MIXED_FAST,
> +	I3C_BUS_MODE_MIXED_LIMITED,
>  	I3C_BUS_MODE_MIXED_SLOW,
>  };
>  

The code itself looks good.

Thanks,

Boris
