Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F4C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A015D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FxxUhfdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfFUPPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:15:14 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43700 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFUPPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xxRtkouLQOkjbSb2xQ/D7ZWITwU59jLSNRvzRcqT9bk=; b=FxxUhfdM/DtOAZTabH4qWJ6mQ
        EReqHrL+GxlNTIgZD4JEhmWW0iH/QXpqI+Up//zh9QZyLrgmjnP6mu2AfJqOGRNynOebpF+M4dRTC
        +w3WB3LsinjSw7tW9/Mj4yMQVG854K+CPcTrSqgQp5lalygjKEQ5qKVUObwEtTlk5WKMbZR93fB01
        O3zE+lLduJk5VjVdUJKbArQAbB3DEWe8l0XlsjPFQ3FGTC2HvPFQ09F4N0JCV3q6zATHFm3VxHghh
        3lEbLhMbYoVWEFxHb7EypNss1MGiw9jqNW4q8BN7QJT9JQRslr45dF85Tdpw31N/0EnmOLTSShbum
        3ZdwrPYWA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:58962)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1heLFp-0006B6-NZ; Fri, 21 Jun 2019 16:15:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1heLFk-0003Mj-NF; Fri, 21 Jun 2019 16:15:00 +0100
Date:   Fri, 21 Jun 2019 16:15:00 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v1 1/2] drm/i2c: tda998x: access chip registers via a
 regmap
Message-ID: <20190621151500.cv57g3al5sadpcum@shell.armlinux.org.uk>
References: <20190527191552.10413-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527191552.10413-1-TheSven73@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 03:15:51PM -0400, Sven Van Asbroeck wrote:
> The tda988x i2c chip registers are accessed through a
> paged register scheme. The kernel regmap abstraction
> supports paged accesses. Replace this driver's
> dedicated i2c access functions with a standard i2c
> regmap.
> 
> Pros:
> - dedicated i2c access code disappears: accesses now
>   go through well-maintained regmap code
> - page atomicity requirements now handled by regmap
> - ro/wo/rw access modes are now explicitly defined:
>   any inappropriate register accesses (e.g. write to a
>   read-only register) will now be explicitly rejected
>   by the regmap core
> - all tda988x registers are now visible via debugfs
> 
> Cons:
> - this will probably require extensive testing

Another con is the need to keep the functions that detail the register
properties up to date, which if they're wrong may result in unexpected
behaviour.

I subscribe to the "keep it simple" approach, and regmap, although
useful, seems like a giant sledgehammer for this.

