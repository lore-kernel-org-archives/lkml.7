Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D308BC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BF1206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="WwkEubxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbfFJHtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:49:07 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:42262 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387946AbfFJHtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:49:06 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 1BC3E2E146D;
        Mon, 10 Jun 2019 10:49:03 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 3wMTGjTNnn-n2lW74fo;
        Mon, 10 Jun 2019 10:49:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560152943; bh=Qzebi1leFqcpZHW1I+Cib60DHdujFnQNpZ3bLJWHh6s=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=WwkEubxXt3DWtlV+9KizQuB1prBb89ONXLPhZyNQYoIevSM68jGLQVk2fRugkVPFh
         JIqv/qCv4BBsJ4dCJxUzGy4oVGTj2bFZe0U/UKP4lLa30bldT57V1srm/EZJelyDpj
         45DUEdB1IqrKrBNFudz/BcMMSxweMcZQpTPd9jNo=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d25:9e27:4f75:a150])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id BUMfaPbDgr-n1gKVU5p;
        Mon, 10 Jun 2019 10:49:02 +0300
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
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <b554c428-417e-5fef-1776-87a4db1d674a@yandex-team.ru>
Date:   Mon, 10 Jun 2019 10:49:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560116241.3324.19.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.06.2019 0:37, James Bottomley wrote:
> On Sat, 2019-06-08 at 17:13 +0300, Konstantin Khlebnikov wrote:
>>> On 08.06.2019 11:25, Christoph Hellwig wrote:> On Fri, Jun 07, 2019
>>> at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
>>>   >
>>>   > Do we really need to spam dmesg with even more ATA crap?  What
>>> about
>>>   > a sysfs file that can be read on demand instead?
>>>   >
>>>
>>> Makes sense.
>>>
>>> Trim state is exposed for ata_device:
>>> /sys/class/ata_device/devX.Y/trim
>>> but there is no link from scsi device to ata device so they hard to
>>> match.
>>>
>>> I'll think about it.
>>
>> Nope. There is no obvious way to link scsi device with ata_device.
>> ata_device is built on top of "transport_class" and
>> "attribute_container".
>> This some extremely over engineered sysfs framework used only in
>> ata/scsi. I don't want to touch this.
> 
> You don't need to know any of that.  The problem is actually when the
> ata transport classes were first created, the devices weren't properly
> parented.  What should have happened, like every other transport class,
> is that the devices should have descended down to the scsi device as
> the leaf in an integrated fashion.  Instead, what we seem to have is
> three completely separate trees.
> 
> So if you look at a SAS device, you see from the pci device:
> 
> host2/port-2:0/end_device-2:0/target2:0:0/2:0:0:0/block/sdb/sdb1
> 
> But if you look at a SATA device, you see three separate paths:
> 
> ata3/host3/target3\:0\:0/3\:0\:0\:0/block/sda/sda1
> ata3/link3/dev3.0/ata_device/dev3.0
> ata3/ata_port/ata3
> 
> Instead of an integrated tree
> 
> Unfortunately, this whole thing is unfixable now.  If I integrate the
> tree properly, the separate port and link directories will get subsumed
> and we won't be able to recover them with judicious linking so scripts
> relying on them will break.  The best we can probably do is add
> additional links with what we have.
> 
> To follow the way we usually do it, there should be a link from the ata
> device to the scsi target, but that wouldn't help you find the "trim"
> files, so it sounds like you want a link from the scsi device to the ata device, which would?

Yes, I'm talking about link from scsi device to leaf ata_device node.

In libata scsi_device has one to one relation with ata_device.
So making link like /sys/class/block/sda/device/ata_device should be possible easy.
But I haven't found implicit reference from struct ata_device to ata_device in sysfs.

In simplest ahci case whole path looks like:
/sys/devices/pci0000:00/0000:00:1f.2/ata1/link1/dev1.0/ata_device/dev1.0
|______________________|__ata_host__|port|link_|_tdev_|___ata_device___|


/sys/class/ata_device/dev1.0 points directly to leaf ata_device
While in struct ata_device tdev is different intermediate node.

It would be nice merge tdev and ata_device into one node, or at least embed leaf
struct device into struct ata_device too.

As I see ata registers only "transport" device while scsi transport template
magically matches it and creates actual ata device of ata_dev_class.
I see no reason for this complexity. Why ata host couldn't enumerate and
register all these devices explicitly?
