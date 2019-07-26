Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407C9C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF256218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564173767;
	bh=7zhF5RO7sFN0Vp44cnR8p6iChwiX9bmrecwEgfqNKK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T/KcvrKiroallRhq4N2+Ep3Lkm0eYcN6Xiy7apYyK0Tr/9PmYAgvFyPMS2W+R4Xmw
	 cJToHNmKzX0G5JZ1/qqw9JNRSWRGYKyZhkKDXjIoLL70hMff1/x4vF0ZSinbpI4mFY
	 Qee/6Hu72J3FzjjPihCMidyzc99ARScjyvT+d5sY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfGZUmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:42:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45317 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfGZUmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:42:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so25280201pgp.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 13:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jEcrnWSfLx6wrUxTy6Z4iiCB/JTGK1p1AkFdDvOFdGA=;
        b=hCmiurfsFANnn08L79k+KCgwHzuxso+mjdVqQO65/mU8Gwd5my8yqpNLkjhDZ35/s3
         5ifpiLT2CUOvg6deNuf9RhkeQGgN9ySqnIXwfipH1RhbVF8ciw5auHPlZeK15T34g8ij
         uH9hZWnOn8wUr4ARlvBt/xkDHB0uPMkn0FlLIPIN6ZGRF+lmMRRckMcxWQdIVtKn/15q
         bvbD+Vcn1P6osz7Nu0XPlnXUmba14t6ZGp1wlDU1sf4fXymjq1E6MZle/PU8yUGbaG/T
         ZbVoxRXH3pnorAiw6z64cu3QE0io8voUT2WA/izVW4z9MFx6dqF/UmzgA15FJprDSdiK
         Tayg==
X-Gm-Message-State: APjAAAV5TfHpNSFise8SgDzJtct1uZze/MFsH5bKQ6Y4hTfUSFq+nsih
        vpZiX/1f/BCtHOIO2hgseFGOsg==
X-Google-Smtp-Source: APXvYqxfxBlMtG+MpWuPfrGRPzdrG3KkgirINPMEg5pODCdFa35kEdxNUJrZ+t+w1wKDLvPcOAo+Qw==
X-Received: by 2002:a63:c0d:: with SMTP id b13mr92735822pgl.420.1564173764101;
        Fri, 26 Jul 2019 13:42:44 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id k36sm55301695pgl.42.2019.07.26.13.42.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 13:42:43 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:42:42 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     mdf@kernel.org, richard.gong@linux.intel.com, agust@denx.de,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 3/3] fpga: altera-cvp: Add Stratix10 (V2) Support
Message-ID: <20190726204242.GA3163@archbox>
References: <1564067808-21173-1-git-send-email-thor.thayer@linux.intel.com>
 <1564067808-21173-4-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564067808-21173-4-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:16:48AM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add Stratix10 specific functions that use a credit mechanism
