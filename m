Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5871C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10D22146E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfLSQ6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:58:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:14807 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSQ6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:58:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 08:58:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,332,1571727600"; 
   d="scan'208";a="228308842"
Received: from dpshah-mobl1.amr.corp.intel.com (HELO [10.254.191.243]) ([10.254.191.243])
  by orsmga002.jf.intel.com with ESMTP; 19 Dec 2019 08:58:40 -0800
Subject: Re: [alsa-devel] [PATCH v5 2/2] soundwire: qcom: add support for
 SoundWire controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     robh@kernel.org, bgoswami@codeaurora.org, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
References: <20191219092842.10885-1-srinivas.kandagatla@linaro.org>
 <20191219092842.10885-3-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c791e241-cd71-4c05-dac5-04e3ecaaf995@linux.intel.com>
Date:   Thu, 19 Dec 2019 10:07:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219092842.10885-3-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/19 3:28 AM, Srinivas Kandagatla wrote:
> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
> either integrated as part of WCD audio codecs via slimbus or
> as part of SOC I/O.
> 
> This patchset adds support to a very basic controller which has been
> tested with WCD934x SoundWire controller connected to WSA881x smart
> speaker amplifiers.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This looks quite good, I only have a couple of nit-picks/questions below.
> +static int qcom_swrm_abh_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
> +				  u32 *val)
> +{
> +	struct regmap *wcd_regmap = ctrl->regmap;
> +	int ret;
> +
> +	/* pg register + offset */
> +	ret = regmap_bulk_write(wcd_regmap, SWRM_AHB_BRIDGE_RD_ADDR_0,
> +			  (u8 *)&reg, 4);
> +	if (ret < 0)
> +		return SDW_CMD_FAIL;
> +
> +	ret = regmap_bulk_read(wcd_regmap, SWRM_AHB_BRIDGE_RD_DATA_0,
> +			       val, 4);
> +	if (ret < 0)
> +		return SDW_CMD_FAIL;
> +
> +	return SDW_CMD_OK;
> +}

I think I asked the question before but don't remember the answer so you 
may want to add a comment explaining why SDW_CMD_IGNORED is not a 
possible return value?

The BER is supposed to be very very low but there is a non-zero 
possibility of a device losing sync.

> +
> +static int qcom_swrm_ahb_reg_write(struct qcom_swrm_ctrl *ctrl,
> +				   int reg, int val)
> +{
> +	struct regmap *wcd_regmap = ctrl->regmap;
> +	int ret;
> +	/* pg register + offset */
> +	ret = regmap_bulk_write(wcd_regmap, SWRM_AHB_BRIDGE_WR_DATA_0,
> +			  (u8 *)&val, 4);
> +	if (ret)
> +		return SDW_CMD_FAIL;
> +
> +	/* write address register */
> +	ret = regmap_bulk_write(wcd_regmap, SWRM_AHB_BRIDGE_WR_ADDR_0,
> +			  (u8 *)&reg, 4);
> +	if (ret)
> +		return SDW_CMD_FAIL;
> +
> +	return SDW_CMD_OK;
> +}

same here, how is a CMD_IGNORED case handled?

> +
> +static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 cmd_data,
> +				     u8 dev_addr, u16 reg_addr)
> +{
> +	DECLARE_COMPLETION_ONSTACK(comp);
> +	unsigned long flags;
> +	u32 val;
> +	int ret;
> +
> +	spin_lock_irqsave(&ctrl->comp_lock, flags);
> +	ctrl->comp = &comp;
> +	spin_unlock_irqrestore(&ctrl->comp_lock, flags);
> +	val = SWRM_REG_VAL_PACK(cmd_data, dev_addr,
> +				SWRM_SPECIAL_CMD_ID, reg_addr);
> +	ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
> +	if (ret)
> +		goto err;

the code is a bit inconsistent at the moment on how errors are handled.
In some cases you explicitly test for errors, but ...


> +
> +	for (i = 0; i < len; i++) {
> +		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_RD_FIFO_ADDR, &val);

... here you don't ...

> +		rval[i] = val & 0xFF;
> +	}
> +
> +err:
> +	spin_lock_irqsave(&ctrl->comp_lock, flags);
> +	ctrl->comp = NULL;
> +	spin_unlock_irqrestore(&ctrl->comp_lock, flags);
> +
> +	return ret;
> +}
> +
> +static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
> +{
> +	u32 val;
> +	int i;
> +
> +	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);

... and not here ...

> +
> +	for (i = 0; i < SDW_MAX_DEVICES; i++) {
> +		u32 s;
> +
> +		s = (val >> (i * 2));
> +		s &= SWRM_MCP_SLV_STATUS_MASK;
> +		ctrl->status[i] = s;
> +	}
> +}
> +
> +static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
> +{
> +	struct qcom_swrm_ctrl *ctrl = dev_id;
> +	u32 sts, value;
> +	unsigned long flags;
> +
> +	ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &sts);

... and here same the reg_read/writes are no longer tested for?

> +
> +	if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
> +		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
> +		dev_err_ratelimited(ctrl->dev,
> +				    "CMD error, fifo status 0x%x\n",
> +				     value);
> +		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
> +	}
> +
> +	if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
> +	    sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS)
> +		schedule_work(&ctrl->slave_work);
> +
> +	ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, sts);

is it intentional to clear the interrupts first, before doing additional 
checks?

Or could it be done immediately after reading the status. It's not clear 
to me if the position of this clear matters, and if yes you should 
probably add a comment?

> +
> +	if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED) {
> +		spin_lock_irqsave(&ctrl->comp_lock, flags);
> +		if (ctrl->comp)
> +			complete(ctrl->comp);
> +		spin_unlock_irqrestore(&ctrl->comp_lock, flags);
> +	}
> +
> +	return IRQ_HANDLED;
The rest looks fine. nice work.
