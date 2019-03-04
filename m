Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9004020842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfCDBzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:55:52 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbfCDBzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 20:55:52 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B038DC8A4609FE46AA7B;
        Mon,  4 Mar 2019 09:55:49 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Mar 2019
 09:55:39 +0800
CC:     <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, <yudongbin@hisilicon.com>,
        <zangleigang@hisilicon.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3 10/12] hikey960: Support usb functionality of Hikey960
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <20190302090505.65542-1-chenyu56@huawei.com>
 <20190302090505.65542-11-chenyu56@huawei.com>
 <1551664069.2210.64.camel@mhfsdcap03>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <2708b188-d318-6758-a5fd-8573559b2e70@huawei.com>
Date:   Mon, 4 Mar 2019 09:55:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1551664069.2210.64.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng Yun,

On 2019/3/4 9:47, Chunfeng Yun wrote:

>> +
>> +	hisi_hikey_usb->role_sw = usb_role_switch_get(dev);
>> +	if (!hisi_hikey_usb->role_sw)
>> +		return -EPROBE_DEFER;
> Here return EPROBE_DEFFER means the related device_connection is
> registered after this probe is called, right?
> if not, use IS_ERR_OR_NULL then return PTR_ERR is enough
Yes, the driver which register the usb_role_switch may finish probe after
this driver is probed for the first time.
>> +	else if (IS_ERR(hisi_hikey_usb->role_sw))
>> +		return PTR_ERR(hisi_hikey_usb->role_sw);
>> +
>> +	ret = usb_role_switch_register_notifier(hisi_hikey_usb->role_sw,
>> +			&hisi_hikey_usb->nb);
>> +	if (ret) {
>> +		usb_role_switch_put(hisi_hikey_usb->role_sw);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, hisi_hikey_usb);
>> +
>> +	return 0;
>> +}
>> +

> 
> 
> .
> 

