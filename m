Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0BEC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB47F2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYeB1n62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfFIMQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:16:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54078 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfFIMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:16:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so5998313wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5MgoNbO0fjbY6iRhBt3I0q8U4sJDeB9Wb5JP/w6clJA=;
        b=CYeB1n62amT1x8KMQhpbtyKaEoy2oiIILbUJSsO926btsXb/wMOYYHLB47Rzx5nWAf
         Q1utQ9m+ASuCR16kuDq0hJsDfSIaXTxnqcBLvXJH7mTfvV43GfNvIOna9aeIRR8KkZwm
         Ie60YtErqf+SRxUW3OEm89Fq7wEb9Vjtn8CXnnFneuz/pdwD2mFHiQKfJn5QIPUkEF4w
         xFg2yEgAH41Snwo/RIGJQMAntZxaDQjSPylHJaHruEMvl8oiIw/ZUBU2Y0p88fXHstD8
         x5vKUt/kJ2mvrb28g7GYYvQIcYOc9fz25O/ClTg97cFbOCxbaaka9/qO/VCahTAFByN+
         m6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5MgoNbO0fjbY6iRhBt3I0q8U4sJDeB9Wb5JP/w6clJA=;
        b=Ju4kGTGeHPymiNgthzaZOCD2w8hmHF5KrRlOIox+Mgjac3X20khQjTGz1CJKwo6X8Z
         aku+RXmWghFCSOZF7+ZCW5R0jK+t0qPR5E+h9H2NRm15b7USMGkQdUgV3rBi1gVnUQiN
         kbbnfcGDQg0N/16C4h7I8SruyUd5hyjIN22uSdlPtTm64/2vPDj/YWI7pNo6hdYEAgHn
         40xAWcM7Z3CbOKFYXSlomihj+wv5b1wGG/vHadM36Wlp/OFBP1QyAJH2FvYxzClArD3x
         I+285Wo5XZS0OtzGzc65Ixfq8ag/7kZZinC14+QUvxvBpM30DnGkUqhLq5yqDhKumK4G
         fXiA==
X-Gm-Message-State: APjAAAXpbE4a803Dz+24yCBwVDZBxX/dNHJTG/Pt+OXLBzmahtzX3FBv
        RLEr+T6YdW29igMj/30x78TdfQ==
X-Google-Smtp-Source: APXvYqzoqwHRiAbhz3uN0UVJUotETMlqmUqIQWaiaJICOT8VE/zB9tu6GyaEkBTsFQeJODzCzPYufw==
X-Received: by 2002:a1c:e702:: with SMTP id e2mr10079886wmh.38.1560082556847;
        Sun, 09 Jun 2019 05:15:56 -0700 (PDT)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id x16sm5761423wmj.4.2019.06.09.05.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 05:15:56 -0700 (PDT)
Subject: Re: [alsa-devel] [RFC PATCH 6/6] soundwire: qcom: add support for
 SoundWire controller
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
 <249f9647-94d0-41d7-3b95-64c36d90f8e8@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <40ea774c-8aa8-295d-e91e-71423b03c88d@linaro.org>
Date:   Sun, 9 Jun 2019 13:15:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <249f9647-94d0-41d7-3b95-64c36d90f8e8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review,

On 07/06/2019 14:36, Pierre-Louis Bossart wrote:
> 
>> +config SOUNDWIRE_QCOM
>> +    tristate "Qualcomm SoundWire Master driver"
>> +    select SOUNDWIRE_BUS
>> +    depends on SND_SOC
> 
> depends on SLIMBUS if you need the SlimBus link to talk to your 
> SoundWire Master?
> 
> Also depends on device tree since you use of_ functions?
> 
Thats true, will fix this in next version.
>> +#define SWRM_COMP_HW_VERSION                    0x00
> 
> Can we please use SDW_ or QCOM_SDW_ as prefix?
> 

SWRM prefix is as per the data sheet register names, If it help am happy 
to add QCOM_ prefix it.

