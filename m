Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC1BC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3EA2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AuNkqTaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfCSASD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:18:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39478 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCSASD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:18:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2J04vYj144116;
        Tue, 19 Mar 2019 00:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Lldu1vG/QH2WxFVnpbDniVg4v7Xl0DVSsToxUgGZAEY=;
 b=AuNkqTaWgAsBO97qvRjuPcAPyrz2oYRov0fO+QB5qRQvEEc8oYPvd5frhBaootArwSNO
 hftVfJmnQVg4vbXgVWqyWEDxgcBurBeX8FOVnMag5s0w0HSI5j/oFdQ9iKTgXRJcxDbq
 u880Vuub4Pir02Z1wPsX5L9u0uJSpRB5l8I5BYFjJ2y4FAMfzQSiodtZh+SBuIbIfem9
 qsLMij9K8eNb9Yyrf+bPPkqtIrZWDm6y36mTPvKLotUX739qcjYz1rscLFdwi0RENMqp
 mm5H7nC99QoaJVfrTQByW864c6RVko+5R2NUIwF0vCN5BQ76GZzcUIJTfIjsIYEo5Gd0 iA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2r8ssr9gys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 00:17:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2J0Hkca030025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 00:17:46 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2J0HjDJ020737;
        Tue, 19 Mar 2019 00:17:45 GMT
Received: from [192.168.1.222] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 17:17:45 -0700
Subject: Re: [PATCH] include/linux/hugetlb.h: Convert to use vm_fault_t
To:     Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
References: <20190318162604.GA31553@jordon-HP-15-Notebook-PC>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <08a039da-6bc2-0da9-e83e-46cce6d7264b@oracle.com>
Date:   Mon, 18 Mar 2019 17:17:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318162604.GA31553@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/18/19 9:26 AM, Souptick Joarder wrote:
> kbuild produces the below warning ->
> 
> tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5453a3df2a5eb49bc24615d4cf0d66b2aae05e5f
> commit 3d3539018d2c ("mm: create the new vm_fault_t type")
> reproduce:
>         # apt-get install sparse
>         git checkout 3d3539018d2cbd12e5af4a132636ee7fd8d43ef0
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
>>> mm/memory.c:3968:21: sparse: incorrect type in assignment (different
>>> base types) @@    expected restricted vm_fault_t [usertype] ret @@
>>> got e] ret @@
>    mm/memory.c:3968:21:    expected restricted vm_fault_t [usertype] ret
>    mm/memory.c:3968:21:    got int
> 
> This patch will convert to return vm_fault_t type for hugetlb_fault()
> when CONFIG_HUGETLB_PAGE =n.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Thanks for fixing this.

The BUG() here and in several other places in this file is unnecessary
and IMO should be cleaned up.  But that is beyond the scope of this fix.
Added to my to do list.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
