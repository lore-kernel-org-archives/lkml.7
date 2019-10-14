Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE23ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0CA2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fqTzwBDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfJNSZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:25:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47808 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731216AbfJNSZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:25:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EIJ7R9086769;
        Mon, 14 Oct 2019 18:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=HVDimIMycCCpWVsATfl1aEnKFHWQ4XRLe41kiA9Q/7Q=;
 b=fqTzwBDx2jq4AsRlWzgxzF7niVnbAde76n7hxnp8CcSnzRFc8mkfDEX79aHCcu5hLPXS
 o75bDsXzcyyTOAsKyAOiP+YkH0T/0sBHODuZ/AJlCmun5f9m9X/1qEII/coQ3mXyYhRB
 QBRDEigK33rfpZh79aJfDEm4vt+47EKSibOXSyvWDWlOOX2hM5GiLw8VtSl+jKcOQaFG
 K9MQk2sNpT2TT3y3VHAUhKqYBIL+ijN6Yz3lb+PwJFI7PU2YK1pT/KyhQdzA3XMxcP3e
 JOsxpXBF4YzNjLABsQSs59A7udfmfaZknIiGCmoFlz+yppzQFr31tvi4v84KZ75I+tQl lA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vk6sqard2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 18:25:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EII7uV022325;
        Mon, 14 Oct 2019 18:25:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vks079bvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 18:25:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9EIPWUD001806;
        Mon, 14 Oct 2019 18:25:32 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 18:25:32 +0000
Subject: Re: [PATCH] hugetlb: Add nohugepages parameter to prevent hugepages
 creation
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, jay.vosburgh@canonical.com,
        kernel@gpiccoli.net
References: <20191011223955.1435-1-gpiccoli@canonical.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c145a020-5ae0-e3a5-0251-199618cfaa9e@oracle.com>
Date:   Mon, 14 Oct 2019 11:25:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011223955.1435-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/19 3:39 PM, Guilherme G. Piccoli wrote:
> Currently there are 2 ways for setting HugeTLB hugepages in kernel; either
> users pass parameters on kernel command-line or they can write to sysfs
> files (which is effectively the sysctl way).
> 
> Kdump kernels won't benefit from hugepages - in fact it's quite opposite,
> it may be the case hugepages on kdump kernel can lead to OOM if kernel
> gets unable to allocate demanded pages due to the fact the preallocated
> hugepages are consuming a lot of memory.
> 
> This patch proposes a new kernel parameter to prevent the creation of
> HugeTLB hugepages - we currently don't have a way to do that. We can
> even have kdump scripts removing the kernel command-line options to
> set hugepages, but it's not straightforward to prevent sysctl/sysfs
> configuration, given it happens in later boot or anytime when the
> system is running.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> ---
> 
> About some decisions took in this patch:
> 
> * early_param() was used because I couldn't find a way to enforce
> parameters' ordering when using __setup(), and we need nohugepages
> processed before all other hugepages options.

I don't know much about early_param(), so I will assume this works as you
describe.  However, a quick grep shows hugepage options for ia64 also with
early_param.

> * The return when sysctl handler is prevented to progress due to
> nohugepages is -EINVAL, but could be changed; I've just followed
> present code there, but I'm OK changing that if we have suggestions.

It looks like you only have short circuited/prevented nr_hugepages via
sysfs/sysctl.  Theoretically, one could set nr_overcommit_hugepages and
still allocate hugetlb pages.  So, if you REALLY want to shut things down
you need to stop this as well.

There is already a macro hugepages_supported() that can be set by arch
specific code.  I wonder how difficult it would be to 'overwrite' the
macro if nohugepages is specified.  Perhaps just a level of naming
indirection.  This would use the existing code to prevent all hugetlb usage.

It seems like there may be some discussion about 'the right' way to
do kdump.  I can't add to that discussion, but if such an option as
nohugepages is needed, I can help.
-- 
Mike Kravetz
