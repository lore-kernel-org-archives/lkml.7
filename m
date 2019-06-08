Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3976C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 14:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6717D21537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 14:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="A4B64Yp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfFHONg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 10:13:36 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:47986 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfFHONg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 10:13:36 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 899DB2E125C;
        Sat,  8 Jun 2019 17:13:32 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id DzuU53LwT0-DVoqFgjZ;
        Sat, 08 Jun 2019 17:13:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1560003212; bh=ZJAigA+ZG+rVR7oC7AwaFY8agPggvLHat5UXOAYyCec=;
        h=In-Reply-To:Message-ID:Date:References:To:From:Subject:Cc;
        b=A4B64Yp3ADzOz20YSiA9DlFU61mA6+K+M1JsMm0rTWTb0hT4WbxUb5X6wiM/Mzbwz
         4PeLHgH6oR9XpM8/Wm+HT9andPporgQa+b1D9LUYGX+YLbkL7+jlW+GwbIQ/bFbHSU
         aXS4gmvEr7r5O7rvdvPP/VHExAo5tp+Ga7Sz0jr8=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d25:9e27:4f75:a150])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id I7j3bGcYlp-DVe0sccL;
        Sat, 08 Jun 2019 17:13:31 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] drivers/ata: print trim features at device initialization
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
 <yq1wohxib7t.fsf@oracle.com>
 <eebfb1cc-f6d0-580e-1d56-2af0f481a92f@yandex-team.ru>
Message-ID: <048ed77f-8faa-fb67-c6bc-10d953f52f89@yandex-team.ru>
Date:   Sat, 8 Jun 2019 17:13:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <eebfb1cc-f6d0-580e-1d56-2af0f481a92f@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.06.2019 12:12, Konstantin Khlebnikov wrote:
> On 07.06.2019 19:58, Martin K. Petersen wrote:
>>
>> Konstantin,
>>
>>> +            if (dev->horkage & ATA_HORKAGE_NOTRIM)
>>> +                trim_status = "backlisted";
>>
>> blacklisted
> 
> Oops. My bad.
> 
>>
>>> +            else
>>> +                trim_status = "supported";
>>> +
>>> +            if (!ata_fpdma_dsm_supported(dev))
>>> +                trim_queued = "no";
>>> +            else if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
>>> +                trim_queued = "backlisted";
>>
>> ditto
>>
>>> +            else
>>> +                trim_queued = "yes";
>>
>> Why is trim_status "supported" and trim_queued/trim_zero "yes"?
> 
> Hmm. This seems properties of trim, not independent features.
> 
>>
>>> +
>>> +            if (!ata_id_has_zero_after_trim(id))
>>> +                trim_zero = "no";
>>> +            else if (dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
>>> +                trim_zero = "yes";
>>> +            else
>>> +                trim_zero = "maybe";
>>> +
>>> +            ata_dev_info(dev, "trim: %s, queued: %s, zero_after_trim: %s\n",
>>> +                     trim_status, trim_queued, trim_zero);
>>> +        }
>>> +
>>
>> Otherwise no particular objections. We were trying to limit noise during
>> boot which is why this information originally went to sysfs instead of
>> being printed during probe.
>>
> 
> On 08.06.2019 11:25, Christoph Hellwig wrote:> On Fri, Jun 07, 2019 at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
>  >
>  > Do we really need to spam dmesg with even more ATA crap?  What about
>  > a sysfs file that can be read on demand instead?
>  >
> 
> Makes sense.
> 
> Trim state is exposed for ata_device: /sys/class/ata_device/devX.Y/trim
> but there is no link from scsi device to ata device so they hard to match.
> 
> I'll think about it.

Nope. There is no obvious way to link scsi device with ata_device.
ata_device is built on top of "transport_class" and "attribute_container".
This some extremely over engineered sysfs framework used only in ata/scsi.
I don't want to touch this.
