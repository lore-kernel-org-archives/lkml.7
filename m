Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECE6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E8020643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCSMH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:07:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5267 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbfCSMH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:07:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CB93C4BD417CBBD05B1F;
        Tue, 19 Mar 2019 20:07:23 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Mar 2019
 20:07:14 +0800
CC:     <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, <yudongbin@hisilicon.com>,
        <zangleigang@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 08/12] usb: roles: Add usb role switch notifier.
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20190316035342.77998-1-chenyu56@huawei.com>
 <20190316035342.77998-9-chenyu56@huawei.com>
 <20190319115651.GT7752@kuha.fi.intel.com>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <68d036a7-aad6-ff7f-ccf6-2e54c503e51a@huawei.com>
Date:   Tue, 19 Mar 2019 20:07:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190319115651.GT7752@kuha.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019/3/19 19:56, Heikki Krogerus wrote:
> On Sat, Mar 16, 2019 at 11:53:38AM +0800, Yu Chen wrote:
>> This patch adds notifier for drivers want to be informed of the usb role switch.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> ---
>>  drivers/usb/roles/class.c | 20 +++++++++++++++++++-
>>  include/linux/usb/role.h  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
>> index f45d8df5cfb8..e2caaa665d6e 100644
>> --- a/drivers/usb/roles/class.c
>> +++ b/drivers/usb/roles/class.c
>> @@ -20,6 +20,7 @@ struct usb_role_switch {
>>  	struct device dev;
>>  	struct mutex lock; /* device lock*/
>>  	enum usb_role role;
>> +	struct blocking_notifier_head nh;
>>  
>>  	/* From descriptor */
>>  	struct device *usb2_port;
>> @@ -49,8 +50,10 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
>>  	mutex_lock(&sw->lock);
>>  
>>  	ret = sw->set(sw->dev.parent, role);
>> -	if (!ret)
>> +	if (!ret) {
>>  		sw->role = role;
>> +		blocking_notifier_call_chain(&sw->nh, role, NULL);
>> +	}
>>  
>>  	mutex_unlock(&sw->lock);
>>  
>> @@ -58,6 +61,20 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
>>  }
>>  EXPORT_SYMBOL_GPL(usb_role_switch_set_role);
>>  
>> +int usb_role_switch_register_notifier(struct usb_role_switch *sw,
>> +				      struct notifier_block *nb)
>> +{
>> +	return blocking_notifier_chain_register(&sw->nh, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(usb_role_switch_register_notifier);
>> +
>> +int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
>> +					struct notifier_block *nb)
>> +{
>> +	return blocking_notifier_chain_unregister(&sw->nh, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(usb_role_switch_unregister_notifier);
>> +
>>  /**
>>   * usb_role_switch_get_role - Get the USB role for a switch
>>   * @sw: USB role switch
>> @@ -271,6 +288,7 @@ usb_role_switch_register(struct device *parent,
>>  		return ERR_PTR(-ENOMEM);
>>  
>>  	mutex_init(&sw->lock);
>> +	BLOCKING_INIT_NOTIFIER_HEAD(&sw->nh);
>>  
>>  	sw->allow_userspace_control = desc->allow_userspace_control;
>>  	sw->usb2_port = desc->usb2_port;
>> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
>> index c05ffa6abda9..99d8b8e4fe61 100644
>> --- a/include/linux/usb/role.h
>> +++ b/include/linux/usb/role.h
>> @@ -42,6 +42,8 @@ struct usb_role_switch_desc {
>>  	bool allow_userspace_control;
>>  };
>>  
>> +
>> +#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
>>  int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role);
>>  enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw);
>>  struct usb_role_switch *usb_role_switch_get(struct device *dev);
>> @@ -51,5 +53,49 @@ struct usb_role_switch *
>>  usb_role_switch_register(struct device *parent,
>>  			 const struct usb_role_switch_desc *desc);
>>  void usb_role_switch_unregister(struct usb_role_switch *sw);
>> +int usb_role_switch_register_notifier(struct usb_role_switch *sw,
>> +				      struct notifier_block *nb);
>> +int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
>> +					struct notifier_block *nb);
>> +#else
>> +static inline int usb_role_switch_set_role(struct usb_role_switch *sw,
>> +		enum usb_role role)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
>> +{
>> +	return USB_ROLE_NONE;
>> +}
>> +
>> +static inline struct usb_role_switch *usb_role_switch_get(struct device *dev)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
>> +
>> +static inline struct usb_role_switch *
>> +usb_role_switch_register(struct device *parent,
>> +			 const struct usb_role_switch_desc *desc)
>> +{
>> +	return ERR_PTR(-ENODEV);
>> +}
>> +
>> +static inline void usb_role_switch_unregister(struct usb_role_switch *sw) { }
>> +
>> +static int usb_role_switch_register_notifier(struct usb_role_switch *sw,
>> +				      struct notifier_block *nb)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
>> +					struct notifier_block *nb)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif
>>  
>>  #endif /* __LINUX_USB_ROLE_H */
> 
> Sorry for the late response, but since you are providing a stub for
> all the functions, not just the new ones, could you please introduce
> them in a separate patch.
> 
> Add a patch where you introduce stubs for the exiting functions, and
> this patch can then add the stubs for just the new notifier functions.
> 
> 
> thanks,
> 

OK.

Thanks
Yu Chen

