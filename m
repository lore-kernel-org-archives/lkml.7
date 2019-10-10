Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFD4218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dYoKO/oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfJJKY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:24:26 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22131 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfJJKY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:24:26 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191010102423epoutp0199c72184c1f3418d2c3b4d3e1a4fd0e6~MQh1EOpp20678006780epoutp01H
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:24:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191010102423epoutp0199c72184c1f3418d2c3b4d3e1a4fd0e6~MQh1EOpp20678006780epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1570703063;
        bh=fSsgHl4LjFCs5SPryzUXTHierABWkXvOT8LCc8Mq6p8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dYoKO/oymjKhoEBCvH3RqODSoG1vB55wWu+587rkEZBXPscy9uohulVDGmToc4n0J
         Zp1eDp0Y9o4wRPcWiq28MgHvWosiDPcAfBgQQp1SGT0ZKbt4UVdHi3UDf+UaQVmuwt
         SFwnvv+DNsg4WtmPsmJ2SrQXHgclOfPCEnQBJavA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191010102423epcas1p47525166618ef089b3b4636a86abcfcb7~MQh0uerA20530505305epcas1p4Z;
        Thu, 10 Oct 2019 10:24:23 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46pnJ42cwMzMqYkc; Thu, 10 Oct
        2019 10:24:20 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.2E.04068.3D60F9D5; Thu, 10 Oct 2019 19:24:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191010102418epcas1p2158808496b2ed2fb8a1efed928dcb540~MQhwxxkZ50880608806epcas1p2G;
        Thu, 10 Oct 2019 10:24:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191010102418epsmtrp19905dfb08d2a0a20304a427174510ea0~MQhwxJ8nR0868808688epsmtrp1T;
        Thu, 10 Oct 2019 10:24:18 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-9f-5d9f06d3b017
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.12.04081.2D60F9D5; Thu, 10 Oct 2019 19:24:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191010102418epsmtip1e8ac75a49a513505ca30d9743308fb26~MQhwp1gPN2289622896epsmtip1N;
        Thu, 10 Oct 2019 10:24:18 +0000 (GMT)
