Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670BBC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40365214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfCMOMf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:12:35 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbfCMOMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:12:35 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 785CF2FC4146B8EFAE50;
        Wed, 13 Mar 2019 14:12:31 +0000 (GMT)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Mar 2019 14:12:31 +0000
Received: from fraeml704-chm.china.huawei.com (10.206.15.53) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 13 Mar 2019 16:12:30 +0200
Received: from fraeml704-chm.china.huawei.com ([10.206.112.182]) by
 fraeml704-chm.china.huawei.com ([10.206.112.182]) with mapi id
 15.01.1591.008; Wed, 13 Mar 2019 16:12:30 +0200
From:   Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        yuehaibing <yuehaibing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] exec: Fix mem leak in kernel_read_file
Thread-Topic: [PATCH -next] exec: Fix mem leak in kernel_read_file
Thread-Index: AQHUx/hXfkWBsNi2tEKokiQlVrf8Y6XmQzYAgCCDsbeAAEiIgIACrT2N
Date:   Wed, 13 Mar 2019 14:12:30 +0000
Message-ID: <0bd9d01037354048a1d45be1ce96714f@huawei.com>
References: <20190219021038.11340-1-yuehaibing@huawei.com>
 <20190219022512.GW2217@ZenIV.linux.org.uk>
 <ad928cfca24743d5bb9f01e9a3ae74bd@huawei.com>,<20190311231627.GI158926@sasha-vm>
In-Reply-To: <20190311231627.GI158926@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.122.225.32]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org







From: Sasha Levin <sashal@kernel.org>
Sent: Tuesday, March 12, 2019 1:16 AM
To: Dmitry Kasatkin
Cc: Al Viro; yuehaibing; linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; keescook@chromium.org; stable@vger.kernel.org; gregkh@google.com
Subject: Re: [PATCH -next] exec: Fix mem leak in kernel_read_file
    
On Mon, Mar 11, 2019 at 04:59:14PM +0000, Dmitry Kasatkin wrote:
>
>From: Al Viro <viro@ftp.linux.org.uk> on behalf of Al Viro <viro@zeniv.linux.org.uk>
>Sent: Tuesday, February 19, 2019 4:25 AM
>To: yuehaibing
>Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; Dmitry Kasatkin; keescook@chromium.org
>Subject: Re: [PATCH -next] exec: Fix mem leak in kernel_read_file
> 
>On Tue, Feb 19, 2019 at 10:10:38AM +0800, YueHaibing wrote:
>> syzkaller report this:
>> BUG: memory leak
>> unreferenced object 0xffffc9000488d000 (size 9195520):
>>   comm "syz-executor.0", pid 2752, jiffies 4294787496 (age 18.757s)
>>   hex dump (first 32 bytes):
>>     ff ff ff ff ff ff ff ff a8 00 00 00 01 00 00 00  ................
>>     02 00 00 00 00 00 00 00 80 a1 7a c1 ff ff ff ff  ..........z.....
>>   backtrace:
>>     [<000000000863775c>] __vmalloc_node mm/vmalloc.c:1795 [inline]
>>     [<000000000863775c>] __vmalloc_node_flags mm/vmalloc.c:1809 [inline]
>>     [<000000000863775c>] vmalloc+0x8c/0xb0 mm/vmalloc.c:1831
>>     [<000000003f668111>] kernel_read_file+0x58f/0x7d0 fs/exec.c:924
>>     [<000000002385813f>] kernel_read_file_from_fd+0x49/0x80 fs/exec.c:993
>>     [<0000000011953ff1>] __do_sys_finit_module+0x13b/0x2a0 kernel/module.c:3895
>>     [<000000006f58491f>] do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
>>     [<00000000ee78baf4>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>     [<00000000241f889b>] 0xffffffffffffffff
>>
>> It should goto 'out_free' lable to free allocated buf while kernel_read
>> fails.
>
>Applied.
>
>
>This must be applied to stables as well...

> It's already in all relevant stable trees...

I only can see in longterm 4.19.

What about 4.9 and 4.14?

Thanks,
Dmitry
