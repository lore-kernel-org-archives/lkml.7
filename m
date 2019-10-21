Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C3ECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 04:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6E72067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 04:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571633063;
	bh=LVlUwIor1Q0zqTd3c1Z8i6+KPgjp8+NUXpE9o1AUPGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c6qhrTCeW7WST/Y+gGT9ubk9xU63Q4ZcNm2JFEkD+gqKKLA7kyWgsmFYYCa4DEZ9O
	 hYP5lQtKObpqQaQf7gg5LE5AI62cOV70a3Xvw/hXglRZ+IJoXA8ueoYLf9Kv+1poY0
	 RUnyqj2kPJnzkc5UwakfLn5x7k4myrKH8ou/6rIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfJUEoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 00:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfJUEoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 00:44:10 -0400
Received: from localhost (unknown [122.167.89.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 102972067B;
        Mon, 21 Oct 2019 04:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571633049;
        bh=LVlUwIor1Q0zqTd3c1Z8i6+KPgjp8+NUXpE9o1AUPGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6WyMO4de+yhu9NJ87JGfUDk+teLPhNjtBP7DfyEfMwcriRxAM0DBKoshvRyAxjT8
         Rw2crnxAE4eO4ywbrixkkk++fwl0VQ4ay2UipY6mi6JtLiBPAeQ35wGoGk2Gfi2J3p
         I0GCNmT+kV4uyMNPvoDXLVL7Vqf5oyYwTpo0ocII=
Date:   Mon, 21 Oct 2019 10:14:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
Subject: Re: [PATCH v3 2/2] soundwire: qcom: add support for SoundWire
 controller
Message-ID: <20191021044405.GB2654@vkoul-mobl>
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011154423.2506-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-10-19, 16:44, Srinivas Kandagatla wrote:

> +static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
> +{
> +	struct qcom_swrm_ctrl *ctrl = dev_id;
> +	u32 sts, value;
> +	unsigned long flags;
> +
> +	ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &sts);
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

we are in irq thread, so why not do the work here rather than schedule
it?

> +static int qcom_swrm_compute_params(struct sdw_bus *bus)
> +{
> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
> +	struct sdw_master_runtime *m_rt;
> +	struct sdw_slave_runtime *s_rt;
> +	struct sdw_port_runtime *p_rt;
> +	struct qcom_swrm_port_config *pcfg;
> +	int i = 0;
> +
> +	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
> +		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
> +			pcfg = &ctrl->pconfig[p_rt->num - 1];
> +			p_rt->transport_params.port_num = p_rt->num;
> +			p_rt->transport_params.sample_interval = pcfg->si + 1;
> +			p_rt->transport_params.offset1 = pcfg->off1;
> +			p_rt->transport_params.offset2 = pcfg->off2;
> +		}
> +
> +		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
> +			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
> +				pcfg = &ctrl->pconfig[i];
> +				p_rt->transport_params.port_num = p_rt->num;
> +				p_rt->transport_params.sample_interval =
> +					pcfg->si + 1;
> +				p_rt->transport_params.offset1 = pcfg->off1;
> +				p_rt->transport_params.offset2 = pcfg->off2;
> +				i++;
> +			}

Can you explain this one, am not sure I understood this. This fn is
supposed to compute and fill up the params, all I can see is filling up!

> +static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
> +	.hw_params = qcom_swrm_hw_params,
> +	.prepare = qcom_swrm_prepare,
> +	.hw_free = qcom_swrm_hw_free,
> +	.startup = qcom_swrm_startup,
> +	.shutdown = qcom_swrm_shutdown,
> +        .set_sdw_stream = qcom_swrm_set_sdw_stream,

why does indent look off to me!
-- 
~Vinod