Subject: Re: [PATCH] extcon: sm5502: Clear pending interrupts during
 initialization
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a363a1ee-59ed-bc9b-1f33-d29af0613dac@samsung.com>
Date:   Thu, 10 Oct 2019 19:29:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010101509.GA122066@gerhold.net>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTV/cy2/xYg21zpC0u75rDZnG7cQWb
        xY25Jg7MHm0L7D36tqxi9Pi8SS6AOSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DS
        wlxJIS8xN9VWycUnQNctMwdojZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJA
        rzgxt7g0L10vOT/XytDAwMgUqDAhO2P2lltsBesUKvqaFjE2ML6S6GLk5JAQMJH4cvwGWxcj
        F4eQwA5GiZkPXrBAOJ8YJX4vnMMK4XxjlHjbsooVpuXx9N1Qib2MEk8+nmEDSQgJvGeUWPXH
        GsQWFgiV+PX9BguILSKgKfFr20EmEJtZwFOib0Y7WD2bgJbE/hc3wGx+AUWJqz8eM4LYvAJ2
        Ei0/ZjCD2CwCqhKr+tcDLePgEBWIkDj9NRGiRFDi5MwnYOM5BYwkVjbPYoEYLy5x68l8qFXy
        Es1bZzOD3CkhcIBNouFGNxvEAy4Siyb2MUHYwhKvjm9hh7ClJF72t0HZ1RIrTx5hg2juYJTY
        sv8C1PfGEvuXTmYCOYgZ6LH1u/QhwooSO3/PZYRYzCfx7msP2M0SArwSHW1CECXKEpcf3IVa
        KymxuL2TbQKj0iwk78xC8sIsJC/MQli2gJFlFaNYakFxbnpqsWGBKXJkb2IEp0Atyx2Mx875
        HGIU4GBU4uHNODk3Vog1say4MvcQowQHs5II76JZc2KFeFMSK6tSi/Lji0pzUosPMZoCA3si
        s5Rocj4wPeeVxBuaGhkbG1uYGJqZGhoqifOyMs6PFRJITyxJzU5NLUgtgulj4uCUamCMchN0
        9/VcelxcdXbiguDH525xHfNguGGsp3xl8QYD3bA1UxjiXds/uLcsCNKM/cXUHXqHe3LGnDfe
        rwRmfly81NTy0yOWss0ZXoZXzPecU/POXaepU/MuXvDlqap2p1t1Hjc3zvlXqCCYprxP6cix
        o44Tv2fyFToyFXy6IGFqc2++517RU6eUWIozEg21mIuKEwFkPIfBlwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnO4ltvmxBut/GVtc3jWHzeJ24wo2
        ixtzTRyYPdoW2Hv0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJXxuwtt9gK1ilU9DUtYmxgfCXR
        xcjJISFgIvF4+m7WLkYuDiGB3YwSqw40MEEkJCWmXTzK3MXIAWQLSxw+XAxR85ZR4uLFu6wg
        NcICoRK/vt9gAbFFBDQlfm07CNbLLOAp0TejnQ2iYT6TxO8VH8CK2AS0JPa/uMEGYvMLKEpc
        /fGYEcTmFbCTaPkxgxnEZhFQlVjVvx5sgahAhMTz7TegagQlTs58AjaHU8BIYmXzLBaIZeoS
        f+ZdYoawxSVuPZkPdYS8RPPW2cwTGIVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxL
        LdcrTswtLs1L10vOz93ECI4HLc0djJeXxB9iFOBgVOLhzTg5N1aINbGsuDL3EKMEB7OSCO+i
        WXNihXhTEiurUovy44tKc1KLDzFKc7AoifM+zTsWKSSQnliSmp2aWpBaBJNl4uCUamDsXSiq
        zqB88P2eiYat9UWvpZzkc+ckVE/kfX6a1UZwyqSwaJ0ve3OtXv109+SbxFbveOnJ+2MlYhv2
        FNm+KJSN3LDxsY8LB//aQK5FjLsFTmn2hC3lf2J9rOuofesSNo6VxRy55zP6k7h/phv//viy
        5918Lw0TPcuY1z+DBXbeKdt4LsaeS0KJpTgj0VCLuag4EQAhgg3IgwIAAA==
X-CMS-MailID: 20191010102418epcas1p2158808496b2ed2fb8a1efed928dcb540
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
        <a4e6c33d-b715-34af-67c7-f9a3afc21e05@samsung.com>
        <20191010101509.GA122066@gerhold.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On 19. 10. 10. 오후 7:15, Stephan Gerhold wrote:
