Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41416C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145E3217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JvFPeW3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfIBJlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:41:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfIBJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:41:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x829da8n125845;
        Mon, 2 Sep 2019 09:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=AfdOS5z9vEy8+ZDY2fpRv/BnQc3mYUEV45RXIeZtSJk=;
 b=JvFPeW3zcoM8nqK6I0jf9k78GoBNImSYH9V7lPrtLaBMiHBJ4RqDtwyzrh0asUggWku4
 q6g6fsD23jB7wG3P4BdyGLQUKpoig8bxYo5QjFfDM9Dds5TVdcrx3w5D5jEzlAR/e9CR
 ewUyYsDFIim+u1zS8S4eo/xb7Vc1kZ7du++0KDX8YE5LxMs5DZvl/3kb9xsz2IHtx96c
 H9hwfhwSvJBAIQTenxOJ8RCfKK5cG5dR/J5ASfHCHsYJv7phgCQT2gjK0FsGT21K3DZU
 ztz+SgptptLiKYx7ttKzq+iKXxf9+ncGtS0dmnALYKei/vtf0uzz+G8dz0zP4ljFZrgb bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2us0myg04v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 09:40:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x829dMcs112363;
        Mon, 2 Sep 2019 09:40:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2uqg82xhs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 09:40:33 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x829eWXs008355;
        Mon, 2 Sep 2019 09:40:32 GMT
Received: from [10.191.10.186] (/10.191.10.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Sep 2019 02:40:32 -0700
Subject: Re: [PATCH] x86/boot/compressed/64: Fix 'may be used uninitialized'
 issue
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>
References: <1567416624-26727-1-git-send-email-zhenzhong.duan@oracle.com>
 <20190902093534.GB9605@zn.tnic>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <8361d582-3429-c91d-3f5a-0b988a0e16ed@oracle.com>
Date:   Mon, 2 Sep 2019 17:40:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902093534.GB9605@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909020110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909020110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/2 17:35, Borislav Petkov wrote:
> On Mon, Sep 02, 2019 at 05:30:24PM +0800, Zhenzhong Duan wrote:
>> Builds kernel with "make bzImage EXTRA_CFLAGS=-Wall", gcc complains:
>>
>> arch/x86/boot/compressed/pgtable_64.c: In function 'paging_prepare':
>> arch/x86/boot/compressed/pgtable_64.c:92:7: warning: 'new' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>     new = round_down(new, PAGE_SIZE);
>>
>> In theory a random value of variable new may pass all the check and be
>> assigned to bios_start, fixing it by assigning it an initial value.
>>
>> Fixes: 0a46fff2f910 ("x86/boot/compressed/64: Fix boot on machines with broken E820 table")
>> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@oracle.com>
>> Cc: Kirill A. Shutemov<kirill@shutemov.name>
>> Cc: Thomas Gleixner<tglx@linutronix.de>
>> Cc: Ingo Molnar<mingo@redhat.com>
>> Cc: Borislav Petkov<bp@alien8.de>
>> Cc: "H. Peter Anvin"<hpa@zytor.com>
>> Cc: x86-ml<x86@kernel.org>
>> ---
>>   arch/x86/boot/compressed/pgtable_64.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
>> index 2faddeb..c886269 100644
>> --- a/arch/x86/boot/compressed/pgtable_64.c
>> +++ b/arch/x86/boot/compressed/pgtable_64.c
>> @@ -72,7 +72,7 @@ static unsigned long find_trampoline_placement(void)
>>   
>>   	/* Find the first usable memory region under bios_start. */
>>   	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
>> -		unsigned long new;
>> +		unsigned long new = bios_start;
>>   
>>   		entry = &boot_params->e820_table[i];
>>   
>> -- 
> https://git.kernel.org/tip/c96e8483cb2da6695c8b8d0896fe7ae272a07b54
>
> In the future, use tip/master when preparing fixes because it has the
> latest state of the x86 tree and you won't have to duplicate effort,
> like in this case.

Ok, I see. Thanks for your suggestion.

Zhenzhong

