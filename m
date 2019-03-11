Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14306C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3FE2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lRJmdFas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfCKXgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:36:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53864 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKXgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:36:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BNXwOw074888;
        Mon, 11 Mar 2019 23:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NJKDtsh5YrM8x5tUkycex/CSPhouA9bJRC3diCVnwtc=;
 b=lRJmdFas0b8kxWuc7L2qTZtKtcmEBK3xWcHg2atb1NWKF8NRqjuWoe6mgcyb+8JnnS/l
 FcIbJ0zp/JDx+kNrLLu2NIyLuvn8u5EuPqmjbZjYLE7teni+z0HPtfD3yiSie1Xtpgao
 454aTNhlz66bkj7+v1CC3lWQoGq2Nm83J79SgJf0tfhkWYPr3QtK2aR79rDEXwFLLgzc
 e3M4qVvh7hmmjULeakpbk2an6Htu+bQm5Xfed6SVqvkBsDnyPCaPTlukWSIFS6uqP1VW
 AJcgZQpC/iNKUHIO9uSu2tPtR7mq6nxOOE//3LNDEtmn8sDOR5vjl3qp7bMTF8dbGiua QQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2r430ehwpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 23:35:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2BNZwhF027346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 23:35:58 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2BNZuMu017111;
        Mon, 11 Mar 2019 23:35:56 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 16:35:56 -0700
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Fr?d?ric Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
 <20190222124544.GY9565@techsingularity.net>
 <14a9adf7-9b50-1dfa-0c35-d04e976081c2@oracle.com>
 <CAERHkru9DzvszvdGHWp8PhEAqeUc-wVR1Gey-KtQ6aMRLx68bQ@mail.gmail.com>
 <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com>
Message-ID: <ac10b8fd-da1a-2cc2-afee-4e2b9b4278ee@oracle.com>
Date:   Mon, 11 Mar 2019 16:33:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <19d5d492-a4c1-b3c8-cae4-da2fdfcb872b@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/11/19 11:34 AM, Subhra Mazumdar wrote:
>
> On 3/10/19 9:23 PM, Aubrey Li wrote:
>> On Sat, Mar 9, 2019 at 3:50 AM Subhra Mazumdar
>> <subhra.mazumdar@oracle.com> wrote:
>>> expected. Most of the performance recovery happens in patch 15 which,
>>> unfortunately, is also the one that introduces the hard lockup.
>>>
>> After applied Subhra's patch, the following is triggered by enabling
>> core sched when a cgroup is
>> under heavy load.
>>
> It seems you are facing some other deadlock where printk is involved. 
> Can you
> drop the last patch (patch 16 sched: Debug bits...) and try?
>
> Thanks,
> Subhra
>
Never Mind, I am seeing the same lockdep deadlock output even w/o patch 
16. Btw
the NULL fix had something missing, following works.

--------->8------------

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d0dac4..27cbc64 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4131,7 +4131,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct 
sched_entity *curr)
          * Avoid running the skip buddy, if running something else can
          * be done without getting too unfair.
*/
-       if (cfs_rq->skip == se) {
+       if (cfs_rq->skip && cfs_rq->skip == se) {
                 struct sched_entity *second;

                 if (se == curr) {
@@ -4149,13 +4149,15 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct 
sched_entity *curr)
/*
          * Prefer last buddy, try to return the CPU to a preempted task.
*/
-       if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
+       if (left && cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, 
left)
+           < 1)
                 se = cfs_rq->last;

/*
          * Someone really wants this to run. If it's not unfair, run it.
*/
-       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
+       if (left && cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, 
left)
+           < 1)
                 se = cfs_rq->next;

         clear_buddies(cfs_rq, se);
@@ -6958,6 +6960,9 @@ pick_task_fair(struct rq *rq)

                 se = pick_next_entity(cfs_rq, NULL);

+               if (!(se || curr))
+                       return NULL;
+
                 if (curr) {
                         if (se && curr->on_rq)
update_curr(cfs_rq);