> Hi Chanwoo,
> 
> thank you for your suggestions!
> 
> On Thu, Oct 10, 2019 at 04:46:56PM +0900, Chanwoo Choi wrote:
>> On 19. 10. 10. 오후 4:33, Chanwoo Choi wrote:
>>> It is not proper. Instead, initialize the SM5502_RET_INT1/2 with zero.
> 
> Sorry about that. I don't have a datasheet, so I wasn't sure what's the
> best way to fix the problem.
> 
>>>
>>> The reset value of SM5502_RET_INT1/2 are zero (0x00) as following:
>>> If you can test it with h/w, please try to test it and then
>>> send the modified patch. 
>>>
>>> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
>>> index c897f1aa4bf5..e168f77a18ba 100644
>>> --- a/drivers/extcon/extcon-sm5502.c
>>> +++ b/drivers/extcon/extcon-sm5502.c
>>> @@ -68,6 +68,14 @@ static struct reg_data sm5502_reg_data[] = {
>>>                 .reg = SM5502_REG_CONTROL,
>>>                 .val = SM5502_REG_CONTROL_MASK_INT_MASK,
>>>                 .invert = false,
>>> +       }, {
>>> +               .reg = SM5502_REG_INT1,
>>> +               .val = SM5502_RET_INT1_MASK,
>>> +               .invert = true,
>>> +       }, {
>>> +               .reg = SM5502_REG_INT2,
>>> +               .val = SM5502_RET_INT1_MASK,
>>> +               .invert = true,
>>>         }, {
>>>                 .reg = SM5502_REG_INTMASK1,
>>>                 .val = SM5502_REG_INTM1_KP_MASK
>>> diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
>>> index 9dbb634d213b..5c4edb3e7fce 100644
>>> --- a/drivers/extcon/extcon-sm5502.h
>>> +++ b/drivers/extcon/extcon-sm5502.h
>>> @@ -93,6 +93,8 @@ enum sm5502_reg {
>>>  #define SM5502_REG_CONTROL_RAW_DATA_MASK       (0x1 << SM5502_REG_CONTROL_RAW_DATA_SHIFT)
>>>  #define SM5502_REG_CONTROL_SW_OPEN_MASK                (0x1 << SM5502_REG_CONTROL_SW_OPEN_SHIFT)
>>>  
>>> +#define SM5502_RET_INT1_MASK                   (0xff)
>>> +
>>>  #define SM5502_REG_INTM1_ATTACH_SHIFT          0
>>>  #define SM5502_REG_INTM1_DETACH_SHIFT          1
>>>  #define SM5502_REG_INTM1_KP_SHIFT              2
>>>
>>>>  }
>>>>  
>>>>  static int sm5022_muic_i2c_probe(struct i2c_client *i2c,
>>>>
>>>
>>>
> 
> This patch (i.e. writing to SM5502_REG_INT1 and SM5502_REG_INT2)
> does not result in any difference.
> There are still no interrupts being sent.
> 
> On the other hand, your other suggestion fixes the problem:
> 
>>
>> When write 0x1 to SM5502_REG_RESET, reset the device.
>> So, you can reset the all registers by writing 1 to SM5502_REG_RESET as following:
>>
> 
> Writing 0x1 to SM5502_REG_RESET seems to make interrupts work, so writing
> to SM5502_REG_INT1 and SM5502_REG_INT2 is not even necessary in this case.

OK.

> 
> Would you still prefer initializing SM5502_REG_INT1/2 or is the patch
> below enough?

No. If SM5502_REG_RESET is enough to fix this issue, I'm OK.
Thanks.

> 
> diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> index dc43847ad2b0..b3d93baf4fc5 100644
> --- a/drivers/extcon/extcon-sm5502.c
> +++ b/drivers/extcon/extcon-sm5502.c
> @@ -65,6 +65,10 @@ struct sm5502_muic_info {
>  /* Default value of SM5502 register to bring up MUIC device. */
>  static struct reg_data sm5502_reg_data[] = {
>  	{
> +		.reg = SM5502_REG_RESET,
> +		.val = SM5502_REG_RESET_MASK,
> +		.invert = true,
> +	}, {
>  		.reg = SM5502_REG_CONTROL,
>  		.val = SM5502_REG_CONTROL_MASK_INT_MASK,
>  		.invert = false,
> diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
> index 9dbb634d213b..2ea1bc01be0a 100644
> --- a/drivers/extcon/extcon-sm5502.h
> +++ b/drivers/extcon/extcon-sm5502.h
> @@ -237,6 +237,8 @@ enum sm5502_reg {
>  #define DM_DP_SWITCH_UART			((DM_DP_CON_SWITCH_UART <<SM5502_REG_MANUAL_SW1_DP_SHIFT) \
>  						| (DM_DP_CON_SWITCH_UART <<SM5502_REG_MANUAL_SW1_DM_SHIFT))
>  
> +#define SM5502_REG_RESET_MASK		    (0x1)
> +
>  /* SM5502 Interrupts */
>  enum sm5502_irq {
>  	/* INT1 */
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
