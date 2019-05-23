Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E9C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981EA20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="j6fjZAw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbfEWKqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:46:55 -0400
Received: from mail-eopbgr740057.outbound.protection.outlook.com ([40.107.74.57]:58496
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729949AbfEWKqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaTak+QX0VatnP0y6Pfh1aCh+SUSTkesItNmKDJ4lsE=;
 b=j6fjZAw3Wr/GKwPXrv9LMj7i1dldekacPzkaigPoclQ4goXUTnFaCmH9fewzb9ZZHXmrWXaeujShIIp5XzzmKb2gVnyXc9x5CAyWhzCaZ545ixSoP1WUvE0MJD4k6qJoFJXObLP0GhhUqiUWBAEbRmYyviFNJU1zh0oXzPFFFwo=
Received: from MWHPR02CA0050.namprd02.prod.outlook.com (2603:10b6:301:60::39)
 by BN6PR02MB2676.namprd02.prod.outlook.com (2603:10b6:404:fa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.16; Thu, 23 May
 2019 10:46:50 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR02CA0050.outlook.office365.com
 (2603:10b6:301:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.17 via Frontend
 Transport; Thu, 23 May 2019 10:46:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Thu, 23 May 2019 10:46:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hTlFH-0003oy-Th; Thu, 23 May 2019 03:46:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hTlFC-0003fO-Qr; Thu, 23 May 2019 03:46:42 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x4NAkflx026008;
        Thu, 23 May 2019 03:46:41 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hTlFB-0003f8-3O; Thu, 23 May 2019 03:46:41 -0700
Subject: Re: [PATCH] serial-uartlite: Fix null-ptr-deref in ulite_exit
To:     Johan Hovold <johan@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, jslaby@suse.com,
        shubhrajyoti.datta@xilinx.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
References: <20190516040931.16276-1-yuehaibing@huawei.com>
 <20190517075502.GE28564@localhost> <20190521101059.GB13612@kroah.com>
 <20190523091839.GC568@localhost>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <3bdfe2ab-daec-e222-8e2b-cac96fd218a2@xilinx.com>
Date:   Thu, 23 May 2019 12:46:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523091839.GC568@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(189003)(199004)(5660300002)(4326008)(9786002)(76176011)(63266004)(81156014)(6246003)(356004)(6666004)(8936002)(36386004)(8676002)(81166006)(107886003)(6306002)(2906002)(230700001)(36756003)(64126003)(305945005)(229853002)(50466002)(65826007)(316002)(44832011)(446003)(11346002)(336012)(486006)(2616005)(126002)(426003)(2486003)(52146003)(23676004)(106002)(476003)(110136005)(58126008)(54906003)(77096007)(26005)(65806001)(186003)(65956001)(31686004)(47776003)(966005)(31696002)(325944009)(14444005)(70586007)(70206006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2676;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 968603a5-9da6-4911-fb96-08d6df6bf533
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BN6PR02MB2676;
X-MS-TrafficTypeDiagnostic: BN6PR02MB2676:
X-MS-Exchange-PUrlCount: 9
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB26763497FBFDC7B5E305F64EC6010@BN6PR02MB2676.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 00462943DE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: eQet7xD/Nqjgz9k3A/+vwCS1gspQuy9aQdnkkTQYXkOor/FJ1S7FC8kDZNZFcw3KeXyy5jG2VgJD/KAlee3LA/E3YSJ3niyymIyNbEdP4eudl7LlJREDKBeuMZTfz9bwYAloax7UlMOp7a/1i0eCGHmkFUM4iIOcJ2aWJKKhJ7mg2RbVCLlhf1fXrczvLHu2ZUWC4Eew1kd0WEbP087dJIbckzngMKswP8DgKgHXerPFzmTwc3VvOSWIbpcKFf9+o7BPT7ZMHrd9n6whrIbXXSmUL+bCkJZ1V+JbhMk3lT/8oz7vcC5LoPV+t1jj2KCaX0HvW7ltD/N8lAbFyNJTuxZrzfiFGTuETpV4z44VwTRKbg54FaikvJClouLaZkBvrB8562rEaNTMgauR/Wpcv4kR1hM2+zcXBpFLWRunbIg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2019 10:46:48.5431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968603a5-9da6-4911-fb96-08d6df6bf533
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 23. 05. 19 11:18, Johan Hovold wrote:
> On Tue, May 21, 2019 at 12:10:59PM +0200, Greg Kroah-Hartman wrote:
>> On Fri, May 17, 2019 at 09:55:02AM +0200, Johan Hovold wrote:
>>> On Thu, May 16, 2019 at 12:09:31PM +0800, YueHaibing wrote:
>>>> If ulite_probe is not called or failed to registed
>>>> uart_register_driver, unload the module will call
>>>> uart_unregister_driver, which will tigger NULL
>>>> pointer dereference like this:
>>>>
>>>> BUG: KASAN: null-ptr-deref in tty_unregister_driver+0x19/0x100
>>>> Read of size 4 at addr 0000000000000034 by task syz-executor.0/4246
>>>
>>>> This patch fix this by moving uart_unregister_driver
>>>> to ulite_remove.
>>>>
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> Fixes: 415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>> ---
>>>>  drivers/tty/serial/uartlite.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
>>>> index b8b912b..2e49fb6 100644
>>>> --- a/drivers/tty/serial/uartlite.c
>>>> +++ b/drivers/tty/serial/uartlite.c
>>>> @@ -867,6 +867,7 @@ static int ulite_remove(struct platform_device *pdev)
>>>>  	pm_runtime_disable(&pdev->dev);
>>>>  	pm_runtime_set_suspended(&pdev->dev);
>>>>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>>>> +	uart_unregister_driver(&ulite_uart_driver);
>>>
>>> This broken. Consider what happens if you have tho ports registered and
>>> you unbind the first.
>>>
>>> Someone else sent a fix for this here
>>>
>>> 	https://lkml.kernel.org/r/20190514033219.169947-1-wangkefeng.wang@huawei.com
>>>
>>> That fix also has some issues, but is still better given the current
>>> state this driver is in.
>>
>> I'm not taking any of these patches until people agree on what needs to
>> be done here :)
> 
> Good. :)
> 
>> Why is this driver so "special" it is having these types of problems?
>> Why can't it do what all other drivers do in this case?
> 
> Apparently some vendor-tree hacks has made it into mainline.

I have designed this change and it didn't go to vendor tree first.
I have been also asking if this is the right way to go.
You can find the whole series started with this RFC
https://lore.kernel.org/lkml/e2039dc5-92ec-d3a1-bc4f-6565a8c901ac@suse.de/t/

https://lkml.org/lkml/2018/6/6/346
and then

https://lkml.org/lkml/2018/9/3/404


And even this step was discussed before in
[RFC PATCH 0/4] serial: uartps: Dynamic allocation
which was July 2017.

And all these patches have been merged by Greg and then I have taken
them back to Xilinx Linux tree.

And the same concept was also applied to uartlite and intention is also
to apply it to pl011 driver to avoid this warning.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/serial/amba-pl011.c?h=v5.2-rc1#n2538

> They're
> trying to register one tty/uart driver per physical port which sounds
> like a terrible idea. And even the implementation is broken as these bug
> reports indicate.

I have followed standard process and I have been asking for advices how
to do it without hardcoded any number and limiting amount of
pre-registered uarts because adding Kconfig options for NR_UARTs was
NACK in past too.
If you know better way how this can be done, please let us know.

And if there is bug we should definitely fix it.


> A series was apparently first posted for xilinks_uartps.c, but that one
> has not yet been merged AFAICT.

Series have been applied by Great 2018-09-18. Feel free to check log here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/tty/serial/xilinx_uartps.c?h=v5.2-rc1


> A similar series was later posted for
> uartlite.c, but only the first half or so got in:
> 
> 	https://lkml.kernel.org/r/1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com
> 
> Actually, it looks like the problems started already with:
> 
> 	https://lkml.kernel.org/r/1533545534-24458-1-git-send-email-shubhrajyoti.datta@gmail.com
> 
> So the first broken commit is
> 
> 	415b43bdb008 ("tty: serial: uartlite: Move uart register to probe")
> 
> I think the offending patches should be reverted, but unfortunately they
> may no longer revert cleanly since there were some new features (e.g.
> runtime pm) thrown in the mix.

Similar changes have been sent for uartlite but they should use the same
concept as I started to use for uartps.
But based on what I see in linux-next these patches haven't been merged
there.
That's why I don't understand the reason for this patch.

If you want to see latest state of uartlite you can find it out here.
https://github.com/Xilinx/linux-xlnx

Thanks,
Michal

