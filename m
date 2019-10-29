Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9B6CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4A02087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 22:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rjclqAY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfJ2Wg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:36:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58234 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2Wg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 18:36:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TMYRcK169422;
        Tue, 29 Oct 2019 22:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=CGaityfoKrNJnqNc5AMbv+kCP7JuT/aV+9xFPLyunYk=;
 b=rjclqAY7D1/NmGI/E2XRCyvwT7sTXLkS/JxzlvjfbqlCX+1fMzeMPOliyVONAVlSGoyZ
 hJD4ZvM1U/+fDWa8H49ZGKYN1LfMXXUbX3CJLMu62pBtHe6C5Xm+W9DmA6jvJfcwmJAh
 TS/LRmY0TWikL8IkcZ3McfqyGQQ6lTXy8L4w8/gq2ZeUHTQQqmNYGLyGfQoFRcdkD37d
 4gT6chpDaQ8/vrNTDm+KLx8id4UQg2TW7TCAHoFESlLhwkypJUYBb3J8TBHV/Pa2chUR
 ZeXTcU56N+qmiYDuE8xsn5Ey+GMtCLQFh9F7dgvuvJy3+P4xifWu1gJg0qY6rDHR89Cp 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vxwhfg5uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 22:36:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TMXMCV054190;
        Tue, 29 Oct 2019 22:36:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vxwj52e5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 22:36:40 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9TMac7o025223;
        Tue, 29 Oct 2019 22:36:39 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 15:36:38 -0700
Subject: Re: [PATCH] hugetlbfs: fix error handling in init_hugetlbfs_fs()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgxu519@mykernel.net, linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <20191017103822.8610-1-cgxu519@mykernel.net>
 <ba6cd4a4-a1cd-82c0-5ea1-5e20112f8f6b@oracle.com>
 <16e15cd0096.1068d5c9f40168.8315245997167313680@mykernel.net>
 <94b6244d-2c24-e269-b12c-e3ba694b242d@oracle.com>
 <20191029152442.32bf51a13e48d9b2d83cd504@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <befca227-cb8a-8f47-617d-e3bf9972bfec@oracle.com>
Date:   Tue, 29 Oct 2019 15:36:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029152442.32bf51a13e48d9b2d83cd504@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290195
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/19 3:24 PM, Andrew Morton wrote:
> On Tue, 29 Oct 2019 13:47:38 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> It is assumed that the hugetlbfs_vfsmount[] array will contain
>> either a valid vfsmount pointer or NULL for each hstate after
>> initialization.  Changes made while converting to use fs_context
>> broke this assumption.
>>
>> While fixing the hugetlbfs_vfsmount issue, it was discovered that
>> init_hugetlbfs_fs never did correctly clean up when encountering
>> a vfs mount error.
> 
> What were the user-visible runtime effects of this bug?
> 
> (IOW: why does it warrant the cc:stable?)

On second thought, let's not cc stable.

It was found during code inspection.  A small memory allocation failure
would be the most likely cause of taking a error path with the bug.  This
is unlikely to happen as this is early init code.

Sorry about that,
-- 
Mike Kravetz
