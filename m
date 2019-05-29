Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDFFC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F14D20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P5KPPLS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfE2Hge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:36:34 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49044 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfE2Hge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:36:34 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4T4s9jf141872;
        Wed, 29 May 2019 04:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=xO/I95wa/BDchQFoLjVha8GkTVVJiQMKwy7fu/wkxYA=;
 b=P5KPPLS2UzjMJn6rGUCVjhYHj8LaJwoGOxhnoVHzWY+CmNEcnqmounAsekASPzNLBOro
 MaXZltz3kUZk/zCQoeyPB6vOfizOZyGpKOj9ez31MiimJ1LBuinzD1XDAvZO21j4ddeD
 vm3qPI94Hu3mANEt5VILtTSbGR+kD4wLVvmAqIpp4ieESvWfzO9biPI3ZS2hR0gIIvgZ
 eJohCUeOWnwh7B8mQ+eXwqSkc+KCKqD8lFE71DecQ3wpEziD05jDCH5HCGZDPcmSAGtl
 MAzisqiEfgOq0kKmC935/NBp4Z4gUgmAp4O8dCVHDw8x1zZw2N5BhYKW/qnTnpuk3XKN ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2spu7dfc6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 04:55:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4T4sHBi124365;
        Wed, 29 May 2019 04:55:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sr31v1hy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 04:55:06 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4T4t5v9001280;
        Wed, 29 May 2019 04:55:05 GMT
Received: from [192.168.0.139] (/118.26.137.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 21:55:05 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     riel@surriel.com
Subject: question on lazy tlb flush
Message-ID: <cd421c2c-8507-6652-2ef7-a6f3b20efcd2@oracle.com>
Date:   Wed, 29 May 2019 12:54:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290032
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainers,

A question raised when I learned below code.  Appreciate any help me 
understand the code.

void native_flush_tlb_others(const struct cpumask *cpumask,
                              const struct flush_tlb_info *info)

{

...

         /*
          * If no page tables were freed, we can skip sending IPIs to
          * CPUs in lazy TLB mode. They will flush the CPU themselves
          * at the next context switch.
          *
          * However, if page tables are getting freed, we need to send the
          * IPI everywhere, to prevent CPUs in lazy TLB mode from tripping
          * up on the new contents of what used to be page tables, while
          * doing a speculative memory access.
          */
         if (info->freed_tables)
                 smp_call_function_many(cpumask, flush_tlb_func_remote,
                                (void *)info, 1);
         else
                 on_each_cpu_cond_mask(tlb_is_not_lazy, 
flush_tlb_func_remote,
                                 (void *)info, 1, GFP_ATOMIC, cpumask);

}

I just didn't understand how a kernel thread could trip up on the new 
contents of what used to be page tables. I presume the freed page tables 
are user mapping?

But kernel thread only access kernel address space, is kernel space also 
freed?


thanks

Zhenzhong

