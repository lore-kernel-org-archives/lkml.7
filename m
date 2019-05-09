Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB8CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B4C20989
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E7oT+8E/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEIRzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:55:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45058 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEIRzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:55:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49Hs1p3180463;
        Thu, 9 May 2019 17:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0cA+7TWrNg9bHBZMP9UFrAJLhzvcT2LzSfZo3KAUyJI=;
 b=E7oT+8E/OzXlxrLrPwHFjVENhLH5dQ3xofj7DfjTiTDZIOxgcycY3MKHaCTF8U9rRUj1
 CnnmzbzKDrpLhf50TDDHKmJaLxe3w/HTHl9y4XngDAzyz6TJIOsfV8/H6Ib0sp4lSVZ/
 uE91j6apVRp+OPc1aboJ/0czdPL9Tn4mDfC7YGFJIRnOh3lC9rFwr1Gd0IIYRVqllsQS
 oGSGQ26JwKhPkuQJfYlvaV+JPyZ3itVnSZvAL7GJuD1/7bshNeguA1QoK+jhvQIFPL4Q
 AiGMHBu2WS8pHSOcb+eMfMgq3Hg0H2rGGmRDNFYPCNy1IZijbP1cVX4p1Ud5jAmaIW0p aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s94bgck8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:54:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x49Hs0lI191807;
        Thu, 9 May 2019 17:54:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2sagyvd06x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 17:54:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x49HrxSg005414;
        Thu, 9 May 2019 17:53:59 GMT
Received: from [10.132.91.213] (/10.132.91.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 10:53:59 -0700
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
 <20190429061516.GA9796@aaronlu>
 <6dfc392f-e24b-e641-2f7d-f336a90415fa@linux.intel.com>
 <777b7674-4811-dac4-17df-29bd028d6b26@linux.intel.com>
 <CAERHkrvU0nay-cG9equdOBejOZ5Ffdxo+67ZRp9q0L9BQkcAtQ@mail.gmail.com>
 <eb9abb34-d946-c63c-750b-8f52ed842670@oracle.com>
 <28fb6854-2772-5d29-087a-6a0cf6afe626@oracle.com>
 <CAERHkrsavsBoEOR5Eq-nm6ADarS0zTi5Mu-T7TO6JoSUi7TRfQ@mail.gmail.com>
 <8098b70b-2095-91ea-d4ad-9181829066c7@oracle.com>
 <CAERHkrvKfvrSOKoJ5StYWENm9domgx1OkPyeKHacP9AGrgf8cg@mail.gmail.com>
 <7671d3f0-ca07-7260-a855-473ab58d1c30@oracle.com>
 <CAERHkrtw3jH1eWn52r+L75k84SeYuvw12A5cbmofiNjoJFhEsw@mail.gmail.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <b2b1b1f6-9790-73c7-8566-031ec28606a7@oracle.com>
Date:   Thu, 9 May 2019 10:50:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAERHkrtw3jH1eWn52r+L75k84SeYuvw12A5cbmofiNjoJFhEsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090102
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> select_task_rq_* seems to be unchanged. So the search logic to find a cpu
>> to enqueue when a task becomes runnable is same as before and doesn't do
>> any kind of cookie matching.
> Okay, that's true in task wakeup path, and also load_balance seems to pull task
> without checking cookie too. But my system is not over loaded when I tested this
> patch, so there is none or only one task in rq and on the rq's rb
> tree, so this patch
> does not make a difference.
I had same hypothesis for my tests.
>
> The question is, should we do cookie checking for task selecting CPU and load
> balance CPU pulling task?
The basic issue is keeping the CPUs busy. In case of overloaded system,
the trivial new idle balancer should be able to find a matching task
in case of forced idle. More problematic is the lower load scenario when
there aren't any matching task to be found but there are runnable tasks of
other groups. Also wake up code path tries to balance threads across cores
(select_idle_core) first which is opposite of what core scheduling wants.
I will re-run my tests with select_idle_core disabled, but the issue is
on x86 Intel systems (my test rig) the CPU ids are interleaved across cores
so even select_idle_cpu will balance across cores first. May be others have
some better ideas?
>
> Thanks,
> -Aubrey
