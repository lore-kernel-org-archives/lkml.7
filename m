Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF49ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E2220854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qlHUe9+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfJNJFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:05:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37471 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbfJNJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:05:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id p14so18727583wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 02:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qVf/bhsbBAGdIJNSUQBNYaBfvtttG3jIGRjyhI20Bs8=;
        b=qlHUe9+nrwjT07+d5js3iFWuu3/3NsGlzk2cmenspjlDs6G4E64vgC6wDUKkJcoko5
         w6T9mVxoPEaJI2fXgCQu1IUPVAKsu8b9RGu80JoeHcqXXPyY31Pqp60YqMZc7Aw9iOQq
         qwvj3KKas416HXJbkLgyqlJHp4C8ABhg0Bgtob5IOAJzjOELeQ+VwxO4mPDUiFWlgcyJ
         tM+WxqXYZlPQADQ/dmlDTNfRmwzrRaPcSxRaqNpVea65ENvcFl77UQnZKY2qF4ozoWe4
         2db3bQwN4vzm9tatV7yoq8q5E/ygwTzhwWicDto/cJljA7VdH9EWuo4/cMfDf1+ip0zB
         w5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qVf/bhsbBAGdIJNSUQBNYaBfvtttG3jIGRjyhI20Bs8=;
        b=hPcG+19P9zSIuH1jIUB1VMU/zZcpfaMtd0TjtGpb3YlFS4Csc+B52QNN0H2Oir8Nv+
         C7KZV70ctQdeENn9kE36vLG8e9GuW8AS6JmVk0AEmLSpsTI8Qv037cw/wzzK+Y94lSNm
         HelmnJb4dQo1pi4oChHzjsq53wtDqIwC0ON3vqX5HCJlXafR8romiv9GlDxCzQtDbzSE
         C8d7nnZ1aecUp21L9AeDqj47uLNgLy6698/1FJolHzbwxKHrIZ+jhi6xkICX+uyFjLYc
         f4IpPNNHXTU3hX4Q+LJlZGyj/l15ncAfkD4OC38bfxzSrBa5AYVg/YnJ9lczIFsL7BXu
         pD+Q==
X-Gm-Message-State: APjAAAVHA8wNQ+IXmBbYCBrOHNEF80cPpC4LtK4sMBJ0m8VURDidq058
        mZmAkFIIMzs/FoaaBVKUQFC95g==
X-Google-Smtp-Source: APXvYqx36OkBA6TiruKEZwQQwLh8Mt2lrT3TIasCSOXVxKWFbEffhnjpMLW7FaUpDfg7j4VunduoUg==
X-Received: by 2002:adf:db0e:: with SMTP id s14mr26034870wri.341.1571043898204;
        Mon, 14 Oct 2019 02:04:58 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s10sm33410515wmf.48.2019.10.14.02.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 02:04:57 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] soundwire: qcom: add support for SoundWire
 controller
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        robh@kernel.org, vkoul@kernel.org
Cc:     broonie@kernel.org, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org
References: <20191011154423.2506-1-srinivas.kandagatla@linaro.org>
 <20191011154423.2506-3-srinivas.kandagatla@linaro.org>
 <9d00c94b-1bce-9fdf-55fe-ee681466a97a@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d053a17e-3d6d-e3b6-f988-485e77c30e3b@linaro.org>
Date:   Mon, 14 Oct 2019 10:04:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9d00c94b-1bce-9fdf-55fe-ee681466a97a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for taking time to review the patch.

On 11/10/2019 18:50, Pierre-Louis Bossart wrote:
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
> 
> It's odd to report CMD_IGNORED on a timeout. CMD_IGNORED is a valid 
> answer that should be retrieved immediately. You probably need to 
> translate the soundwire errors into -ETIMEOUT or something.

In this controller we have no way to know if the command is ignored or 
timedout, so All the commands that did not receive response either due 
to ignore or timeout are currently detected with out any response 
interrupt in given timeout.