> to throttle data to the CvP FIFOs. Add a private structure
> with function pointers for V1 vs V2 functions.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2 Remove inline function declaration
>    Reverse Christmas Tree format for local variables
>    Remove mask from credit calculation
>    Add commment for the delay(1) function in wait_for_credit()
> v3 Fix return code of abstraction function
>    Move reset of current_credit_byte to clear_state().
>    Check return code of credit register read in wait_for_credit()
>    Check return code of clear_state read/write register.
> ---
>  drivers/fpga/altera-cvp.c | 193 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 178 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index b08c0fd353ba..6bf7462af4f3 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -43,16 +43,32 @@
>  #define VSE_CVP_PROG_CTRL		0x2c	/* 32bit */
>  #define VSE_CVP_PROG_CTRL_CONFIG	BIT(0)
>  #define VSE_CVP_PROG_CTRL_START_XFER	BIT(1)
> +#define VSE_CVP_PROG_CTRL_MASK		GENMASK(1, 0)
>  
>  #define VSE_UNCOR_ERR_STATUS		0x34	/* 32bit */
>  #define VSE_UNCOR_ERR_CVP_CFG_ERR	BIT(5)	/* CVP_CONFIG_ERROR_LATCHED */
>  
> +/* V2 Defines */
> +#define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
> +
> +#define CREDIT_TIMEOUT_US		20000
> +#define V2_POLL_TIMEOUT_US		1000000
> +#define V2_USER_TIMEOUT_US		500000
> +
> +#define V1_POLL_TIMEOUT_US		10
> +
>  #define DRV_NAME		"altera-cvp"
>  #define ALTERA_CVP_MGR_NAME	"Altera CvP FPGA Manager"
>  
> +/* Write block sizes */
> +#define ALTERA_CVP_V1_SIZE	4
> +#define ALTERA_CVP_V2_SIZE	4096
> +
>  /* Optional CvP config error status check for debugging */
>  static bool altera_cvp_chkcfg;
>  
> +struct cvp_priv;
> +
>  struct altera_cvp_conf {
>  	struct fpga_manager	*mgr;
>  	struct pci_dev		*pci_dev;
> @@ -60,9 +76,27 @@ struct altera_cvp_conf {
>  	void			(*write_data)(struct altera_cvp_conf *, u32);
>  	char			mgr_name[64];
>  	u8			numclks;
> +	u8			current_credit_byte;
>  	u32			vsec_offset;
> +	const struct cvp_priv	*priv;
>  };
>  
> +struct cvp_priv {
> +	void	(*switch_clk)(struct altera_cvp_conf *conf);
> +	int	(*clear_state)(struct altera_cvp_conf *conf);
> +	int	(*wait_credit)(struct fpga_manager *mgr, u32 blocks);
> +	int	block_size;
> +	int	poll_time_us;
> +	int	user_time_us;
> +};
> +
> +static int altera_read_config_byte(struct altera_cvp_conf *conf,
> +				   int where, u8 *val)
> +{
> +	return pci_read_config_byte(conf->pci_dev, conf->vsec_offset + where,
> +				    val);
> +}
> +
>  static int altera_read_config_dword(struct altera_cvp_conf *conf,
>  				    int where, u32 *val)
>  {
> @@ -158,6 +192,78 @@ static int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
>  	return 0;
>  }
>  
> +/*
> + * CvP Version2 Functions
> + * Recent Intel FPGAs use a credit mechanism to throttle incoming
> + * bitstreams and a different method of clearing the state.
> + */
> +
> +static int altera_cvp_v2_clear_state(struct altera_cvp_conf *conf)
> +{
> +	u32 val;
> +	int ret;
> +
> +	conf->current_credit_byte = 0;
> +
> +	/* Clear the START_XFER and CVP_CONFIG bits */
> +	ret = altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
> +	if (ret) {
> +		dev_err(&conf->pci_dev->dev,
> +			"Error reading CVP Program Control Register\n");
> +		return ret;
> +	}
> +
> +	val &= ~VSE_CVP_PROG_CTRL_MASK;
> +	ret = altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
> +	if (ret) {
> +		dev_err(&conf->pci_dev->dev,
> +			"Error writing CVP Program Control Register\n");
> +		return ret;
> +	}
> +
> +	return altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
> +				      conf->priv->poll_time_us);
> +}
> +
> +static int altera_cvp_v2_wait_for_credit(struct fpga_manager *mgr,
> +					 u32 blocks)
> +{
> +	struct altera_cvp_conf *conf = mgr->priv;
> +	u8 val, delta_credit;
> +	u32 count = 0;
> +	int ret;
> +
> +	do {
> +		ret = altera_read_config_byte(conf, VSE_CVP_TX_CREDITS, &val);
> +		if (ret) {
> +			dev_err(&conf->pci_dev->dev,
> +				"Error reading CVP Credit Register\n");
> +			return ret;
> +		}
> +
> +		delta_credit = val - conf->current_credit_byte;
How about 'space' or something similar ... instead of delta_credit
> +
> +		ret = altera_cvp_chk_error(mgr, blocks * ALTERA_CVP_V2_SIZE);
> +		if (ret) {
> +			dev_err(&conf->pci_dev->dev,
> +				"CE Bit error credits host[0x%x]:dev[0x%x]\n",
> +				conf->current_credit_byte, val);
> +			return -EAGAIN;
> +		}
> +
> +		if (count++ >= CREDIT_TIMEOUT_US) {
If you invert the logic here you can run your loop with while (!space &&
timeout--), that might make it simpler.
> +			dev_err(&conf->pci_dev->dev,
> +				"Timeout waiting for credit\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		/* Limit the traffic & ensure a timeout in usec */
> +		udelay(1);
Does this need to be 1us or can this be a usleep_range()?
> +	} while (!delta_credit);
> +
> +	return 0;
> +}
> +
>  static int altera_cvp_send_block(struct altera_cvp_conf *conf,
>  				 const u32 *data, size_t len)
>  {
> @@ -199,10 +305,12 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
>  	 * - set CVP_NUMCLKS to 1 and then issue CVP_DUMMY_WR dummy
>  	 *   writes to the HIP
>  	 */
> -	altera_cvp_dummy_write(conf); /* from CVP clock to internal clock */
> +	if (conf->priv->switch_clk)
> +		conf->priv->switch_clk(conf);
>  
>  	/* STEP 15 - poll CVP_CONFIG_READY bit for 0 with 10us timeout */
> -	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0, 10);
> +	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
> +				     conf->priv->poll_time_us);
>  	if (ret)
>  		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
>  
> @@ -264,7 +372,16 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  	 * STEP 3
>  	 * - set CVP_NUMCLKS to 1 and issue CVP_DUMMY_WR dummy writes to the HIP
>  	 */
> -	altera_cvp_dummy_write(conf);
> +	if (conf->priv->switch_clk)
> +		conf->priv->switch_clk(conf);
> +
> +	if (conf->priv->clear_state) {
> +		ret = conf->priv->clear_state(conf);
> +		if (ret) {
> +			dev_err(&mgr->dev, "Problem clearing out state\n");
> +			return ret;
> +		}
> +	}
>  
>  	/* STEP 4 - set CVP_CONFIG bit */
>  	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
> @@ -272,9 +389,10 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  	val |= VSE_CVP_PROG_CTRL_CONFIG;
>  	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
>  
> -	/* STEP 5 - poll CVP_CONFIG READY for 1 with 10us timeout */
> +	/* STEP 5 - poll CVP_CONFIG READY for 1 with timeout */
>  	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY,
> -				     VSE_CVP_STATUS_CFG_RDY, 10);
> +				     VSE_CVP_STATUS_CFG_RDY,
> +				     conf->priv->poll_time_us);
>  	if (ret) {
>  		dev_warn(&mgr->dev, "CFG_RDY == 1 timeout\n");
>  		return ret;
> @@ -284,7 +402,16 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  	 * STEP 6
>  	 * - set CVP_NUMCLKS to 1 and issue CVP_DUMMY_WR dummy writes to the HIP
>  	 */
> -	altera_cvp_dummy_write(conf);
> +	if (conf->priv->switch_clk)
> +		conf->priv->switch_clk(conf);
> +
> +	if (altera_cvp_chkcfg) {
> +		ret = altera_cvp_chk_error(mgr, 0);
> +		if (ret) {
> +			dev_warn(&mgr->dev, "CFG_RDY == 1 timeout\n");
> +			return ret;
> +		}
> +	}
>  
>  	/* STEP 7 - set START_XFER */
>  	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
> @@ -292,11 +419,12 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
>  
>  	/* STEP 8 - start transfer (set CVP_NUMCLKS for bitstream) */
> -	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
> -	val &= ~VSE_CVP_MODE_CTRL_NUMCLKS_MASK;
> -	val |= conf->numclks << VSE_CVP_MODE_CTRL_NUMCLKS_OFF;
> -	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
> -
> +	if (conf->priv->switch_clk) {
> +		altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
> +		val &= ~VSE_CVP_MODE_CTRL_NUMCLKS_MASK;
> +		val |= conf->numclks << VSE_CVP_MODE_CTRL_NUMCLKS_OFF;
> +		altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
> +	}
>  	return 0;
>  }
>  
> @@ -314,15 +442,26 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>  	done = 0;
>  
>  	while (remaining) {
> -		if (remaining >= sizeof(u32))
> -			len = sizeof(u32);
> +		/* Use credit throttling if available */
> +		if (conf->priv->wait_credit) {
> +			status = conf->priv->wait_credit(mgr, done);
> +			if (status) {
> +				dev_err(&conf->pci_dev->dev,
> +					"Wait Credit ERR: 0x%x\n", status);
> +				return status;
> +			}
> +		}
> +
> +		if (remaining >= conf->priv->block_size)
> +			len = conf->priv->block_size;
>  		else
>  			len = remaining;
len = min(conf->priv->block_size, remaining) seems easier.
>  
>  		altera_cvp_send_block(conf, data, len);
> -		data++;
> +		data += len / sizeof(u32);
>  		done += len;
>  		remaining -= len;
> +		conf->current_credit_byte++;

I'll need to take another look at this loop :) This is confusing
>  
>  		/*
>  		 * STEP 10 (optional) and STEP 11
> @@ -372,7 +511,8 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
>  
>  	/* STEP 18 - poll PLD_CLK_IN_USE and USER_MODE bits */
>  	mask = VSE_CVP_STATUS_PLD_CLK_IN_USE | VSE_CVP_STATUS_USERMODE;
> -	ret = altera_cvp_wait_status(conf, mask, mask, TIMEOUT_US);
> +	ret = altera_cvp_wait_status(conf, mask, mask,
> +				     conf->priv->user_time_us);
>  	if (ret)
>  		dev_err(&mgr->dev, "PLD_CLK_IN_USE|USERMODE timeout\n");
>  
> @@ -386,6 +526,24 @@ static const struct fpga_manager_ops altera_cvp_ops = {
>  	.write_complete	= altera_cvp_write_complete,
>  };
>  
> +static const struct cvp_priv cvp_priv_v1 = {
> +	.switch_clk	= altera_cvp_dummy_write,
> +	.clear_state	= NULL,
> +	.wait_credit	= NULL,
static variables (and structs) would get set to 0 anyways,
so the = NULL parts aren't technically required.

I think if this were a single static variable, you'd get a checkpatch
warning here.
> +	.block_size	= ALTERA_CVP_V1_SIZE,
> +	.poll_time_us	= V1_POLL_TIMEOUT_US,
> +	.user_time_us	= TIMEOUT_US,
> +};
> +
> +static const struct cvp_priv cvp_priv_v2 = {
> +	.switch_clk	= NULL,
> +	.clear_state	= altera_cvp_v2_clear_state,
> +	.wait_credit	= altera_cvp_v2_wait_for_credit,
> +	.block_size	= ALTERA_CVP_V2_SIZE,
> +	.poll_time_us	= V2_POLL_TIMEOUT_US,
> +	.user_time_us	= V2_USER_TIMEOUT_US,
> +};
> +
>  static ssize_t chkcfg_show(struct device_driver *dev, char *buf)
>  {
>  	return snprintf(buf, 3, "%d\n", altera_cvp_chkcfg);
> @@ -488,6 +646,11 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	conf->pci_dev = pdev;
>  	conf->write_data = altera_cvp_write_data_iomem;
>  
> +	if (conf->vsec_offset == 0x200)
Can you give that 0x200 a name?
> +		conf->priv = &cvp_priv_v1;
> +	else
> +		conf->priv = &cvp_priv_v2;
> +
>  	conf->map = pci_iomap(pdev, CVP_BAR, 0);
>  	if (!conf->map) {
>  		dev_warn(&pdev->dev, "Mapping CVP BAR failed\n");
> -- 
> 2.7.4
> 

Thanks,
Moritz
