Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82217C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA3520840
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhTg194P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfFIMPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:15:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53188 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfFIMPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:15:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so5992272wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=APDvh4+fAVfAZ4nvIjtSUhIQWXNz2fc9L+P5Z53Ax0E=;
        b=KhTg194PjzFiSk6XaXG2O94TGNLbDzKeczx7toe04weJfn72lnG236QCW8huI33NzW
         URTYUgEQudKwiVAi0CZs90qQIEOwff+Q3EGI9qTebo7Wbm1MnzBIjDg4Y4qE9f7P8w2/
         iL9hvnZr8huJlv1Z/CRJtXx0EKj3qDBwqOepufrwGB80M5d5QN+PGJhdgDL6K1K0pN1W
         J6n29PhabaJs/ZCkB1YZtSEG60Be3YG1FrQBRAsr+ba7yjhluIAYnykn7y3suZSOd4bg
         A5PBWCKal9IXH6BHY0B1qnKt1xLPfYpMpmdktwQPjFfIFFlXuiLNeqBXinvp2AWsWRzY
         F8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=APDvh4+fAVfAZ4nvIjtSUhIQWXNz2fc9L+P5Z53Ax0E=;
        b=rbBqCoOiYBCsE1kgnQlJXT0A2bFy8CyogewF0PcrF8QRF6XRJdPI5y564EG085zSaG
         91tiDp/YOE+Ow9NZROxXry5dq57T1rgeQN4Kd/bqX5HzUStuKZ1MTd/CCmgAHICLZPL0
         DbuZgA4xfrq4RaWIkewVpj7vxVDXi98HC1a2FXDZklNvKWtdDD4RkifrKxNYAPqS5nh6
         uM3029QND7jbUwxJXUsKulz+rS3QVJblcdXDG+DXjqtcQrHXqH9P/AndsFK1PjZjC0oA
         uf38lELn5MScGEONPjsGUctyD1EnJNBAbF3ygubjOG/e4m6vVGdA2DMEkG2BBYnHVnRn
         X8WQ==
X-Gm-Message-State: APjAAAXQzNx8RQmFAzVGIV9Os+k9csATtWK0qeuO4GS40bX49io71uwu
        CAnq21Ww+iiST75rdJhclZF8eau0MXJf6g==
X-Google-Smtp-Source: APXvYqwCkSbnVi9snb2663fcUjdQBAwETspRaruifnDWhQkUWlDCTBM6IzgjzXVLQx/XyqexBzhIcQ==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr10231543wmm.96.1560082540820;
        Sun, 09 Jun 2019 05:15:40 -0700 (PDT)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y5sm7682407wrs.63.2019.06.09.05.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 05:15:39 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] soundwire: qcom: add support for SoundWire
 controller
To:     Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org,
        vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-7-srinivas.kandagatla@linaro.org>
 <644c7aec-1844-d19b-4620-9da26020752f@intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6e656981-e141-2831-0732-55f4beca565e@linaro.org>
Date:   Sun, 9 Jun 2019 13:15:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <644c7aec-1844-d19b-4620-9da26020752f@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking time to review,
I agre with most of the comments specially handling returns and making 
code more readable.
Will fix them in next version.

