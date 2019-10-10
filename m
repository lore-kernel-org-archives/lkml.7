Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A83C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CD7208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 07:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OqFo+pmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbfJJHmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 03:42:06 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34839 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733161AbfJJHmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:42:05 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191010074200epoutp04da869461b1ec0cc967f97e3de1f264cf~MOUDiUEfc2646426464epoutp04T
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 07:42:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191010074200epoutp04da869461b1ec0cc967f97e3de1f264cf~MOUDiUEfc2646426464epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570693320;
        bh=JJafoigNHyzGNbFoO5/U4MRcgYqsEW0g7//RCZY9ElI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OqFo+pmqmwxMHvOlcR5/wD93jDxXer1FCdB7rJUqndzd6YkiYYAmo6bOmgWN7u+bc
         Vn7BnjjwlCPxSZv130bPv2s4EQHQ1Cv46A5mAn3BCkECYgt9NypxHloUMmwsH/6FJc
         PfmcgzlJ1qBHc7EKYj8i1jS3QMYhOx2Pk7tqh4qU=
Received: from epsnrtp6.localdomain (unknown [182.195.42.167]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191010074200epcas1p36e28c60b3c967a944eb41c3be8d74aac~MOUDS6E-I3118531185epcas1p3c;
        Thu, 10 Oct 2019 07:42:00 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp6.localdomain (Postfix) with ESMTP id 46pjhj47v2zMqYkn; Thu, 10 Oct
        2019 07:41:57 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.6D.04085.2C0EE9D5; Thu, 10 Oct 2019 16:41:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191010074154epcas1p19e777f0088d3d8e80ac1a281fae9badf~MOT9VXo_H1458814588epcas1p1f;
        Thu, 10 Oct 2019 07:41:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191010074154epsmtrp19b8659f420fc850fedb8c6d530f6bcd6~MOT9UVgpm1862318623epsmtrp1i;
        Thu, 10 Oct 2019 07:41:54 +0000 (GMT)
X-AuditID: b6c32a37-e31ff70000000ff5-b7-5d9ee0c27ee0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.D4.04081.2C0EE9D5; Thu, 10 Oct 2019 16:41:54 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191010074154epsmtip2baf558fb4970e61c6a3766acb7c878ad~MOT9Kv_iz2052420524epsmtip2S;
        Thu, 10 Oct 2019 07:41:54 +0000 (GMT)
Subject: Re: [PATCH] extcon: sm5502: Clear pending interrupts during
 initialization
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     Stephan Gerhold <stephan@gerhold.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <a4e6c33d-b715-34af-67c7-f9a3afc21e05@samsung.com>
Date:   Thu, 10 Oct 2019 16:46:56 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <328ccd73-2ceb-2e3f-524c-3fd950ccbf09@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTURjGObvb7RqtTkvzdVltVwwU/Lht0xmpRSGDjKwMRFh608sm7svd
        LdKKZoWp9GX9Uc35gaHUiEpRs6JmU8oRhVCBFJaRZBao9P0h0a63yP9+POd5zvu+57wUoagm
        lVSZzcU5bayFJhdKewcSkpKCY83G1OmZFP2TWz5S/6L6EqkfadJuIAw1rdmGk91+ZPjUtSqP
        KCxfb+bYUs6p4mwl9tIymymT3rKzaFORLi2VSWIy9Om0ysZauUx6c25eUk6ZJVyGVu1lLe6w
        lMfyPJ2Std5pd7s4ldnOuzJpzlFqcWQ4knnWyrttpuQSu3Udk5q6Vhc2FpebzzwaJhyHmX3t
        0x1SDzoaX48iKMBa8EzdQfVoIaXAfQiezgYI4UCBPyLwDxWL/BXBzDnlv8CZnk6ZGLiD4MPl
        KxLRNI1gojlS4GV4F/z8NiIVmMSJEHg3QtYjiorE+dAzoBVkAqvg58sumcBLsBqefX+DBJbj
        LPjdHZrTpTgeftzzIyEahQvg4RdWtCyF0IXxudsjcDZMDF+ViVdGw/PxFonIq+FITyMhtAm4
        n4S7DZ0LxP43w8vZDqnIy+D9g+6/uhImT9X85f1wOTRIiuFaBN2BYZl4oIFA+1mJ0BCBE+Da
        rRRRVsPNX01ILLwYpr4clwkWwHKorVGIljh4MjYqETkGLh6rI08j2jtvHO+8EbzzRvD+L9aK
        pH60nHPwVhPHMw7N/J/uQnPrl5jeh64/zg0iTCF6kdwcajIqZOxevtIaREARdKS8zeszKuSl
        bGUV57QXOd0Wjg8iXfixGwhlVIk9vMw2VxGjW6vRaPRaJk3HMHS03GDyGBXYxLq4co5zcM5/
        OQkVofQg3+dDgwXqwa27NTlD7uPTHKGVRfoLKl6pM781uPOHVsQoPWSdrPNEqKVwm204eVTT
        v3LP9huF9Tleg29NcZu/SvOsMCGobrdc7T994H4FOjtqjO3Jdb0ld+9YdMizuvn8pYOtMeMe
        Jx2j2BiIix3vfT25o/JrY/pt3z5th6lllpbyZpZJJJw8+wfKT6ZllAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsWy7bCSvO6hB/NiDW7v4bS4vGsOm8XtxhVs
        Fjfmmjgwe7QtsPfo27KK0ePzJrkA5igum5TUnMyy1CJ9uwSujElnLzAXNBlWLH2/jKWBsUW1
        i5GTQ0LARGLS1o2sXYxcHEICuxkljqycyAaRkJSYdvEocxcjB5AtLHH4cDFEzVtGiTP3XjKC
        1AgLhEr8+n6DBcRmE9CS2P/iBliviECIxLVTC5lBbGYBBYlf9zaxgthCAocYJbZ/5ASx+QUU
        Ja7+eAw2h1fATuLflpNgNSwCqhI/D64Ci4sKREg8334DqkZQ4uTMJ2C7OAXsJZ5fWMcKMV9d
        4s+8S1C7xCVuPZnPBGHLSzRvnc08gVF4FpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAsO8
        1HK94sTc4tK8dL3k/NxNjOBo0NLcwXh5SfwhRgEORiUe3oyTc2OFWBPLiitzgZ7kYFYS4V00
        a06sEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NTC1KLYLJMHJxSDYxOf5uk
        A5Zf+c2reHvmmWUx0zhks1fVOe1xizCzjZmxo+5lcu6z7oMzv96/zrrivn5Q7e0izuchtp93
        Xb5x2+ngG28zjrJPk9VLjwkW/W+ZsE3lbtrK/x+dfcSc8y/kfLr2We7EQkblPUZyO4tuur0L
        LZmu7nbEi+/UlVl+Yt8OeNg7hl45Y7FMiaU4I9FQi7moOBEAY8X7+YICAAA=
X-CMS-MailID: 20191010074154epcas1p19e777f0088d3d8e80ac1a281fae9badf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191008105726epcas3p178e8421ce5062b6955475199efa130e1
References: <CGME20191008105726epcas3p178e8421ce5062b6955475199efa130e1@epcas3p1.samsung.com>
        <20191008105434.119346-1-stephan@gerhold.net>
        <328ccd73-2ceb-2e3f-524c-3fd950ccbf09@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 10. 10. 오후 4:33, Chanwoo Choi wrote:
> On 19. 10. 8. 오후 7:54, Stephan Gerhold wrote:
>> On some devices (e.g. Samsung Galaxy A5 (2015)), the bootloader
>> seems to keep interrupts enabled for SM5502 when booting Linux.
>> Changing the cable state (i.e. plugging in a cable) - until the driver
>> is loaded - will therefore produce an interrupt that is never read.
>>
>> In this situation, the cable state will be stuck forever on the
>> initial state because SM5502 stops sending interrupts.
>> This can be avoided by clearing those pending interrupts after
>> the driver has been loaded.
>>
>> Reading the interrupt status registers twice seems to be sufficient
>> to make interrupts work in this situation.
>>
>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>> ---
>> This makes interrupts work on the Samsung Galaxy A5 (2015), which
>> has recently gained mainline support [1].
>>
>> I was not able to find a datasheet for SM5502, so this patch is
>> merely based on testing and comparison with the downstream driver [2].
>>
>> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1329c1ab0730b521e6cd3051c56a2ff3d55f21e6
>> [2]: https://protect2.fireeye.com/url?k=029d0042-5ffa4464-029c8b0d-0cc47a31384a-14ac0bce09798d1f&u=https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/SM-A500FU/drivers/misc/sm5502.c#L1566-L1578
>> ---
>>  drivers/extcon/extcon-sm5502.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
>> index dc43847ad2b0..c897f1aa4bf5 100644
>> --- a/drivers/extcon/extcon-sm5502.c
>> +++ b/drivers/extcon/extcon-sm5502.c
>> @@ -539,6 +539,12 @@ static void sm5502_init_dev_type(struct sm5502_muic_info *info)
>>  			val = info->reg_data[i].val;
>>  		regmap_write(info->regmap, info->reg_data[i].reg, val);
>>  	}
>> +
>> +	/* Clear pending interrupts */
>> +	regmap_read(info->regmap, SM5502_REG_INT1, &reg_data);
>> +	regmap_read(info->regmap, SM5502_REG_INT2, &reg_data);
>> +	regmap_read(info->regmap, SM5502_REG_INT1, &reg_data);
>> +	regmap_read(info->regmap, SM5502_REG_INT2, &reg_data);
> 
> It is not proper. Instead, initialize the SM5502_RET_INT1/2 with zero.
> 
> The reset value of SM5502_RET_INT1/2 are zero (0x00) as following:
> If you can test it with h/w, please try to test it and then
> send the modified patch. 
> 
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index c897f1aa4bf5..e168f77a18ba 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -68,6 +68,14 @@ static struct reg_data sm5502_reg_data[] = {
>                 .reg = SM5502_REG_CONTROL,
>                 .val = SM5502_REG_CONTROL_MASK_INT_MASK,
>                 .invert = false,
> +       }, {
> +               .reg = SM5502_REG_INT1,
> +               .val = SM5502_RET_INT1_MASK,
> +               .invert = true,
> +       }, {
> +               .reg = SM5502_REG_INT2,
> +               .val = SM5502_RET_INT1_MASK,
> +               .invert = true,
>         }, {
>                 .reg = SM5502_REG_INTMASK1,
>                 .val = SM5502_REG_INTM1_KP_MASK
> diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
> index 9dbb634d213b..5c4edb3e7fce 100644
> --- a/drivers/extcon/extcon-sm5502.h
> +++ b/drivers/extcon/extcon-sm5502.h
> @@ -93,6 +93,8 @@ enum sm5502_reg {
>  #define SM5502_REG_CONTROL_RAW_DATA_MASK       (0x1 << SM5502_REG_CONTROL_RAW_DATA_SHIFT)
>  #define SM5502_REG_CONTROL_SW_OPEN_MASK                (0x1 << SM5502_REG_CONTROL_SW_OPEN_SHIFT)
>  
> +#define SM5502_RET_INT1_MASK                   (0xff)
> +
>  #define SM5502_REG_INTM1_ATTACH_SHIFT          0
>  #define SM5502_REG_INTM1_DETACH_SHIFT          1
>  #define SM5502_REG_INTM1_KP_SHIFT              2
> 
>>  }
>>  
>>  static int sm5022_muic_i2c_probe(struct i2c_client *i2c,
>>
> 
> 

When write 0x1 to SM5502_REG_RESET, reset the device.
So, you can reset the all registers by writing 1 to SM5502_REG_RESET as following:


diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index c897f1aa4bf5..96a578d2533a 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -65,9 +65,22 @@ struct sm5502_muic_info {
 /* Default value of SM5502 register to bring up MUIC device. */
 static struct reg_data sm5502_reg_data[] = {
        {
+       {
+               .reg = SM5502_REG_RESET,
+               .val = SM5502_REG_RESET_MASK,
+               .invert = true,
+       }, {
                .reg = SM5502_REG_CONTROL,
                .val = SM5502_REG_CONTROL_MASK_INT_MASK,
                .invert = false,
+       }, {
+               .reg = SM5502_REG_INT1,
+               .val = SM5502_REG_INT1_MASK,
+               .invert = true,
+       }, {
+               .reg = SM5502_REG_INT2,
+               .val = SM5502_REG_INT1_MASK,
+               .invert = true,
        }, {
                .reg = SM5502_REG_INTMASK1,
                .val = SM5502_REG_INTM1_KP_MASK
diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
index 9dbb634d213b..2db62e093ef3 100644
--- a/drivers/extcon/extcon-sm5502.h
+++ b/drivers/extcon/extcon-sm5502.h
@@ -93,6 +93,8 @@ enum sm5502_reg {
 #define SM5502_REG_CONTROL_RAW_DATA_MASK       (0x1 << SM5502_REG_CONTROL_RAW_DATA_SHIFT)
 #define SM5502_REG_CONTROL_SW_OPEN_MASK                (0x1 << SM5502_REG_CONTROL_SW_OPEN_SHIFT)
 
+#define SM5502_REG_INT1_MASK                   (0xff)
+
 #define SM5502_REG_INTM1_ATTACH_SHIFT          0
 #define SM5502_REG_INTM1_DETACH_SHIFT          1
 #define SM5502_REG_INTM1_KP_SHIFT              2
@@ -237,6 +239,8 @@ enum sm5502_reg {
 #define DM_DP_SWITCH_UART                      ((DM_DP_CON_SWITCH_UART <<SM5502_REG_MANUAL_SW1_DP_SHIFT) \
                                                | (DM_DP_CON_SWITCH_UART <<SM5502_REG_MANUAL_SW1_DM_SHIFT))
 
+#define SM5502_RER_RESET_MASK                  (0x1)
+
 /* SM5502 Interrupts */
 enum sm5502_irq {
        /* INT1 */





-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
