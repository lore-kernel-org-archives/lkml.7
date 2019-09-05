Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A35C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A294720870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 05:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfIEFzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:55:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730804AbfIEFzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 01:55:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x855qJZv133754
        for <linux-kernel@vger.kernel.org>; Thu, 5 Sep 2019 01:55:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uttnt4pae-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:55:47 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 5 Sep 2019 06:55:45 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Sep 2019 06:55:42 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x855tfIa34603494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 05:55:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A86C5204F;
        Thu,  5 Sep 2019 05:55:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.164])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 39CA552052;
        Thu,  5 Sep 2019 05:55:39 +0000 (GMT)
Subject: Re: [RFC PATCH 0/9] Task latency-nice
To:     subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, patrick.bellasi@arm.com
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 5 Sep 2019 11:25:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090505-4275-0000-0000-0000036161A0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090505-4276-0000-0000-00003873A870
Message-Id: <cef0717a-e1da-c4a3-9fd0-ddb0914e3850@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=563 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Subhra,

On 8/30/19 11:19 PM, subhra mazumdar wrote:
> Introduce new per task property latency-nice for controlling scalability
> in scheduler idle CPU search path. Valid latency-nice values are from 1 to
> 100 indicating 1% to 100% search of the LLC domain in select_idle_cpu. New
> CPU cgroup file cpu.latency-nice is added as an interface to set and get.
> All tasks in the same cgroup share the same latency-nice value. Using a
> lower latency-nice value can help latency intolerant tasks e.g very short
> running OLTP threads where full LLC search cost can be significant compared
> to run time of the threads. The default latency-nice value is 5.
> 
> In addition to latency-nice, it also adds a new sched feature SIS_CORE to
> be able to disable idle core search altogether which is costly and hurts
> more than it helps in short running workloads.
> 
> Finally it also introduces a new per-cpu variable next_cpu to track
> the limit of search so that every time search starts from where it ended.
> This rotating search window over cpus in LLC domain ensures that idle
> cpus are eventually found in case of high load.
> 
> Uperf pingpong on 2 socket, 44 core and 88 threads Intel x86 machine with
> message size = 8k (higher is better):
> threads baseline   latency-nice=5,SIS_CORE     latency-nice=5,NO_SIS_CORE 
> 8       64.66      64.38 (-0.43%)              64.79 (0.2%)
> 16      123.34     122.88 (-0.37%)             125.87 (2.05%)
> 32      215.18     215.55 (0.17%)              247.77 (15.15%)
> 48      278.56     321.6 (15.45%)              321.2 (15.3%)
> 64      259.99     319.45 (22.87%)             333.95 (28.44%)
> 128     431.1      437.69 (1.53%)              431.09 (0%)
> 

The result seems to be appealing with your experimental setup.
BTW, do you have any plans of load balancing as well based on latency niceness
of the tasks? It seems to be a more interesting case when we give pack the lower
latency sensitive tasks on fewer CPUs.

Also, do you see any workload results showing performance regression with NO_SIS_CORE?


Thanks,
Parth

