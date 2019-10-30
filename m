Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CA3CA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9437020679
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfJ3PSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:18:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:3811 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbfJ3PSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:18:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 08:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="374918242"
Received: from kmbarley-mobl.amr.corp.intel.com (HELO [10.252.135.193]) ([10.252.135.193])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2019 08:18:35 -0700
Subject: Re: [alsa-devel] [PATCH v3 2/2] soundwire: qcom: add support for
 SoundWire controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-3-srinivas.kandagatla@linaro.org>
 <20191021044405.GB2654@vkoul-mobl>
 <17cb6d3f-2317-9667-8642-566a8a88bd4c@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e9b63796-4af2-452c-53de-aab2e7c85866@linux.intel.com>
Date:   Wed, 30 Oct 2019 10:18:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <17cb6d3f-2317-9667-8642-566a8a88bd4c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/19 9:56 AM, Srinivas Kandagatla wrote:
> 
> 
> On 21/10/2019 05:44, Vinod Koul wrote:
>> On 11-10-19, 16:44, Srinivas Kandagatla wrote:
>>
>>> +static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>>> +{
>>> +    struct qcom_swrm_ctrl *ctrl = dev_id;
>>> +    u32 sts, value;
>>> +    unsigned long flags;
>>> +
>>> +    ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &sts);
>>> +
>>> +    if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
>>> +        ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
>>> +        dev_err_ratelimited(ctrl->dev,
>>> +                    "CMD error, fifo status 0x%x\n",
>>> +                     value);
>>> +        ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>>> +    }
>>> +
>>> +    if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
>>> +        sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS)
>>> +        schedule_work(&ctrl->slave_work);
>>
>> we are in irq thread, so why not do the work here rather than schedule
>> it?
> 
> The reason is that, sdw_handle_slave_status() we will read device id 
> registers, which are fifo based in this controller and triggers an 
> interrupt for each read.
> So all the such reads will timeout waiting for interrupt if we do not do 
> it in a separate thread.

Yes, it's similar for Intel. we don't read device ID in the handler or 
reads would time out. And in the latest patches we also use a work queue 
for the slave status handling (due to MSI handling issues).
Even if this timeout problem did not exists, updates to the slave status 
will typically result in additional read/writes, which are going to be 
throttled by the command bandwidth (frame rate), so this status update 
should really not be done in a handler. This has to be done in a thread 
or work queue.

> 
> 
> 
>>
>>> +static int qcom_swrm_compute_params(struct sdw_bus *bus)
>>> +{
>>> +    struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>>> +    struct sdw_master_runtime *m_rt;
>>> +    struct sdw_slave_runtime *s_rt;
>>> +    struct sdw_port_runtime *p_rt;
>>> +    struct qcom_swrm_port_config *pcfg;
>>> +    int i = 0;
>>> +
>>> +    list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
>>> +        list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
>>> +            pcfg = &ctrl->pconfig[p_rt->num - 1];
>>> +            p_rt->transport_params.port_num = p_rt->num;
>>> +            p_rt->transport_params.sample_interval = pcfg->si + 1;
>>> +            p_rt->transport_params.offset1 = pcfg->off1;
>>> +            p_rt->transport_params.offset2 = pcfg->off2;
>>> +        }
>>> +
>>> +        list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
>>> +            list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>>> +                pcfg = &ctrl->pconfig[i];
>>> +                p_rt->transport_params.port_num = p_rt->num;
>>> +                p_rt->transport_params.sample_interval =
>>> +                    pcfg->si + 1;
>>> +                p_rt->transport_params.offset1 = pcfg->off1;
>>> +                p_rt->transport_params.offset2 = pcfg->off2;
>>> +                i++;
>>> +            }
>>
>> Can you explain this one, am not sure I understood this. This fn is
>> supposed to compute and fill up the params, all I can see is filling up!
>>
> Bandwidth parameters are currently coming from board specific Device 
> Tree, which are programmed here.

'compute' does not mean 'dynamic on-demand bandwidth allocation', it's 
perfectly legal to use fixed tables as done here.

> 
>>> +static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
>>> +    .hw_params = qcom_swrm_hw_params,
>>> +    .prepare = qcom_swrm_prepare,
>>> +    .hw_free = qcom_swrm_hw_free,
>>> +    .startup = qcom_swrm_startup,
>>> +    .shutdown = qcom_swrm_shutdown,
>>> +        .set_sdw_stream = qcom_swrm_set_sdw_stream,
>>
>> why does indent look off to me!
>>
> Yep, Fixed in next version.
> 
> --srini
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
