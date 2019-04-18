Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73888C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E95214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfDRGZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:25:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59029 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfDRGZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:25:11 -0400
Received: from [125.35.49.90] (helo=[10.0.0.40])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1hH0Tn-0006Gf-Q7; Thu, 18 Apr 2019 06:25:04 +0000
Subject: Re: [PATCH] nvme: determine the number of IO queues
To:     "Edmund Nadolski (Microsoft)" <edmund.f.nadolski@gmail.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, axboe@fb.com
References: <1555510379-20199-1-git-send-email-aaron.ma@canonical.com>
 <08ac5733-596b-598d-c821-f1aa2dc32650@gmail.com>
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
Message-ID: <2024829f-4b8f-7f83-d861-da009cd75edb@canonical.com>
Date:   Thu, 18 Apr 2019 14:24:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <08ac5733-596b-598d-c821-f1aa2dc32650@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 5:30 AM, Edmund Nadolski (Microsoft) wrote:
> On 4/17/19 7:12 AM, Aaron Ma wrote:
>> Some controllers support limited IO queues, when over set
>> the number, it will return invalid field error.
>> Then NVME will be removed by driver.
>>
>> Find the max number of IO queues that controller supports.
>> When it still got invalid result, set 1 IO queue at least to
>> bring NVME online.
>>
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>>   drivers/nvme/host/core.c | 29 ++++++++++++++++++-----------
>>   1 file changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 2c43e12b70af..fb7f05c310c8 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -1134,14 +1134,24 @@ static int nvme_set_features(struct nvme_ctrl
>> *dev, unsigned fid, unsigned dword
>>     int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>>   {
>> -    u32 q_count = (*count - 1) | ((*count - 1) << 16);
>> +    u32 q_count;
>>       u32 result;
>> -    int status, nr_io_queues;
>> -
>> -    status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES, q_count,
>> NULL, 0,
>> -            &result);
>> -    if (status < 0)
>> -        return status;
>> +    int status = -1;
>> +    int nr_io_queues;
>> +    int try_count;
>> +
>> +    for (try_count = *count; try_count > 0; try_count--) {
>> +        q_count = (try_count - 1) | ((try_count - 1) << 16);
> 
> A macro here might help readability.

Will add in V2.

> 
>> +        status = nvme_set_features(ctrl, NVME_FEAT_NUM_QUEUES,
>> +                q_count, NULL, 0, &result);
>> +        if (status < 0)
>> +            return status;
>> +        else if (status == 0) {
> 
> else following return is not needed.

 *      0: successful read
 *      > 0: NVMe error status code
 *      < 0: Linux errno error code

3 conditions should be taken care.
status > 0 will be handled after loop.

else is needed.

> 
> 
>> +            nr_io_queues = min(result & 0xffff, result >> 16) + 1;
> 
> Likewise, a macro as above.

Will add in V2.

> 
> 
> Ed
> 
>> +            *count = min(try_count, nr_io_queues);
>> +            break;
>> +        }
>> +    }
>>         /*
>>        * Degraded controllers might return an error when setting the
>> queue
>> @@ -1150,10 +1160,7 @@ int nvme_set_queue_count(struct nvme_ctrl
>> *ctrl, int *count)
>>        */
>>       if (status > 0) {
>>           dev_err(ctrl->device, "Could not set queue count (%d)\n",
>> status);
>> -        *count = 0;
>> -    } else {
>> -        nr_io_queues = min(result & 0xffff, result >> 16) + 1;
>> -        *count = min(*count, nr_io_queues);
>> +        *count = 1;
>>       }
>>         return 0;
>>
> 
