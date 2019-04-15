Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471E9206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YswsQT1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfDOMIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:08:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42680 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:08:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FBwd4d029068;
        Mon, 15 Apr 2019 12:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=VRB8tNLK9X8cBAGG4HA8WQOuTmxeWd3G1iy1HESNtjQ=;
 b=YswsQT1f2xdmN+/fiHVH4opiAHlH06uwZndfEPIo8Pr0TZkT64NyzXF2IzdA5rLahSH2
 gKFKGA5xuVecknAzMKUbVOCeDgfcoJbNi2NjQgUlNIMYt4V1h++1TnzdNak9JAszzW3R
 JOX4pQ679YIflFAUndlvk/kVqRxLNaZirm2BsN5txf7rbCDiL83G2UmYBeDiVUz2J4Fv
 DpNBu9AdExFyfIUNbWDpF7mrX7wJFFk4h56a/r8tpyr6Xt8oH9gagnbI2qJw+DrYC5rG
 L6cWt6WCBLn5pBJszP0p4oqoDzMjxSAlaEdf3EtF4QfW4WD+GWvq+p+AqNHJQ/KV5Rum kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rusnem8fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 12:08:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FC8T7V072580;
        Mon, 15 Apr 2019 12:08:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ru4vsjxga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 12:08:28 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3FC8OAm006665;
        Mon, 15 Apr 2019 12:08:24 GMT
Received: from [192.168.2.8] (/106.39.148.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 05:08:24 -0700
Subject: Re: [PATCH 1/1] swiotlb: save io_tlb_used to local variable before
 leaving critical section
To:     konrad@darnok.org
References: <1555069106-2964-1-git-send-email-dongli.zhang@oracle.com>
 <5bdc3265-e5a4-e8c8-9098-0bba18a66f19@oracle.com>
 <38f6f868-013e-5619-b939-a8273fc64ee4@oracle.com>
 <CAPbh3rvyVd_D9tMfE-Bo2JmdabaiQnaipmmadc67tUt_Lrt2gw@mail.gmail.com>
Cc:     joe.jin@oracle.com, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, haakon.bugge@oracle.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org, hch@lst.de
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <f10187e3-b84c-6c8c-2dae-09059a5f3270@oracle.com>
Date:   Mon, 15 Apr 2019 20:08:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAPbh3rvyVd_D9tMfE-Bo2JmdabaiQnaipmmadc67tUt_Lrt2gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150085
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/15/2019 07:26 PM, Konrad Rzeszutek Wilk wrote:
> 
> 
> On Mon, Apr 15, 2019, 2:50 AM Dongli Zhang <dongli.zhang@oracle.com
> <mailto:dongli.zhang@oracle.com>> wrote:
> 
>     As the patch to be fixed is still in Konrad's own tree, I will send the v2 for
>     the patch to be fixed, instead of an incremental fix.
> 
> 
> I squashed it in.

Thank you very much!

I saw it is at:

https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/commit/?h=devel/for-linus-5.1&id=53b29c336830db48ad3dc737f88b8c065b1f0851

Dongli Zhang