On 08/06/2019 22:53, Cezary Rojewski wrote:
> On 2019-06-07 10:56, Srinivas Kandagatla wrote:
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
>>   drivers/soundwire/Kconfig  |   9 +
>>   drivers/soundwire/Makefile |   4 +
>>   drivers/soundwire/qcom.c   | 983 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 996 insertions(+)
>>   create mode 100644 drivers/soundwire/qcom.c
>>
>> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
>> index 53b55b79c4af..f44d4f36dbbb 100644
>> --- a/drivers/soundwire/Kconfig
>> +++ b/drivers/soundwire/Kconfig
>> @@ -34,4 +34,13 @@ config SOUNDWIRE_INTEL
>>         enable this config option to get the SoundWire support for that
>>         device.
>> +config SOUNDWIRE_QCOM
>> +    tristate "Qualcomm SoundWire Master driver"
>> +    select SOUNDWIRE_BUS
>> +    depends on SND_SOC
>> +    help
>> +      SoundWire Qualcomm Master driver.
>> +      If you have an Qualcomm platform which has a SoundWire Master then
>> +      enable this config option to get the SoundWire support for that
>> +      device
>>   endif
>> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
>> index 5817beaca0e1..f4ebfde31372 100644
>> --- a/drivers/soundwire/Makefile
>> +++ b/drivers/soundwire/Makefile
>> @@ -16,3 +16,7 @@ obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
>>   soundwire-intel-init-objs := intel_init.o
>>   obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel-init.o
>> +
>> +#Qualcomm driver
>> +soundwire-qcom-objs :=    qcom.o
>> +obj-$(CONFIG_SOUNDWIRE_QCOM) += soundwire-qcom.o
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> new file mode 100644
>> index 000000000000..d1722d44d217
>> --- /dev/null
>> +++ b/drivers/soundwire/qcom.c
>> @@ -0,0 +1,983 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2019, Linaro Limited
>> +
>> +#include <linux/clk.h>
>> +#include <linux/completion.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/slimbus.h>
>> +#include <linux/soundwire/sdw.h>
>> +#include <linux/soundwire/sdw_registers.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc.h>
>> +#include "bus.h"
>> +
> 
> Pierre already pointed this out - SWR looks odd. During my time with 
> Soundwire I've met SDW and SNDW, but it's the first time I see SWR.

These names are derived from register names from hw datasheet.
So I have not much choice here other than using them as it. May be 
adding QCOM_ prefix make it bit more non-confusing.
> 
> You seem to shortcut every reg here similarly to how it's done in SDW 
> spec. INTERRUPT is represented by INT there, and by doing so, this 
> define block would look more like a real family.
> 
Will do that in next version.!

>> +#define SWRM_CMD_FIFO_WR_CMD                    0x300
>> +#define SWRM_CMD_FIFO_RD_CMD                    0x304
>> +#define SWRM_CMD_FIFO_CMD                    0x308
>> +#define SWRM_CMD_FIFO_STATUS                    0x30C
>> +#define SWRM_CMD_FIFO_CFG_ADDR                    0x314
>> +#define SWRM_CMD_FIFO_CFG_NUM_OF_CMD_RETRY_SHFT            0x0
>> +#define SWRM_CMD_FIFO_RD_FIFO_ADDR                0x318
>> +#define SWRM_ENUMERATOR_CFG_ADDR                0x500
>> +#define SWRM_MCP_FRAME_CTRL_BANK_ADDR(m)        (0x101C + 0x40 * (m))
>> +#define SWRM_MCP_FRAME_CTRL_BANK_SSP_PERIOD_SHFT        16
>> +#define SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT            3
>> +#define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK            GENMASK(2, 0)
>> +#define SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT            0
>> +#define SWRM_MCP_CFG_ADDR                    0x1048
>> +#define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_BMSK        GENMASK(21, 17)
>> +#define SWRM_MCP_CFG_MAX_NUM_OF_CMD_NO_PINGS_SHFT        0x11
>> +#define SWRM_MCP_STATUS                        0x104C
>> +#define SWRM_MCP_STATUS_BANK_NUM_MASK                BIT(0)
>> +#define SWRM_MCP_SLV_STATUS                    0x1090
>> +#define SWRM_MCP_SLV_STATUS_MASK                GENMASK(1, 0)
>> +#define SWRM_DP_PORT_CTRL_BANK(n, m)    (0x1124 + 0x100 * (n - 1) + 
>> 0x40 * m)
> 
> Some of these you align, others leave with the equal amount of tabs 
> despite different widths.
>
I will take a closer look at such instance before sending next version.

>> +#define SWRM_DP_PORT_CTRL2_BANK(n, m)    (0x1126 + 0x100 * (n - 1) + 
>> 0x40 * m)
> 
> Consider reusing _CTRL_ and simply adding offset for 2_.
Okay.