> 
>> +err:
>> +    spin_lock_irqsave(&ctrl->comp_lock, flags);
>> +    ctrl->comp = NULL;
>> +    spin_unlock_irqrestore(&ctrl->comp_lock, flags);
>> +
>> +    return ret;
>> +}
>> +
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
>> +} > +
> 
> [snip]
> 
>> +static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_id;
>> +    u32 sts, value;
>> +    unsigned long flags;
>> +
>> +    ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &sts);
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
>> +        ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
>> +        dev_err_ratelimited(ctrl->dev,
>> +                    "CMD error, fifo status 0x%x\n",
>> +                     value);
>> +        ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>> +    }
>> +
>> +    if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
>> +        sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS)
>> +        schedule_work(&ctrl->slave_work);
>> +
>> +    ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, sts);
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED) {
>> +        spin_lock_irqsave(&ctrl->comp_lock, flags);
>> +        if (ctrl->comp)
>> +            complete(ctrl->comp);
>> +        spin_unlock_irqrestore(&ctrl->comp_lock, flags);
> 
> 
> Wouldn't it be simpler if you declared the completion structure as part 
> of your controller definitions, as done for the Intel stuff?
> 
I can give that a go!
> [snip]
> 
>> +static void qcom_swrm_stream_free_ports(struct qcom_swrm_ctrl *ctrl,
>> +                    struct sdw_stream_runtime *stream)
>> +{
>> +    struct sdw_master_runtime *m_rt;
>> +    struct sdw_port_runtime *p_rt;
>> +    unsigned long *port_mask;
>> +
>> +    mutex_lock(&ctrl->port_lock);
> 
> is this lock to avoid races between alloc/free? if yes maybe document it?
> 

Yes, port allocation resource is protected across these calls here, I 
can add some notes as you suggested in next version.

>> +
>> +    list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>> +        if (m_rt->direction == SDW_DATA_DIR_RX)
>> +            port_mask = &ctrl->dout_port_mask;
>> +        else
>> +            port_mask = &ctrl->din_port_mask;
>> +
>> +        list_for_each_entry(p_rt, &m_rt->port_list, port_node)
>> +            clear_bit(p_rt->num - 1, port_mask);
>> +    }
>> +
>> +    mutex_unlock(&ctrl->port_lock);
>> +}
>> +
>> +static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>> +                    struct sdw_stream_runtime *stream,
>> +                       struct snd_pcm_hw_params *params,
>> +                       int direction)
>> +{
>> +    struct sdw_port_config pconfig[QCOM_SDW_MAX_PORTS];
>> +    struct sdw_stream_config sconfig;
>> +    struct sdw_master_runtime *m_rt;
>> +    struct sdw_slave_runtime *s_rt;
>> +    struct sdw_port_runtime *p_rt;
>> +    unsigned long *port_mask;
>> +    int i, maxport, pn, nports = 0, ret = 0;
>> +
>> +    mutex_lock(&ctrl->port_lock);
>> +    list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>> +        if (m_rt->direction == SDW_DATA_DIR_RX) {
>> +            maxport = ctrl->num_dout_ports;
>> +            port_mask = &ctrl->dout_port_mask;
>> +        } else {
>> +            maxport = ctrl->num_din_ports;
>> +            port_mask = &ctrl->din_port_mask;
>> +        }
>> +
>> +        list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
>> +            list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>> +                /* Port numbers start from 1 - 14*/
>> +                pn = find_first_zero_bit(port_mask, maxport);
>> +                if (pn > (maxport - 1)) {
>> +                    dev_err(ctrl->dev, "All ports busy\n");
>> +                    ret = -EBUSY;
>> +                    goto err;
>> +                }
>> +                set_bit(pn, port_mask);
>> +                pconfig[nports].num = pn + 1;
>> +                pconfig[nports].ch_mask = p_rt->ch_mask;
>> +                nports++;
>> +            }
>> +        }
>> +    }
>> +
>> +    if (direction == SNDRV_PCM_STREAM_CAPTURE)
>> +        sconfig.direction = SDW_DATA_DIR_TX;
>> +    else
>> +        sconfig.direction = SDW_DATA_DIR_RX;
>> +
>> +    sconfig.ch_count = 1;
>> +    sconfig.frame_rate = params_rate(params);
>> +    sconfig.type = stream->type;
>> +    sconfig.bps = 1;
> 
> Should probably add a note that hw_params is ignored since it's PDM 
> content, so only 1ch 1bit data.
> 

Okay Sure!
>> +    sdw_stream_add_master(&ctrl->bus, &sconfig, pconfig,
>> +                  nports, stream);
>> +err:
>> +    if (ret) {
>> +        for (i = 0; i < nports; i++)
>> +            clear_bit(pconfig[i].num - 1, port_mask);
>> +    }
>> +
>> +    mutex_unlock(&ctrl->port_lock);
>> +
>> +    return ret;
>> +}
>> +
> 
> [snip]
> 
>> +static int qcom_swrm_hw_free(struct snd_pcm_substream *substream,
>> +                 struct snd_soc_dai *dai)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>> +    struct sdw_stream_runtime *sruntime = ctrl->sruntime[dai->id];
>> +
>> +    qcom_swrm_stream_free_ports(ctrl, sruntime);
>> +    sdw_stream_remove_master(&ctrl->bus, sruntime);
>> +    sdw_deprepare_stream(sruntime);
>> +    sdw_disable_stream(sruntime);
> 
> Should is be the reverse order? Removing ports/master before disabling 
> doesn't seem too good.

Good point!  Will fix it in next version.

> 
>> +
>> +    return 0;
>> +}
>> +
> 
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
>> +
>> +        if (i < ctrl->num_dout_ports) {
>> +            stream = &dais[i].playback;
>> +            stream->stream_name = devm_kasprintf(dev, GFP_KERNEL,
>> +                                 "SDW Tx%d", i);
>> +        } else {
>> +            stream = &dais[i].capture;
>> +            stream->stream_name = devm_kasprintf(dev, GFP_KERNEL,
>> +                                 "SDW Rx%d", i);
>> +        }
> 
> For the Intel stuff, we removed the stream_name assignment since it 
> conflicted with the DAI widgets added by the topology. Since the code 
> looks inspired by the Intel DAI handling, you should look into this.

Yes, this code was inspired by Intel's DAI handling, I will take a look 
a look at latest code and update accordingly.

Thanks,
srini
> 
