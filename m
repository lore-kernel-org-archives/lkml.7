Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C417C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC17620663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H1V2vwd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfDEBe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:34:28 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51094 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDEBe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:34:28 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x351PFVO134098;
        Fri, 5 Apr 2019 01:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=AEIcjekLDVfO3Ojew6/jbgwYoGPLKt7EJhWhignEeX8=;
 b=H1V2vwd6obwRohWug4yqZmRJxXhuwstQVm+ydz93GA9dGIOSDTT3eQ+PWaLe9/+RSpq3
 zalcvPfONTQUWYfxNdiWY8hE8nt/ls89dETuF8DYTrfiptEMfJ3lIrKeMCQqY+sm7g0p
 SaaNJWsJ34VyvUde3R4z4tcU8hHhvtY4XfxDpHtIFjJSrXdhv3irHyF6/G2USuDULZyk
 wDH0gvqQd9jq+gMHA0dcnZ9wBY08/fkhGF16LpNn2o53Xf+rzZnSRLZXYAAvTYWY3nLE
 8041l8Ozid4zCBwmPlOz8Kk9TxPrjeyLuufIKKptsmVqP84rqLQFk5SwtnReePXIagHA qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rhwydjewp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 01:33:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x351WUOW185554;
        Fri, 5 Apr 2019 01:33:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rm8f607rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 01:33:54 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x351Xrqt026288;
        Fri, 5 Apr 2019 01:33:53 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 18:33:52 -0700
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
 <6e8e6fa0-8976-5e97-d90c-af0b4a6fc8b2@oracle.com>
 <cd11cde9-4aed-b02f-cae5-170bb6fa686b@oracle.com>
 <20190403201634.GA4192@sinkpad>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <4bc8cd35-5132-d717-d952-9ef90189345d@oracle.com>
Date:   Thu, 4 Apr 2019 18:30:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190403201634.GA4192@sinkpad>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050010
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9217 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> We tried to comment those lines and it doesn’t seem to get rid of the
> performance regression we are seeing.
> Can you elaborate a bit more about the test you are performing, what kind of
> resources it uses ?
I am running 1 and 2 Oracle DB instances each running TPC-C workload. The
clients driving the instances also run in same node. Each server client
pair is put in each cpu group and tagged.
> Can you also try to replicate our test and see if you see the same problem ?
>
> cgcreate -g cpu,cpuset:set1
> cat /sys/devices/system/cpu/cpu{0,2,4,6}/topology/thread_siblings_list
> 0,36
> 2,38
> 4,40
> 6,42
>
> echo "0,2,4,6,36,38,40,42" | sudo tee /sys/fs/cgroup/cpuset/set1/cpuset.cpus
> echo 0 | sudo tee /sys/fs/cgroup/cpuset/set1/cpuset.mems
>
> echo 1 | sudo tee /sys/fs/cgroup/cpu,cpuacct/set1/cpu.tag
>
> sysbench --test=fileio prepare
> cgexec -g cpu,cpuset:set1 sysbench --threads=4 --test=fileio \
> --file-test-mode=seqwr run
>
> The reason we create a cpuset is to narrow down the investigation to just 4
> cores on a highly powerful machine. It might not be needed if testing on a
> smaller machine.
With this sysbench test I am not seeing any improvement with removing the
condition. Also with hackbench I found it makes no difference but that has
much lower regression to begin with (18%)
>
> Julien
