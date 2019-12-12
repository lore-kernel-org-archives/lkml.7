Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21E7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F8D2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GJxpLefd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfLLTXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:23:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40266 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbfLLTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:23:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCJJ9mB111910;
        Thu, 12 Dec 2019 19:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=0alWbgE46g/ct/UN84jiFPYKn6cVaNLX6mSZlhl2YkE=;
 b=GJxpLefdM+whF00+XO36+2oZ1FKudbI7+f35/iAmZLOmY8lPFuNiZSlong79jAS62E4F
 1aqytFpWj4MKnuWBNeCZRtOtLDhk0foIScYZFWfC4j7lUOs5Y+msgvgOP1PnNtaz2Pep
 ViKQEmmaZXu04TCymam22CkiADj11JXEjLjLjY7yT7SulVPmeFpFHLzV987cVlIZ/6bJ
 w8oopAUjJDL5u7Kz6ejnm7/8GwzsKaEldhqePtl78JT+Lq3U9w72jttNARbankL2N+Br
 Q/+ZjtihA1e0Qo9s0iRUaqus0AHKoX0B1QVTw6oqbLxr/bGycJ6r2wOGu7cJQVCIIzXj HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wrw4nhx13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 19:22:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCJJN2R083602;
        Thu, 12 Dec 2019 19:22:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wumw13jmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 19:22:58 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBCJMuPE023322;
        Thu, 12 Dec 2019 19:22:56 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Dec 2019 11:22:56 -0800
Subject: Re: [PATCH v2] mm/hugetlb: defer free_huge_page() to a workqueue
To:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>, aneesh.kumar@linux.ibm.com
References: <20191211194615.18502-1-longman@redhat.com>
 <4fbc39a9-2c9c-4c2c-2b13-a548afe6083c@oracle.com>
 <32d2d4f2-83b9-2e40-05e2-71cd07e01b80@redhat.com>
 <0fcce71f-bc20-0ea3-b075-46592c8d533d@oracle.com>
 <20191212060650.ftqq27ftutxpc5hq@linux-p48b>
 <20191212063050.ufrpij6s6jkv7g7j@linux-p48b>
 <20191212190427.ouyohviijf5inhur@linux-p48b>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d6b9743c-776c-d740-73af-a600f15b910a@oracle.com>
Date:   Thu, 12 Dec 2019 11:22:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212190427.ouyohviijf5inhur@linux-p48b>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 11:04 AM, Davidlohr Bueso wrote:
> There have been deadlock reports[1, 2] where put_page is called
> from softirq context and this causes trouble with the hugetlb_lock,
> as well as potentially the subpool lock.
> 
> For such an unlikely scenario, lets not add irq dancing overhead
> to the lock+unlock operations, which could incur in expensive
> instruction dependencies, particularly when considering hard-irq
> safety. For example PUSHF+POPF on x86.
> 
> Instead, just use a workqueue and do the free_huge_page() in regular
> task context.
> 
> [1] https://lore.kernel.org/lkml/20191211194615.18502-1-longman@redhat.com/
> [2] https://lore.kernel.org/lkml/20180905112341.21355-1-aneesh.kumar@linux.ibm.com/
> 
> Reported-by: Waiman Long <longman@redhat.com>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Thank you Davidlohr.

The patch does seem fairly simple and straight forward.  I need to brush up
on my workqueue knowledge to provide a full review.

Longman,
Do you have a test to reproduce the issue?  If so, can you try running with
this patch.
-- 
Mike Kravetz
