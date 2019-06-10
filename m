Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331B5C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E140A206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfwAcreq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbfFJI1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:27:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38313 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388041AbfFJI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:27:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so8208148wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A37KVk/TxifJsVNalXVoRHH861G3sRXMWjHmk2uFY2M=;
        b=GfwAcreqPVer5VZpTnACEitJnXlm0m+ZJTICWWGT8anLZ0XG5b2OYbIHY7/wfXcNWv
         lmzjOOm23dCDWC1KALbuTOzbWGCBrbBP66+ldH0WNYApE3GXys1W5oPwYpfMlwKXfcz6
         ucxS2IGC0hGnZyaEGkviU2eyJGicMkqr4JRnMf068/JTszGTaDJjowjC4tEKgEoDaVMr
         3QEALegKlofNNsRgt8NTGeetL6unawnjTvQf6hGUiMfHFvEH4u49OUMSo/MDSdGdbIqe
         Bgua22q3EUnAmEBskpe8GLbq2fAdmn8lVxG9JCmWcHMfiJB6KX/jfyXTSQohi2bXHl2W
         WfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A37KVk/TxifJsVNalXVoRHH861G3sRXMWjHmk2uFY2M=;
        b=B6YQDzZFpDl5q8gIcOocwLV7E4qtkFVLht2L5aburukHI8yY6FOC0n+mm6OMA+tpD1
         HDC0IsB8I51cQOFf9KtAWz/iddHA0WRVYa/P248Go542lx6Tk1EyHKwuexGzmEYB6Euv
         JgaI0r6BDsbB3oAFou4GjaTHtrnhpO/fr5aXdNfBgR49JgZkL3oH6rl0+2ILlFXTCNCt
         GiUfquAn4HO9Qe8CUs25BStr7MK34sHRl1krpgq+3Bmlx+8stHAHkZXpvX6A22yWeFpU
         MDKGXjN9bVJlMMNLvNRgPLg7G7ji0tVB0oRwKhTOlYyGzoAmxwI73OkXMJVa3H1riiQg
         EUkw==
X-Gm-Message-State: APjAAAUNuZJlUk25NB7rr7liqP2W7TfYaCpsICnaj+ImZxll7fmRFD7f
        1cwqX6JQGM9XbCAWnrx3Bx7+xJJrdTBlOw==
X-Google-Smtp-Source: APXvYqyU0P1s2pRG5AtbsgnoLVeAozBW9+nm5u6a2qJdGzEp/UYtuWum3mqTg5H52gD7qEe/59GjRA==
X-Received: by 2002:a5d:4992:: with SMTP id r18mr29891457wrq.107.1560155259056;
        Mon, 10 Jun 2019 01:27:39 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id f204sm12730331wme.18.2019.06.10.01.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 01:27:38 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] soundwire: qcom: add support for SoundWire
 controller
To:     Vinod Koul <vkoul@kernel.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
 <20190610064025.GK9160@vkoul-mobl.Dlink>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2938660d-81e1-d6b2-4179-9f32c6ca1644@linaro.org>
Date:   Mon, 10 Jun 2019 09:27:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190610064025.GK9160@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review!


On 10/06/2019 07:40, Vinod Koul wrote:
> On 07-06-19, 09:56, Srinivas Kandagatla wrote:
>> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
>> either integrated as part of WCD audio codecs via slimbus or
>> as part of SOC I/O.
>>
>> This patchset adds support to a very basic controller which has been
>> tested with WCD934x SoundWire controller connected to WSA881x smart
>> speaker amplifiers.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/Kconfig  |   9 +
>>   drivers/soundwire/Makefile |   4 +
>>   drivers/soundwire/qcom.c   | 983 +++++++++++++++++++++++++++++++++++++
> 
> Can you split this to two patches (at least), master driver followed by
> DAI driver

Sure.

> 
>> +
>> +#define SWRM_COMP_HW_VERSION					0x00
> 
> What does COMP stand for?

