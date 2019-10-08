Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF23C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4996F21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p2dbOqq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfJHSNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:13:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32902 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfJHSNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:13:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98HwtS5076605;
        Tue, 8 Oct 2019 18:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=/UJpMBgMVV9V7RcawlqYq2l9m+5ScOrASd+f/x6MW54=;
 b=p2dbOqq1rCl59FOuQvF4t50DnKhSaA9OSHVZuQZcUt4En2B1gSxySOXOI0syYMHIZtuu
 Rzrjpr9qWe7mpERwZGYsNR6wMghpSsfTxEzDfSii+q5+JvByASKlmY+yULx6xASXCcYy
 2K9daEr4m48NqoE0VO3AfdMyWG5Xuta8yrVPBvpiKQnCRzeYOZmSVYUWbbGNuGBd6Ptw
 J7b1ZNgP9L+wZoOt3OW7lJ9FwNEgjl/OtnerjZ5mXIm+uYkdI6nReOWg7PQLvR8ppP5n
 DiX7PG/crLr3wFwL7JJoQKIQoUy53V7AuBKVm9gWQmmEc6d0xkk/9Fma0sMWbZ9xNXRI xQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vejkuf2ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 18:13:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x98Hx8pg030335;
        Tue, 8 Oct 2019 18:13:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vg1ywdm0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Oct 2019 18:13:25 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x98IDO6t007602;
        Tue, 8 Oct 2019 18:13:24 GMT
Received: from [10.159.141.189] (/10.159.141.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Oct 2019 18:13:24 +0000
Subject: Re: [PATCH v4 0/2] mm/memory-failure: Poison read receives SIGKILL
 instead of SIGBUS issue
From:   Jane Chu <jane.chu@oracle.com>
To:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1565112345-28754-1-git-send-email-jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <9af6b35d-bfbf-7f87-a419-042dff018fdd@oracle.com>
Date:   Tue, 8 Oct 2019 11:13:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1565112345-28754-1-git-send-email-jane.chu@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910080143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910080143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Naoya,

What is the status of the patches?
Is there anything I need to do from my end ?

Regards,
-jane

On 8/6/2019 10:25 AM, Jane Chu wrote:
> Change in v4:
>   - remove trailing white space
> 
> Changes in v3:
>   - move **tk cleanup to its own patch
> 
> Changes in v2:
>   - move 'tk' allocations internal to add_to_kill(), suggested by Dan;
>   - ran checkpatch.pl check, pointed out by Matthew;
>   - Noaya pointed out that v1 would have missed the SIGKILL
>     if "tk->addr == -EFAULT", since the code returns early.
>     Incorporated Noaya's suggestion, also, skip VMAs where
>     "tk->size_shift == 0" for zone device page, and deliver SIGBUS
>     when "tk->size_shift != 0" so the payload is helpful;
>   - added Suggested-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> Jane Chu (2):
>    mm/memory-failure.c clean up around tk pre-allocation
>    mm/memory-failure: Poison read receives SIGKILL instead of SIGBUS if
>      mmaped more than once
> 
>   mm/memory-failure.c | 62 ++++++++++++++++++++++-------------------------------
>   1 file changed, 26 insertions(+), 36 deletions(-)
> 
