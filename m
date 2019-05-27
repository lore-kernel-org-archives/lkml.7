Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFABC282E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617352075C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 02:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfE0Cdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 22:33:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbfE0Cdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 22:33:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D7F0E9D3FE75A93C40BB;
        Mon, 27 May 2019 10:33:33 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 10:33:29 +0800
Subject: =?UTF-8?Q?Re:_[PATCH_net]_staging:_Remove_set_but_not_used_variable?=
 =?UTF-8?B?IOKAmHN0YXR1c+KAmQ==?=
To:     Sven Van Asbroeck <thesven73@gmail.com>
References: <20190525042642.78482-1-maowenan@huawei.com>
 <CAGngYiX04W+-jxqnWUD6CLh8LAr61FhtADGM0zbGcdeArqzC-Q@mail.gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Sowden <jeremy@azazel.net>,
        <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        "Matt Sickler" <matt.sickler@daktronics.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <05c9bfac-c3ad-5889-8f47-0e6f53844a76@huawei.com>
Date:   Mon, 27 May 2019 10:33:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGngYiX04W+-jxqnWUD6CLh8LAr61FhtADGM0zbGcdeArqzC-Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/25 20:59, Sven Van Asbroeck wrote:
> On Sat, May 25, 2019 at 12:20 AM Mao Wenan <maowenan@huawei.com> wrote:
>>
>> The variable 'status' is not used any more, remve it.
> 
>>      /* do the transfers for this message */
>>      list_for_each_entry(transfer, &m->transfers, transfer_list) {
>>          if (transfer->tx_buf == NULL && transfer->rx_buf == NULL && transfer->len) {
>> -            status = -EINVAL;
>>              break;
>>          }
> 
> This looks like an error condition that's not reported to the spi core.
> 
> Instead of removing the status variable (which also removes the error value!),
> maybe this should be reported to the spi core instead ?
> 
> Other spi drivers appear to do the following on the error path:
> m->status = status;
> return status;

I have reviewed the code again, and it is good idea to store m->status in error path, like below?

@@ -374,7 +374,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
     list_for_each_entry(transfer, &m->transfers, transfer_list) {
         if (transfer->tx_buf == NULL && transfer->rx_buf == NULL && transfer->len) {
             status = -EINVAL;
-            break;
+            goto error;
         }

         /* transfer */
@@ -412,7 +412,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)

             if (count != transfer->len) {
                 status = -EIO;
-                break;
+                goto error;
             }
         }


...

     /* done work */
     spi_finalize_current_message(master);
     return 0;
+
+ error:
+    m->status = status;
+    return status;

 }


> 
>>
>> @@ -370,7 +368,6 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
>>
>>              if (count != transfer->len) {
>> -                status = -EIO;
>>                  break;
> 
> Same issue here.
> 
> 

