Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA54C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3812A21850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDLBX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:23:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbfDLBXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:23:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C91B793732090A697CCC;
        Fri, 12 Apr 2019 09:23:53 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 09:23:44 +0800
CC:     <liuyu712@hisilicon.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        "Zhuangluan Su" <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        butao <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>,
        Li Pengcheng <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, YiPing Xu <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, Yudongbin <yudongbin@hisilicon.com>,
        Zang Leigang <zangleigang@hisilicon.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v5 10/13] usb: dwc3: Registering a role switch in the DRD
 code.
To:     John Stultz <john.stultz@linaro.org>
References: <20190329041409.70138-1-chenyu56@huawei.com>
 <20190329041409.70138-11-chenyu56@huawei.com>
 <CALAqxLVdrzNS2t1OYT=Pziu81VO+zWq5LYghHhMJO53cSvNNtQ@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <7d5ba117-735e-3fb0-97f7-33be328a4ae6@huawei.com>
Date:   Fri, 12 Apr 2019 09:23:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CALAqxLVdrzNS2t1OYT=Pziu81VO+zWq5LYghHhMJO53cSvNNtQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2019/4/12 8:48, John Stultz wrote:
> On Thu, Mar 28, 2019 at 9:14 PM Yu Chen <chenyu56@huawei.com> wrote:
>>
>> The Type-C drivers use USB role switch API to inform the
>> system about the negotiated data role, so registering a role
>> switch in the DRD code in order to support platforms with
>> USB Type-C connectors.
>>
> 
> Hey Yu Chen!
>   Thanks so much for sending these patches out!  I have run into some
> troubles on bootup where things aren't working properly at first, that
> seem to be due to state initialization races.  In chasing those down,
> I've found some other quirks I wanted to bring up.
> 
>> --- a/drivers/usb/dwc3/drd.c
>> +++ b/drivers/usb/dwc3/drd.c
>> @@ -479,6 +479,43 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>>         return edev;
>>  }
>>
>> +static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
>> +{
>> +       struct dwc3 *dwc = dev_get_drvdata(dev);
>> +       u32 mode;
>> +
>> +       switch (role) {
>> +       case USB_ROLE_HOST:
>> +               mode = DWC3_GCTL_PRTCAP_HOST;
>> +               break;
>> +       case USB_ROLE_DEVICE:
>> +               mode = DWC3_GCTL_PRTCAP_DEVICE;
>> +               break;
>> +       default:
>> +               if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
>> +                       mode = DWC3_GCTL_PRTCAP_HOST;
>> +               else
>> +                       mode = DWC3_GCTL_PRTCAP_DEVICE;
>> +               break;
>> +       }
>> +
>> +       dwc3_set_mode(dwc, mode);
>> +       return 0;
>> +}
>> +
>> +static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
>> +{
>> +       struct dwc3 *dwc = dev_get_drvdata(dev);
>> +       unsigned long flags;
>> +       enum usb_role role;
>> +
>> +       spin_lock_irqsave(&dwc->lock, flags);
>> +       role = dwc->current_otg_role;
>> +       spin_unlock_irqrestore(&dwc->lock, flags);
>> +
>> +       return role;
>> +}
>> +
> 
> So the two functions above are a bit asymmetric.  The
> dwc3_usb_role_switch_set() can put the device into host or device
> mode, which eventually sets the current_dr_role value.  However on the
> dwc3_usb_role_switch_get() we return the current_otg_role value.
> current_otg_role isn't set unless current_dr_role is
> DWC3_GCTL_PRTCAP_OTG, which doesn't seem to happen here.
> 
> I suspect in dwc3_usb_role_switch_get() we should return
> current_dr_role, unless current_dr_role==DWC3_GCTL_PRTCAP_OTG, in
> which case we'd want to return current_otg_role.
> 
> Does that make sense?
> 
Yes, you are right! The dwc3_usb_role_switch_get() should return current_dr_role
. Actually if we register the dwc3_role_switch, the current_dr_role would not be DWC3_GCTL_PRTCAP_OTG.
> Nothing really actually use this dwc3_usb_role_switch_get() yet, so
> this was easy to overlook, and I only caught it as I was trying to
> debug some of the initialization races.
> 
> thanks
> -john
> 
> .
> 

