Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D76C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D44205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 23:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CpkVOYU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgAIXaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:30:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgAIXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 18:30:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 009NSmIg192998;
        Thu, 9 Jan 2020 23:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=mRGveEf/LQllrkPFYbXImW1JYkM5dZmKgDk7Iei+h40=;
 b=CpkVOYU9UV1Jn+6qMnVxcNliqaJLEUd6hxRgnL3K0t24lWIbFvXNxIRBF+c8lqHPIcL1
 EaAXUPde6GIjtfIrlD+u/W2JV91wDskz0OyAJifree2/rfo8BuAaC1VUYYdR/3I7+6bO
 Dmq8Sp75019nvV0YQuV7JQ0yEnWpgeADWEkGrB+Vg96d5YHT31kRmlUl0ZX4E1hMIFd5
 Kd7siMsjgAN/3VrAFg6B3OqMXP0QFEHCOz+jY4efWZ6zkVcZ8f76oVmvuZM1VTV2+uGG
 O3kkAIXRD5Q1CYXuz/hskyfM9grCnNH7U+q93qDmVBq2pq+gA0VQ5EG3ovJMfHaG4Tcm xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xaj4ue779-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jan 2020 23:29:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 009NO7Bt063938;
        Thu, 9 Jan 2020 23:27:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xdms0aay4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jan 2020 23:27:43 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 009NReTB004699;
        Thu, 9 Jan 2020 23:27:40 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jan 2020 15:27:40 -0800
Subject: Re: [PATCH v1 2/4] x86/xen: add basic KASAN support for PV kernel
To:     Sergey Dyasli <sergey.dyasli@citrix.com>, xen-devel@lists.xen.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200108152100.7630-1-sergey.dyasli@citrix.com>
 <20200108152100.7630-3-sergey.dyasli@citrix.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <5214cb54-1719-f93b-130f-90c5da31e22a@oracle.com>
Date:   Thu, 9 Jan 2020 18:27:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200108152100.7630-3-sergey.dyasli@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001090195
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001090196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/20 10:20 AM, Sergey Dyasli wrote:
> @@ -1943,6 +1973,15 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
>   	if (i && i < pgd_index(__START_KERNEL_map))
>   		init_top_pgt[i] = ((pgd_t *)xen_start_info->pt_base)[i];
>   
> +#ifdef CONFIG_KASAN
> +	/*
> +	 * Copy KASAN mappings
> +	 * ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
> +	 */
> +	for (i = 0xec0 >> 3; i < 0xfc0 >> 3; i++)

Are you referring here to  KASAN_SHADOW_START and KASAN_SHADOW_END? If 
so, can you use them instead?

-boris

> +		init_top_pgt[i] = ((pgd_t *)xen_start_info->pt_base)[i];
> +#endif
> +
>   

