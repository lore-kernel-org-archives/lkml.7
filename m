Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0BDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022542175B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfCKO3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:29:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727388AbfCKO3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:29:24 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F6868F0676FB95C4DF9;
        Mon, 11 Mar 2019 22:29:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Mon, 11 Mar 2019
 22:29:16 +0800
Subject: Re: [PATCH v2] serial: sh-sci: Missing uart_unregister_driver() on
 error in sci_probe_single()
To:     Dan Carpenter <dan.carpenter@oracle.com>
References: <20190311095115.156774-1-maowenan@huawei.com>
 <20190311124616.GE2412@kadam>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   maowenan <maowenan@huawei.com>
Message-ID: <50cd311c-651c-5c82-a3f4-8b1faf20110b@huawei.com>
Date:   Mon, 11 Mar 2019 22:29:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190311124616.GE2412@kadam>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/11 20:46, Dan Carpenter wrote:
> On Mon, Mar 11, 2019 at 05:51:15PM +0800, Mao Wenan wrote:
>> Add the missing uart_unregister_driver() before return
>> from sci_probe_single() in the error handling case.
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
> 
> Sorry, I didn't really look at the code when I saw the v1 patch.
> 
> There are other error paths, but actually the whole approach is wrong.
> Please, read my google plus post about error handling:
> 
> https://plus.google.com/u/0/106378716002406849458/posts/1Ud9JbaYnPr
> 
OK.

> But then the other rule I didn't mention in that post which applies
> here is that the error handling should "mirror" the allocation code
> so if you have:
> 
> 	if (foo) {
> 		ret = allocate_one();
> 		if (ret)
> 			return ret;
> 	}
> 	ret = allocate_two();
> 	if (ret)
> 		goto free_one;
> 
> The error handling should mirror the "if (foo) " condition.  Like this:
> 
> free_one:
> 	if (foo)
> 		free_one();
> 
> Even if you can do extra analysis and find that the "if (foo) " can
> be removed, you should leave there, because the mirroring helps human
> readers.
> 
> In this case, the code is doing:
> 
> drivers/tty/serial/sh-sci.c
>   3259                  return -EBUSY;
>   3260  
>   3261          mutex_lock(&sci_uart_registration_lock);
>   3262          if (!sci_uart_driver.state) {
>                     ^^^^^^^^^^^^^^^^^^^^^^
>   3263                  ret = uart_register_driver(&sci_uart_driver);
>   3264                  if (ret) {
>   3265                          mutex_unlock(&sci_uart_registration_lock);
>   3266                          return ret;
>   3267                  }
>   3268          }
>   3269          mutex_unlock(&sci_uart_registration_lock);
>   3270  
> 
> We would have to mirror the "if (!sci_uart_driver.state) {" code.
> 
> But actually, we can't.
> 
> The first driver to hit this code is supposed to load the
> sci_uart_driver.  We can't know if we are the last driver to stop using
> the sci_uart_driver so we can't know if we can free it.  This looks like
> a very ugly hack to me.  It should probably be using ref counters.
It seems something should be considered deeply.
> 
> regards,
> an carpenter
> 
> .
> 