> 
>> +#define SWRM_DP_PORT_CTRL_EN_CHAN_SHFT                0x18
>> +#define SWRM_DP_PORT_CTRL_OFFSET2_SHFT                0x10
>> +#define SWRM_DP_PORT_CTRL_OFFSET1_SHFT                0x08
>> +#define SWRM_AHB_BRIDGE_WR_DATA_0                0xc885
>> +#define SWRM_AHB_BRIDGE_WR_ADDR_0                0xc889
>> +#define SWRM_AHB_BRIDGE_RD_ADDR_0                0xc88d
>> +#define SWRM_AHB_BRIDGE_RD_DATA_0                0xc891
>> +
>> +#define SWRM_REG_VAL_PACK(data, dev, id, reg)    \
>> +            ((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
>> +
>> +#define SWRM_MAX_ROW_VAL    0 /* Rows = 48 */
>> +#define SWRM_DEFAULT_ROWS    48
>> +#define SWRM_MIN_COL_VAL    0 /* Cols = 2 */
>> +#define SWRM_DEFAULT_COL    16
>> +#define SWRM_SPECIAL_CMD_ID    0xF
>> +#define MAX_FREQ_NUM        1
>> +#define TIMEOUT_MS        1000
>> +#define QCOM_SWRM_MAX_RD_LEN    0xf
>> +#define DEFAULT_CLK_FREQ    9600000
>> +#define SWRM_MAX_DAIS        0xF
> 
> Given the scale of this block, it might be good to reiterate all defines 
> and see if indeed all are QCom specific. Maybe some could be replaced by 
> equivalents from common code.
> 
I did take a look at common defines, however these values are pretty 
much specific to this controller configuration.>> +
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
> 
> Given the fact you don't use version field directly and always shift it, 
> I'd consider making use of union here to listing version bits 
> explicitly. Overall size won't change.
Okay, I tried to keep most of the driver simple as I could as this is 
the first version, I will explore adding union as you suggested.

> 
>> +    int num_din_ports;
>> +    int num_dout_ports;
>> +    unsigned long dout_port_mask;
>> +    unsigned long din_port_mask;
>> +    struct qcom_swrm_port_config pconfig[SDW_MAX_PORTS];
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
>> +
> 
> "usecase" looks ambiguous at best.

Its leftover

> 
>> +static u32 qcom_swrm_slim_reg_read(struct qcom_swrm_ctrl *ctrl, int reg)
>> +{
>> +    struct regmap *wcd_regmap = ctrl->regmap;
>> +    u32 val = 0, ret;
>> +
>> +    /* pg register + offset */
>> +    regmap_bulk_write(wcd_regmap, SWRM_AHB_BRIDGE_RD_ADDR_0,
>> +              (u8 *)&reg, 4);
>> +
>> +    ret = regmap_bulk_read(wcd_regmap, SWRM_AHB_BRIDGE_RD_DATA_0,
>> +                   (u8 *)&val, 4);
>> +    if (ret < 0)
>> +        dev_err(ctrl->dev, "Read Failure (%d)\n", ret);
>> +
>> +    return val;
>> +}
>> +
>> +static u32 qcom_swrm_mmio_reg_read(struct qcom_swrm_ctrl *ctrl, int reg)
>> +{
>> +    return readl_relaxed(ctrl->base + reg);
>> +}
>> +
>> +static int qcom_swrm_mmio_reg_write(struct qcom_swrm_ctrl *ctrl,
>> +                    int reg, int val)
>> +{
>> +    writel_relaxed(val, ctrl->base + reg);
>> +
>> +    return 0;
>> +}
>> +
>> +static int qcom_swrm_slim_reg_write(struct qcom_swrm_ctrl *ctrl,
>> +                    int reg, int val)
>> +{
>> +    struct regmap *wcd_regmap = ctrl->regmap;
>> +
>> +    /* pg register + offset */
>> +    regmap_bulk_write(wcd_regmap, SWRM_AHB_BRIDGE_WR_DATA_0,
>> +              (u8 *)&val, 4);
>> +    /* write address register */
>> +    regmap_bulk_write(wcd_regmap, SWRM_AHB_BRIDGE_WR_ADDR_0,
>> +              (u8 *)&reg, 4);
>> +
>> +    return 0;
>> +}
> 
> Ok, so you choose to declare write op as returning "int" yet either it 
> cannot do so (void writel_relaxed) or ret is completely ignored 
> (regmap_bulk_write does return an int value). Either switch to void or 
> check against returned value whenever possible.
> 

Its right to check the return values, I will change it this accordingly 
and fix all such occurances.

>> +
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
>> +
>> +        if (!ret || ctrl->fifo_status) {
>> +            dev_err(ctrl->dev, "reg 0x%x write failed\n", val);
> 
> Both, this and err msg above are generic enough to be put into goto to 
> save some space.

I agree!

> 
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
>> +
>> +    val = SWRM_REG_VAL_PACK(len, dev_addr, cmd_id, reg_addr);
>> +    ret = ctrl->reg_write(ctrl, SWRM_CMD_FIFO_RD_CMD, val);
>> +    if (ret < 0) {
>> +        dev_err(ctrl->dev, "reg 0x%x write failed err:%d\n", val, ret);
> 
> Same for _rt_.
> 
>> +        goto err;
>> +    }
>> +
>> +    if (dev_addr == SDW_ENUM_DEV_NUM) {
>> +        ctrl->fifo_status = 0;
>> +        ret = wait_for_completion_timeout(&ctrl->sp_cmd_comp,
>> +                          msecs_to_jiffies(TIMEOUT_MS));
>> +
>> +        if (!ret || ctrl->fifo_status) {
>> +            dev_err(ctrl->dev, "reg 0x%x read failed\n", val);
> 
> Just to be sure. It is really "read" that is failing here?
>
The final result is that read has not been sucessfull with a complete 
interrupt. So yes read is failing here.


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
> If you do not handle these errors at all, consider declaring 
> ERROR-message table. I believe leaving erroneus status as is may lead to 
> fatal consequences. If there is no intention for handling even the most 
> critical cases, please add TODO/ comment here.

Yep, I agree will clean this up!

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
>> +
>> +    /* Mask soundwire interrupts */
>> +    ctrl->reg_write(ctrl, SWRM_INTERRUPT_MASK_ADDR,
>> +                    SWRM_INTERRUPT_STATUS_RMSK);
>> +
>> +    /* Configure No pings */
>> +    val = ctrl->reg_read(ctrl, SWRM_MCP_CFG_ADDR);
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
>> +    return 0;
> 
> As in my previous comment, you should check against ret from reg_write 
> if void approach is not chosen.

I agree!

> 
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
> 
> Any reason for inlining this incrementation? If _rd_ fails, we leave the 
> loop anyway.
> 
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
>> +    ctrl->reg_write(ctrl, reg, val);
>> +
>> +    return 0;
> 
> s/return 0/return ctrl->reg_write(ctrl, reg, val)/
> 
>> +}
>> +
>> +static int qcom_swrm_port_params(struct sdw_bus *bus,
>> +                 struct sdw_port_params *p_params,
>> +                unsigned int bank)
>> +{
>> +    /* TBD */
>> +    return 0;
>> +}
>> +
>> +static int qcom_swrm_transport_params(struct sdw_bus *bus,
>> +                      struct sdw_transport_params *params,
>> +                     enum sdw_reg_bank bank)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>> +    u32 value;
>> +
>> +    value = params->offset1 << SWRM_DP_PORT_CTRL_OFFSET1_SHFT;
>> +    value |= params->offset2 << SWRM_DP_PORT_CTRL_OFFSET2_SHFT;
>> +    value |= params->sample_interval - 1;
>> +
>> +    ctrl->reg_write(ctrl, SWRM_DP_PORT_CTRL_BANK((params->port_num), 
>> bank),
>> +            value);
>> +
>> +    return 0;
> 
> Another "return issue" here.
> 
>> +}
>> +
>> +static int qcom_swrm_port_enable(struct sdw_bus *bus,
>> +                 struct sdw_enable_ch *enable_ch,
>> +                unsigned int bank)
>> +{
>> +    u32 reg = SWRM_DP_PORT_CTRL_BANK(enable_ch->port_num, bank);
>> +    struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>> +    u32 val;
>> +
>> +    val = ctrl->reg_read(ctrl, reg);
>> +    if (enable_ch->enable)
>> +        val |= (enable_ch->ch_mask << SWRM_DP_PORT_CTRL_EN_CHAN_SHFT);
>> +    else
>> +        val &= ~(enable_ch->ch_mask << SWRM_DP_PORT_CTRL_EN_CHAN_SHFT);
>> +
>> +    ctrl->reg_write(ctrl, reg, val);
>> +
>> +    return 0;
>> +}
>> +
>> +static struct sdw_master_port_ops qcom_swrm_port_ops = {
>> +    .dpn_set_port_params = qcom_swrm_port_params,
>> +    .dpn_set_port_transport_params = qcom_swrm_transport_params,
>> +    .dpn_port_enable_ch = qcom_swrm_port_enable,
>> +};
>> +
>> +static struct sdw_master_ops qcom_swrm_ops = {
>> +    .xfer_msg = qcom_swrm_xfer_msg,
>> +    .pre_bank_switch = qcom_swrm_pre_bank_switch,
>> +};
>> +
>> +static int qcom_swrm_compute_params(struct sdw_bus *bus)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>> +    struct sdw_master_runtime *m_rt;
>> +    struct sdw_slave_runtime *s_rt;
>> +    struct sdw_port_runtime *p_rt;
>> +    int i = 0;
>> +
>> +    list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
>> +        list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
>> +            p_rt->transport_params.port_num = p_rt->num;
>> +            p_rt->transport_params.sample_interval =
>> +                    ctrl->pconfig[p_rt->num - 1].si + 1;
>> +            p_rt->transport_params.offset1 =
>> +                    ctrl->pconfig[p_rt->num - 1].off1;
>> +            p_rt->transport_params.offset2 =
>> +                    ctrl->pconfig[p_rt->num - 1].off2;
> 
> ctrl->pconfig[ <idx> ] colleagues bellow make use of local index 
> variable which clearly makes it more readable.
> 
>> +        }
>> +
>> +        list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
>> +            list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>> +                p_rt->transport_params.port_num = p_rt->num;
>> +                p_rt->transport_params.sample_interval =
>> +                        ctrl->pconfig[i].si + 1;
>> +                p_rt->transport_params.offset1 =
>> +                        ctrl->pconfig[i].off1;
>> +                p_rt->transport_params.offset2 =
>> +                        ctrl->pconfig[i].off2;
>> +                i++;
>> +            }
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static u32 qcom_swrm_freq_tbl[MAX_FREQ_NUM] = {
>> +    DEFAULT_CLK_FREQ,
>> +};
>> +
>> +static void qcom_swrm_slave_wq(struct work_struct *work)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl =
>> +            container_of(work, struct qcom_swrm_ctrl, slave_work);
>> +
>> +    qcom_swrm_get_device_status(ctrl);
>> +    sdw_handle_slave_status(&ctrl->bus, ctrl->status);
>> +}
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
>> +}
>> +
>> +static void qcom_swrm_stream_free_ports(struct qcom_swrm_ctrl *ctrl,
>> +                    struct sdw_stream_runtime *stream)
>> +{
>> +    struct sdw_master_runtime *m_rt;
>> +    struct sdw_port_runtime *p_rt;
>> +    unsigned long *port_mask;
>> +
>> +    mutex_lock(&ctrl->port_lock);
>> +
>> +    list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>> +        if (m_rt->direction == SDW_DATA_DIR_RX)
>> +            port_mask = &ctrl->dout_port_mask;
>> +        else
>> +            port_mask = &ctrl->din_port_mask;
>> +
>> +        list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
>> +            clear_bit(p_rt->num - 1, port_mask);
>> +        }
> 
> Unnecessary brackets.
> 
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
>> +    struct sdw_port_config pconfig[SDW_MAX_PORTS];
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
> Hmm. frame_rate and type gets assigned based on "input" data yet the 
> rest is hardcoded. Is this intended?

