Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB10EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634B720866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="jlnoPumk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfFNNtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:49:45 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:54272 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728659AbfFNNtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:49:42 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 6E12E2E0DEB;
        Fri, 14 Jun 2019 16:49:38 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 39Vphjpq6N-nbaKmusr;
        Fri, 14 Jun 2019 16:49:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560520178; bh=qVDq0D9OO4glvmHjwdsfU4Vr8j6/j6nCy0HmZ0dRLo4=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=jlnoPumk7gJZI0ixDYV80/1/L6jVlKxHcakmFwA55RM19Np4dp3x3nHB7tZx65BSN
         cC6djB3PALQntHVktvwxg3d+FOTzSX/GenBSGQ3CLnGcxGVUP3/WB0UAbB5qu08f6M
         QXyRbBPhR/uNk9srWi9FuZUWcw7b101Ny6j/WqZY=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:a1b1:2ca9:8cc0:4c56])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id uQaJmBDJhz-nbgScMef;
        Fri, 14 Jun 2019 16:49:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] drivers/ata: print trim features at device initialization
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
 <yq1wohxib7t.fsf@oracle.com>
 <eebfb1cc-f6d0-580e-1d56-2af0f481a92f@yandex-team.ru>
 <048ed77f-8faa-fb67-c6bc-10d953f52f89@yandex-team.ru>
 <1560116241.3324.19.camel@HansenPartnership.com>
 <b554c428-417e-5fef-1776-87a4db1d674a@yandex-team.ru>
 <1560206933.3698.27.camel@HansenPartnership.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <cd91b050-cbc6-7c3b-f9f8-91c0760668e6@yandex-team.ru>
Date:   Fri, 14 Jun 2019 16:49:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560206933.3698.27.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.06.2019 1:48, James Bottomley wrote:
> On Mon, 2019-06-10 at 10:49 +0300, Konstantin Khlebnikov wrote:
>> On 10.06.2019 0:37, James Bottomley wrote:
>>> On Sat, 2019-06-08 at 17:13 +0300, Konstantin Khlebnikov wrote:
>>>>> On 08.06.2019 11:25, Christoph Hellwig wrote:> On Fri, Jun 07,
>>>>> 2019
>>>>> at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
>>>>>    >
>>>>>    > Do we really need to spam dmesg with even more ATA
>>>>> crap?  What
>>>>> about
>>>>>    > a sysfs file that can be read on demand instead?
>>>>>    >
>>>>>
>>>>> Makes sense.
>>>>>
>>>>> Trim state is exposed for ata_device:
>>>>> /sys/class/ata_device/devX.Y/trim
>>>>> but there is no link from scsi device to ata device so they
>>>>> hard to match.
>>>>>
>>>>> I'll think about it.
>>>>
>>>> Nope. There is no obvious way to link scsi device with
>>>> ata_device. ata_device is built on top of "transport_class" and
>>>> "attribute_container". This some extremely over engineered sysfs
>>>> framework used only in ata/scsi. I don't want to touch this.
>>>
>>> You don't need to know any of that.  The problem is actually when
>>> the ata transport classes were first created, the devices weren't
>>> properly parented.  What should have happened, like every other
>>> transport class, is that the devices should have descended down to
>>> the scsi device as the leaf in an integrated fashion.  Instead,
>>> what we seem to have is three completely separate trees.
>>>
>>> So if you look at a SAS device, you see from the pci device:
>>>
>>> host2/port-2:0/end_device-2:0/target2:0:0/2:0:0:0/block/sdb/sdb1
>>>
>>> But if you look at a SATA device, you see three separate paths:
>>>
>>> ata3/host3/target3\:0\:0/3\:0\:0\:0/block/sda/sda1
>>> ata3/link3/dev3.0/ata_device/dev3.0
>>> ata3/ata_port/ata3
>>>
>>> Instead of an integrated tree
>>>
>>> Unfortunately, this whole thing is unfixable now.  If I integrate
>>> the tree properly, the separate port and link directories will get
>>> subsumed and we won't be able to recover them with judicious
>>> linking so scripts relying on them will break.  The best we can
>>> probably do is add additional links with what we have.
>>>
>>> To follow the way we usually do it, there should be a link from the
>>> ata device to the scsi target, but that wouldn't help you find the
>>> "trim" files, so it sounds like you want a link from the scsi
>>> device to the ata device, which would?
>>
>> Yes, I'm talking about link from scsi device to leaf ata_device node.
>>
>> In libata scsi_device has one to one relation with ata_device.
>> So making link like /sys/class/block/sda/device/ata_device should be
>> possible easy.
>> But I haven't found implicit reference from struct ata_device to
>> ata_device in sysfs.
> 
> If that's all you want, it is pretty simple modulo the fact we can only
> get at the tdev, not the lower transport device, which is what you
> want, but at least it's linear from the symlink.
> 
> The attached patch should do this.
> 
> Now I see this for my non-sas device:
> 
> # ls -l /sys/class/scsi_device/3\:0\:0\:0/device/ata_device
> lrwxrwxrwx 1 root root 0 Jun 10 13:39 /sys/class/scsi_device/3:0:0:0/device/ata_device -> ../../../link3/dev3.0

I've tried this too. Such link is not very useful,
because attribute 'trim' is deeper and suffix path isn't constant:

/sys/class/block/sda/device/ata_device/ata_device/dev1.0/trim

while I expect something like

/sys/class/block/sda/device/ata_device/trim

> 
> James
> 
> ---
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 391ac0503dc0..b644336a6d65 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4576,7 +4576,20 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
>   			sdev = __scsi_add_device(ap->scsi_host, channel, id, 0,
>   						 NULL);
>   			if (!IS_ERR(sdev)) {
> +				int r;
> +
>   				dev->sdev = sdev;
> +				/* this is a sysfs stupidity: we don't
> +				 * care if the link actually gets
> +				 * created: there's no error handling
> +				 * for failure and we continue on
> +				 * regardless, but we have to discard
> +				 * the return value like this to
> +				 * defeat unused result checking */
> +				r = sysfs_create_link(&sdev->sdev_gendev.kobj,
> +						      &dev->tdev.kobj,
> +						      "ata_device");
> +				(void)r;
>   				scsi_device_put(sdev);
>   			} else {
>   				dev->sdev = NULL;
> @@ -4703,6 +4716,7 @@ static void ata_scsi_remove_dev(struct ata_device *dev)
>   		ata_dev_info(dev, "detaching (SCSI %s)\n",
>   			     dev_name(&sdev->sdev_gendev));
>   
> +		sysfs_remove_link(&sdev->sdev_gendev.kobj, "ata_device");
>   		scsi_remove_device(sdev);
>   		scsi_device_put(sdev);
>   	}
> 
