Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC84C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168192184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbfDRGWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:22:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58984 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRGWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:22:08 -0400
Received: from [125.35.49.90] (helo=[10.0.0.40])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1hH0Qt-00065n-9J; Thu, 18 Apr 2019 06:22:03 +0000
Subject: Re: [PATCH] nvme: determine the number of IO queues
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, axboe@fb.com
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <a2f0a97e14b884dc1183db9cbdd6f4b520000ce3.camel@redhat.com>
 <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
From:   Aaron Ma <aaron.ma@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=aaron.ma@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFffeLkBCACi4eE4dPsgWN6B9UDOVcAvb5QgU/hRG6yS0I1lGKQv4KA+bke0c5g8clbO
 9gIlIl2bityfA9NzBsDik4Iei3AxMbFyxv9keMwcOFQBIOZF0P3f05qjxftF8P+yp9QTV4hp
 BkFzsXzWRgXN3r8hU8wqZybepF4B1C83sm2kQ5A5N0AUGbZli9i2G+/VscG9sWfLy8T7f4YW
 MjmlijCjoV6k29vsmTWQPZ7EApNpvR5BnZQPmQWzkkr0lNXlsKcyLgefQtlwg6drK4fe4wz0
 ouBIHJEiXE1LWK1hUzkCUASra4WRwKk1Mv/NLLE/aJRqEvF2ukt3uVuM77RWfl7/H/v5ABEB
 AAG0IUFhcm9uIE1hIDxhYXJvbi5tYUBjYW5vbmljYWwuY29tPokBNwQTAQgAIQUCV994uQIb
 AwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDNxCzQfVU6ntJ9B/9aVy0+RkLqF9QpLmw+
 LAf1m3Fd+4ZarPTerqDqkLla3ekYhbrEtlI1mYuB5f+gtrIjmcW27gacHdslKB9YwaL8B4ZB
 GJKhcrntLg4YPzYUnXZkHHTv1hMw7fBYw82cBT+EbG0Djh6Po6Ihqyr3auHhfFcp1PZH4Mtq
 6hN5KaDZzF/go+tRF5e4bn61Nhdue7mrhFSlfkzLG2ehHWmRV+S91ksH81YDFnazK0sRINBx
 V1S8ts3WJ2f1AbgmnDlbK3c/AfI5YxnIHn/x2ZdXj1P/wn7DgZHmpMy5DMuk0gN34NLUPLA/
 cHeKoBAF8emugljiKecKBpMTLe8FrVOxbkrauQENBFffeLkBCACweKP3Wx+gK81+rOUpuQ00
 sCyKzdtMuXXJ7oL4GzYHbLfJq+F+UHpQbytVGTn3R5+Y61v41g2zTYZooaC+Hs1+ixf+buG2
 +2LZjPSELWPNzH9lsKNlCcEvu1XhyyHkBDbnFFHWlUlql3nSXMo//dOTG/XGKaEaZUxjCLUC
 8ehLc16DJDvdXsPwWhHrCH/4k92F6qQ14QigBMsl75jDTDJMEYgRYEBT1D/bwxdIeoN1BfIG
 mYgf059RrWax4SMiJtVDSUuDOpdwoEcZ0FWesRfbFrM+k/XKiIbjMZSvLunA4FIsOdWYOob4
 Hh0rsm1G+fBLYtT+bE26OWpQ/lSn4TdhABEBAAGJAR8EGAEIAAkFAlffeLkCGwwACgkQzcQs
 0H1VOp6p5Af/ap5EVuP1AhFdPD3pXLNrUUt72W3cuAOjXyss43qFC2YRjGfktrizsDjQU46g
 VKoD6EW9XUPgvYM+k8BJEoXDLhHWnCnMKlbHP3OImxzLRhF4kdlnLicz1zKRcessQatRpJgG
 NIiD+eFyh0CZcWBO1BB5rWikjO/idicHao2stFdaBmIeXvhT9Xp6XNFEmzOmfHps+kKpWshY
 9LDAU0ERBNsW4bekOCa/QxfqcbZYRjrVQvya0EhrPhq0bBpzkIL/7QSBMcdv6IajTlHnLARF
 nAIofCEKeEl7+ksiRapL5Nykcbt4dldE3sQWxIybC94SZ4inENKw6I8RNpigWm0R5w==
Message-ID: <e79703d5-3502-6519-a497-71b2b2a8768f@canonical.com>
Date:   Thu, 18 Apr 2019 14:21:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <096935354b16662eb481aeda1f48001ba489463c.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 1:33 AM, Maxim Levitsky wrote:
> On Wed, 2019-04-17 at 20:32 +0300, Maxim Levitsky wrote:
>> On Wed, 2019-04-17 at 22:12 +0800, Aaron Ma wrote:
>>> Some controllers support limited IO queues, when over set
>>> the number, it will return invalid field error.
>>> Then NVME will be removed by driver.
>>>
>>> Find the max number of IO queues that controller supports.
>>> When it still got invalid result, set 1 IO queue at least to
>>> bring NVME online.
>> To be honest a spec compliant device should not need this.
>> The spec states:
>>
>> "Number of I/O Completion Queues Requested (NCQR): Indicates the number of I/O
>> Completion
>> Queues requested by software. This number does not include the Admin
>> Completion
>> Queue. A
>> minimum of one queue shall be requested, reflecting that the minimum support
>> is
>> for one I/O
>> Completion Queue. This is a 0’s based value. The maximum value that may be
>> specified is 65,534
>> (i.e., 65,535 I/O Completion Queues). If the value specified is 65,535, the
>> controller should return
>> an error of Invalid Field in Command."
>>
>>
>> This implies that you can ask for any value and the controller must not
>> respond
>> with an error, but rather indicate how many queues it supports.
>>
>> Maybe its better to add a quirk for the broken device, which needs this?

Adding quirk only makes the code more complicated.
This patch doesn't change the default behavior.
Only handle the NVME error code.

Yes the IO queues number is 0's based, but driver would return error and
remove the nvme device as dead.

So set it as 1 at least the NVME can be probed properly.

Regards,
Aaron

> I forgot to add the relevant paragraph:
> 
> "Note: The value allocated may be smaller or larger than the number of queues
> requested, often in virtualized
> implementations. The controller may not have as many queues to allocate as are
> requested. Alternatively,
> the controller may have an allocation unit of queues (e.g. power of two) and may
> supply more queues to
> host software to satisfy its allocation unit."
> 
> 
> Best regards,
> 	Maxim Levitsky
> 
