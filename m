Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F34FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E099021928
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 02:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405556AbfITCaB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 22:30:01 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:58006 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405325AbfITCaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 22:30:00 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 70EB3FC551F96FA08BA5;
        Fri, 20 Sep 2019 10:29:58 +0800 (CST)
Received: from DGGEMM507-MBX.china.huawei.com ([169.254.1.207]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0439.000;
 Fri, 20 Sep 2019 10:29:49 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "penberg@cs.helsinki.fi" <penberg@cs.helsinki.fi>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "textshell@uchuujin.de" <textshell@uchuujin.de>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yangyingliang <yangyingliang@huawei.com>,
        yuehaibing <yuehaibing@huawei.com>,
        Zengweilin <zengweilin@huawei.com>
Subject: RE: [PATCH] tty:vt: Add check the return value of kzalloc to avoid
 oops
Thread-Topic: [PATCH] tty:vt: Add check the return value of kzalloc to avoid
 oops
Thread-Index: AQHVbss9p4oaa6BB+U6wTTWJjS3rk6cyNcqAgAGignA=
Date:   Fri, 20 Sep 2019 02:29:49 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12AE5F4FA@dggemm507-mbx.china.huawei.com>
References: <1568884695-56789-1-git-send-email-nixiaoming@huawei.com>
 <20190919092933.GA2684163@kroah.com>
In-Reply-To: <20190919092933.GA2684163@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/19 17:30, Greg KH wrote:
> On Thu, Sep 19, 2019 at 05:18:15PM +0800, Xiaoming Ni wrote:
>> Using kzalloc() to allocate memory in function con_init(), but not
>> checking the return value, there is a risk of null pointer references
>> oops.
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>
> We keep having this be "reported" 
>
>> ---
>>  drivers/tty/vt/vt.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> index 34aa39d..db83e52 100644
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
>> @@ -3357,15 +3357,33 @@ static int __init con_init(void)
>>  
>>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
>> +		if (unlikely(!vc)) {
>> +			pr_warn("%s:failed to allocate memory for the %u vc\n",
>> +					__func__, currcons);
>> +			break;
>> +		}
>
> At init, this really can not happen.  Have you see it ever happen?

I did not actually observe the null pointer here.
I am confused when I see the code allocated here without check the return value.
Small memory allocation failures are difficult to occur during system initialization
But is it not safe enough if the code is not judged?
Also if the memory allocation failure is not allowed here, is it better to add the __GFP_NOFAIL flags?

>>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>>  		tty_port_init(&vc->port);
>>  		visual_init(vc, currcons, 1);
>>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
>> +		if (unlikely(!vc->vc_screenbuf)) {
>
> Never use likely/unlikely unless you can actually measure the speed
> difference.  For something like this, the compiler will always get it
> right without you having to do anything.
>
Thank you for your guidance.
 I misuse it.

> And again, how can this fail?  Have you seen it fail?
>
>> +			pr_warn("%s:failed to allocate memory for the %u vc_screenbuf\n",
>> +					__func__, currcons);
>> +			visual_deinit(vc);
>> +			tty_port_destroy(&vc->port);
>> +			kfree(vc);
>> +			vc_cons[currcons].d = NULL;
>> +			break;
>> +		}
>>  		vc_init(vc, vc->vc_rows, vc->vc_cols,
>>  			currcons || !vc->vc_sw->con_save_screen);
>>  	}
>>  	currcons = fg_console = 0;
>>  	master_display_fg = vc = vc_cons[currcons].d;
>> +	if (unlikely(!vc)) {
>
> Again, never use likely/unlikely unless you can measure it.
>
> thanks,
>
> greg k-h
>
> .
>
thanks,
Xiaoming Ni

