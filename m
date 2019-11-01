Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8112DCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4869C20650
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCXI/veZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfKAQRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:17:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42389 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbfKAQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:17:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id a15so10139107wrf.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qbEALJPGyMG1TdmryILrvwfTCLWmWNt0rNBwGTNqEpw=;
        b=FCXI/veZR0NzQ4qOLR8l3kMMPzej2RExbJGN4/HCaV3NL1TAvkg3pHCA6273sPpBoK
         vZfYShIaeLbZt5wE/8PMC5EAZzvCczFmc/5T51CSw7F88Z5NqtIsye6lw8VXabSykDMI
         Ul/GPpD62E44sC0li2Pi5BOecgYwRLhAZqGq7KSzv2ViMSPyKvvAApKg+Uw/xPaG7S4g
         RSO+4BwZNfIk+5OVVSwR8+fj6Jt5p1x0bja90qp4AbDYCI2u5eS88Ltg1s7Ur66jl463
         4+/NNJGdm6aHbk2uBQxfCi0VnftzKonK24CvgR5hd5kgVSsA0cmYbJEwDeYBoggo6Pg5
         DIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qbEALJPGyMG1TdmryILrvwfTCLWmWNt0rNBwGTNqEpw=;
        b=phwQQFL4RKcZDpE4bBUOTkk5IAMlX4KwDdFEa0HQIU/eFes8wPJOenzzOMocob7XAM
         OJIn41kQrdlsRH75aAHug3PIovzOXpzPAlIcrTNYrgFQf/L16e+giuc/qMIv524yvmRK
         +elUjij7OJ48f6/Gz5FJ8J2r/qzHrBU1+3QA9b3b/BhJvbQStO0TSgctA9Crnzzp9Z55
         zQWWGlx9rbGE09CeIIgxiD/QoctybQgoUOsiYiU9Nr4RiTDOJ/j3NH0Ewx3LXVt8YzWi
         ATHoHV/yNq49Vz4SIQgItsdPZtXtdY9WAESdx+cd0Qn9K0NkCYS6fP2TMx/oUPnVdVTq
         wcOg==
X-Gm-Message-State: APjAAAVqjVO+WVbZH/GTzLrxj7m0uozfi/3uRN1ffO+Yz1HKXmxT8i5X
        BNHumSWYagT5e2S+6rV/7ChBpEr0GL0=
X-Google-Smtp-Source: APXvYqx6EyFz+f4X7YnfGdwPAwc5VAsJiQiK9qlrPpD42h/+1t9COsvgm+xukYZBXFUqMRrQPsDe5A==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr10395454wrv.59.1572625058805;
        Fri, 01 Nov 2019 09:17:38 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id j63sm9350109wmj.46.2019.11.01.09.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 09:17:37 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v4 2/2] soundwire: qcom: add support for
 SoundWire controller
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        robh@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org
References: <20191030153150.18303-1-srinivas.kandagatla@linaro.org>
 <20191030153150.18303-3-srinivas.kandagatla@linaro.org>
 <af29ec6e-d89e-7fa4-a8cd-29ab944ecd5c@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <926bd15f-e230-8f5e-378d-355bfeeecf27@linaro.org>
Date:   Fri, 1 Nov 2019 16:17:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <af29ec6e-d89e-7fa4-a8cd-29ab944ecd5c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for reviewing this!

