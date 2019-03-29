Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8158AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4F5218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MZh9cOqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbfC2W0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:26:51 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46696 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730452AbfC2W0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:26:50 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TMO2vB025382;
        Fri, 29 Mar 2019 22:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PtEGgfckPDq0wGGpZfAcvK0+M+jCFNuLT7mnbB1esj8=;
 b=MZh9cOqw3volpOs2bh/3blGSvsdQ6fageEiK8M/ds9mRa4BjcBI2Bxs/TxLTuOP42zB9
 9kCDQB/4jLwNc5uA+yz6JFwL1h0eC0C5dJO3eikmcltB7aA+1qVZdvwiSuBdUj4MPg/Y
 XjWMMAkOLFCQ4NWNHESYaPxEL0yms0qhrj0vWs03GJ1EfpQHSqBo3rzpmGewb4p93sCb
 BfBGQkVZ2BRrvfAFQOcSrNL2g8Uo4AeIvgFM4PxBHRfZcOaZeQPj+yvRdNXcHguvrzrS
 vpyQ1/OFnwS59f2FvSIiGe0a3PJCOESDextxZC9D/6P4fT8EeYZUGQKLXrHsyBkNCXIE 4g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2re6g1eykx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 22:26:21 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TMQFv0012477
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 22:26:15 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TMQDEn009533;
        Fri, 29 Mar 2019 22:26:13 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 15:26:13 -0700
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
To:     Julien Desfossez <jdesfossez@digitalocean.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
References: <fcad329b-e421-624a-0d1a-a98466eaf2ed@oracle.com>
 <1553866527-18879-1-git-send-email-jdesfossez@digitalocean.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <6e8e6fa0-8976-5e97-d90c-af0b4a6fc8b2@oracle.com>
Date:   Fri, 29 Mar 2019 15:23:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553866527-18879-1-git-send-email-jdesfossez@digitalocean.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9211 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/19 6:35 AM, Julien Desfossez wrote:
> On Fri, Mar 22, 2019 at 8:09 PM Subhra Mazumdar <subhra.mazumdar@oracle.com>
> wrote:
>> Is the core wide lock primarily responsible for the regression? I ran
>> upto patch
>> 12 which also has the core wide lock for tagged cgroups and also calls
>> newidle_balance() from pick_next_task(). I don't see any regression.  Of
>> course
>> the core sched version of pick_next_task() may be doing more but
>> comparing with
>> the __pick_next_task() it doesn't look too horrible.
> On further testing and investigation, we also agree that spinlock contention
> is not the major cause for the regression, but we feel that it should be one
> of the major contributing factors to this performance loss.
>
>
I finally did some code bisection and found the following lines are
basically responsible for the regression. Commenting them out I don't see
the regressions. Can you confirm? I am yet to figure if this is needed for
the correctness of core scheduling and if so can we do this better?

-------->8-------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe3918c..3b3388a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3741,8 +3741,8 @@ pick_next_task(struct rq *rq, struct task_struct 
*prev, struct rq_flags *rf)
                                  * If there weren't no cookies; we 
don't need
                                  * to bother with the other siblings.
*/
-                               if (i == cpu && !rq->core->core_cookie)
-                                       goto next_class;
+                               //if (i == cpu && !rq->core->core_cookie)
+                                       //goto next_class;

continue;
                         }
