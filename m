Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7BAC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39412133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QmgF69El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfFXNuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:50:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33670 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFXNuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:50:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ODnCJ2183615;
        Mon, 24 Jun 2019 13:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SW6Szazq/wB2nNLnJHycEJb7byHwJ55tmOD9zZh4JmM=;
 b=QmgF69El//eOOAYwiDMFA/pB2Cg6Ir69CC2fmdEAI9knXHbuIo2t5IhWYLRQ2NB4UrZa
 eQKByBNHGzfTyeIofHM6kf3PTPNqTpiR74BZYP1X5Lno4YoCOWdWuLiW3DGCqaXPUz0+
 E4bUyY1cC1m4dI7CVDedv26N7Rt+nx+B/R+TY80Z9tBX4JlpiNHHe3zLPOyjCAvUCbMc
 fxmxYblZMxYmroQkBAYl8yGzBTRh1sh8Esv22I7tWF+8u6vVHH7c3KZe31p5Cej5Md7y
 pDqlTYpZHPj5HvbMTs9IcRZPugKoEkTmf20FTU6kldV79+FckoRnWcW8L4LzkLYNeGwl hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t9brsxjhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 13:50:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ODnNxj113546;
        Mon, 24 Jun 2019 13:50:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tat7bn7mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 13:50:38 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5ODoaqJ029412;
        Mon, 24 Jun 2019 13:50:37 GMT
Received: from [192.168.0.8] (/1.180.238.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 06:50:36 -0700
Subject: Re: [PATCH 3/6] x86: Add nopv parameter to disable PV extensions
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org
References: <1561294903-6166-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561294903-6166-3-git-send-email-zhenzhong.duan@oracle.com>
 <9e60cea2-a15f-b816-9049-f22be14c04b2@suse.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <cf315d9a-7027-aa8c-1cac-9be9b734811c@oracle.com>
Date:   Mon, 24 Jun 2019 21:50:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <9e60cea2-a15f-b816-9049-f22be14c04b2@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/6/24 21:18, Juergen Gross wrote:
> On 23.06.19 15:01, Zhenzhong Duan wrote:
>> In virtualization environment, PV extensions (drivers, interrupts,
>> timers, etc) are enabled in the majority of use cases which is the
>> best option.
>>
>> However, in some cases (kexec not fully working, benchmarking)
>> we want to disable PV extensions. As such introduce the
>> 'nopv' parameter that will do it.
>>
>> There is already 'xen_nopv' parameter for XEN platform but not for
>> others. 'xen_nopv' can then be removed with this change.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>> Cc: xen-devel@lists.xenproject.org
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>>   arch/x86/kernel/cpu/hypervisor.c                | 11 +++++++++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 138f666..b352f36 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5268,6 +5268,10 @@
>>               improve timer resolution at the expense of processing
>>               more timer interrupts.
>>   +    nopv=        [X86]
>> +            Disables the PV optimizations forcing the guest to run
>> +            as generic guest with no PV drivers.
>> +
>>       xirc2ps_cs=    [NET,PCMCIA]
>>               Format:
>> <irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
>> diff --git a/arch/x86/kernel/cpu/hypervisor.c 
>> b/arch/x86/kernel/cpu/hypervisor.c
>> index 479ca47..4f2c875 100644
>> --- a/arch/x86/kernel/cpu/hypervisor.c
>> +++ b/arch/x86/kernel/cpu/hypervisor.c
>> @@ -85,10 +85,21 @@ static void __init copy_array(const void *src, 
>> void *target, unsigned int size)
>>               to[i] = from[i];
>>   }
>>   +static bool nopv;
>> +static __init int xen_parse_nopv(char *arg)
>> +{
>> +    nopv = true;
>> +    return 0;
>> +}
>> +early_param("nopv", xen_parse_nopv);
>> +
>>   void __init init_hypervisor_platform(void)
>>   {
>>       const struct hypervisor_x86 *h;
>>   +    if (nopv)
>> +        return;
>> +
>
> Oh, this is no good idea.
>
> There are guest types which just won't work without pv interfaces, like
> Xen PV and Xen PVH. Letting them fail due to just a wrong command line
> parameter is not nice, especially as the failure might be very hard to
> track down to the issue for the user.
Yes, thanks for catching.
>
> I guess you could add a "ignore_nopv" member to struct hypervisor_x86
> set to true for the mentioned guest types and call the detect functions
> only if nopv is false or ignore_nopv is true.

I think your suggestion is good, I'll rework it based on your suggestion.

Thanks

Zhenzhong

