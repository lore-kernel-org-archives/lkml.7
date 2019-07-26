Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDE2C76194
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8E022BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfGZJUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:20:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbfGZJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:20:31 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6Q9HWpo097299
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:20:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tywrh315x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 05:20:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 26 Jul 2019 10:20:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Jul 2019 10:20:24 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6Q9KNF652559878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 09:20:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA0C3AE051;
        Fri, 26 Jul 2019 09:20:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE303AE056;
        Fri, 26 Jul 2019 09:20:21 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 26 Jul 2019 09:20:21 +0000 (GMT)
Date:   Fri, 26 Jul 2019 14:50:21 +0530
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87y30l5jdo.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19072609-0016-0000-0000-0000029661A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072609-0017-0000-0000-000032F46133
Message-Id: <20190726092021.GA5273@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Huang, Ying <ying.huang@intel.com> [2019-07-26 15:45:39]:

> Hi, Srikar,
> 
> >
> > More Remote + Private page Accesses:
> > Most likely the Private accesses are going to be local accesses.
> >
> > In the unlikely event of the private accesses not being local, we should
> > scan faster so that the memory and task consolidates.
> >
> > More Remote + Shared page Accesses: This means the workload has not
> > consolidated and needs to scan faster. So we need to scan faster.
> 
> This sounds reasonable.  But
> 
> lr_ratio < NUMA_PERIOD_THRESHOLD
> 
> doesn't indicate More Remote.  If Local = Remote, it is also true.  If

less lr_ratio means more remote.

> there are also more Shared, we should slow down the scanning.  So, the

Why should we slowing down if there are more remote shared accesses?

> logic could be
> 
> if (lr_ratio >= NUMA_PERIOD_THRESHOLD)
>     slow down scanning
> else if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
>     if (NUMA_PERIOD_SLOTS - lr_ratio >= NUMA_PERIOD_THRESHOLD)
>         speed up scanning
>     else
>         slow down scanning
> } else
>    speed up scanning
> 
> This follows your idea better?
> 
> Best Regards,
> Huang, Ying

-- 
Thanks and Regards
Srikar Dronamraju

