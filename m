Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA679CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC2E20650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfJaMio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:38:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726506AbfJaMim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:38:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C50CC42C892F09C4CA5E;
        Thu, 31 Oct 2019 20:38:40 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 31 Oct 2019
 20:38:38 +0800
Subject: Re: [PATCH] tty:n_gsm.c: destroy port by tty_port_destroy()
To:     Jiri Slaby <jslaby@suse.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <1569317156-45850-1-git-send-email-nixiaoming@huawei.com>
 <1fd7d2eb-7497-254b-b40f-84bc4114f8a3@suse.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <9d515be6-5430-7ca2-24e8-a8c3798beec9@huawei.com>
Date:   Thu, 31 Oct 2019 20:38:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1fd7d2eb-7497-254b-b40f-84bc4114f8a3@suse.com>
Content-Type: text/plain; charset="iso-8859-2"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 18:11, Jiri Slaby wrote:
> On 24. 09. 19, 11:25, Xiaoming Ni wrote:
>> According to the comment of tty_port_destroy():
>>      When a port was initialized using tty_port_init, one has to destroy
>>      the port by tty_port_destroy();
> 
> It continues with a part saying:
>     Either indirectly by using tty_port refcounting
>     (tty_port_put) or directly if refcounting is not used.
> 
>> tty_port_init() is called in gsm_dlci_alloc()
>> so tty_port_destroy() needs to be called in gsm_dlci_free()
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> ---
>>   drivers/tty/n_gsm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
>> index 36a3eb4..3f5bcc9 100644
>> --- a/drivers/tty/n_gsm.c
>> +++ b/drivers/tty/n_gsm.c
>> @@ -1681,6 +1681,7 @@ static void gsm_dlci_free(struct tty_port *port)
>>   
>>   	del_timer_sync(&dlci->t1);
>>   	dlci->gsm->dlci[dlci->addr] = NULL;
>> +	tty_port_destroy(&dlci->port);
> 
> This is wrong. gsm_dlci_free is tty_port_operations->destruct, i.e.
> n_gsm uses tty_port refcounting and tty_port_destroy was called on this
> port in tty_port_destructor already.
> 
> Greg, please revert.
> 
> thanks,
> 

Function call flow
tty_port_put
     ===>  tty_port_destructor
          ===> tty_port_destroy
               Port->ops->destruct(port);
                ===> .destruct = gsm_dlci_free

Thank you for your correction, I am wrong.

thanks