> 
> Tested on a TDA19988 using a Freescale/NXP imx6q.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
> 
> I originally hacked this together while debugging an incompatibility between
> the tda988x's audio input and the audio codec I was driving it with.
> That required me to have debug access to the chip's register values.
> A regmap did the trick, it has good debugfs support.
> 
>  drivers/gpu/drm/i2c/tda998x_drv.c | 350 ++++++++++++++++++++----------
>  1 file changed, 234 insertions(+), 116 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index 7f34601bb515..8153e2e19e18 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/tda9950.h>
>  #include <linux/irq.h>
> +#include <linux/regmap.h>
>  #include <sound/asoundef.h>
>  #include <sound/hdmi-codec.h>
>  
> @@ -43,10 +44,9 @@ struct tda998x_audio_port {
>  struct tda998x_priv {
>  	struct i2c_client *cec;
>  	struct i2c_client *hdmi;
> -	struct mutex mutex;
> +	struct regmap *regmap;
>  	u16 rev;
>  	u8 cec_addr;
> -	u8 current_page;
>  	bool is_on;
>  	bool supports_infoframes;
>  	bool sink_has_audio;
> @@ -88,12 +88,10 @@ struct tda998x_priv {
>  /* The TDA9988 series of devices use a paged register scheme.. to simplify
>   * things we encode the page # in upper bits of the register #.  To read/
>   * write a given register, we need to make sure CURPAGE register is set
> - * appropriately.  Which implies reads/writes are not atomic.  Fun!
> + * appropriately.
>   */
>  
>  #define REG(page, addr) (((page) << 8) | (addr))
> -#define REG2ADDR(reg)   ((reg) & 0xff)
> -#define REG2PAGE(reg)   (((reg) >> 8) & 0xff)
>  
>  #define REG_CURPAGE               0xff                /* write */
>  
> @@ -285,8 +283,9 @@ struct tda998x_priv {
>  
>  
>  /* Page 09h: EDID Control */
> +/*	EDID_DATA consists of 128 successive registers   read */
>  #define REG_EDID_DATA_0           REG(0x09, 0x00)     /* read */
> -/* next 127 successive registers are the EDID block */
> +#define REG_EDID_DATA_127         REG(0x09, 0x7f)     /* read */
>  #define REG_EDID_CTRL             REG(0x09, 0xfa)     /* read/write */
>  #define REG_DDC_ADDR              REG(0x09, 0xfb)     /* read/write */
>  #define REG_DDC_OFFS              REG(0x09, 0xfc)     /* read/write */
> @@ -295,11 +294,17 @@ struct tda998x_priv {
>  
>  
>  /* Page 10h: information frames and packets */
> +/*	REG_IF1_HB consists of 32 successive registers	 read/write */
>  #define REG_IF1_HB0               REG(0x10, 0x20)     /* read/write */
> +/*	REG_IF2_HB consists of 32 successive registers	 read/write */
>  #define REG_IF2_HB0               REG(0x10, 0x40)     /* read/write */
> +/*	REG_IF3_HB consists of 32 successive registers	 read/write */
>  #define REG_IF3_HB0               REG(0x10, 0x60)     /* read/write */
> +/*	REG_IF4_HB consists of 32 successive registers	 read/write */
>  #define REG_IF4_HB0               REG(0x10, 0x80)     /* read/write */
> +/*	REG_IF5_HB consists of 32 successive registers	 read/write */
>  #define REG_IF5_HB0               REG(0x10, 0xa0)     /* read/write */
> +#define REG_IF5_HB31              REG(0x10, 0xbf)     /* read/write */
>  
>  
>  /* Page 11h: audio settings and content info packets */
> @@ -542,93 +547,29 @@ static void tda998x_cec_hook_release(void *data)
>  	cec_enamods(priv, CEC_ENAMODS_EN_CEC_CLK | CEC_ENAMODS_EN_CEC, false);
>  }
>  
> -static int
> -set_page(struct tda998x_priv *priv, u16 reg)
> -{
> -	if (REG2PAGE(reg) != priv->current_page) {
> -		struct i2c_client *client = priv->hdmi;
> -		u8 buf[] = {
> -				REG_CURPAGE, REG2PAGE(reg)
> -		};
> -		int ret = i2c_master_send(client, buf, sizeof(buf));
> -		if (ret < 0) {
> -			dev_err(&client->dev, "%s %04x err %d\n", __func__,
> -					reg, ret);
> -			return ret;
> -		}
> -
> -		priv->current_page = REG2PAGE(reg);
> -	}
> -	return 0;
> -}
> -
>  static int
>  reg_read_range(struct tda998x_priv *priv, u16 reg, char *buf, int cnt)
>  {
> -	struct i2c_client *client = priv->hdmi;
> -	u8 addr = REG2ADDR(reg);
>  	int ret;
>  
> -	mutex_lock(&priv->mutex);
> -	ret = set_page(priv, reg);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = i2c_master_send(client, &addr, sizeof(addr));
> +	ret = regmap_bulk_read(priv->regmap, reg, buf, cnt);
>  	if (ret < 0)
> -		goto fail;
> -
> -	ret = i2c_master_recv(client, buf, cnt);
> -	if (ret < 0)
> -		goto fail;
> -
> -	goto out;
> -
> -fail:
> -	dev_err(&client->dev, "Error %d reading from 0x%x\n", ret, reg);
> -out:
> -	mutex_unlock(&priv->mutex);
> -	return ret;
> +		return ret;
> +	return cnt;
>  }
>  
> -#define MAX_WRITE_RANGE_BUF 32
> -
>  static void
>  reg_write_range(struct tda998x_priv *priv, u16 reg, u8 *p, int cnt)
>  {
> -	struct i2c_client *client = priv->hdmi;
> -	/* This is the maximum size of the buffer passed in */
> -	u8 buf[MAX_WRITE_RANGE_BUF + 1];
> -	int ret;
> -
> -	if (cnt > MAX_WRITE_RANGE_BUF) {
> -		dev_err(&client->dev, "Fixed write buffer too small (%d)\n",
> -				MAX_WRITE_RANGE_BUF);
> -		return;
> -	}
> -
> -	buf[0] = REG2ADDR(reg);
> -	memcpy(&buf[1], p, cnt);
> -
> -	mutex_lock(&priv->mutex);
> -	ret = set_page(priv, reg);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = i2c_master_send(client, buf, cnt + 1);
> -	if (ret < 0)
> -		dev_err(&client->dev, "Error %d writing to 0x%x\n", ret, reg);
> -out:
> -	mutex_unlock(&priv->mutex);
> +	regmap_bulk_write(priv->regmap, reg, p, cnt);
>  }
>  
>  static int
>  reg_read(struct tda998x_priv *priv, u16 reg)
>  {
> -	u8 val = 0;
> -	int ret;
> +	int ret, val;
>  
> -	ret = reg_read_range(priv, reg, &val, sizeof(val));
> +	ret = regmap_read(priv->regmap, reg, &val);
>  	if (ret < 0)
>  		return ret;
>  	return val;
> @@ -637,59 +578,27 @@ reg_read(struct tda998x_priv *priv, u16 reg)
>  static void
>  reg_write(struct tda998x_priv *priv, u16 reg, u8 val)
>  {
> -	struct i2c_client *client = priv->hdmi;
> -	u8 buf[] = {REG2ADDR(reg), val};
> -	int ret;
> -
> -	mutex_lock(&priv->mutex);
> -	ret = set_page(priv, reg);
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = i2c_master_send(client, buf, sizeof(buf));
> -	if (ret < 0)
> -		dev_err(&client->dev, "Error %d writing to 0x%x\n", ret, reg);
> -out:
> -	mutex_unlock(&priv->mutex);
> +	regmap_write(priv->regmap, reg, val);
>  }
>  
>  static void
>  reg_write16(struct tda998x_priv *priv, u16 reg, u16 val)
>  {
> -	struct i2c_client *client = priv->hdmi;
> -	u8 buf[] = {REG2ADDR(reg), val >> 8, val};
> -	int ret;
> -
> -	mutex_lock(&priv->mutex);
> -	ret = set_page(priv, reg);
> -	if (ret < 0)
> -		goto out;
> +	u8 buf[] = {val >> 8, val};
>  
> -	ret = i2c_master_send(client, buf, sizeof(buf));
> -	if (ret < 0)
> -		dev_err(&client->dev, "Error %d writing to 0x%x\n", ret, reg);
> -out:
> -	mutex_unlock(&priv->mutex);
> +	regmap_bulk_write(priv->regmap, reg, buf, ARRAY_SIZE(buf));
>  }
>  
>  static void
>  reg_set(struct tda998x_priv *priv, u16 reg, u8 val)
>  {
> -	int old_val;
> -
> -	old_val = reg_read(priv, reg);
> -	if (old_val >= 0)
> -		reg_write(priv, reg, old_val | val);
> +	regmap_update_bits(priv->regmap, reg, val, val);
>  }
>  
>  static void
>  reg_clear(struct tda998x_priv *priv, u16 reg, u8 val)
>  {
> -	int old_val;
> -
> -	old_val = reg_read(priv, reg);
> -	if (old_val >= 0)
> -		reg_write(priv, reg, old_val & ~val);
> +	regmap_update_bits(priv->regmap, reg, val, 0);
>  }
>  
>  static void
> @@ -816,7 +725,7 @@ static void
>  tda998x_write_if(struct tda998x_priv *priv, u8 bit, u16 addr,
>  		 union hdmi_infoframe *frame)
>  {
> -	u8 buf[MAX_WRITE_RANGE_BUF];
> +	u8 buf[32];
>  	ssize_t len;
>  
>  	len = hdmi_infoframe_pack(frame, buf, sizeof(buf));
> @@ -1654,6 +1563,211 @@ static void tda998x_destroy(struct device *dev)
>  		cec_notifier_put(priv->cec_notify);
>  }
>  
> +static bool tda_is_edid_data_reg(unsigned int reg)
> +{
> +	return (reg >= REG_EDID_DATA_0) &&
> +		(reg <= REG_EDID_DATA_127);
> +}
> +
> +static bool tda_is_precious_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	if (tda_is_edid_data_reg(reg))
> +		return true;
> +	switch (reg) {
> +	case REG_INT_FLAGS_0:
> +	case REG_INT_FLAGS_1:
> +	case REG_INT_FLAGS_2:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool tda_is_rw_reg(unsigned int reg)
> +{
> +	if ((reg >= REG_IF1_HB0) && (reg <= REG_IF5_HB31))
> +		return true;
> +	switch (reg) {
> +	case REG_MAIN_CNTRL0:
> +	case REG_DDC_DISABLE:
> +	case REG_CCLK_ON:
> +	case REG_I2C_MASTER:
> +	case REG_FEAT_POWERDOWN:
> +	case REG_INT_FLAGS_0:
> +	case REG_INT_FLAGS_1:
> +	case REG_INT_FLAGS_2:
> +	case REG_ENA_ACLK:
> +	case REG_ENA_VP_0:
> +	case REG_ENA_VP_1:
> +	case REG_ENA_VP_2:
> +	case REG_ENA_AP:
> +	case REG_MUX_AP:
> +	case REG_MUX_VP_VIP_OUT:
> +	case REG_I2S_FORMAT:
> +	case REG_PLL_SERIAL_1:
> +	case REG_PLL_SERIAL_2:
> +	case REG_PLL_SERIAL_3:
> +	case REG_SERIALIZER:
> +	case REG_BUFFER_OUT:
> +	case REG_PLL_SCG1:
> +	case REG_PLL_SCG2:
> +	case REG_PLL_SCGN1:
> +	case REG_PLL_SCGN2:
> +	case REG_PLL_SCGR1:
> +	case REG_PLL_SCGR2:
> +	case REG_AUDIO_DIV:
> +	case REG_SEL_CLK:
> +	case REG_ANA_GENERAL:
> +	case REG_EDID_CTRL:
> +	case REG_DDC_ADDR:
> +	case REG_DDC_OFFS:
> +	case REG_DDC_SEGM_ADDR:
> +	case REG_DDC_SEGM:
> +	case REG_AIP_CNTRL_0:
> +	case REG_CA_I2S:
> +	case REG_LATENCY_RD:
> +	case REG_ACR_CTS_0:
> +	case REG_ACR_CTS_1:
> +	case REG_ACR_CTS_2:
> +	case REG_ACR_N_0:
> +	case REG_ACR_N_1:
> +	case REG_ACR_N_2:
> +	case REG_CTS_N:
> +	case REG_ENC_CNTRL:
> +	case REG_DIP_FLAGS:
> +	case REG_DIP_IF_FLAGS:
> +	case REG_TX3:
> +	case REG_TX4:
> +	case REG_TX33:
> +	case REG_CH_STAT_B(0):
> +	case REG_CH_STAT_B(1):
> +	case REG_CH_STAT_B(2):
> +	case REG_CH_STAT_B(3):
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool tda_is_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	if (tda_is_rw_reg(reg) || tda_is_edid_data_reg(reg))
> +		return true;
> +	switch (reg) {
> +	case REG_VERSION_LSB:
> +	case REG_VERSION_MSB:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool tda_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	if (tda_is_rw_reg(reg))
> +		return true;
> +	switch (reg) {
> +	case REG_CURPAGE:
> +	case REG_SOFTRESET:
> +	case REG_VIP_CNTRL_0:
> +	case REG_VIP_CNTRL_1:
> +	case REG_VIP_CNTRL_2:
> +	case REG_VIP_CNTRL_3:
> +	case REG_VIP_CNTRL_4:
> +	case REG_VIP_CNTRL_5:
> +	case REG_MAT_CONTRL:
> +	case REG_VIDFORMAT:
> +	case REG_REFPIX_MSB:
> +	case REG_REFPIX_LSB:
> +	case REG_REFLINE_MSB:
> +	case REG_REFLINE_LSB:
> +	case REG_NPIX_MSB:
> +	case REG_NPIX_LSB:
> +	case REG_NLINE_MSB:
> +	case REG_NLINE_LSB:
> +	case REG_VS_LINE_STRT_1_MSB:
> +	case REG_VS_LINE_STRT_1_LSB:
> +	case REG_VS_PIX_STRT_1_MSB:
> +	case REG_VS_PIX_STRT_1_LSB:
> +	case REG_VS_LINE_END_1_MSB:
> +	case REG_VS_LINE_END_1_LSB:
> +	case REG_VS_PIX_END_1_MSB:
> +	case REG_VS_PIX_END_1_LSB:
> +	case REG_VS_LINE_STRT_2_MSB:
> +	case REG_VS_LINE_STRT_2_LSB:
> +	case REG_VS_PIX_STRT_2_MSB:
> +	case REG_VS_PIX_STRT_2_LSB:
> +	case REG_VS_LINE_END_2_MSB:
> +	case REG_VS_LINE_END_2_LSB:
> +	case REG_VS_PIX_END_2_MSB:
> +	case REG_VS_PIX_END_2_LSB:
> +	case REG_HS_PIX_START_MSB:
> +	case REG_HS_PIX_START_LSB:
> +	case REG_HS_PIX_STOP_MSB:
> +	case REG_HS_PIX_STOP_LSB:
> +	case REG_VWIN_START_1_MSB:
> +	case REG_VWIN_START_1_LSB:
> +	case REG_VWIN_END_1_MSB:
> +	case REG_VWIN_END_1_LSB:
> +	case REG_VWIN_START_2_MSB:
> +	case REG_VWIN_START_2_LSB:
> +	case REG_VWIN_END_2_MSB:
> +	case REG_VWIN_END_2_LSB:
> +	case REG_DE_START_MSB:
> +	case REG_DE_START_LSB:
> +	case REG_DE_STOP_MSB:
> +	case REG_DE_STOP_LSB:
> +	case REG_TBG_CNTRL_0:
> +	case REG_TBG_CNTRL_1:
> +	case REG_ENABLE_SPACE:
> +	case REG_HVF_CNTRL_0:
> +	case REG_HVF_CNTRL_1:
> +	case REG_RPT_CNTRL:
> +	case REG_AIP_CLKSEL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct reg_default tda_reg_default[] = {
> +	{ REG_CURPAGE, 0xff },
> +};
> +
> +static const struct regmap_range_cfg hdmi_range_cfg[] = {
> +	{
> +		.range_min = 0x00,
> +		.range_max = REG_TX33,
> +		.selector_reg = REG_CURPAGE,
> +		.selector_mask = 0xff,
> +		.selector_shift = 0,
> +		.window_start = 0,
> +		.window_len = 0x100,
> +	},
> +};
> +
> +/* Paged register scheme, with a write-only page register (CURPAGE).
> + * Make this work by marking CURPAGE write-only and cacheable. Give it
> + * an invalid page default value, which guarantees that it will get written to
> + * the first time we read/write the registers.
> + */
> +
> +static const struct regmap_config hdmi_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.ranges = hdmi_range_cfg,
> +	.num_ranges = ARRAY_SIZE(hdmi_range_cfg),
> +	.max_register = REG_TX33,
> +
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_reg = tda_is_precious_volatile_reg,
> +	.precious_reg = tda_is_precious_volatile_reg,
> +	.readable_reg = tda_is_readable_reg,
> +	.writeable_reg = tda_is_writeable_reg,
> +	.reg_defaults = tda_reg_default,
> +	.num_reg_defaults = ARRAY_SIZE(tda_reg_default),
> +};
> +
>  static int tda998x_create(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> @@ -1666,10 +1780,15 @@ static int tda998x_create(struct device *dev)
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> +	priv->regmap = devm_regmap_init_i2c(client, &hdmi_regmap_config);
> +	if (IS_ERR(priv->regmap)) {
> +		ret = PTR_ERR(priv->regmap);
> +		dev_err(dev, "Failed to allocate register map: %d\n", ret);
> +		return ret;
> +	}
>  
>  	dev_set_drvdata(dev, priv);
>  
> -	mutex_init(&priv->mutex);	/* protect the page access */
>  	mutex_init(&priv->audio_mutex); /* protect access from audio thread */
>  	mutex_init(&priv->edid_mutex);
>  	INIT_LIST_HEAD(&priv->bridge.list);
> @@ -1683,7 +1802,6 @@ static int tda998x_create(struct device *dev)
>  
>  	/* CEC I2C address bound to TDA998x I2C addr by configuration pins */
>  	priv->cec_addr = 0x34 + (client->addr & 0x03);
> -	priv->current_page = 0xff;
>  	priv->hdmi = client;
>  
>  	/* wake up the device: */
> -- 
> 2.17.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