Controller splits registers into "Component(core configuration 
registers)", "Interrupt" "Command Fifo" and so on...

> 
>> +#define SWRM_COMP_CFG_ADDR					0x04
>> +#define SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK			BIT(1)
>> +#define SWRM_COMP_CFG_ENABLE_MSK				BIT(0)
>> +#define SWRM_COMP_PARAMS					0x100
>> +#define SWRM_COMP_PARAMS_DOUT_PORTS_MASK			GENMASK(4, 0)
>> +#define SWRM_COMP_PARAMS_DIN_PORTS_MASK				GENMASK(9, 5)
>> +#define SWRM_COMP_PARAMS_WR_FIFO_DEPTH				GENMASK(14, 10)
>> +#define SWRM_COMP_PARAMS_RD_FIFO_DEPTH				GENMASK(19, 15)
>> +#define SWRM_COMP_PARAMS_AUTO_ENUM_SLAVES			GENMASK(32. 20)
> 
> Thats a lot of text, So as others have said we need to rethink the
> naming conventions, perhaps QC_SDW_PARAM_AUTO_ENUM (feel free to drop
> SDW as well from here as it QC specific!
> 
> Also move common ones to core..
> 
>> +#define SWRM_INTERRUPT_STATUS					0x200
>> +#define SWRM_INTERRUPT_STATUS_RMSK				GENMASK(16, 0)
>> +#define SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ			BIT(0)
>> +#define SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED		BIT(1)
>> +#define SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS		BIT(2)
>> +#define SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET			BIT(3)
>> +#define SWRM_INTERRUPT_STATUS_RD_FIFO_OVERFLOW			BIT(4)
>> +#define SWRM_INTERRUPT_STATUS_RD_FIFO_UNDERFLOW			BIT(5)
>> +#define SWRM_INTERRUPT_STATUS_WR_CMD_FIFO_OVERFLOW		BIT(6)
>> +#define SWRM_INTERRUPT_STATUS_CMD_ERROR				BIT(7)
>> +#define SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION		BIT(8)
>> +#define SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH		BIT(9)
>> +#define SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED		BIT(10)
>> +#define SWRM_INTERRUPT_STATUS_NEW_SLAVE_AUTO_ENUM_FINISHED	BIT(11)
>> +#define SWRM_INTERRUPT_STATUS_AUTO_ENUM_FAILED			BIT(12)
>> +#define SWRM_INTERRUPT_STATUS_AUTO_ENUM_TABLE_IS_FULL		BIT(13)
>> +#define SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED		BIT(14)
>> +#define SWRM_INTERRUPT_STATUS_CLK_STOP_FINISHED			BIT(15)
>> +#define SWRM_INTERRUPT_STATUS_ERROR_PORT_TEST			BIT(16)
>> +#define SWRM_INTERRUPT_MASK_ADDR				0x204
>> +#define SWRM_INTERRUPT_CLEAR					0x208
>> +#define SWRM_CMD_FIFO_WR_CMD					0x300
>> +#define SWRM_CMD_FIFO_RD_CMD					0x304
>> +#define SWRM_CMD_FIFO_CMD					0x308
>> +#define SWRM_CMD_FIFO_STATUS					0x30C
>> +#define SWRM_CMD_FIFO_CFG_ADDR					0x314
>> +#define SWRM_CMD_FIFO_CFG_NUM_OF_CMD_RETRY_SHFT			0x0
>> +#define SWRM_CMD_FIFO_RD_FIFO_ADDR				0x318
>> +#define SWRM_ENUMERATOR_CFG_ADDR				0x500
>> +#define SWRM_MCP_FRAME_CTRL_BANK_ADDR(m)		(0x101C + 0x40 * (m))
>> +#define SWRM_MCP_FRAME_CTRL_BANK_SSP_PERIOD_SHFT		16
>> +#define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT			3
>> +#define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK			GENMASK(2, 0)
>> +#define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT			0
>> +#define SWRM_MCP_CFG_ADDR					0x1048
>> +#define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK		GENMASK(21, 17)
>> +#define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_SHFT		0x11
>> +#define SWRM_MCP_STATUS						0x104C
>> +#define SWRM_MCP_STATUS_BANK_NUM_MASK				BIT(0)
>> +#define SWRM_MCP_SLV_STATUS					0x1090
>> +#define SWRM_MCP_SLV_STATUS_MASK				GENMASK(1, 0)
>> +#define SWRM_DP_PORT_CTRL_BANK(n, m)	(0x1124 + 0x100 * (n - 1) + 0x40 * m)
>> +#define SWRM_DP_PORT_CTRL2_BANK(n, m)	(0x1126 + 0x100 * (n - 1) + 0x40 * m)
>> +#define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT				0x18
>> +#define SWRM_DP_PORT_CTRL_OFFSET2_SHFT				0x10
>> +#define SWRM_DP_PORT_CTRL_OFFSET1_SHFT				0x08
>> +#define SWRM_AHB_BRIDGE_WR_DATA_0				0xc885
>> +#define SWRM_AHB_BRIDGE_WR_ADDR_0				0xc889
>> +#define SWRM_AHB_BRIDGE_RD_ADDR_0				0xc88d
>> +#define SWRM_AHB_BRIDGE_RD_DATA_0				0xc891
>> +
>> +#define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
>> +			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
>> +
>> +#define SWRM_MAX_ROW_VAL	0 /* Rows = 48 */
>> +#define SWRM_DEFAULT_ROWS	48
>> +#define SWRM_MIN_COL_VAL	0 /* Cols = 2 */
>> +#define SWRM_DEFAULT_COL	16
>> +#define SWRM_SPECIAL_CMD_ID	0xF
>> +#define MAX_FREQ_NUM		1
>> +#define TIMEOUT_MS		1000
>> +#define QCOM_SWRM_MAX_RD_LEN	0xf
>> +#define DEFAULT_CLK_FREQ	9600000
>> +#define SWRM_MAX_DAIS		0xF
> 
> I was thinking it would make sense to move this to DT, DAI is after all
> a hw property!

I will give that a try before sending out next version.
> 
>> +static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
>> +				     u8 dev_addr, u16 reg_addr)
>> +{
>> +	int ret = 0;
>> +	u8 cmd_id;
>> +	u32 val;
>> +
>> +	mutex_lock(&ctrl->lock);
>> +	if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>> +		cmd_id = SWRM_SPECIAL_CMD_ID;
>> +	} else {
>> +		if (++ctrl->wr_cmd_id == SWRM_SPECIAL_CMD_ID)
>> +			ctrl->wr_cmd_id = 0;
>> +
>> +		cmd_id = ctrl->wr_cmd_id;
>> +	}
>> +
>> +	val = SWRM_REG_VAL_PACK(cmd_data, dev_addr, cmd_id, reg_addr);
>> +	ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
>> +	if (ret < 0) {
>> +		dev_err(ctrl->dev, "%s: reg 0x%x write failed, err:%d\n",
>> +			__func__, val, ret);
>> +		goto err;
>> +	}
>> +
>> +	if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>> +		ctrl->fifo_status = 0;
>> +		ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>> +						  msecs_to_jiffies(TIMEOUT_MS));
> 
> why not wait for completion on non broadcast?
> 

