Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E601AC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C886D217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 15:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbfJNPpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 11:45:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:23599 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729997AbfJNPpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 11:45:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 08:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="199434999"
Received: from rtnitta-mobl1.amr.corp.intel.com (HELO [10.251.134.135]) ([10.251.134.135])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2019 08:45:28 -0700
Subject: Re: [alsa-devel] [PATCH v3 2/2] soundwire: qcom: add support for
 SoundWire controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        robh@kernel.org, vkoul@kernel.org
Cc:     broonie@kernel.org, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-3-srinivas.kandagatla@linaro.org>
 <9d00c94b-1bce-9fdf-55fe-ee681466a97a@linux.intel.com>
 <d053a17e-3d6d-e3b6-f988-485e77c30e3b@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1a1a4ac0-388c-8999-47a2-6d6f7471ab93@linux.intel.com>
Date:   Mon, 14 Oct 2019 10:43:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d053a17e-3d6d-e3b6-f988-485e77c30e3b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/19 4:04 AM, Srinivas Kandagatla wrote:
> Thanks Pierre for taking time to review the patch.
> 
> On 11/10/2019 18:50, Pierre-Louis Bossart wrote:
>>
>>> +static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 
>>> cmd_data,
>>> +                     u8 dev_addr, u16 reg_addr)
>>> +{
>>> +    DECLARE_COMPLETION_ONSTACK(comp);
>>> +    unsigned long flags;
>>> +    u32 val;
>>> +    int ret;
>>> +
>>> +    spin_lock_irqsave(&ctrl->comp_lock, flags);
>>> +    ctrl->comp = &comp;
>>> +    spin_unlock_irqrestore(&ctrl->comp_lock, flags);
>>> +    val = SWRM_REG_VAL_PACK(cmd_data, dev_addr,
>>> +                SWRM_SPECIAL_CMD_ID, reg_addr);
>>> +    ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
>>> +    if (ret)
>>> +        goto err;
>>> +
>>> +    ret = wait_for_completion_timeout(ctrl->comp,
>>> +                      msecs_to_jiffies(TIMEOUT_MS));
>>> +
>>> +    if (!ret)
>>> +        ret = SDW_CMD_IGNORED;
>>> +    else
>>> +        ret = SDW_CMD_OK;
>>
>> It's odd to report CMD_IGNORED on a timeout. CMD_IGNORED is a valid 
>> answer that should be retrieved immediately. You probably need to 
>> translate the soundwire errors into -ETIMEOUT or something.
> 
> In this controller we have no way to know if the command is ignored or 
> timedout, so All the commands that did not receive response either due 
> to ignore or timeout are currently detected with out any response 
> interrupt in given timeout.

ok. It's still very odd. a CMD_IGNORED is a required answer e.g. when 
there is no device0 left to enumerate, when a device has fallen off the 
bus or when accessing a non-implemented register.

>>> +static int qcom_swrm_register_dais(struct qcom_swrm_ctrl *ctrl)
>>> +{
>>> +    int num_dais = ctrl->num_dout_ports + ctrl->num_din_ports;
>>> +    struct snd_soc_dai_driver *dais;
>>> +    struct snd_soc_pcm_stream *stream;
>>> +    struct device *dev = ctrl->dev;
>>> +    int i;
>>> +
>>> +    /* PDM dais are only tested for now */
>>> +    dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
>>> +    if (!dais)
>>> +        return -ENOMEM;
>>> +
>>> +    for (i = 0; i < num_dais; i++) {
>>> +        dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW Pin%d", i);
>>> +        if (!dais[i].name)
>>> +            return -ENOMEM;
>>> +
>>> +        if (i < ctrl->num_dout_ports) {
>>> +            stream = &dais[i].playback;
>>> +            stream->stream_name = devm_kasprintf(dev, GFP_KERNEL,
>>> +                                 "SDW Tx%d", i);
>>> +        } else {
>>> +            stream = &dais[i].capture;
>>> +            stream->stream_name = devm_kasprintf(dev, GFP_KERNEL,
>>> +                                 "SDW Rx%d", i);
>>> +        }
>>
>> For the Intel stuff, we removed the stream_name assignment since it 
>> conflicted with the DAI widgets added by the topology. Since the code 
>> looks inspired by the Intel DAI handling, you should look into this.
> 
> Yes, this code was inspired by Intel's DAI handling, I will take a look 
> a look at latest code and update accordingly.


FWIW, the stream handling seems to have issues as well, specifically the 
'deprepare' part, we are currently working around errors with 
suspend-resume, see e.g. experimental branch at 
https://github.com/thesofproject/linux/pull/1314