>> +#define SWRM_INTERRUPT_STATUS_NEW_SLAVE_AUTO_ENUM_FINISHED    BIT(11)
>> +#define SWRM_INTERRUPT_STATUS_AUTO_ENUM_FAILED            BIT(12)
>> +#define SWRM_INTERRUPT_STATUS_AUTO_ENUM_TABLE_IS_FULL        BIT(13)
> 
> This hints at hardware support to assign Device Numbers automagically so 
> will likely have impacts on the bus driver code, no?

yes, this controller has autoenumeration support, however I had disabled 
this code due to the fact that we need some more support in bus driver 
to accommodate this feature.

I will explore this side once again, may be before sending next version.


> 
> 
>> +#define SWRM_MAX_ROW_VAL    0 /* Rows = 48 */
>> +#define SWRM_DEFAULT_ROWS    48
>> +#define SWRM_MIN_COL_VAL    0 /* Cols = 2 */
>> +#define SWRM_DEFAULT_COL    16
>> +#define SWRM_SPECIAL_CMD_ID    0xF
>> +#define MAX_FREQ_NUM        1
>> +#define TIMEOUT_MS        1000
>> +#define QCOM_SWRM_MAX_RD_LEN    0xf
>> +#define DEFAULT_CLK_FREQ    9600000
> 
> The clocks and frame shape don't match usual expectations for PDM.
> For a 9.6 MHz support, you would typically use 8 columns and 50 rows to 
> transport PDM with a 50x oversampling. I've never seen anyone use 48x 
> for PDM.
> 
>> +#define SWRM_MAX_DAIS        0xF
>> +
>> +struct qcom_swrm_port_config {
>> +    u8 si;
>> +    u8 off1;
>> +    u8 off2;
>> +};
>> +
>> +struct qcom_swrm_ctrl {
>> +    struct sdw_bus bus;
>> +    struct device *dev;
>> +    struct regmap *regmap;
>> +    struct completion sp_cmd_comp;
>> +    struct work_struct slave_work;
>> +    /* read/write lock */
>> +    struct mutex lock;
>> +    /* Port alloc/free lock */
>> +    struct mutex port_lock;
>> +    struct clk *hclk;
>> +    int fifo_status;
>> +    void __iomem *base;
>> +    u8 wr_cmd_id;
>> +    u8 rd_cmd_id;
>> +    int irq;
>> +    unsigned int version;
>> +    int num_din_ports;
>> +    int num_dout_ports;
>> +    unsigned long dout_port_mask;
>> +    unsigned long din_port_mask;
>> +    struct qcom_swrm_port_config pconfig[SDW_MAX_PORTS];
> 
> this is not necessarily correct. the initial definitions for 
> SDW_MAX_PORTS was for Slave devices. There is no definitions for Masters 
> in the SoundWire spec, so you could use whatever constant you want for 
> your hardware.

Yes, I can move this define to this driver specific.

> 
>> +    struct sdw_stream_runtime *sruntime[SWRM_MAX_DAIS];
>> +    enum sdw_slave_status status[SDW_MAX_DEVICES];
>> +    u32 (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg);
>> +    int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
>> +};
>> +
>> +#define to_qcom_sdw(b)    container_of(b, struct qcom_swrm_ctrl, bus)
>> +
>> +struct usecase {
>> +    u8 num_port;
>> +    u8 num_ch;
>> +    u32 chrate;
>> +};
> 
> this structure doesn't seem to be used?
> 
looks like left over, I will remove this.

>> +static int qcom_swrm_cmd_fifo_wr_cmd(struct qcom_swrm_ctrl *ctrl, u8 
>> cmd_data,
>> +                     u8 dev_addr, u16 reg_addr)
>> +{
>> +    int ret = 0;
>> +    u8 cmd_id;
>> +    u32 val;
>> +
>> +    mutex_lock(&ctrl->lock);
>> +    if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>> +        cmd_id = SWRM_SPECIAL_CMD_ID;
>> +    } else {
>> +        if (++ctrl->wr_cmd_id == SWRM_SPECIAL_CMD_ID)
>> +            ctrl->wr_cmd_id = 0;
>> +
>> +        cmd_id = ctrl->wr_cmd_id;
>> +    }
> 
> might be worth having a helper/macro since you are doing the same thing 
> below.
> 

