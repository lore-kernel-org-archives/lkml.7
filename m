Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B2C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A35F206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pcv2RYJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbfJJArm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:47:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55452 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbfJJArl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:47:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A0iLlM171680;
        Thu, 10 Oct 2019 00:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=wUw24dYwtRzDhdQ0o8HSROqGQRo01O5bW3h5i/yV0YA=;
 b=Pcv2RYJi0amWYNl6TCUmkcbjGAM5sjbz7jTIlFs2/MKodKTj2PV631IsY4xMYJFZZnqy
 k8lk7AzWgZmd8xOf+cemErBCvwQV38bmGlnVeCDdDi7Dp6C+SALF42S7u7ldrgD/CphO
 5l6JouFMsSSpBzvrrLwLnmBaEgXQ45o4iuTXXp1FRjvn0AQPdnocmDQ+HnfmTia4qHlk
 7hRowDQb9yvSffzX6g3y/PtlVzWEqk7gyupPwz0dj4Z1C5f0j72BxKbmnbdaAWy3SCbC
 DPSZ7TnSJN9TresoCGKzDXPqtDTEUFd8PSgPWyZa6ABrbI1LEKTCmls87Hlnlvhk4Bbf eA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4qqx6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 00:46:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A0cujo051434;
        Thu, 10 Oct 2019 00:46:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vhhsnm5ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 00:46:07 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9A0jxYL026366;
        Thu, 10 Oct 2019 00:45:59 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 17:45:59 -0700
Subject: Re: [PATCH -next] userfaultfd: remove set but not used variable 'h'
To:     YueHaibing <yuehaibing@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20191009122740.70517-1-yuehaibing@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a28da32b-5c26-21e9-4a08-722abf9fbeba@oracle.com>
Date:   Wed, 9 Oct 2019 17:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009122740.70517-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/19 5:27 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> mm/userfaultfd.c: In function '__mcopy_atomic_hugetlb':
> mm/userfaultfd.c:217:17: warning:
>  variable 'h' set but not used [-Wunused-but-set-variable]
> 
> It is not used since commit 78911d0e18ac ("userfaultfd: use vma_pagesize
> for all huge page size calculation")
> 

Thanks!  That should have been removed with the recent cleanups.

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
