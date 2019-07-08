Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3F3C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C807220665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TaUgfw0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfGHId7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:33:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50048 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfGHId7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:33:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x688SPgX112277;
        Mon, 8 Jul 2019 08:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=UQsBXsIHQtJ9LZ75WWjRdKuqkVfjHrOmOAXqkEadiCk=;
 b=TaUgfw0fnMUE1OWAZInt+uzjBe3Oa9qW9qmihJiDcTwcPHpEtwhBm64mRHjIot2G5fk9
 ip3cNdo82hxlQbJp0n4MQD3fBlUywzc8aiD83I0xQ4P4dkEa6HY4eY5vH9vZu/MffJ3R
 RMrbUupoYh5rvqvEQO/Wg7b+7CJ2yDXZeI3ERZvBHBSZfJSnS9nhUA3ArptqmrAZZpMq
 RwEWeinpD+l2Wcz2B+fMLj443Lx7JVY7zb4cUx9SdPlnKsS/nyDw1wD1d8HSI7y6M2mS
 E06aPyZh8EGm3R9b8lzYxKNoqhP/HlMgOs0nUutPO12QBbAqS75MV/EQEfpComek1Q59 UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2tjm9qcx4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 08:33:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x688XFYi039574;
        Mon, 8 Jul 2019 08:33:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tjkf22wt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jul 2019 08:33:15 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x688X90k012433;
        Mon, 8 Jul 2019 08:33:09 GMT
Received: from [10.191.18.118] (/10.191.18.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jul 2019 01:33:08 -0700
Subject: Re: [PATCH v5 4/4] x86/xen: Add "nopv" support for HVM guest
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     xen-devel@lists.xenproject.org, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
References: <1562116778-5846-1-git-send-email-zhenzhong.duan@oracle.com>
 <1562116778-5846-5-git-send-email-zhenzhong.duan@oracle.com>
 <7f5f42fd-de85-91f4-3274-055df28a27f6@oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <a1882b6a-3f97-f784-7f2b-fc1ac8ad954c@oracle.com>
Date:   Mon, 8 Jul 2019 16:33:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7f5f42fd-de85-91f4-3274-055df28a27f6@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907080112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907080111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/5 21:06, Boris Ostrovsky wrote:
> On 7/2/19 9:19 PM, Zhenzhong Duan wrote:
>> PVH guest needs PV extentions to work, so "nopv" parameter should be
>> ignored for PVH but not for HVM guest.
>>
>> If PVH guest boots up via the Xen-PVH boot entry, xen_pvh is set early,
>> we know it's PVH guest and ignore "nopv" parameter directly.
>>
>> If PVH guest boots up via the normal boot entry same as HVM guest, it's
>> hard to distinguish PVH and HVM guest at that time.
>>
>> To handle that case, add a new function xen_hvm_nopv_guest_late_init()
>> to detect PVH at a late time and panic itself if nopv enabled for a
>> PVH guest.
>>
>> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@oracle.com>
>> Cc: Boris Ostrovsky<boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross<jgross@suse.com>
>> Cc: Stefano Stabellini<sstabellini@kernel.org>
>> Cc: Thomas Gleixner<tglx@linutronix.de>
>> Cc: Ingo Molnar<mingo@redhat.com>
>> Cc: Borislav Petkov<bp@alien8.de>
>> ---
>>   arch/x86/xen/enlighten_hvm.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
>> index 1756cf7..09a010a 100644
>> --- a/arch/x86/xen/enlighten_hvm.c
>> +++ b/arch/x86/xen/enlighten_hvm.c
>> @@ -231,11 +231,37 @@ bool __init xen_hvm_need_lapic(void)
>>   	return true;
>>   }
>>   
>> +static __init void xen_hvm_nopv_guest_late_init(void)
>> +{
>> +#ifdef CONFIG_XEN_PVH
>> +	if (x86_platform.legacy.rtc || !x86_platform.legacy.no_vga)
>> +		return;
>> +
>> +	/* PVH detected. */
>> +	xen_pvh = true;
>> +
>> +	panic("\"nopv\" and \"xen_nopv\" parameters are unsupported in PVH guest.");
>> +#endif
>> +}
> Can't all of this be done in xen_hvm_guest_late_init()? It has the same
> tests already and it seems to me you should be able to panic from there.

Indeed, I didn't realize this, thanks for pointing, I'll fix it.

Zhenzhong