I will do that!

>> +
>> +    val = SWRM_REG_VAL_PACK(cmd_data, dev_addr, cmd_id, reg_addr);
>> +    ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_WR_CMD, val);
>> +    if (ret < 0) {
>> +        dev_err(ctrl->dev, "%s: reg 0x%x write failed, err:%d\n",
>> +            __func__, val, ret);
>> +        goto err;
>> +    }
>> +
>> +    if (dev_addr == SDW_BROADCAST_DEV_NUM) {
>> +        ctrl->fifo_status = 0;
>> +        ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>> +                          msecs_to_jiffies(TIMEOUT_MS));
> 
> This is odd. The SoundWire spec does not handle writes to a single 
> device or broadcast writes differently. I don't see a clear reason why 
> you would only timeout for a broadcast write.
> 

There is danger of blocking here without timeout.

>> +
>> +        if (!ret || ctrl->fifo_status) {
>> +            dev_err(ctrl->dev, "reg 0x%x write failed\n", val);
>> +            ret = -ENODATA;
>> +            goto err;
>> +        }
>> +    }
>> +err:
>> +    mutex_unlock(&ctrl->lock);
>> +    return ret;
>> +}
>> +
>> +static int qcom_swrm_cmd_fifo_rd_cmd(struct qcom_swrm_ctrl *ctrl,
>> +                     u8 dev_addr, u16 reg_addr,
>> +                     u32 len, u8 *rval)
>> +{
>> +    int i, ret = 0;
>> +    u8 cmd_id = 0;
>> +    u32 val;
>> +
>> +    mutex_lock(&ctrl->lock);
>> +    if (dev_addr == SDW_ENUM_DEV_NUM) {
>> +        cmd_id = SWRM_SPECIAL_CMD_ID;
>> +    } else {
>> +        if (++ctrl->rd_cmd_id == SWRM_SPECIAL_CMD_ID)
>> +            ctrl->rd_cmd_id = 0;
>> +
>> +        cmd_id = ctrl->rd_cmd_id;
>> +    }
> 
> helper?
yes will add that.

> 
>> +    val = SWRM_REG_VAL_PACK(len, dev_addr, cmd_id, reg_addr);
>> +    ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_RD_CMD, val);
>> +    if (ret < 0) {
>> +        dev_err(ctrl->dev, "reg 0x%x write failed err:%d\n", val, ret);
>> +        goto err;
>> +    }
>> +
>> +    if (dev_addr == SDW_ENUM_DEV_NUM) {
>> +        ctrl->fifo_status = 0;
>> +        ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>> +                          msecs_to_jiffies(TIMEOUT_MS));
>>
> same comment here, there isn't a clear reason to only timeout for a read 
> from device0.
> 
>> +        if (!ret || ctrl->fifo_status) {
>> +            dev_err(ctrl->dev, "reg 0x%x read failed\n", val);
>> +            ret = -ENODATA;
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    for (i = 0; i < len; i++) {
>> +        rval[i] = ctrl->reg_read(ctrl, SWRM_CMD_FIFO_RD_FIFO_ADDR);
>> +        rval[i] &= 0xFF;
>> +    }
>> +
>> +err:
>> +    mutex_unlock(&ctrl->lock);
>> +    return ret;
>> +}
>> +
>> +static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
>> +{
>> +    u32 val = ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS);
>> +    int i;
>> +
>> +    for (i = 1; i < SDW_MAX_DEVICES; i++) {
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
>> +
>> +    sts = ctrl->reg_read(ctrl, SWRM_INTERRUPT_STATUS);
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED)
>> +        complete(&ctrl->sp_cmd_comp);
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
>> +        value = ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS);
>> +        dev_err_ratelimited(ctrl->dev,
>> +                    "CMD error, fifo status 0x%x\n",
>> +                     value);
>> +        ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>> +        if ((value & 0xF) == 0xF) {
>> +            ctrl->fifo_status = -ENODATA;
>> +            complete(&ctrl->sp_cmd_comp);
>> +        }
>> +    }
>> +
>> +    if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
>> +        sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS) {
>> +        if (sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED)
>> +            ctrl->status[0] = SDW_SLAVE_ATTACHED;
>> +
>> +        schedule_work(&ctrl->slave_work);
>> +    }
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_SLAVE_PEND_IRQ)
>> +        dev_dbg(ctrl->dev, "Slave pend irq\n");
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED)
>> +        dev_dbg(ctrl->dev, "New slave attached\n");
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET)
>> +        dev_err_ratelimited(ctrl->dev, "Bus clash detected\n");
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_RD_FIFO_OVERFLOW)
>> +        dev_err(ctrl->dev, "Read FIFO overflow\n");
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_RD_FIFO_UNDERFLOW)
>> +        dev_err(ctrl->dev, "Read FIFO underflow\n");
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_WR_CMD_FIFO_OVERFLOW)
>> +        dev_err(ctrl->dev, "Write FIFO overflow\n");
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_DOUT_PORT_COLLISION)
>> +        dev_err(ctrl->dev, "Port collision detected\n");
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_READ_EN_RD_VALID_MISMATCH)
>> +        dev_err(ctrl->dev, "Read enable valid mismatch\n");
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_SPECIAL_CMD_ID_FINISHED)
>> +        dev_err(ctrl->dev, "Cmd id finished\n");
>> +
>> +    if (sts & SWRM_INTERRUPT_STATUS_BUS_RESET_FINISHED)
>> +        dev_err(ctrl->dev, "Bus reset finished\n");
> 
> This list is odd as well. It makes sense to only log error cases if you 
> don't really know how to handle them, but a 'NEW SLAVE ATTACHED' should 
> lead to an action, no?

