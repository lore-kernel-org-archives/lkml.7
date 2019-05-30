Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16376C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D648D24410
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u9+32RdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfE3CKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:10:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34684 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfE3CKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:10:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U28pWQ004661;
        Thu, 30 May 2019 02:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=kwnUukt2cSq26vWZNoougj6vjpzzNr/Dk7uTGlSP4gI=;
 b=u9+32RdH3S0TqKiMyoKmozEDkLOWtR5m9bz6h06n8RMDri6Nm2A2nJOJKeI0F3haTzYw
 UQgqOkrgk+zDlGZKJsj8uIx4CRn7gJJCme+zgrxBkzrY9Rg0jgngGq4lAHKc/oo36k//
 Ddche3TYwKseI22lcCzjG7oFIZETE3fDkbHjbvH+gS/62vegbrxI82sH0yKZM25ddetq
 SYcd+Oi2+tUO9tJE5BwB+70/RJqfjDhJC3G4rYnlNZLXWW668+ENC4poJKaFJ96nJ4KN
 2ZDVREugKvMU+tSi2hMupM0oq6IAJb0B2kR1Hpfc2WkcmQG7HDd6/pYaZsPt/dEWtrQE eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2spu7dnj0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:10:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U28O7m011954;
        Thu, 30 May 2019 02:10:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2sqh741x77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:10:05 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4U2A2b7001712;
        Thu, 30 May 2019 02:10:02 GMT
Received: from [192.168.0.139] (/118.26.137.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 19:10:02 -0700
Subject: Re: question on lazy tlb flush
To:     Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <cd421c2c-8507-6652-2ef7-a6f3b20efcd2@oracle.com>
 <5af5f7aa8ac48d2c8a2d1809e3c7932824958a76.camel@surriel.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <d11f26c9-5a5b-9e3c-5a19-ef931f16814c@oracle.com>
Date:   Thu, 30 May 2019 10:09:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5af5f7aa8ac48d2c8a2d1809e3c7932824958a76.camel@surriel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/5/29 22:17, Rik van Riel wrote:
> On Wed, 2019-05-29 at 12:54 +0800, Zhenzhong Duan wrote:
>> Hi Maintainers,
>>
>> A question raised when I learned below code.  Appreciate any help me
>> understand the code.
>>
>> void native_flush_tlb_others(const struct cpumask *cpumask,
>>                                const struct flush_tlb_info *info)
>>
>> {
>>
>> ...
>>
>>           /*
>>            * If no page tables were freed, we can skip sending IPIs to
>>            * CPUs in lazy TLB mode. They will flush the CPU themselves
>>            * at the next context switch.
>>            *
>>            * However, if page tables are getting freed, we need to
>> send the
>>            * IPI everywhere, to prevent CPUs in lazy TLB mode from
>> tripping
>>            * up on the new contents of what used to be page tables,
>> while
>>            * doing a speculative memory access.
>>            */
>>           if (info->freed_tables)
>>                   smp_call_function_many(cpumask,
>> flush_tlb_func_remote,
>>                                  (void *)info, 1);
>>           else
>>                   on_each_cpu_cond_mask(tlb_is_not_lazy,
>> flush_tlb_func_remote,
>>                                   (void *)info, 1, GFP_ATOMIC,
>> cpumask);
>>
>> }
>>
>> I just didn't understand how a kernel thread could trip up on the
>> new
>> contents of what used to be page tables. I presume the freed page
>> tables
>> are user mapping?
> That is correct, and you ask a very good question.
>
> The software does indeed not access userspace memory
> addresses from kernel threads.
>
> However, the CPU itself can do speculative loads from
> userspace memory addresses, even when the software thread
> is running exclusively in kernel mode.
>
> Add to that the fact that the page table pages can get
> reused for something else after they have been freed, and
> that the CPU can cache intermediate translations (eg. PUD
> and PMD level things get cached in the TLB), and you might
> end up with a speculative load poking at a PCI register,
> or something else that trips up the machine.
>
> For that reason, when page table pages get freed, we need
> to flush the TLBs of all users, inluding lazy TLB kernel
> threads.

Understood. Thanks for your detailed explanation :)

Zhenzhong

