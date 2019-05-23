Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB0FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166552133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lp/0yHQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfEWMsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:48:07 -0400
Received: from mail-eopbgr790072.outbound.protection.outlook.com ([40.107.79.72]:12312
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728309AbfEWMsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98/9JVKedYk32ITwR1SYoZCfVhoIEOVCTNqnNd948As=;
 b=lp/0yHQCqodGQa6cfnWCuLMG8yOh6GL6U9x/A4ysDkWElg0wSmheVDDoLoTHVsRBBvE3G4xuOS75KznGoFRVVTbmcMTfAhrqE//uAPPHUTvK8ig5XKC6DAmYbsJmhbSYH6SqpdwAtgL/rNm5Nylq9r7syheNexza7UYI7FNltjo=
Received: from DM6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:5:1f4::18)
 by CH2PR02MB6229.namprd02.prod.outlook.com (2603:10b6:610:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.19; Thu, 23 May
 2019 12:47:58 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by DM6PR02CA0077.outlook.office365.com
 (2603:10b6:5:1f4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.15 via Frontend
 Transport; Thu, 23 May 2019 12:47:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Thu, 23 May 2019 12:47:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45181 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hTn8X-00070F-KF; Thu, 23 May 2019 05:47:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hTn8S-0004Ey-HJ; Thu, 23 May 2019 05:47:52 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x4NClmw8006719;
        Thu, 23 May 2019 05:47:48 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hTn8N-0004EY-Qc; Thu, 23 May 2019 05:47:48 -0700
Subject: Re: [PATCH] serial-uartlite: Fix null-ptr-deref in ulite_exit
To:     Johan Hovold <johan@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, jslaby@suse.com,
        shubhrajyoti.datta@xilinx.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20190516040931.16276-1-yuehaibing@huawei.com>
 <20190517075502.GE28564@localhost> <20190521101059.GB13612@kroah.com>
 <20190523091839.GC568@localhost>
 <3bdfe2ab-daec-e222-8e2b-cac96fd218a2@xilinx.com>
 <20190523123140.GF568@localhost>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <dd262bb0-3af3-fbbb-b26e-68a23e937d9a@xilinx.com>
Date:   Thu, 23 May 2019 14:47:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523123140.GF568@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(199004)(189003)(4326008)(44832011)(6246003)(63266004)(81156014)(81166006)(8676002)(8936002)(9786002)(966005)(316002)(6306002)(486006)(77096007)(186003)(336012)(26005)(229853002)(2906002)(476003)(446003)(11346002)(2616005)(305945005)(126002)(70206006)(70586007)(426003)(36386004)(14444005)(50466002)(31696002)(31686004)(110136005)(478600001)(6666004)(54906003)(356004)(64126003)(36756003)(76176011)(106002)(23676004)(5660300002)(52146003)(65956001)(47776003)(65806001)(58126008)(65826007)(325944009)(2486003)(230700001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6229;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86b9e270-4203-4dfd-d154-08d6df7ce22f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:CH2PR02MB6229;
X-MS-TrafficTypeDiagnostic: CH2PR02MB6229:
X-MS-Exchange-PUrlCount: 8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CH2PR02MB62295CB61EBEDE91AD16FCC4C6010@CH2PR02MB6229.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 00462943DE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: j22O3zr/mf0vRk7ghtdmLgaNqWggp27qbuxuvwDzBg8ykQK00iYB5GIv0im0BHOxnomG849fKTqsJdbXVpv/K9bXS/Lu7LWJsknQj2w+4OrAA4LhdR0OR/U/Sv7jqYDRIJDpdmjOUAOope6ckzC+6JiKEQT4Kzn360Tsc8gB6lSkCndTD2hMiWZz1Y+nQcONdWac4mqVgR3HoDWvwGD+DZGzJ9R75hhbhxFG5hMRdR4GBCRi4kQE0Lm+JNOpkyJyVsnAZlNOC0z66hoDdwjWlRYfosvZqJOvnyeU2sLXK1fOb9fI62tY0aQD07hcS05GQPbxabSJAy+BLAE+QqMY2BbnfPdVTSo/MGhNUsX3QuegoFQuBPf5Rh0MMpdjWF0VCIV9IyqkmJ6YnYZBsosWYnTn6VZro3n7YXSehaLjJ8A=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2019 12:47:57.9984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b9e270-4203-4dfd-d154-08d6df7ce22f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 05. 19 14:31, Johan Hovold wrote:
> On Thu, May 23, 2019 at 12:46:38PM +0200, Michal Simek wrote:
>> Hi Johan,
>>
>> On 23. 05. 19 11:18, Johan Hovold wrote:
>>> On Tue, May 21, 2019 at 12:10:59PM +0200, Greg Kroah-Hartman wrote:
>>>> On Fri, May 17, 2019 at 09:55:02AM +0200, Johan Hovold wrote:
>>>>> On Thu, May 16, 2019 at 12:09:31PM +0800, YueHaibing wrote:
>>>>>> If ulite_probe is not called or failed to registed
>>>>>> uart_register_driver, unload the module will call
>>>>>> uart_unregister_driver, which will tigger NULL
>>>>>> pointer dereference like this:
>>>>>>
>>>>>> BUG: KASAN: null-ptr-deref in tty_unregister_driver+0x19/0x100
>>>>>> Read of size 4 at addr 0000000000000034 by task syz-executor.0/4246
>>>>>
>>>>>> This patch fix this by moving uart_unregister_driver
>>>>>> to ulite_remove.
>>>>>>
>>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>>> Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
>>>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>>>> ---
>>>>>>  drivers/tty/serial/uartlite.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
>>>>>> index b8b912b..2e49fb6 100644
>>>>>> --- a/drivers/tty/serial/uartlite.c
>>>>>> +++ b/drivers/tty/serial/uartlite.c
>>>>>> @@ -867,6 +867,7 @@ static int ulite_remove(struct platform_device *pdev)
>>>>>>  	pm_runtime_disable(&pdev->dev);
>>>>>>  	pm_runtime_set_suspended(&pdev->dev);
>>>>>>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>>>>>> +	uart_unregister_driver(&ulite_uart_driver);
>>>>>
>>>>> This broken. Consider what happens if you have tho ports registered and
>>>>> you unbind the first.
>>>>>
>>>>> Someone else sent a fix for this here
>>>>>
>>>>> 	https://lkml.kernel.org/r/20190514033219.169947-1-wangkefeng.wang@huawei.com
>>>>>
>>>>> That fix also has some issues, but is still better given the current
>>>>> state this driver is in.
>>>>
>>>> I'm not taking any of these patches until people agree on what needs to
>>>> be done here :)
>>>
>>> Good. :)
>>>
>>>> Why is this driver so "special" it is having these types of problems?
>>>> Why can't it do what all other drivers do in this case?
>>>
>>> Apparently some vendor-tree hacks has made it into mainline.
>>
>> I have designed this change and it didn't go to vendor tree first.
>> I have been also asking if this is the right way to go.
>> You can find the whole series started with this RFC
>> https://lore.kernel.org/lkml/e2039dc5-92ec-d3a1-bc4f-6565a8c901ac@suse.de/t/
>>
>> https://lkml.org/lkml/2018/6/6/346
>> and then
>>
>> https://lkml.org/lkml/2018/9/3/404
> 
> Looks like you didn't get any real feedback to your first two RFC
> series, before you resent as non-RFC and it was merged without any
> discussion. :/
> 
>> And even this step was discussed before in
>> [RFC PATCH 0/4] serial: uartps: Dynamic allocation
>> which was July 2017.
> 
> Yeah, you definitely tried to get feedback on this.
> 
>> And all these patches have been merged by Greg and then I have taken
>> them back to Xilinx Linux tree.
> 
> Right, I had missed some of the back story.
> 
>> And the same concept was also applied to uartlite and intention is also
>> to apply it to pl011 driver to avoid this warning.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/amba-pl011.c?h=v5.2-rc1#n2538
> 
> Perhaps you should hold off on spreading this further until it can be
> reviewed. Looks like it's mostly contained to xilinx_uartps right now.
> 
>>> They're trying to register one tty/uart driver per physical port
>>> which sounds like a terrible idea. And even the implementation is
>>> broken as these bug reports indicate.
>>
>> I have followed standard process and I have been asking for advices how
>> to do it without hardcoded any number and limiting amount of
>> pre-registered uarts because adding Kconfig options for NR_UARTs was
>> NACK in past too.
> 
> Yep, you clearly tried to get feedback, but our process fails sometimes.
> 
>> If you know better way how this can be done, please let us know.
> 
> Having separate tty drivers and allocating a new major number for every
> serial port clearly isn't the right way at least (and especially not for
> fpga uarts of which there could be plenty).


