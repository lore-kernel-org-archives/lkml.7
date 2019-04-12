Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3683DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F125920850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P6a0VI7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfDLOOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:14:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLOOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:14:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3CEAcBf192576;
        Fri, 12 Apr 2019 14:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=bGNr2bNF9zPMPBOf6iXYHxRclpUpvUUNKwzCvvoEZns=;
 b=P6a0VI7z7akJn0xpbERiwcIcSOohvx2IWYCIB+54018Sd4jHZ9Dh2DSfVu+dNKkmnLMP
 TYDJ0OLy2P8mwjdMOGLDdz5hxnwvluOzPjc8B/oImopZRQSghphXfc9C+Hw/G/6LJUm9
 S6zGMr8rHM4e6uO5ZwOWQ9eX1P2a4VbzeelZi6+PsYiAk1FbdNLOuKkUda6/hKjky1NT
 A+JqN6DQbnkiMbB9lcBp8JSfLMqWvg/JyMS+3sUPx3Q3tSVS9ZlC27ZSIcx9hzsuKdic
 NE9vg+K7bBm7o5pWuIy7tkPi7nJCBxZJFU7lbwmEJvANAMw1AkNlEmLmaJp2pXPqtiG6 ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rpkhterkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 14:14:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3CEDBlE093705;
        Fri, 12 Apr 2019 14:14:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rtqnp3y4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 14:14:03 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3CEE01r005826;
        Fri, 12 Apr 2019 14:14:00 GMT
Received: from [10.211.46.126] (/10.211.46.126)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Apr 2019 07:14:00 -0700
Subject: Re: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
 leaving critical section
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        iommu@lists.linux-foundation.org, konrad.wilk@oracle.com
Cc:     linux-kernel@vger.kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, haakon.bugge@oracle.com
References: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
Date:   Fri, 12 Apr 2019 07:13:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904120094
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9224 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904120093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm good to have this patch, which helps identify the cause of failure is
fragmentation or it really been used up.

On 4/12/19 4:38 AM, Dongli Zhang wrote:
> When swiotlb is full, the kernel would print io_tlb_used. However, the
> result might be inaccurate at that time because we have left the critical
> section protected by spinlock.
> 
> Therefore, we backup the io_tlb_used into local variable before leaving
> critical section.
> 
> Fixes: 83ca25948940 ("swiotlb: dump used and total slots when swiotlb buffer is full")
> Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Reviewed-by: Joe Jin <joe.jin@oracle.com> 

Thanks,
Joe

