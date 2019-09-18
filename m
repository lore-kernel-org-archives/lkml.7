Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0A8C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4EB2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfIRMlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:41:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbfIRMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:41:18 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8ICYMOA016162
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:41:16 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3m8m9ba0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:41:16 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 18 Sep 2019 13:41:14 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Sep 2019 13:41:09 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8ICf8CX48168974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 12:41:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12628AE045;
        Wed, 18 Sep 2019 12:41:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70008AE058;
        Wed, 18 Sep 2019 12:41:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.91])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Sep 2019 12:41:05 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
Subject: Usecases for the per-task latency-nice attribute
To:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        tim.c.chen@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, morten.rasmussen@arm.com,
        dietmar.eggemann@arm.com, pjt@google.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org, tj@kernel.org,
        rafael.j.wysocki@intel.com, qais.yousef@arm.com
Date:   Wed, 18 Sep 2019 18:11:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091812-0020-0000-0000-0000036E8D03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091812-0021-0000-0000-000021C435DA
Message-Id: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=722 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

As per the discussion in LPC2019, new per-task property like latency-nice
can be useful in certain scenarios. The scheduler can take proper decision
by knowing latency requirement of a task from the end-user itself.

There has already been an effort from Subhra for introducing Task
latency-nice [1] values and have seen several possibilities where this type of
interface can be used.

From the best of my understanding of the discussion on the mail thread and
in the LPC2019, it seems that there are two dilemmas;

1. Name: What should be the name for such attr for all the possible usecases?
=============
Latency nice is the proposed name as of now where the lower value indicates
that the task doesn't care much for the latency and we can spend some more
time in the kernel to decide a better placement of a task (to save time,
energy, etc.)
But there seems to be a bit of confusion on whether we want biasing as well
(latency-biased) or something similar, in which case "latency-nice" may
confuse the end-user.

2. Value: What should be the range of possible values supported by this new
attr?
==============
The possible values of such task attribute still need community attention.
Do we need a range of values or just binary/ternary values are sufficient?
Also signed or unsigned and so the length of the variable (u64, s32, etc)?



This mail is to initiate the discussion regarding the possible usecases of
such per task attribute and to come up with a specific name and value for
the same.

Hopefully, interested one should plot out their usecase for which this new
attr can potentially help in solving or optimizing it.


Well, to start with, here is my usecase.

-------------------
**Usecases**
-------------------

$> TurboSched
====================
TurboSched [2] tries to minimize the number of active cores in a socket by
packing an un-important and low-utilization (named jitter) task on an
already active core and thus refrains from waking up of a new core if
possible. This requires tagging of tasks from the userspace hinting which
tasks are un-important and thus waking-up a new core to minimize the
latency is un-necessary for such tasks.
As per the discussion on the posted RFC, it will be appropriate to use the
task latency property where a task with the highest latency-nice value can
be packed.
But for this specific use-cases, having just a binary value to know which
task is latency-sensitive and which not is sufficient enough, but having a
range is also a good way to go where above some threshold the task can be
packed.




References:
===========
[1]. https://lkml.org/lkml/2019/8/30/829
[2]. https://lkml.org/lkml/2019/7/25/296