This could lead to dead-lock if we endup reading registers from 
interrupt handler.

>> +static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *ctrl,
>> +				     u8 dev_addr, u16 reg_addr,
>> +				     u32 len, u8 *rval)
>> +{
>> +	int i, ret = 0;
> 
> Superfluous initialization of ret
> 
I agree.
>> +static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct qcom_swrm_ctrl *ctrl = dev_id;
>> +	u32 sts, value;
>> +
>> +	sts = ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS);
>> +
>> +	if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED)
>> +		complete(&ctrl->sp_cmd_comp);
>> +
>> +	if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
>> +		value = ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS);
>> +		dev_err_ratelimited(ctrl->dev,
>> +				    "CMD error, fifo status 0x%x\n",
>> +				     value);
>> +		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>> +		if ((value & 0xF) == 0xF) {
>> +			ctrl->fifo_status = -ENODATA;
>> +			complete(&ctrl->sp_cmd_comp);
>> +		}
>> +	}
>> +
>> +	if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
>> +	    sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS) {
>> +		if (sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED)
>> +			ctrl->status[0] = SDW_SLAVE_ATTACHED;
>> +
>> +		schedule_work(&ctrl->slave_work);
> 
> So why are we scheduling work, you are the thread handler so I think it
> should be okay and better to invoke bus for status update.

I had seen lockup issues as this would trigger broadcast messages which 
would wait on completion interrupt!

> 
>> +	}
>> +
>> +	if (sts & SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ)
>> +		dev_dbg(ctrl->dev, "Slave pend irq\n");
>> +
>> +	if (sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED)
>> +		dev_dbg(ctrl->dev, "New slave attached\n");
> 
> No updating bus on the status?
> 
Its done down below this function! These are debug messages only!
looks redundant, will remove it.

