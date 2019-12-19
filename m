Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E480EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A5124679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4G/I2Wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLSROS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:14:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34104 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSROS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:14:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so6792336wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZ0EtI8SNKlfgm0DfEQvvRLmJ1Ih0hN8p888zZI0xD0=;
        b=H4G/I2WrR1UhOCtp1/0yzqTouxps1FSmdWsBfOQTPXS+dwbHJG2wxEOPPq8f/a1fs+
         6ZABq6etTBDIn7AzrrWkJUnW+k4YKWzA0nbrDfHGAhs8mXbeKtgTmfVFXL9MJxiWTh9Z
         7N2GqMK0Z2fhKaB9Kyx5WpCCUx2YXElNEpEEVimjEO4B6vAeTOKXPnQrEkld9B+MNMkx
         ZCb3JkmF4D+qs0XL0JDPusJNh8JSYgDwXigyZS5dA5ikNteDmdH8P8xwFF/nV90sjlYN
         j5Uu0DzK+jpeFcnW/6ADPP0H0/r3Gr2HZE5IgMWScOkQ3Oo16H9hImySyw75UjPrftLU
         BNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZ0EtI8SNKlfgm0DfEQvvRLmJ1Ih0hN8p888zZI0xD0=;
        b=OmvcOeZ8mz34lZ3Wwh4loE8L176RAvJHvv5LYKA2Nv63WAomNgCSllX74bL+iItTia
         A49Dlxb5mPkDBpWm7LiBgygUpSU3O2MUSmzRWI8seyFJ5yEwzQLh74Yv54KugqtGgTNP
         wjmbU3mUv7lk3fB07Nq5/6CA9HCtDTnlrnH4iw5jr4zQlBIr0NBs+0XeQbNZiPfEJZXr
         DPc0kyheBY7SIxmmn159WD+rUqUZ04EDxjDkh1kXwB8aGb+krdgfsAghQeuaeEQVTfkH
         ejyU51TUXnNw6HLNs/EMQsSSofAQhO4tKodJdsDf7xOwVVolRPHlN0wej6s6cAtuqi5h
         xpKw==
X-Gm-Message-State: APjAAAWSsGvdGaXKyRaIAm1k/e4XtDKpoRvC4Xc6nN7lKtIqsteFwgjc
        nZ52SacLJH5Jg3EDPaVBIpnoRN9UhhU=
X-Google-Smtp-Source: APXvYqwA8FWwQCzaZcPxfmvA9yCyMILHVORxzfEwKmag9PvZ6iu+Z0fU6wuYiLUEqjwYA9xb9fI5kg==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr10904787wrs.213.1576775654849;
        Thu, 19 Dec 2019 09:14:14 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x132sm11088147wmg.0.2019.12.19.09.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 09:14:14 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH v5 2/2] soundwire: qcom: add support for
 SoundWire controller
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     robh@kernel.org, bgoswami@codeaurora.org, broonie@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, spapothi@codeaurora.org
References: <20191219092842.10885-1-srinivas.kandagatla@linaro.org>
 <20191219092842.10885-3-srinivas.kandagatla@linaro.org>
 <c791e241-cd71-4c05-dac5-04e3ecaaf995@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a5315861-d9b8-0852-8a3a-012f60cc3a44@linaro.org>
Date:   Thu, 19 Dec 2019 17:14:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c791e241-cd71-4c05-dac5-04e3ecaaf995@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2019 16:07, Pierre-Louis Bossart wrote:
> 
> 
> On 12/19/19 3:28 AM, Srinivas Kandagatla wrote:
>> Qualcomm SoundWire Master controller is present in most Qualcomm SoCs
>> either integrated as part of WCD audio codecs via slimbus or
>> as part of SOC I/O.
>>
>> This patchset adds support to a very basic controller which has been
>> tested with WCD934x SoundWire controller connected to WSA881x smart
>> speaker amplifiers.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This looks quite good, I only have a couple of nit-picks/questions below.

Thanks for taking time to review this.

>> +static int qcom_swrm_abh_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
>> +                  u32 *val)
>> +{
>> +    struct regmap *wcd_regmap = ctrl->regmap;
>> +    int ret;
>> +
>> +    /* pg register + offset */
>> +    ret = regmap_bulk_write(wcd_regmap, SWRM_AHB_BRIDGE_RD_ADDR_0,
>> +              (u8 *)&reg, 4);
>> +    if (ret < 0)
>> +        return SDW_CMD_FAIL;
>> +
>> +    ret = regmap_bulk_read(wcd_regmap, SWRM_AHB_BRIDGE_RD_DATA_0,
>> +                   val, 4);
>> +    if (ret < 0)
>> +        return SDW_CMD_FAIL;
>> +
>> +    return SDW_CMD_OK;
>> +}
> 
> I think I asked the question before but don't remember the answer so you 
> may want to add a comment explaining why SDW_CMD_IGNORED is not a 
> possible return value?
> 
There is no way atleast in this version of the controller to know if the 
command is ignored. Only error that can be detected atm is timeout 
waiting for response. Hopefully new versions of this IP have that 
ability to detect this.

> The BER is supposed to be very very low but there is a non-zero 
> possibility of a device losing sync.
> 
>> +
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
> 
> the code is a bit inconsistent at the moment on how errors are handled.
> In some cases you explicitly test for errors, but ...

I looked at our previous discussions and I think we decided not to do 
error checking reading on controller registers.

"For the Intel stuff, we typically don't check the read/writes to 
controller registers, but anything that goes out on the bus is checked. "
> 
> 
>> +
>> +    for (i = 0; i < len; i++) {
>> +        ctrl->reg_read(ctrl, SWRM_CMD_FIFO_RD_FIFO_ADDR, &val);
> 
> ... here you don't ...
> 
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
> ... and not here ...
> 
>> +
>> +    for (i = 0; i < SDW_MAX_DEVICES; i++) {
>> +        u32 s;
>> +
>> +        s = (val >> (i * 2));
>> +        s &= SWRM_MCP_SLV_STATUS_MASK;
>> +        ctrl->status[i] = s;
>> +    }
>> +}
>> +
>> +static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_id;
>> +    u32 sts, value;
>> +    unsigned long flags;
>> +
>> +    ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS, &sts);
> 
> ... and here same the reg_read/writes are no longer tested for?
> 
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
> 
> is it intentional to clear the interrupts first, before doing additional 
> checks?
> 

No, I can move it to right to the end!

> Or could it be done immediately after reading the status. It's not clear 
> to me if the position of this clear matters, and if yes you should 
> probably add a comment?

Am not 100% if it matters, but Ideally I would like clear the interrupt 
source before clearing the interrupt.


> 
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED) {
>> +        spin_lock_irqsave(&ctrl->comp_lock, flags);
>> +        if (ctrl->comp)
>> +            complete(ctrl->comp);
>> +        spin_unlock_irqrestore(&ctrl->comp_lock, flags);
>> +    }
>> +
>> +    return IRQ_HANDLED;
> The rest looks fine. nice work.
Thanks,
srini