On 30/10/2019 16:28, Pierre-Louis Bossart wrote:
> 
> 
> On 10/30/19 10:31 AM, Srinivas Kandagatla wrote:
>> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
>> either integrated as part of WCD audio codecs via slimbus or
>> as part of SOC I/O.
>>
>> This patchset adds support to a very basic controller which has been
>> tested with WCD934x SoundWire controller connected to WSA881x smart
>> speaker amplifiers.
> 
> Sorry for the delay in reviewing this patch.
> 
> I have a set of comments mostly on error handling and mapping between 
> ASoC callbacks and stream states (which took a lot of work on our side 
> and required an updated state machine in the patches shared last week).
> 
> [snip]
> 
>> +static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 
>> cmd_data,
>> +                     u8 dev_addr, u16 reg_addr)
>> +{
>> +    DECLARE_COMPLETION_ONSTACK(comp);
>> +    unsigned long flags;
>> +    u32 val;
>> +    int ret;
>> +
>> +    spin_lock_irqsave(&ctrl->comp_lock, flags);
>> +    ctrl->comp = &comp;
>> +    spin_unlock_irqrestore(&ctrl->comp_lock, flags);
>> +    val = SWRM_REG_VAL_PACK(cmd_data, dev_addr,
>> +                SWRM_SPECIAL_CMD_ID, reg_addr);
>> +    ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
>> +    if (ret)
>> +        goto err;
>> +
>> +    ret = wait_for_completion_timeout(ctrl->comp,
>> +                      msecs_to_jiffies(TIMEOUT_MS));
>> +
>> +    if (!ret)
>> +        ret = SDW_CMD_IGNORED;
>> +    else
>> +        ret = SDW_CMD_OK;
>> +err:
>> +    spin_lock_irqsave(&ctrl->comp_lock, flags);
>> +    ctrl->comp = NULL;
>> +    spin_unlock_irqrestore(&ctrl->comp_lock, flags);
>> +
>> +    return ret;
>> +}
>> +
>> +static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *ctrl,
>> +                     u8 dev_addr, u16 reg_addr,
>> +                     u32 len, u8 *rval)
>> +{
>> +    int i, ret;
>> +    u32 val;
>> +    DECLARE_COMPLETION_ONSTACK(comp);
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&ctrl->comp_lock, flags);
>> +    ctrl->comp = &comp;
>> +    spin_unlock_irqrestore(&ctrl->comp_lock, flags);
>> +
>> +    val = SWRM_REG_VAL_PACK(len, dev_addr, SWRM_SPECIAL_CMD_ID, 
>> reg_addr);
>> +    ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_RD_CMD, val);
>> +    if (ret)
>> +        goto err;
>> +
>> +    ret = wait_for_completion_timeout(ctrl->comp,
>> +                      msecs_to_jiffies(TIMEOUT_MS));
>> +
>> +    if (!ret) {
>> +        ret = SDW_CMD_IGNORED;
>> +        goto err;
>> +    } else {
>> +        ret = SDW_CMD_OK;
>> +    }
>> +
>> +    for (i = 0; i < len; i++) {
>> +        ret = ctrl->reg_read(ctrl, SWRM_CMD_FIFO_RD_FIFO_ADDR, &val);
>> +        if (ret)
>> +            return ret;
>> +
>> +        rval[i] = val & 0xFF;
>> +    }
>> +
>> +err:
>> +    spin_lock_irqsave(&ctrl->comp_lock, flags);
>> +    ctrl->comp = NULL;
>> +    spin_unlock_irqrestore(&ctrl->comp_lock, flags);
>> +
>> +    return ret;
>> +}
>> +
>> +static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
>> +{
>> +    u32 val;
>> +    int i;
>> +
>> +    ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
> 
> Sometimes you test the return value of reg_read(), and sometimes you 
> don't? same for read_write()?
> 
> For the Intel stuff, we typically don't check the read/writes to 
> controller registers, but anything that goes out on the bus is checked.
> 

I will try to make this more consistent in next version!

...

>> +
>> +static int qcom_swrm_prepare(struct snd_pcm_substream *substream,
>> +                 struct snd_soc_dai *dai)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>> +
>> +    if (!ctrl->sruntime[dai->id])
>> +        return -EINVAL;
>> +
>> +    return sdw_enable_stream(ctrl->sruntime[dai->id]);
> 
> So in hw_params you call sdw_prepare_stream() and in _prepare you call 
> sdw_enable_stream()?
> 
> Shouldn't this be handled in a .trigger operation as per the 
> documentation "From ASoC DPCM framework, this stream state is linked to
> .trigger() start operation."

If I move sdw_enable/disable_stream() to trigger I get a big click noise 
on my speakers at start and end of every playback. Tried different 
things but nothing helped so far!. Enabling Speaker DACs only after 
SoundWire ports are enabled is working for me!
There is nothing complicated on WSA881x codec side all the DACs are 
enabled/disabled as part of DAPM.

> 
> It's also my understanding that .prepare will be called multiples times, 

I agree, need to add some extra checks in the prepare to deal with this!

> including for underflows and resume if you don't support INFO_RESUME.

> 
> the sdw_disable_stream() is in .hw_free, which is not necessarily called 
> by the core, so you may have a risk of not being able to recover?

Hmm, I thought hw_free is always called to release resources allocated 
in hw_params.

In what cases does the core not call this?

> 
>> +}
>> +

>> +static int qcom_swrm_hw_free(struct snd_pcm_substream *substream,
>> +                 struct snd_soc_dai *dai)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>> +    struct sdw_stream_runtime *sruntime = ctrl->sruntime[dai->id];
>> +
>> +    qcom_swrm_stream_free_ports(ctrl, sruntime);
>> +    sdw_stream_remove_master(&ctrl->bus, sruntime);
>> +    sdw_disable_stream(sruntime);
>> +    sdw_deprepare_stream(sruntime);
> 
> is the order correct here?
> 
> On the Intel side we do
> 
> trigger_stop:
> sdw_disable_stream(sruntime);
> 
> hw_free
> sdw_deprepare_stream(sruntime);
> sdw_stream_remove_master(&ctrl->bus, sruntime);
> sdw_release_stream(dma->stream);
> 

I thought I fixed this one! will be more careful next time!

>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_swrm_set_sdw_stream(struct snd_soc_dai *dai,
>> +                    void *stream, int direction)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>> +
>> +    ctrl->sruntime[dai->id] = stream;
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_swrm_startup(struct snd_pcm_substream *substream,
>> +                 struct snd_soc_dai *dai)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>> +    struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +    struct sdw_stream_runtime *sruntime;
>> +    int ret, i;
> 
> if you supported pm_runtime, that's where you'd want to take a reference?
> 

I have not tested runtime pm Yet on my setup!

