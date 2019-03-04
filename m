Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB75C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE5B20842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfCDCx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:53:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbfCDCxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:53:55 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4966B9FA88030B769710;
        Mon,  4 Mar 2019 10:53:53 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Mar 2019
 10:53:43 +0800
CC:     <liuyu712@hisilicon.com>, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, Yao Chen <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        songxiaowei <songxiaowei@hisilicon.com>,
        xu yiping <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: //Re: [PATCH v3 06/12] usb: dwc3: Increase timeout for CmdAct cleared
 by device controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "zhangfei (AC)" <zhangfei28@huawei.com>
References: <20190302090505.65542-1-chenyu56@huawei.com>
 <20190302090505.65542-7-chenyu56@huawei.com>
 <CAHp75Vd+wPU_QvaWHanpG6hjnUj6==4Y3YiOtZnWpk0kyFUQ4A@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <7bbe9516-cb16-09a9-554f-0b8177c6f535@huawei.com>
Date:   Mon, 4 Mar 2019 10:53:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd+wPU_QvaWHanpG6hjnUj6==4Y3YiOtZnWpk0kyFUQ4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang Fei,

On 2019/3/2 23:47, Andy Shevchenko wrote:
> On Sat, Mar 2, 2019 at 11:06 AM Yu Chen <chenyu56@huawei.com> wrote:
>>
>> It needs more time for the device controller to clear the CmdAct of
>> DEPCMD on Hisilicon Kirin Soc.
>>
> 
> 5x times more? Can you provide more specific details on that?
> 
Can you explain the details about the timeout expansion on Hisilicon Kirin Soc?
Thanks!

>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Felipe Balbi <balbi@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Binghui Wang <wangbinghui@hisilicon.com>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> ---
>>  drivers/usb/dwc3/gadget.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 6c9b76bcc2e1..84d701b37171 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -270,7 +270,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
>>  {
>>         const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
>>         struct dwc3             *dwc = dep->dwc;
>> -       u32                     timeout = 1000;
>> +       u32                     timeout = 5000;
>>         u32                     saved_config = 0;
>>         u32                     reg;
>>
>> --
>> 2.15.0-rc2
>>
> 
> 