>> +static enum sdw_command_response qcom_swrm_xfer_msg(struct sdw_bus *bus,
>> +						    struct sdw_msg *msg)
>> +{
>> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>> +	int ret, i, len;
>> +
>> +	if (msg->flags == SDW_MSG_FLAG_READ) {
>> +		for (i = 0; i < msg->len;) {
>> +			if ((msg->len - i) < QCOM_SWRM_MAX_RD_LEN)
>> +				len = msg->len - i;
>> +			else
>> +				len = QCOM_SWRM_MAX_RD_LEN;
>> +
>> +			ret = qcom_swrm_cmd_fifo_rd_cmd(ctrl, msg->dev_num,
>> +							msg->addr + i, len,
>> +						       &msg->buf[i]);
>> +			if (ret < 0) {
>> +				if (ret == -ENODATA)
>> +					return SDW_CMD_IGNORED;
>> +
>> +				return ret;
>> +			}
>> +
>> +			i = i + len;
>> +		}
>> +	} else if (msg->flags == SDW_MSG_FLAG_WRITE) {
>> +		for (i = 0; i < msg->len; i++) {
>> +			ret = qcom_swrm_cmd_fifo_wr_cmd(ctrl, msg->buf[i],
>> +							msg->dev_num,
>> +						       msg->addr + i);
>> +			if (ret < 0) {
>> +				if (ret == -ENODATA)
>> +					return SDW_CMD_IGNORED;
>> +
>> +				return ret;
> 
> So we need to convert this to sdw_command_response before returning.
> 
Sure!

>> +static int qcom_swrm_prepare(struct snd_pcm_substream *substream,
>> +			     struct snd_soc_dai *dai)
>> +{
>> +	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>> +
>> +	if (!ctrl->sruntime[dai->id])
>> +		return -EINVAL;
>> +
>> +	return sdw_enable_stream(ctrl->sruntime[dai->id]);
> 
> Hmm you need to handle dai prepare being called for multiple times.
> Thanks for pointing this out, Will fix this.

>> +static int qcom_pdm_set_sdw_stream(struct snd_soc_dai *dai,
>> +				   void *stream, int direction)
>> +{
>> +	return 0;
>> +}
> 
> lets remove if we dont intend to do anything!
> 
Hm, not sure how I missed this one!

>> +static int qcom_swrm_runtime_suspend(struct device *device)
>> +{
>> +	/* TBD */
>> +	return 0;
>> +}
>> +
>> +static int qcom_swrm_runtime_resume(struct device *device)
>> +{
>> +	/* TBD */
>> +	return 0;
>> +}
> 
> Again, lets remove these, add when we have the functionality
We have issues without this, as soundwire bus would return error on 
runtime pm get/set. For RFC, I had to make this dummy, I will be able to 
add and test some code in next 1/2 spins.

Thanks,
srini
> 
