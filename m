Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8098FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1C02081B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAc2a7jR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404611AbfIFJhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:37:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46262 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404584AbfIFJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:37:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so5827515wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 02:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gHQvGo2oHSAi0l4hj3JH6Y+XbDhT95DFxyzr46YUgC0=;
        b=NAc2a7jRTkb41+7GcrFFCTtk//51mt4fZSMi2okYkU/RL7BN7Kehl9G8057rRtItPo
         M0d9ShHgo0VHZn3JStaBU1eXpu4pxvy1NbXPVpJqpYp0+s0jaJf3GezIDmCKboV4oSzw
         cqyEoJoyazb6wtmNhxC3D+aA+5YpMH8ijW6xQKuWgzSrnOD6sJFFaGYLCwVDKXs2NAPQ
         +itDTYVhRm1NpBen9LUxpTPFoEVez0CXXQmAABmaHLrqwc3UFxa+XGjO3zDIj1o5on27
         40+JhXnMzVKhjHENBCRefZjBmWNH7xBfUQIpb3i4Em9x3+DLcBt7ho2yqhtzmKUDT/0u
         Rqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gHQvGo2oHSAi0l4hj3JH6Y+XbDhT95DFxyzr46YUgC0=;
        b=IHm1UYtQYFfzvq+CbsvliQynbzErnOcXFD4mEcn3DbMraWBa9FN1b0xtPbH37YMPPQ
         wnCtf5sDW1RCd3LWjY12ZHUa0HaJx1sjUGTEya4S/gaQG67iwbL4YDGsWEItnm583AKB
         WVHIaLT5IiPAfWnyzANyKzTn63qKRqIezlDVlAe/HxcRCNJAsfOnQwcvMtzE/p50WimF
         0dp41pV8YRXAPSbPHv/Plymytrw8HQAIoJTJn2GGIApSl8jyuiwS73LHOebAPMOG1AWj
         +cv87JNZJEOD4+faI0GQckCZp2W+5GDAc2cT0tVmc++D18S1DKQP/NeJCvg4Q7efCYK5
         11yQ==
X-Gm-Message-State: APjAAAVwOZgt+2sqv1teokL0yUCuGGBMv+NaCBPNfadijZAY5e1FOxF3
        pRnt5szcHKiKzZKZURM+orqd4A==
X-Google-Smtp-Source: APXvYqw1zQx7D1rB9iMcWVLhI+wsFFMTYX3kk0oDtXEiRAW+K08F0IAMcTRcUFhriIoveu69KGo66w==
X-Received: by 2002:adf:f709:: with SMTP id r9mr6734946wrp.228.1567762666819;
        Fri, 06 Sep 2019 02:37:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h125sm7238999wmf.31.2019.09.06.02.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 02:37:45 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmem: imx: scu: support write
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
References: <1566356496-30493-1-git-send-email-peng.fan@nxp.com>
 <1566356496-30493-2-git-send-email-peng.fan@nxp.com>
 <AM0PR04MB448144701DB63A3C9F05B3E488BA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <dd82e84d-ab22-9dd9-f895-776570f46fee@linaro.org>
Date:   Fri, 6 Sep 2019 10:37:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB448144701DB63A3C9F05B3E488BA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2019 07:57, Peng Fan wrote:
>> Subject: [PATCH 2/2] nvmem: imx: scu: support write
> 
> Ping..
> 
Thanks for your patience!
I normally do not take patches after rc5 for nvmem.
These will be applied after rc1 is released!

