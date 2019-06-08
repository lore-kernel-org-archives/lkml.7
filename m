Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172E9C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B979A214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="oxaM1Xis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfFHJM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 05:12:59 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:54554 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbfFHJM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:12:58 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id AA5982E0DB6;
        Sat,  8 Jun 2019 12:12:54 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id QsaXMhCqJa-CrO0pb2o;
        Sat, 08 Jun 2019 12:12:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559985174; bh=MMiLmgNqJUSrJfw+GaF3nM145kVYKZXwjH0MmNsHYnE=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=oxaM1Xist0o3ZYctT6hPBHwXsMEwEtne7sZuaC2AhLCTbKfHH2g2Vbq6WrpOmAm7q
         0w53IkIB0dMeXpVT6fAKGZU/M49zsaITjV/keuzdLGZZgiRLeNcsdtu5bCbV24uqxu
         BV5xWjfRv1MbhWMmcdLqXGb03nlr3mUAjBYwcG2U=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net [2a02:6b8:0:827::1:20])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id hX5gvk80Kz-CrYqk4qr;
        Sat, 08 Jun 2019 12:12:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] drivers/ata: print trim features at device initialization
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <155989287898.1506.14253954112551051148.stgit@buzz>
 <yq1wohxib7t.fsf@oracle.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <eebfb1cc-f6d0-580e-1d56-2af0f481a92f@yandex-team.ru>
Date:   Sat, 8 Jun 2019 12:12:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <yq1wohxib7t.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2019 19:58, Martin K. Petersen wrote:
> 
> Konstantin,
> 
>> +			if (dev->horkage & ATA_HORKAGE_NOTRIM)
>> +				trim_status = "backlisted";
> 
> blacklisted

Oops. My bad.

> 
>> +			else
>> +				trim_status = "supported";
>> +
>> +			if (!ata_fpdma_dsm_supported(dev))
>> +				trim_queued = "no";
>> +			else if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
>> +				trim_queued = "backlisted";
> 
> ditto
> 
>> +			else
>> +				trim_queued = "yes";
> 
> Why is trim_status "supported" and trim_queued/trim_zero "yes"?

Hmm. This seems properties of trim, not independent features.

> 
>> +
>> +			if (!ata_id_has_zero_after_trim(id))
>> +				trim_zero = "no";
>> +			else if (dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM)
>> +				trim_zero = "yes";
>> +			else
>> +				trim_zero = "maybe";
>> +
>> +			ata_dev_info(dev, "trim: %s, queued: %s, zero_after_trim: %s\n",
>> +				     trim_status, trim_queued, trim_zero);
>> +		}
>> +
> 
> Otherwise no particular objections. We were trying to limit noise during
> boot which is why this information originally went to sysfs instead of
> being printed during probe.
> 

On 08.06.2019 11:25, Christoph Hellwig wrote:> On Fri, Jun 07, 2019 at 10:34:39AM +0300, Konstantin Khlebnikov wrote:
 >
 > Do we really need to spam dmesg with even more ATA crap?  What about
 > a sysfs file that can be read on demand instead?
 >

Makes sense.

Trim state is exposed for ata_device: /sys/class/ata_device/devX.Y/trim
but there is no link from scsi device to ata device so they hard to match.

I'll think about it.