NEW SLAVE ATTACHED interrupt already schedules action by reporting this 
to soudwire bus layer.
Some of them are leftover as part of debug, i will try to clean them up 
and see if some of them can be handled properly.
> 
>> +
>> +    ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, sts);
>> +
>> +    return IRQ_HANDLED;
>> +}
>> +
>> +static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>> +{
>> +    u32 val;
>> +    u8 row_ctrl = SWRM_MAX_ROW_VAL;
>> +    u8 col_ctrl = SWRM_MIN_COL_VAL;
>> +    u8 ssp_period = 1;
>> +    u8 retry_cmd_num = 3;
> 
> probably want a define for those magic values, they are quite important.

Yep, will do that!

> 
>> +
>> +    /* Clear Rows and Cols */
>> +    val = ((row_ctrl << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT) |
>> +        (col_ctrl << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT) |
>> +        (ssp_period << SWRM_MCP_FRAME_CTRL_BANK_SSP_PERIOD_SHFT));
>> +
>> +    ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
>> +
>> +    /* Disable Auto enumeration */
>> +    ctrl->reg_write(ctrl, SWRM_ENUMERATOR_CFG_ADDR, 0);
> 
> This goes back to my earlier comment. Do you disable this 
> auto-enumeration to avoid conflicts with the existing bus management? 
> That's not necessarily smart, we may want to change that bus layer to 
> reduce the enumeration time if hardware can do it.

I will explore add this support in bus befor next version.

> 
>> +
>> +    /* Mask soundwire interrupts */
>> +    ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR,
>> +                    SWRM_INTERRUPT_STATUS_RMSK);
>> +
>> +    /* Configure No pings */
>> +    val = ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR);
> 
> If there is any sort of PREQ signaling for Slave-initiated interrupts, 
> disabling PINGs is likely a non-conformant implementation since the 
> master is required to issue a PING command within 32 frames. That's also 
> the only way to know if a device is attached, so additional comments are 
> likely required.
This is the value of Maximum number of consiecutive read/write commands 
without ping command in between. I will try to collect more details and 
add some comments here.