Thanks,
srini
> Thanks,
> Peng.
> 
>>
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> The fuse programming from non-secure world is blocked, so we could only use
>> Arm Trusted Firmware SIP call to let ATF program fuse.
>>
>> Because there is ECC region that could only be programmed once, so add a
>> heler in_ecc to check the ecc region.
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>
>> The ATF patch will soon be posted to ATF community.
>>
>>   drivers/nvmem/imx-ocotp-scu.c | 73
>> ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 72 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
>> index 2f339d7432e6..0f064f2e74a8 100644
>> --- a/drivers/nvmem/imx-ocotp-scu.c
>> +++ b/drivers/nvmem/imx-ocotp-scu.c
>> @@ -7,6 +7,7 @@
>>    * Peng Fan <peng.fan@nxp.com>
>>    */
>>
>> +#include <linux/arm-smccc.h>
>>   #include <linux/firmware/imx/sci.h>
>>   #include <linux/module.h>
>>   #include <linux/nvmem-provider.h>
>> @@ -14,6 +15,9 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>
>> +#define IMX_SIP_OTP			0xC200000A
>> +#define IMX_SIP_OTP_WRITE		0x2
>> +
>>   enum ocotp_devtype {
>>   	IMX8QXP,
>>   };
>> @@ -45,6 +49,8 @@ struct imx_sc_msg_misc_fuse_read {
>>   	u32 word;
>>   } __packed;
>>
>> +static DEFINE_MUTEX(scu_ocotp_mutex);
>> +
>>   static struct ocotp_devtype_data imx8qxp_data = {
>>   	.devtype = IMX8QXP,
>>   	.nregs = 800,
>> @@ -73,6 +79,23 @@ static bool in_hole(void *context, u32 index)
>>   	return false;
>>   }
>>
>> +static bool in_ecc(void *context, u32 index) {
>> +	struct ocotp_priv *priv = context;
>> +	const struct ocotp_devtype_data *data = priv->data;
>> +	int i;
>> +
>> +	for (i = 0; i < data->num_region; i++) {
>> +		if (data->region[i].flag & ECC_REGION) {
>> +			if ((index >= data->region[i].start) &&
>> +			    (index <= data->region[i].end))
>> +				return true;
>> +		}
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
>>   				     u32 *val)
>>   {
>> @@ -116,6 +139,8 @@ static int imx_scu_ocotp_read(void *context,
>> unsigned int offset,
>>   	if (!p)
>>   		return -ENOMEM;
>>
>> +	mutex_lock(&scu_ocotp_mutex);
>> +
>>   	buf = p;
>>
>>   	for (i = index; i < (index + count); i++) { @@ -126,6 +151,7 @@ static int
>> imx_scu_ocotp_read(void *context, unsigned int offset,
>>
>>   		ret = imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, i, buf);
>>   		if (ret) {
>> +			mutex_unlock(&scu_ocotp_mutex);
>>   			kfree(p);
>>   			return ret;
>>   		}
>> @@ -134,18 +160,63 @@ static int imx_scu_ocotp_read(void *context,
>> unsigned int offset,
>>
>>   	memcpy(val, (u8 *)p + offset % 4, bytes);
>>
>> +	mutex_unlock(&scu_ocotp_mutex);
>> +
>>   	kfree(p);
>>
>>   	return 0;
>>   }
>>
>> +static int imx_scu_ocotp_write(void *context, unsigned int offset,
>> +			       void *val, size_t bytes)
>> +{
>> +	struct ocotp_priv *priv = context;
>> +	struct arm_smccc_res res;
>> +	u32 *buf = val;
>> +	u32 tmp;
>> +	u32 index;
>> +	int ret;
>> +
>> +	/* allow only writing one complete OTP word at a time */
>> +	if ((bytes != 4) || (offset % 4))
>> +		return -EINVAL;
>> +
>> +	index = offset >> 2;
>> +
>> +	if (in_hole(context, index))
>> +		return -EINVAL;
>> +
>> +	if (in_ecc(context, index)) {
>> +		pr_warn("ECC region, only program once\n");
>> +		mutex_lock(&scu_ocotp_mutex);
>> +		ret = imx_sc_misc_otp_fuse_read(priv->nvmem_ipc, index, &tmp);
>> +		mutex_unlock(&scu_ocotp_mutex);
>> +		if (ret)
>> +			return ret;
>> +		if (tmp) {
>> +			pr_warn("ECC region, already has value: %x\n", tmp);
>> +			return -EIO;
>> +		}
>> +	}
>> +
>> +	mutex_lock(&scu_ocotp_mutex);
>> +
>> +	arm_smccc_smc(IMX_SIP_OTP, IMX_SIP_OTP_WRITE, index, *buf,
>> +		      0, 0, 0, 0, &res);
>> +
>> +	mutex_unlock(&scu_ocotp_mutex);
>> +
>> +	return res.a0;
>> +}
>> +
>>   static struct nvmem_config imx_scu_ocotp_nvmem_config = {
>>   	.name = "imx-scu-ocotp",
>> -	.read_only = true,
>> +	.read_only = false,
>>   	.word_size = 4,
>>   	.stride = 1,
>>   	.owner = THIS_MODULE,
>>   	.reg_read = imx_scu_ocotp_read,
>> +	.reg_write = imx_scu_ocotp_write,
>>   };
>>
>>   static const struct of_device_id imx_scu_ocotp_dt_ids[] = {
>> --
>> 2.16.4
> 
