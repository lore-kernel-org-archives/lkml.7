Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5E8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A335A20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nhF7Fogm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfDOGrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:47:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54162 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOGrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:47:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F6iIjT148277;
        Mon, 15 Apr 2019 06:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=/5Uxmide7W9gl7rmjYHhYH9XEi+gX7190BWTpclzFg0=;
 b=nhF7FogmvUEp7PhklKxgrbRR+GLZ2Eoj1Po5389TnGlbSp58m1B78QaIIK3SkasRK7oq
 0WpcwhaMZyNn1OIRhH60yD36ovmzfy4NI1ej9pFAYLXC06WpKN668LA6JFv3bf9b52gA
 WEwjRXhp5Aeceg3kd924YRBggi0Bi+brz1OWDvNaisM85HoJ1+QKAqdU1SEEgTRLL8m4
 0kbK8Z/HThkU3eW9gFi8DguQjYnGzBJNms6o88Nr7W6juseQnugt7f0MZ/N7iZV0O+ef
 +L08yrzswqmrnAmgyWjY4VHtDQuNu7bwmTPl00r4NJ4eXf2UPb/bVVX30ZRrUwZA4/7q aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ru76t4pty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 06:47:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F6k6jl110089;
        Mon, 15 Apr 2019 06:47:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rv2tu0p7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 06:47:03 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3F6l2gx031609;
        Mon, 15 Apr 2019 06:47:02 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Apr 2019 23:47:02 -0700
Subject: Re: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
 leaving critical section
To:     Joe Jin <joe.jin@oracle.com>, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com
Cc:     linux-kernel@vger.kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, haakon.bugge@oracle.com
References: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
 <5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <38f6f868-013e-5619-b939-a8273fc64ee4@oracle.com>
Date:   Mon, 15 Apr 2019 14:50:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150045
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the patch to be fixed is still in Konrad's own tree, I will send the v2 for
the patch to be fixed, instead of an incremental fix.

Dongli Zhang

On 4/12/19 10:13 PM, Joe Jin wrote:
> I'm good to have this patch, which helps identify the cause of failure is
> fragmentation or it really been used up.
> 
> On 4/12/19 4:38 AM, Dongli Zhang wrote:
>> When swiotlb is full, the kernel would print io_tlb_used. However, the
>> result might be inaccurate at that time because we have left the critical
>> section protected by spinlock.
>>
>> Therefore, we backup the io_tlb_used into local variable before leaving
>> critical section.
>>
>> Fixes: 83ca25948940 ("swiotlb: dump used and total slots when swiotlb buffer is full")
>> Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> 
> Reviewed-by: Joe Jin <joe.jin@oracle.com> 
> 
> Thanks,
> Joe
> 