> 
>> +
>> +    val &= ~SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK;
>> +    val |= (0x1f << SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_SHFT);
>> +    ctrl->reg_write(ctrl, SWRM_MCP_CFG_ADDR, val);
>> +
>> +    /* Configure number of retries of a read/write cmd */
>> +    val = (retry_cmd_num << SWRM_CMD_FIFO_CFG_NUM_OF_CMD_RETRY_SHFT);
>> +    ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR, val);
>> +
>> +    /* Set IRQ to PULSE */
>> +    ctrl->reg_write(ctrl, SWRM_COMP_CFG_ADDR,
>> +                SWRM_COMP_CFG_IRQ_LEVEL_OR_PULSE_MSK |
>> +                SWRM_COMP_CFG_ENABLE_MSK);
> 
> indentation seems off in this code?
>
Yes! I will fix this.

>> +    return 0;
>> +}
>> +
>> +static enum sdw_command_response qcom_swrm_xfer_msg(struct sdw_bus *bus,
>> +                            struct sdw_msg *msg)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>> +    int ret, i, len;
>> +
>> +    if (msg->flags == SDW_MSG_FLAG_READ) {
>> +        for (i = 0; i < msg->len;) {
>> +            if ((msg->len - i) < QCOM_SWRM_MAX_RD_LEN)
>> +                len = msg->len - i;
>> +            else
>> +                len = QCOM_SWRM_MAX_RD_LEN;
>> +
>> +            ret = qcom_swrm_cmd_fifo_rd_cmd(ctrl, msg->dev_num,
>> +                            msg->addr + i, len,
>> +                               &msg->buf[i]);
>> +            if (ret < 0) {
>> +                if (ret == -ENODATA)
>> +                    return SDW_CMD_IGNORED;
>> +
>> +                return ret;
>> +            }
>> +
>> +            i = i + len;
>> +        }
>> +    } else if (msg->flags == SDW_MSG_FLAG_WRITE) {
>> +        for (i = 0; i < msg->len; i++) {
>> +            ret = qcom_swrm_cmd_fifo_wr_cmd(ctrl, msg->buf[i],
>> +                            msg->dev_num,
>> +                               msg->addr + i);
>> +            if (ret < 0) {
>> +                if (ret == -ENODATA)
>> +                    return SDW_CMD_IGNORED;
>> +
>> +                return ret;
>> +            }
>> +        }
>> +    }
>> +
>> +    return SDW_CMD_OK;
>> +}
>> +
>> +static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
>> +{
>> +    u32 reg = SWRM_MCP_FRAME_CTRL_BANK_ADDR(bus->params.next_bank);
>> +    struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>> +    u32 val;
>> +
>> +    val = ctrl->reg_read(ctrl, reg);
>> +    val |= ((0 << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT) |
>> +        (7l << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT));
> 
> magic values, probably need a macro here?
> 
Okay, will add a proper define for this values.

>> +    ctrl->reg_write(ctrl, reg, val);
>> +
>> +    return 0;
>> +}
>> +
> 
>> +static int qcom_swrm_register_dais(struct qcom_swrm_ctrl *ctrl)
>> +{
>> +    int num_dais = ctrl->num_dout_ports + ctrl->num_din_ports;
>> +    struct snd_soc_dai_driver *dais;
>> +    int i;
>> +
>> +    /* PDM dais are only tested for now */
>> +    dais = devm_kcalloc(ctrl->dev, num_dais, sizeof(*dais), GFP_KERNEL);
>> +    if (!dais)
>> +        return -ENOMEM;
>> +
>> +    for (i = 0; i < num_dais; i++) {
>> +        dais[i].name = kasprintf(GFP_KERNEL, "SDW Pin%d", i);
> 
> if (!dais[i].name)
> 
>> +        if (i < ctrl->num_dout_ports) {
>> +            dais[i].playback.stream_name = kasprintf(GFP_KERNEL,
>> +                                 "SDW Tx%d", i);
>> +            if (!dais[i].playback.stream_name) {
>> +                kfree(dais[i].name);
>> +                return -ENOMEM;
>> +            }
> 
> also need to free previously allocated memory in earlier iterations, or 
> use devm_
> 
Yes, thats true, I will fix this in next version.


Thanks,
srini
