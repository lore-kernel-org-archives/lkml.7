Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B19BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCF92183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0bZdslFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfCTCcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:32:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60434 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfCTCcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 22:32:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2K2Os9e042819;
        Wed, 20 Mar 2019 02:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Eea+oIu2VtSDcevWbdA1Fej2LI66vkU/2AqoaLIaxG4=;
 b=0bZdslFlaHaF9AC5ClP9vr5evtqfGVQJUGi0zFYwK2aMBMb0r5ttsj//cyBSRemSBEoX
 OWI6nAwZLLvjQFWMTyUNSEZP4mltRrgBLMcb+BJ3vH+YlLbCLMi2esbO8DtbH6oHc/Ra
 wYSgIkoJuDgA5kafhZbi5dSR3nKLWjPxG/3dgphBh/as0JYiP82KjvA33ligDnmJnFZw
 yPKaa/VGvVejD8AHAVcHOqHjFAovUCDIg3LI04RHIdKFl8qcU//Nk2B5zO7AqetVbEeR
 2n0O1Sg0sJwquMDYvaw364IzBNgT0R+wPDzJVIm6HqpczRJO9d5f4YPg0iASKjB8/y7x Lg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r8rjur5g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 02:31:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2K2VkSo011135
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 02:31:46 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2K2VjKE026856;
        Wed, 20 Mar 2019 02:31:45 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 19:31:45 -0700
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, tim.c.chen@linux.intel.com,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Vineeth Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
References: <20190218173514.064516553@infradead.org>
 <1552923710-30933-1-git-send-email-jdesfossez@digitalocean.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <15f3f7e6-5dce-6bbf-30af-7cffbd7bb0c3@oracle.com>
Date:   Tue, 19 Mar 2019 19:29:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552923710-30933-1-git-send-email-jdesfossez@digitalocean.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903200014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/18/19 8:41 AM, Julien Desfossez wrote:
> The case where we try to acquire the lock on 2 runqueues belonging to 2
> different cores requires the rq_lockp wrapper as well otherwise we
> frequently deadlock in there.
>
> This fixes the crash reported in
> 1552577311-8218-1-git-send-email-jdesfossez@digitalocean.com
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 76fee56..71bb71f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2078,7 +2078,7 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
>   		raw_spin_lock(rq_lockp(rq1));
>   		__acquire(rq2->lock);	/* Fake it out ;) */
>   	} else {
> -		if (rq1 < rq2) {
> +		if (rq_lockp(rq1) < rq_lockp(rq2)) {
>   			raw_spin_lock(rq_lockp(rq1));
>   			raw_spin_lock_nested(rq_lockp(rq2), SINGLE_DEPTH_NESTING);
>   		} else {
With this fix and my previous NULL pointer fix my stress tests are 
surviving. I
re-ran my 2 DB instance setup on 44 core 2 socket system by putting each DB
instance in separate core scheduling group. The numbers look much worse 
now.

users  baseline  %stdev  %idle  core_sched  %stdev %idle
16     1         0.3     66     -73.4%      136.8 82
24     1         1.6     54     -95.8%      133.2 81
32     1         1.5     42     -97.5%      124.3 89

I also notice that if I enable a bunch of debug configs related to 
mutexes, spin
locks, lockdep etc. (which I did earlier to debug the dead lock), it 
opens up a
can of worms with multiple crashes.