For now I only managed to test PDM on this controller, and I agree these 
need to be more generic..
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
>> +static int qcom_swrm_hw_params(struct snd_pcm_substream *substream,
>> +                   struct snd_pcm_hw_params *params,
>> +                  struct snd_soc_dai *dai)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>> +    int ret;
>> +
>> +    ret = qcom_swrm_stream_alloc_ports(ctrl, ctrl->sruntime[dai->id],
>> +                       params, substream->stream);
>> +    if (ret)
>> +        return ret;
>> +
>> +    return sdw_prepare_stream(ctrl->sruntime[dai->id]);
>> +}
>> +
>> +static int qcom_swrm_hw_free(struct snd_pcm_substream *substream,
>> +                 struct snd_soc_dai *dai)
>> +{
>> +    struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(dai->dev);
>> +
>> +    qcom_swrm_stream_free_ports(ctrl, ctrl->sruntime[dai->id]);
>> +    sdw_stream_remove_master(&ctrl->bus, ctrl->sruntime[dai->id]);
>> +    sdw_deprepare_stream(ctrl->sruntime[dai->id]);
>> +    sdw_disable_stream(ctrl->sruntime[dai->id]);
> 
> Declaring local variable initialized with ctrl->sruntime[dai->id] should 
> prove more readable.
> 
I agree!

>> +
>> +    return 0;
>> +}
>> +
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
>> +        if (i < ctrl->num_dout_ports) {
>> +            dais[i].playback.stream_name = kasprintf(GFP_KERNEL,
>> +                                 "SDW Tx%d", i);
>> +            if (!dais[i].playback.stream_name) {
>> +                kfree(dais[i].name);
>> +                return -ENOMEM;
> 
> Now this got me worried. What about memory allocated in iterations 
> before the failure? It must be freed in error handling path. goto should 
> be of help here.
> 
I agree.

>> +            }
>> +            dais[i].playback.channels_min = 1;
>> +            dais[i].playback.channels_max = 1;
>> +            dais[i].playback.rates = SNDRV_PCM_RATE_48000;
>> +            dais[i].playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
> 
> All of these formats are hardcoded. Consider declaring a "template" 
> format above and simply initialize each dai with it.

Okay!

> 
>> +        } else {
>> +            dais[i].capture.stream_name = kasprintf(GFP_KERNEL,
>> +                                "SDW Rx%d", i);
>> +            if (!dais[i].capture.stream_name) {
>> +                kfree(dais[i].name);
>> +                kfree(dais[i].playback.stream_name);
>> +                return -ENOMEM;
> 
> Same memory deallocation issue here.
I see that, I will take care of this in next version.
> 
>> +            }
>> +
>> +            dais[i].capture.channels_min = 1;
>> +            dais[i].capture.channels_max = 1;
>> +            dais[i].capture.rates = SNDRV_PCM_RATE_48000;
>> +            dais[i].capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
> 
> Comment regarding playback dai initialization applies here too.
> 
>> +        }
>> +        dais[i].ops = &qcom_swrm_pdm_dai_ops;
>> +        dais[i].id = i;
>> +    }
>> +
>> +    return devm_snd_soc_register_component(ctrl->dev,
>> +                        &qcom_swrm_dai_component,
>> +                        dais, num_dais);
>> +}
>> +
>> +static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>> +{
>> +    struct device_node *np = ctrl->dev->of_node;
>> +    u8 off1[SDW_MAX_PORTS];
>> +    u8 off2[SDW_MAX_PORTS];
>> +    u8 si[SDW_MAX_PORTS];
> 
> Array of struct qcom_swrm_port_config instead of this trio?
> 
Makes sense! Will do that in next version.
>> +    int i, ret, nports, val;
>> +
>> +    val = ctrl->reg_read(ctrl, SWRM_COMP_PARAMS);
>> +    ctrl->num_dout_ports = val & SWRM_COMP_PARAMS_DOUT_PORTS_MASK;
>> +    ctrl->num_din_ports = (val & SWRM_COMP_PARAMS_DIN_PORTS_MASK) >> 5;
>> +
>> +    ret = of_property_read_u32(np, "qcom,din-ports", &val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (val > ctrl->num_din_ports)
>> +        return -EINVAL;
>> +
>> +    ctrl->num_din_ports = val;
>> +
>> +    ret = of_property_read_u32(np, "qcom,dout-ports", &val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (val > ctrl->num_dout_ports)
>> +        return -EINVAL;
>> +
>> +    ctrl->num_dout_ports = val;
>> +
>> +    nports = ctrl->num_dout_ports + ctrl->num_din_ports;
>> +
>> +    ret = of_property_read_u8_array(np, "qcom,ports-offset1",
>> +                    off1, nports);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = of_property_read_u8_array(np, "qcom,ports-offset2",
>> +                    off2, nports);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = of_property_read_u8_array(np, "qcom,ports-sinterval-low",
>> +                    si, nports);
>> +    if (ret)
>> +        return ret;
>> +
>> +    for (i = 0; i < nports; i++) {
>> +        ctrl->pconfig[i].si = si[i];
>> +        ctrl->pconfig[i].off1 = off1[i];
>> +        ctrl->pconfig[i].off2 = off2[i];
>> +    }
> 
> Using array I spoke of earlier leads to brackets being redundant here.
> 
>> +
>> +    return 0;
>> +}
>> +
