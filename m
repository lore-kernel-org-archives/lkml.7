Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50180C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEB226253
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 02:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bJwtFveJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfEaCwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 22:52:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60226 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfEaCwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 22:52:00 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4V2mdkv167001;
        Fri, 31 May 2019 02:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XJT56M+Sb4lpg5OE0GLgH82BvTlMQLeJsolLEqwuW4w=;
 b=bJwtFveJ7wjgJm1mAsXSAPdzCiWZ5yakcaOnYREYPJikSM8w93ANoAQdzWRcvW9BjOfv
 gazXFMUTcRu8az7UGD81osD1tsrvogaRjYdENDEK8+ORHssNEDa1AYtVeXm8NEaL4N4U
 xMN3QWtAeZCt8XwFQrfmac4pMLuw3lsTutTCFKabSSWieQI00Bmx53CQjLGqNV6QaaKh
 OGYsuJKy+BqJx7V1Wye8mgoU+mIZNIdGINIJt7ar+a0XAw17dXV3T57nVA4WkZZQTQMF
 FNjgBGaZEQ/8uyuebiKTsJGE0BIH0rANsT5Fydjqt28gN95iXXkq9tcBzRheVEDUmh0B bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7duuaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 02:51:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4V2oS3w010040;
        Fri, 31 May 2019 02:51:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sqh74nbjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 02:51:27 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4V2pO83022654;
        Fri, 31 May 2019 02:51:25 GMT
Received: from [192.168.0.139] (/118.26.137.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 19:51:24 -0700
Subject: Re: [PATCH] x86/mm/tlb: Do partial TLB flush when possible
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, srinivas.eeda@oracle.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>
References: <1559116604-23105-1-git-send-email-zhenzhong.duan@oracle.com>
 <CALCETrU96Pjw5AEy_Aju_hMkv=QdE3YVfx5aY24B8WwDqM1A9Q@mail.gmail.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <66defe09-51f1-3def-6e5a-7a9c07430f65@oracle.com>
Date:   Fri, 31 May 2019 10:51:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrU96Pjw5AEy_Aju_hMkv=QdE3YVfx5aY24B8WwDqM1A9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/5/30 22:15, Andy Lutomirski wrote:
> On Thu, May 30, 2019 at 12:56 AM Zhenzhong Duan
> <zhenzhong.duan@oracle.com> wrote:
>> This is a small optimization to stale TLB flush, if there is one new TLB
>> flush, let it choose to do partial or full flush. or else, the stale
>> flush take over and do full flush.
> I think this is invalid because:
>
>> +       if (unlikely(f->new_tlb_gen <= local_tlb_gen &&
>> +           local_tlb_gen + 1 == mm_tlb_gen)) {
>> +               /*
>> +                * For stale TLB flush request, if there will be one new TLB
>> +                * flush coming, we leave the work to the new IPI as it knows
>> +                * partial or full TLB flush to take, or else we do the full
>> +                * flush.
>> +                */
>> +               trace_tlb_flush(reason, 0);
>> +               return;
> We do indeed know that the TLB will get flushed eventually, but we're
> actually providing a stronger guarantee that the TLB will be
> adequately flushed by the time we return.  Otherwise, after
> flush_tlb_mm_range(), there will be a window in which the TLB isn't
> flushed yet.

You are right. I didn't notice this point, sorry for the noise.

Zhenzhong

