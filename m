Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2701AFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CEA20663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393535AbfJPNNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:13:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390087AbfJPNNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:13:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D51EEA3CD92;
        Wed, 16 Oct 2019 13:13:11 +0000 (UTC)
Received: from [10.3.116.74] (ovpn-116-74.phx2.redhat.com [10.3.116.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3647560127;
        Wed, 16 Oct 2019 13:13:11 +0000 (UTC)
Subject: Re: [PATCH] ipmi: Don't allow device module unload when in use
From:   tony camuso <tcamuso@redhat.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
References: <20191014134141.GA25427@t560>
 <20191014154632.11103-1-minyard@acm.org>
 <40e26052-3ccb-684a-540f-61ff47077690@redhat.com>
Message-ID: <321ed6cb-929c-462f-2459-9caf67be224e@redhat.com>
Date:   Wed, 16 Oct 2019 09:13:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <40e26052-3ccb-684a-540f-61ff47077690@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 16 Oct 2019 13:13:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/19 8:18 AM, tony camuso wrote:
> On 10/14/19 11:46 AM, minyard@acm.org wrote:
>> From: Corey Minyard <cminyard@mvista.com>
>>
>> If something has the IPMI driver open, don't allow the device
>> module to be unloaded.  Before it would unload and the user would
>> get errors on use.
>>
>> This change is made on user request, and it makes it consistent
>> with the I2C driver, which has the same behavior.
>>
>> It does change things a little bit with respect to kernel users.
>> If the ACPI or IPMI watchdog (or any other kernel user) has
>> created a user, then the device module cannot be unloaded.  Before
>> it could be unloaded,
>>
>> This does not affect hot-plug.  If the device goes away (it's on
>> something removable that is removed or is hot-removed via sysfs)
>> then it still behaves as it did before.
>>
>> Reported-by: tony camuso <tcamuso@redhat.com>
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>> Tony, here is a suggested change for this.  Can you look it over and
>> see if it looks ok?
>>
>> Thanks,
>>
>> -corey
>>
>>   drivers/char/ipmi/ipmi_msghandler.c | 23 ++++++++++++++++-------
>>   include/linux/ipmi_smi.h            | 12 ++++++++----
>>   2 files changed, 24 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
>> index 2aab80e19ae0..15680de18625 100644
>> --- a/drivers/char/ipmi/ipmi_msghandler.c
>> +++ b/drivers/char/ipmi/ipmi_msghandler.c
>> @@ -448,6 +448,8 @@ enum ipmi_stat_indexes {
>>   #define IPMI_IPMB_NUM_SEQ    64
>>   struct ipmi_smi {
>> +    struct module *owner;
>> +
>>       /* What interface number are we? */
>>       int intf_num;
>> @@ -1220,6 +1222,11 @@ int ipmi_create_user(unsigned int          if_num,
>>       if (rv)
>>           goto out_kfree;
>> +    if (!try_module_get(intf->owner)) {
>> +        rv = -ENODEV;
>> +        goto out_kfree;
>> +    }
>> +
>>       /* Note that each existing user holds a refcount to the interface. */
>>       kref_get(&intf->refcount);
>> @@ -1349,6 +1356,7 @@ static void _ipmi_destroy_user(struct ipmi_user *user)
>>       }
>>       kref_put(&intf->refcount, intf_free);
>> +    module_put(intf->owner);
>>   }
>>   int ipmi_destroy_user(struct ipmi_user *user)
>> @@ -2459,7 +2467,7 @@ static int __get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc)
>>    * been recently fetched, this will just use the cached data.  Otherwise
>>    * it will run a new fetch.
>>    *
>> - * Except for the first time this is called (in ipmi_register_smi()),
>> + * Except for the first time this is called (in ipmi_add_smi()),
>>    * this will always return good data;
>>    */
>>   static int __bmc_get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc,
>> @@ -3377,10 +3385,11 @@ static void redo_bmc_reg(struct work_struct *work)
>>       kref_put(&intf->refcount, intf_free);
>>   }
>> -int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
>> -              void               *send_info,
>> -              struct device            *si_dev,
>> -              unsigned char            slave_addr)
>> +int ipmi_add_smi(struct module         *owner,
>> +         const struct ipmi_smi_handlers *handlers,
>> +         void               *send_info,
>> +         struct device         *si_dev,
>> +         unsigned char         slave_addr)
>>   {
>>       int              i, j;
>>       int              rv;
>> @@ -3406,7 +3415,7 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
>>           return rv;
>>       }
>> -
>> +    intf->owner = owner;
>>       intf->bmc = &intf->tmp_bmc;
>>       INIT_LIST_HEAD(&intf->bmc->intfs);
>>       mutex_init(&intf->bmc->dyn_mutex);
>> @@ -3514,7 +3523,7 @@ int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
>>       return rv;
>>   }
>> -EXPORT_SYMBOL(ipmi_register_smi);
>> +EXPORT_SYMBOL(ipmi_add_smi);
>>   static void deliver_smi_err_response(struct ipmi_smi *intf,
>>                        struct ipmi_smi_msg *msg,
>> diff --git a/include/linux/ipmi_smi.h b/include/linux/ipmi_smi.h
>> index 4dc66157d872..deec18b8944a 100644
>> --- a/include/linux/ipmi_smi.h
>> +++ b/include/linux/ipmi_smi.h
>> @@ -224,10 +224,14 @@ static inline int ipmi_demangle_device_id(uint8_t netfn, uint8_t cmd,
>>    * is called, and the lower layer must get the interface from that
>>    * call.
>>    */
>> -int ipmi_register_smi(const struct ipmi_smi_handlers *handlers,
>> -              void                     *send_info,
>> -              struct device            *dev,
>> -              unsigned char            slave_addr);
>> +int ipmi_add_smi(struct module            *owner,
>> +         const struct ipmi_smi_handlers *handlers,
>> +         void                     *send_info,
>> +         struct device            *dev,
>> +         unsigned char            slave_addr);
>> +
>> +#define ipmi_register_smi(handlers, send_info, dev, slave_addr) \
>> +    ipmi_add_smi(THIS_MODULE, handlers, send_info, dev, slave_addr)
>>   /*
>>    * Remove a low-level interface from the IPMI driver.  This will
>>
> 
> Thanks, Corey.
> 
> Regards,
> Tony
> 

And I meant to add that I will be testing this over the next couple days.

