Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F328520835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfCDCf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:35:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfCDCf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:35:27 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1645B379DC0B44BC9EE5;
        Mon,  4 Mar 2019 10:35:25 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Mar 2019
 10:35:16 +0800
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
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3 10/12] hikey960: Support usb functionality of Hikey960
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20190302090505.65542-1-chenyu56@huawei.com>
 <20190302090505.65542-11-chenyu56@huawei.com>
 <CAHp75VdaNn4OQAQt1cU8CZ+Cton90kxmwQSG5Du7KUzPR3hSCg@mail.gmail.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <386ac0cf-cee7-bc1b-d22c-80dedff391cf@huawei.com>
Date:   Mon, 4 Mar 2019 10:35:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VdaNn4OQAQt1cU8CZ+Cton90kxmwQSG5Du7KUzPR3hSCg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2019/3/3 0:01, Andy Shevchenko wrote:
> On Sat, Mar 2, 2019 at 11:05 AM Yu Chen <chenyu56@huawei.com> wrote:
>>
>> This driver handles usb hub power on and typeC port event of HiKey960 board:
>> 1)DP&DM switching between usb hub and typeC port base on typeC port
>> state
>> 2)Control power of usb hub on Hikey960
>> 3)Control vbus of typeC port
> 
>> +config HISI_HIKEY_USB
>> +       tristate "USB functionality of HiSilicon Hikey Platform"
>> +       depends on OF && GPIOLIB
>> +       help
>> +         If you say yes here you get support for usb functionality of HiSilicon Hikey Platform.
> 
>> +#include <linux/of.h>
> 
> It's hard to see why this have
> depends on OF followed by above header inclusion.
> 
This driver depends on devicetree, so I add "depends on OF".
But is seems that "#include <linux/of.h>" can be removed after "of_" API
have been removed. Thanks for your reminder!
>> +       hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
>> +                       GPIOD_OUT_LOW);
> 
>> +       if (!hisi_hikey_usb->typec_vbus)
>> +               return -ENOENT;
> 
> Hmm... Is it possible to get NULL pointer from gpiod_get() at all?
> 
>> +       if (!hisi_hikey_usb->otg_switch)
>> +               return -ENOENT;
> 
> Ditto.
> 
I check the comments of devm_gpio_get API, it will not return NULL pointer.
But is it more safe to keep the NULL checking? What is your advice?
>> +       /* hub-vdd33-en is optional */
>> +       hisi_hikey_usb->hub_vbus = devm_gpiod_get(dev, "hub-vdd33-en",
>> +                       GPIOD_OUT_HIGH);
> 
> devm_gpio_get_optional() if it's indeed optional.
> 
OK.Thanks!
>> +       hisi_hikey_usb->role_sw = usb_role_switch_get(dev);
>> +       if (!hisi_hikey_usb->role_sw)
>> +               return -EPROBE_DEFER;
> 
>> +       else if (IS_ERR(hisi_hikey_usb->role_sw))
> 
> Redundant 'else'
> 
OK.
>> +               return PTR_ERR(hisi_hikey_usb->role_sw);
> 
>> +static const struct of_device_id id_table_hisi_hikey_usb[] = {
>> +       {.compatible = "hisilicon,gpio_hubv1"},
>> +       {.compatible = "hisilicon,hikey960_usb"},
>> +       {}
>> +};
> 
> MODULE_DEVICE_TABLE()?
> 
OK.

Thanks
Yu Chen

