Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C4CC468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3F220868
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560149016;
	bh=Z8KCt+DTG6pfim6x97afmkIuq90gWxj0zyNXE882p4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=viBIJ9Eqv3pydApEF1QriOeAAxYj4bQux6vgZnmR8J669YU81p/WW6yuEo+aFEYOa
	 G7C+QCg7AIwCvMRQ3Uh+x4hWaYOZygu6VjcyORj4/53Vge6lvx1WD50nIm6OmQe+99
	 uoH/V7wz3V48P3SnEUCsCJWfiGyfXZVDUPJBcA88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbfFJGng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 02:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387718AbfFJGng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:43:36 -0400
Received: from localhost (unknown [122.182.223.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C7A207E0;
        Mon, 10 Jun 2019 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560149014;
        bh=Z8KCt+DTG6pfim6x97afmkIuq90gWxj0zyNXE882p4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZ7ImkOvJagAfiZeJsthi8mfkVUUtGuSa/GJ5a7cRq86d0pmDIgeeJC8mhTBPeg7w
         rMq90yyO/OyjObqA3rYRjs5ta7SYLxtH5DzYizvGrBxvKNux1vN4bSAmjjr+2WU7rb
         TdJj0/uSjfozuqtWIqB2zxs7RvjYOqN8b4+nbYck=
Date:   Mon, 10 Jun 2019 12:10:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] soundwire: qcom: add support for SoundWire
 controller
Message-ID: <20190610064025.GK9160@vkoul-mobl.Dlink>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607085643.932-7-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-19, 09:56, Srinivas Kandagatla wrote:
> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
> either integrated as part of WCD audio codecs via slimbus or
> as part of SOC I/O.
> 
> This patchset adds support to a very basic controller which has been
> tested with WCD934x SoundWire controller connected to WSA881x smart
> speaker amplifiers.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/Kconfig  |   9 +
>  drivers/soundwire/Makefile |   4 +
>  drivers/soundwire/qcom.c   | 983 +++++++++++++++++++++++++++++++++++++

Can you split this to two patches (at least), master driver followed by
DAI driver

> +
> +#define SWRM_COMP_HW_VERSION					0x00

What does COMP stand for?

> +#define SWRM_COMP_CFG_ADDR					0x04
> +#define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
> +#define SWRM_COMP_CFG_ENABLE_MSK				BIT(0)
> +#define SWRM_COMP_PARAMS					0x100
> +#define SWRM_COMP_PARAMS_DOUT_PORTS_MASK			GENMASK(4, 0)
> +#define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
> +#define SWRM_COMP_PARAMS_WR_FIFO_DEPTH				GENMASK(14, 10)
> +#define SWRM_COMP_PARAMS_RD_FIFO_DEPTH				GENMASK(19, 15)
> +#define SWRM_COMP_PARAMS_AUTO_ENUM_SLAVES			GENMASK(32. 20)

Thats a lot of text, So as others have said we need to rethink the
naming conventions, perhaps QC_SDW_PARAM_AUTO_ENUM (feel free to drop
SDW as well from here as it QC specific!

Also move common ones to core..

> +#define SWRM_INTERRUPT_STATUS					0x200
> +#define SWRM_INTERRUPT_STATUS_RMSK				GENMASK(16, 0)
> +#define SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ			BIT(0)
> +#define SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED		BIT(1)
> +#define SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS		BIT(2)
> +#define SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET			BIT(3)
> +#define SWRM_INTERRUPT_STATUS_RD_FIFO_OVERFLOW			BIT(4)
> +#define SWRM_INTERRUPT_STATUS_RD_FIFO_UNDERFLOW			BIT(5)
> +#define SWRM_INTERRUPT_STATUS_WR_CMD_FIFO_OVERFLOW		BIT(6)
> +#define SWRM_INTERRUPT_STATUS_CMD_ERROR				BIT(7)
> +#define SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION		BIT(8)
> +#define SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH		BIT(9)
> +#define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
> +#define SWRM_INTERRUPT_STATUS_NEW_SLAVE_AUTO_ENUM_FINISHED	BIT(11)
> +#define SWRM_INTERRUPT_STATUS_AUTO_ENUM_FAILED			BIT(12)
> +#define SWRM_INTERRUPT_STATUS_AUTO_ENUM_TABLE_IS_FULL		BIT(13)
> +#define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED		BIT(14)
> +#define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED			BIT(15)
> +#define SWRM_INTERRUPT_STATUS_ERROR_PORT_TEST			BIT(16)
> +#define SWRM_INTERRUPT_MASK_ADDR				0x204
> +#define SWRM_INTERRUPT_CLEAR					0x208
> +#define SWRM_CMD_FIFO_WR_CMD					0x300
> +#define SWRM_CMD_FIFO_RD_CMD					0x304
> +#define SWRM_CMD_FIFO_CMD					0x308
> +#define SWRM_CMD_FIFO_STATUS					0x30C
> +#define SWRM_CMD_FIFO_CFG_ADDR					0x314
> +#define SWRM_CMD_FIFO_CFG_NUM_OF_CMD_RETRY_SHFT			0x0
> +#define SWRM_CMD_FIFO_RD_FIFO_ADDR				0x318
> +#define SWRM_ENUMERATOR_CFG_ADDR				0x500
> +#define SWRM_MCP_FRAME_CTRL_BANK_ADDR(m)		(0x101C + 0x40 * (m))
> +#define SWRM_MCP_FRAME_CTRL_BANK_SSP_PERIOD_SHFT		16
> +#define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT			3
> +#define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK			GENMASK(2, 0)
> +#define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT			0
> +#define SWRM_MCP_CFG_ADDR					0x1048
> +#define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK		GENMASK(21, 17)
> +#define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_SHFT		0x11
> +#define SWRM_MCP_STATUS						0x104C
> +#define SWRM_MCP_STATUS_BANK_NUM_MASK				BIT(0)
> +#define SWRM_MCP_SLV_STATUS					0x1090
> +#define SWRM_MCP_SLV_STATUS_MASK				GENMASK(1, 0)
> +#define SWRM_DP_PORT_CTRL_BANK(n, m)	(0x1124 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DP_PORT_CTRL2_BANK(n, m)	(0x1126 + 0x100 * (n - 1) + 0x40 * m)
> +#define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
> +#define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
> +#define SWRM_DP_PORT_CTRL_OFFSET1_SHFT				0x08
> +#define SWRM_AHB_BRIDGE_WR_DATA_0				0xc885
> +#define SWRM_AHB_BRIDGE_WR_ADDR_0				0xc889
> +#define SWRM_AHB_BRIDGE_RD_ADDR_0				0xc88d
> +#define SWRM_AHB_BRIDGE_RD_DATA_0				0xc891
> +
> +#define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
> +			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
> +
> +#define SWRM_MAX_ROW_VAL	0 /* Rows = 48 */
> +#define SWRM_DEFAULT_ROWS	48
> +#define SWRM_MIN_COL_VAL	0 /* Cols = 2 */
> +#define SWRM_DEFAULT_COL	16
> +#define SWRM_SPECIAL_CMD_ID	0xF
> +#define MAX_FREQ_NUM		1
> +#define TIMEOUT_MS		1000
> +#define QCOM_SWRM_MAX_RD_LEN	0xf
> +#define DEFAULT_CLK_FREQ	9600000
> +#define SWRM_MAX_DAIS		0xF

I was thinking it would make sense to move this to DT, DAI is after all
a hw property!

> +static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
> +				     u8 dev_addr, u16 reg_addr)
> +{
> +	int ret = 0;
> +	u8 cmd_id;
> +	u32 val;
> +
> +	mutex_lock(&ctrl->lock);
> +	if (dev_addr == SDW_BROADCAST_DEV_NUM) {
> +		cmd_id = SWRM_SPECIAL_CMD_ID;
> +	} else {
> +		if (++ctrl->wr_cmd_id == SWRM_SPECIAL_CMD_ID)
> +			ctrl->wr_cmd_id = 0;
> +
> +		cmd_id = ctrl->wr_cmd_id;
> +	}
> +
> +	val = SWRM_REG_VAL_PACK(cmd_data, dev_addr, cmd_id, reg_addr);
> +	ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
> +	if (ret < 0) {
> +		dev_err(ctrl->dev, "%s: reg 0x%x write failed, err:%d\n",
> +			__func__, val, ret);
> +		goto err;
> +	}
> +
> +	if (dev_addr == SDW_BROADCAST_DEV_NUM) {
> +		ctrl->fifo_status = 0;
> +		ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
> +						  msecs_to_jiffies(TIMEOUT_MS));

why not wait for completion on non broadcast?

> +static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *ctrl,
> +				     u8 dev_addr, u16 reg_addr,
> +				     u32 len, u8 *rval)
> +{
> +	int i, ret = 0;

Superfluous initialization of ret

> +static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
> +{
> +	struct qcom_swrm_ctrl *ctrl = dev_id;
> +	u32 sts, value;
> +
> +	sts = ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS);
> +
> +	if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED)
> +		complete(&ctrl->sp_cmd_comp);
> +
> +	if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
> +		value = ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS);
> +		dev_err_ratelimited(ctrl->dev,
> +				    "CMD error, fifo status 0x%x\n",
> +				     value);
> +		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
> +		if ((value & 0xF) == 0xF) {
> +			ctrl->fifo_status = -ENODATA;
> +			complete(&ctrl->sp_cmd_comp);
> +		}
> +	}
> +
> +	if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
> +	    sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS) {
> +		if (sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED)
> +			ctrl->status[0] = SDW_SLAVE_ATTACHED;
> +
> +		schedule_work(&ctrl->slave_work);

So why are we scheduling work, you are the thread handler so I think it
should be okay and better to invoke bus for status update.

> +	}
> +
> +	if (sts & SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ)
> +		dev_dbg(ctrl->dev, "Slave pend irq\n");
> +
> +	if (sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED)
> +		dev_dbg(ctrl->dev, "New slave attached\n");