There is no fixed major number for uartps which is not the case for
uartlite.
It means from description you can see that every uartps instance is
getting different major number and also different minor number.
I am aware about this and it was also described. I have one issue
regarding this flying around. But thinking to save non 0 major number
after first registration and pass it to other instances to avoid this
behavior.

In uartlite where dynamic major number allocation is not present you get
correct behavior.
uartlite0 204/187
uartlite1 204/188
etc.

> If you can't implement what you're after with the current serial-core
> and tty infrastructure, those subsystems may need to be updated first.

I didn't need to change anything in tty core because all of this is
possible to do. There was one patch in connection to reading aliases
which was properly reviewed and applied.
In general DT aliases behavior should be the same across all boards but
in reality it is not.

>> And if there is bug we should definitely fix it.
> 
> Yes, but not by papering over the problem. 

sure. This is the first time I hear about it. Based on my understanding
and current linux-next this patch is wrong. If there is any other series
please keep in me in CC and I will take a look at will test it on HW.


>>> A series was apparently first posted for xilinks_uartps.c, but that one
>>> has not yet been merged AFAICT.
>>
>> Series have been applied by Great 2018-09-18. Feel free to check log here:
> 
> "Greg the Great" does have a nice ring to it. ;)


:-) nice typo.

> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/tty/serial/xilinx_uartps.c?h=v5.2-rc1
> 
> Yeah, sorry, I was obviously looking at the wrong tree this morning.

good.

> 
>>> A similar series was later posted for
>>> uartlite.c, but only the first half or so got in:
>>>
>>> 	https://lkml.kernel.org/r/1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com
>>>
>>> Actually, it looks like the problems started already with:
>>>
>>> 	https://lkml.kernel.org/r/1533545534-24458-1-git-send-email-shubhrajyoti.datta@gmail.com
>>>
>>> So the first broken commit is
>>>
>>> 	415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
>>>
>>> I think the offending patches should be reverted, but unfortunately they
>>> may no longer revert cleanly since there were some new features (e.g.
>>> runtime pm) thrown in the mix.
>>
>> Similar changes have been sent for uartlite but they should use the same
>> concept as I started to use for uartps.
>> But based on what I see in linux-next these patches haven't been merged
>> there.
>> That's why I don't understand the reason for this patch.
> 
> As I mentioned above, only half of the uartlite series was merged, but
> that was enough to break module unload.

I didn't strictly follow this. Internally I have reviewed it but didn't
watch what exactly was merged to mainline.

Thanks,
Michal
