Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3887BCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0112087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 14:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3gbXEvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfJ3O4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 10:56:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35940 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfJ3O4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:56:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id w18so2672410wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3KGaDNuZOqaW+oq9eCygfM069fZ/a2Mqyl7Of0Yf3Bk=;
        b=W3gbXEvu5iu+v3Sxxu1RVFPekMr8X8F8JzwignYx4p0KZkG+YP9eZd1wnj1TxbgO6W
         89sUUPKqCOeUlBJyiMxzKo1T2VxdYaaB/9mvCtJUBKg6nfKXG866CRoT9kPFz/dKq63G
         vIGbZi4dC7QPg6QlVN1ZNSTW2qVYK+tmJHP1QfUFHfcloXf7RwIFFfrBODzE3rVy3Yk4
         LZYG0txO706XP16RwRLHhfX+a+CoZ30rTJndNx+YgErlj3hiQVOnjPw6kQvJzH1mCauE
         +NKqegFjdYqIo+X1UldYjNNnwl+mpUFiKwyoeP2qqOBU2EksImdTj08e+BmgjXA63eeX
         Fwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KGaDNuZOqaW+oq9eCygfM069fZ/a2Mqyl7Of0Yf3Bk=;
        b=GgnBvbmEg1/1vfA8bGhiWaec7UtNMhEXic7rP2XxpvFdDjKoXtVml0lxewlVMwMCH2
         mp0GUaOaBK1VystG5SJvwhOzkWGG1nrwOZYIc5Oi8RU/meW2PuZP548rbcq5NiHYiHiH
         2yfpqQAA4odkLv1GGdzNQpXyhAY0WoQBvKRbijlK8H7ARpcfUVdJBnPEhlw/Ypkd3QIQ
         WpI/KOYjU+bodQVWzCEEtDcqgVyWuRQhPG2AmDuZjl0gRTGk9EL5nx3tGIu/crMSjMk6
         EPrcqDsG4omn5NFfrgAXkksGbbzfqVZaefRz/2+eTnhFcUiuSLt/5ZbbTxukAE972Lg7
         4RHQ==
X-Gm-Message-State: APjAAAWVqf5HvBrltdj2P8WxznKtveLwCEq2Ujq680m8PxyMi1vMj9xq
        FKHEx7bGxM0FqY538Qh3sXAFDQ==
X-Google-Smtp-Source: APXvYqzNEp7v8VF6xzERjzhXpFhkFob5hrJIC4MZV7Tiihtvl6ZSZv8Ub0Haz1Ef1kEUnQ9Tnn0N1w==
X-Received: by 2002:adf:828c:: with SMTP id 12mr274663wrc.40.1572447369376;
        Wed, 30 Oct 2019 07:56:09 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n11sm272188wmd.26.2019.10.30.07.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 07:56:08 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] soundwire: qcom: add support for SoundWire
 controller
To:     Vinod Koul <vkoul@kernel.org>
Cc:     robh@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-3-srinivas.kandagatla@linaro.org>
 <20191021044405.GB2654@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <17cb6d3f-2317-9667-8642-566a8a88bd4c@linaro.org>
Date:   Wed, 30 Oct 2019 14:56:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021044405.GB2654@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/10/2019 05:44, Vinod Koul wrote:
> On 11-10-19, 16:44, Srinivas Kandagatla wrote:
> 
>> +static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct qcom_swrm_ctrl *ctrl = dev_id;
>> +	u32 sts, value;
>> +	unsigned long flags;
>> +
>> +	ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &sts);
>> +
>> +	if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
>> +		ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
>> +		dev_err_ratelimited(ctrl->dev,
>> +				    "CMD error, fifo status 0x%x\n",
>> +				     value);
>> +		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>> +	}
>> +
>> +	if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
>> +	    sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS)
>> +		schedule_work(&ctrl->slave_work);
> 
> we are in irq thread, so why not do the work here rather than schedule
> it?

The reason is that, sdw_handle_slave_status() we will read device id 
registers, which are fifo based in this controller and triggers an 
interrupt for each read.
So all the such reads will timeout waiting for interrupt if we do not do 
it in a separate thread.



> 
>> +static int qcom_swrm_compute_params(struct sdw_bus *bus)
>> +{
>> +	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>> +	struct sdw_master_runtime *m_rt;
>> +	struct sdw_slave_runtime *s_rt;
>> +	struct sdw_port_runtime *p_rt;
>> +	struct qcom_swrm_port_config *pcfg;
>> +	int i = 0;
>> +
>> +	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
>> +		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
>> +			pcfg = &ctrl->pconfig[p_rt->num - 1];
>> +			p_rt->transport_params.port_num = p_rt->num;
>> +			p_rt->transport_params.sample_interval = pcfg->si + 1;
>> +			p_rt->transport_params.offset1 = pcfg->off1;
>> +			p_rt->transport_params.offset2 = pcfg->off2;
>> +		}
>> +
>> +		list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
>> +			list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>> +				pcfg = &ctrl->pconfig[i];
>> +				p_rt->transport_params.port_num = p_rt->num;
>> +				p_rt->transport_params.sample_interval =
>> +					pcfg->si + 1;
>> +				p_rt->transport_params.offset1 = pcfg->off1;
>> +				p_rt->transport_params.offset2 = pcfg->off2;
>> +				i++;
>> +			}
> 
> Can you explain this one, am not sure I understood this. This fn is
> supposed to compute and fill up the params, all I can see is filling up!
> 
Bandwidth parameters are currently coming from board specific Device 
Tree, which are programmed here.

>> +static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
>> +	.hw_params = qcom_swrm_hw_params,
>> +	.prepare = qcom_swrm_prepare,
>> +	.hw_free = qcom_swrm_hw_free,
>> +	.startup = qcom_swrm_startup,
>> +	.shutdown = qcom_swrm_shutdown,
>> +        .set_sdw_stream = qcom_swrm_set_sdw_stream,
> 
> why does indent look off to me!
> 
Yep, Fixed in next version.

--srini
