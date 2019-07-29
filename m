Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20815C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE79C216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfG2HaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:30:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbfG2HaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:30:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6T7TtYj103306
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 03:29:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u1sgqxs1y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 03:29:57 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Mon, 29 Jul 2019 08:28:53 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 29 Jul 2019 08:28:49 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6T7SmVX43254160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jul 2019 07:28:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AC5052063;
        Mon, 29 Jul 2019 07:28:48 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 59ED252050;
        Mon, 29 Jul 2019 07:28:46 +0000 (GMT)
Date:   Mon, 29 Jul 2019 12:58:45 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, jhladky@redhat.com,
        lvenanci@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] autonuma: Fix scan period updating
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190725080124.494-1-ying.huang@intel.com>
 <20190725173516.GA16399@linux.vnet.ibm.com>
 <87y30l5jdo.fsf@yhuang-dev.intel.com>
 <20190726092021.GA5273@linux.vnet.ibm.com>
 <87ef295yn9.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87ef295yn9.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19072907-0012-0000-0000-000003373501
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072907-0013-0000-0000-00002170D528
Message-Id: <20190729072845.GC7168@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=978 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907290088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> 
> >> if (lr_ratio >= NUMA_PERIOD_THRESHOLD)
> >>     slow down scanning
> >> else if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
> >>     if (NUMA_PERIOD_SLOTS - lr_ratio >= NUMA_PERIOD_THRESHOLD)
> >>         speed up scanning
> 
> Thought about this again.  For example, a multi-threads workload runs on
> a 4-sockets machine, and most memory accesses are shared.  The optimal
> situation will be pseudo-interleaving, that is, spreading memory
> accesses evenly among 4 NUMA nodes.  Where "share" >> "private", and
> "remote" > "local".  And we should slow down scanning to reduce the
> overhead.
> 
> What do you think about this?

If all 4 nodes have equal access, then all 4 nodes will be active nodes.

From task_numa_fault()

	if (!priv && !local && ng && ng->active_nodes > 1 &&
				numa_is_active_node(cpu_node, ng) &&
				numa_is_active_node(mem_node, ng))
		local = 1;

Hence all accesses will be accounted as local. Hence scanning would slow
down.

-- 
Thanks and Regards
Srikar Dronamraju

