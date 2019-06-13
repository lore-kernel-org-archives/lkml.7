Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7286C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB62C20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vrj0DDbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393147AbfFMQ7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:59:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49420 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbfFMAKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 20:10:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5D04qCO126226;
        Thu, 13 Jun 2019 00:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0OEootoOLq7cPZMlz3xJIkr+9woYMbgUb9aDDD9IL8w=;
 b=vrj0DDbHi/tRfQOTRoPMQeFWT/O3BGw4YZQjeaAiKwYGP8h15rzoTlylbPcU9HJNvW7B
 XkXLh3HaYEU6hDFrEiCojaiq/UGtqooEoFRBtOiNJA/gqUE/mdyNLahbiRXkcORx4ZnG
 CIwAzh43uZ74uw2X7PD7QFNJeL43mkJZzE2uYPPPiZ8dVpPLql3+CvhEosTOoTxSRd68
 CXVyCUDgjh5UyuVvm2TWGna96z3Cv7NQpHXYsgnxLQYdvagt8BA5w3IPTXtj+27rpaBq
 mugUv1s7g47j88+GDaZ8BxPKOC1u+LFtiTu0UPDUNFWYhlNG+fqQ2NUEMTdZhw+iC2kQ 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04etxgqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 00:07:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5D07svf168338;
        Thu, 13 Jun 2019 00:07:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2t1jpj9jk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 00:07:59 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5D07qIQ001114;
        Thu, 13 Jun 2019 00:07:52 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 17:07:52 -0700
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad> <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
Date:   Wed, 12 Jun 2019 17:03:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190612163345.GB26997@sinkpad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/12/19 9:33 AM, Julien Desfossez wrote:
> After reading more traces and trying to understand why only untagged
> tasks are starving when there are cpu-intensive tasks running on the
> same set of CPUs, we noticed a difference in behavior in ‘pick_task’. In
> the case where ‘core_cookie’ is 0, we are supposed to only prefer the
> tagged task if it’s priority is higher, but when the priorities are
> equal we prefer it as well which causes the starving. ‘pick_task’ is
> biased toward selecting its first parameter in case of equality which in
> this case was the ‘class_pick’ instead of ‘max’. Reversing the order of
> the parameter solves this issue and matches the expected behavior.
>
> So we can get rid of this vruntime_boost concept.
>
> We have tested the fix below and it seems to work well with
> tagged/untagged tasks.
>
My 2 DB instance runs with this patch are better with CORESCHED_STALL_FIX
than NO_CORESCHED_STALL_FIX in terms of performance, std deviation and
idleness. May be enable it by default?

NO_CORESCHED_STALL_FIX:

users     %stdev   %gain %idle
16        25       -42.4 73
24        32       -26.3 67
32        0.2      -48.9 62


CORESCHED_STALL_FIX:

users     %stdev   %gain %idle
16        6.5      -23 70
24        0.6      -17 60
32        1.5      -30.2   52