>> +    sruntime = sdw_alloc_stream(dai->name);
>> +    if (!sruntime)
>> +        return -ENOMEM;
>> +
>> +    ctrl->sruntime[dai->id] = sruntime;
>> +
>> +    for (i = 0; i < rtd->num_codecs; i++) {
>> +        ret = snd_soc_dai_set_sdw_stream(rtd->codec_dais[i], sruntime,
>> +                         substream->stream);
>> +        if (ret < 0 && ret != -ENOTSUPP) {
>> +            dev_err(dai->dev, "Failed to set sdw stream on %s",
>> +                rtd->codec_dais[i]->name);
>> +            sdw_release_stream(sruntime);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void qcom_swrm_shutdown(struct snd_pcm_substream *substream,
>> +                   struct snd_soc_dai *dai)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
> 
> and that's where you'd want to  call pm_runtime_put()
> 
>> +    sdw_release_stream(ctrl->sruntime[dai->id]);
>> +    ctrl->sruntime[dai->id] = NULL;
>> +}
>> +
>> +static const struct snd_soc_dai_ops qcom_swrm_pdm_dai_ops = {
>> +    .hw_params = qcom_swrm_hw_params,
>> +    .prepare = qcom_swrm_prepare,
>> +    .hw_free = qcom_swrm_hw_free,
>> +    .startup = qcom_swrm_startup,
>> +    .shutdown = qcom_swrm_shutdown,
>> +    .set_sdw_stream = qcom_swrm_set_sdw_stream,
> 
> no .trigger?
> 
>> +};
>> +
>> +static const struct snd_soc_component_driver qcom_swrm_dai_component = {
>> +    .name = "soundwire",
>> +};
>> +
>> +static int qcom_swrm_register_dais(struct qcom_swrm_ctrl *ctrl)
>> +{
>> +    int num_dais = ctrl->num_dout_ports + ctrl->num_din_ports;
>> +    struct snd_soc_dai_driver *dais;
>> +    struct snd_soc_pcm_stream *stream;
>> +    struct device *dev = ctrl->dev;
>> +    int i;
>> +
>> +    /* PDM dais are only tested for now */
>> +    dais = devm_kcalloc(dev, num_dais, sizeof(*dais), GFP_KERNEL);
>> +    if (!dais)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < num_dais; i++) {
>> +        dais[i].name = devm_kasprintf(dev, GFP_KERNEL, "SDW Pin%d", i);
>> +        if (!dais[i].name)
>> +            return -ENOMEM;
> 
> I think I mentioned we don't do this in the Intel stuff since it 
> conflicts with topology? is this required on the QCOM side?
> 
yes, we need this for dailink parsing code in machine driver which 
lookup the name from device tree node. If we do not add name at this 
point machine driver will fail to probe as missing dai dependencies.

>> +
>> +        if (i < ctrl->num_dout_ports)
>> +            stream = &dais[i].playback;
>> +        else
>> +            stream = &dais[i].capture;
>> +
>> +        stream->channels_min = 1;
>> +        stream->channels_max = 1;
>> +        stream->rates = SNDRV_PCM_RATE_48000;
>> +        stream->formats = SNDRV_PCM_FMTBIT_S16_LE;
>> +
>> +        dais[i].ops = &qcom_swrm_pdm_dai_ops;
>> +        dais[i].id = i;
>> +    }
>> +
>> +    return devm_snd_soc_register_component(ctrl->dev,
>> +                        &qcom_swrm_dai_component,
>> +                        dais, num_dais);
>> +}
>> +

...

>> +static int qcom_swrm_runtime_suspend(struct device *device)
>> +{
>> +    /* TBD */
>> +    return 0;
>> +}
>> +
>> +static int qcom_swrm_runtime_resume(struct device *device)
>> +{
>> +    /* TBD */
>> +    return 0;
>> +}
>> +
>> +static const struct dev_pm_ops qcom_swrm_dev_pm_ops = {
>> +    SET_RUNTIME_PM_OPS(qcom_swrm_runtime_suspend,
>> +               qcom_swrm_runtime_resume,
>> +               NULL
>> +    )
>> +};
> 
> Maybe define pm_runtime at a later time then? We've had a lot of race 
> conditions to deal with, and it's odd that you don't support plain 
> vanilla suspend first?
> 
Trying to keep things simple for the first patchset! added this dummies 
to keep the soundwire core happy!

thanks,
srini
>> +static const struct of_device_id qcom_swrm_of_match[] = {
>> +    { .compatible = "qcom,soundwire-v1.3.0", },
>> +    {/* sentinel */},
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, qcom_swrm_of_match);
>> +
>> +static struct platform_driver qcom_swrm_driver = {
>> +    .probe    = &qcom_swrm_probe,
>> +    .remove = &qcom_swrm_remove,
>> +    .driver = {
>> +        .name    = "qcom-soundwire",
>> +        .of_match_table = qcom_swrm_of_match,
>> +        .pm = &qcom_swrm_dev_pm_ops,
>> +    }
>> +};
>> +module_platform_driver(qcom_swrm_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm soundwire driver");
>> +MODULE_LICENSE("GPL v2");
>>