No updating bus on the status?

> +static enum sdw_command_response qcom_swrm_xfer_msg(struct sdw_bus *bus,
> +						    struct sdw_msg *msg)
> +{
> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
> +	int ret, i, len;
> +
> +	if (msg->flags == SDW_MSG_FLAG_READ) {
> +		for (i = 0; i < msg->len;) {
> +			if ((msg->len - i) < QCOM_SWRM_MAX_RD_LEN)
> +				len = msg->len - i;
> +			else
> +				len = QCOM_SWRM_MAX_RD_LEN;
> +
> +			ret = qcom_swrm_cmd_fifo_rd_cmd(ctrl, msg->dev_num,
> +							msg->addr + i, len,
> +						       &msg->buf[i]);
> +			if (ret < 0) {
> +				if (ret == -ENODATA)
> +					return SDW_CMD_IGNORED;
> +
> +				return ret;
> +			}
> +
> +			i = i + len;
> +		}
> +	} else if (msg->flags == SDW_MSG_FLAG_WRITE) {
> +		for (i = 0; i < msg->len; i++) {
> +			ret = qcom_swrm_cmd_fifo_wr_cmd(ctrl, msg->buf[i],
> +							msg->dev_num,
> +						       msg->addr + i);
> +			if (ret < 0) {
> +				if (ret == -ENODATA)
> +					return SDW_CMD_IGNORED;
> +
> +				return ret;

So we need to convert this to sdw_command_response before returning.

> +static int qcom_swrm_prepare(struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
> +
> +	if (!ctrl->sruntime[dai->id])
> +		return -EINVAL;
> +
> +	return sdw_enable_stream(ctrl->sruntime[dai->id]);

Hmm you need to handle dai prepare being called for multiple times.

> +static int qcom_pdm_set_sdw_stream(struct snd_soc_dai *dai,
> +				   void *stream, int direction)
> +{
> +	return 0;
> +}

lets remove if we dont intend to do anything!

> +static int qcom_swrm_runtime_suspend(struct device *device)
> +{
> +	/* TBD */
> +	return 0;
> +}
> +
> +static int qcom_swrm_runtime_resume(struct device *device)
> +{
> +	/* TBD */
> +	return 0;
> +}

Again, lets remove these, add when we have the functionality
-- 
~Vinod
