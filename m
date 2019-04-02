Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0AA2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gwQKBKaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDBUk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:40:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38922 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfDBUky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:40:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32IXiSl032070;
        Tue, 2 Apr 2019 18:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nzLm0OjyIrPaufp+45RiSA1Tm0FZroyUlXyqz6uPM4M=;
 b=gwQKBKaNO0Rld4H9xBxYSHPyARFdqbfhgM6doGS1wet7d7T2zzaGSVkv4I3FA8F2lzpH
 ZJ2FHGt/7Yd/w5tWgKhCCFXMAk/pA2Dx3t1ZvUPMRK5dEb7VzGCQBFp41gnF3Ndrnpho
 ZOc3HLKhRKYg61WdthsEb4ewOodom11QNaR/JGW1pRwm8pU0syvJ9palKN+uoq/fuvOW
 VLqCOqn8OzJqNFRmipwEuaH6Dsxa/B8gdp0Jtu6XORmzj3qP0HyZ776SrkQAxXlw8/Qs
 Y9rNHyQQMwDLn82f4cfDopCja3WL2g2ezu1OrPIZvcUlw91Nwj4zApkHBUUqa70rG0Ka dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2rj0dnk1b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 18:41:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32IbImT008481;
        Tue, 2 Apr 2019 18:37:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2rm9mhmawe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 18:37:23 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x32IbL9C017898;
        Tue, 2 Apr 2019 18:37:21 GMT
Received: from [192.168.1.222] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 11:37:21 -0700
Subject: Re: [PATCH] mm/hugetlb: Get rid of NODEMASK_ALLOC
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190402133415.21983-1-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8152cb75-da42-0fe7-9aac-82b1b8929f09@oracle.com>
Date:   Tue, 2 Apr 2019 11:37:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402133415.21983-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904020124
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 6:34 AM, Oscar Salvador wrote:
> NODEMASK_ALLOC is used to allocate a nodemask bitmap, ant it does it by
                                                          ^
> first determining whether it should be allocated in the stack or dinamically
                                                                    ^
> depending on NODES_SHIFT.
> Right now, it goes the dynamic path whenever the nodemask_t is above 32
> bytes.
> 
> Although we could bump it to a reasonable value, the largest a nodemask_t
> can get is 128 bytes, so since __nr_hugepages_store_common is called from
> a rather shore stack we can just get rid of the NODEMASK_ALLOC call here.
               ^
In addition, the possible call stacks after this routine are not too deep.
Worst case is high order page allocation.

> 
> This reduces some code churn and complexity.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Not a huge deal, but a few typos in the commit message.  Thanks for the
clean up.
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
