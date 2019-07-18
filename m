Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9839EC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777BB2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbfGRKI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:08:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389689AbfGRKI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:08:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IA6dbn034284
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 06:08:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttm3qp94v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 06:08:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Thu, 18 Jul 2019 11:08:24 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 11:08:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6IA8Job38600810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 10:08:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB82711C058;
        Thu, 18 Jul 2019 10:08:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FECB11C054;
        Thu, 18 Jul 2019 10:08:17 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 18 Jul 2019 10:08:17 +0000 (GMT)
Date:   Thu, 18 Jul 2019 15:38:16 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, prakash.sangappa@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
Subject: Re: [RFC PATCH 3/3] sched: introduce tunables to control soft
 affinity
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
 <20190626224718.21973-4-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190626224718.21973-4-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19071810-0012-0000-0000-00000334047E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071810-0013-0000-0000-0000216D85F5
Message-Id: <20190718100816.GA19218@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* subhra mazumdar <subhra.mazumdar@oracle.com> [2019-06-26 15:47:18]:

> For different workloads the optimal "softness" of soft affinity can be
> different. Introduce tunables sched_allowed and sched_preferred that can
> be tuned via /proc. This allows to chose at what utilization difference
> the scheduler will chose cpus_allowed over cpus_preferred in the first
> level of search. Depending on the extent of data sharing, cache coherency
> overhead of the system etc. the optimal point may vary.
> 
> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
> ---

Correct me but this patchset only seems to be concentrated on the wakeup
path, I don't see any changes in the regular load balancer or the
numa-balancer. If system is loaded or tasks are CPU intensive, then wouldn't
these tasks be moved to cpus_allowed instead of cpus_preferred and hence
breaking this soft affinity.

-- 
Thanks and Regards
Srikar Dronamraju

