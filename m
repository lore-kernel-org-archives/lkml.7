Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6969CC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400CE216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="clB/q5G7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfFZTEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:04:07 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13879 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfFZTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:04:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d13c1a30001>; Wed, 26 Jun 2019 12:04:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Jun 2019 12:04:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Jun 2019 12:04:05 -0700
Received: from [10.24.71.21] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Jun
 2019 19:04:03 +0000
Subject: Re: [PATCH] mdev: Send uevents around parent device registration
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     <cohuck@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <156155924767.11505.11457229921502145577.stgit@gimli.home>
 <1ea5c171-cd42-1c10-966e-1b82a27351d9@nvidia.com>
 <20190626120551.788fa5ed@x1.home>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <a6c2ec9e-b949-4346-13bc-4d7f9c35ea8b@nvidia.com>
Date:   Thu, 27 Jun 2019 00:33:59 +0530
MIME-Version: 1.0
In-Reply-To: <20190626120551.788fa5ed@x1.home>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561575843; bh=jZA/XDQ4US9Ng8Ww5WujClRmd4XFP4iAZ65KheJ7Nh4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=clB/q5G7SbjTlRjSpGBni2WC8guLbfo2PMHjtJcTu6thvaVpKoIDJq1vi21LLfisR
         IqjYoxJnEuuIrGkJOlfxLPAnsNbnLZmTlsmPpwbvJgZf374V4ZZKBQwzpKaAcvfmYy
         5JBpeHnt2RDuby3m0SPKrewFS83fzjzAC+vfpygO3+loJdiZ8TBNkuxbZzmDUCn/yW
         lSolvAYARHTFQt/OwD1hyBPFahD7giYcsjq7hW+hBg+2whM47nvHhToCYDvzLMYDIE
         pdxSF2cDLwKCvYjVyDLXaKtHWvDBybWyBxeneiYQXlL71BSpmpYyFy1ZNVZfaWPmHl
         17+htJ5JXZ1ZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/2019 11:35 PM, Alex Williamson wrote:
> On Wed, 26 Jun 2019 23:23:00 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 6/26/2019 7:57 PM, Alex Williamson wrote:
>>> This allows udev to trigger rules when a parent device is registered
>>> or unregistered from mdev.
>>>
>>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>> ---
>>>  drivers/vfio/mdev/mdev_core.c |   10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
>>> index ae23151442cb..ecec2a3b13cb 100644
>>> --- a/drivers/vfio/mdev/mdev_core.c
>>> +++ b/drivers/vfio/mdev/mdev_core.c
>>> @@ -146,6 +146,8 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
>>>  {
>>>  	int ret;
>>>  	struct mdev_parent *parent;
>>> +	char *env_string = "MDEV_STATE=registered";
>>> +	char *envp[] = { env_string, NULL };
>>>  
>>>  	/* check for mandatory ops */
>>>  	if (!ops || !ops->create || !ops->remove || !ops->supported_type_groups)
>>> @@ -196,7 +198,8 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
>>>  	list_add(&parent->next, &parent_list);
>>>  	mutex_unlock(&parent_list_lock);
>>>  
>>> -	dev_info(dev, "MDEV: Registered\n");
>>> +	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
>>> +  
>>
>> Its good to have udev event, but don't remove debug print from dmesg.
>> Same for unregister.
> 
> Who consumes these?  They seem noisy.  Thanks,
> 

I don't think its noisy, its more of logging purpose. This is seen in
kernel log only when physical device is registered to mdev.

Thanks,
Kirti


> Alex
> 
>>>  	return 0;
>>>  
>>>  add_dev_err:
>>> @@ -220,6 +223,8 @@ EXPORT_SYMBOL(mdev_register_device);
>>>  void mdev_unregister_device(struct device *dev)
>>>  {
>>>  	struct mdev_parent *parent;
>>> +	char *env_string = "MDEV_STATE=unregistered";
>>> +	char *envp[] = { env_string, NULL };
>>>  
>>>  	mutex_lock(&parent_list_lock);
>>>  	parent = __find_parent_device(dev);
>>> @@ -228,7 +233,6 @@ void mdev_unregister_device(struct device *dev)
>>>  		mutex_unlock(&parent_list_lock);
>>>  		return;
>>>  	}
>>> -	dev_info(dev, "MDEV: Unregistering\n");
>>>  
>>>  	list_del(&parent->next);
>>>  	mutex_unlock(&parent_list_lock);
>>> @@ -243,6 +247,8 @@ void mdev_unregister_device(struct device *dev)
>>>  	up_write(&parent->unreg_sem);
>>>  
>>>  	mdev_put_parent(parent);
>>> +
>>> +	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
>>>  }
>>>  EXPORT_SYMBOL(mdev_unregister_device);
>>>  
>>>   
> 
