Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD27CC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF1B2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfGIFi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:38:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49658 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725818AbfGIFi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:38:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x695au27037681
        for <linux-kernel@vger.kernel.org>; Tue, 9 Jul 2019 01:38:25 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tmjtukw1p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 01:38:25 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 9 Jul 2019 06:38:23 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Jul 2019 06:38:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x695cJwq41222472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jul 2019 05:38:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F9EB11C04C;
        Tue,  9 Jul 2019 05:38:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C26B11C04A;
        Tue,  9 Jul 2019 05:38:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.246])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jul 2019 05:38:18 +0000 (GMT)
Subject: Re: [RFC 0/2] Optimize the idle CPU search
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
References: <20190708045432.18774-1-parth@linux.ibm.com>
 <839c6cc8-b550-3066-d856-3c8a919cc318@oracle.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Tue, 9 Jul 2019 11:08:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <839c6cc8-b550-3066-d856-3c8a919cc318@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070905-0016-0000-0000-000002907EFB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070905-0017-0000-0000-000032EE2FBA
Message-Id: <708a2726-628c-196b-1fc0-43067e1e740f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=842 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/19 5:38 AM, Subhra Mazumdar wrote:
> 
> On 7/8/19 10:24 AM, Parth Shah wrote:
>> When searching for an idle_sibling, scheduler first iterates to search for
>> an idle core and then for an idle CPU. By maintaining the idle CPU mask
>> while iterating through idle cores, we can mark non-idle CPUs for which
>> idle CPU search would not have to iterate through again. This is especially
>> true in a moderately load system
>>
>> Optimize idle CPUs search by marking already found non idle CPUs during
>> idle core search. This reduces iteration count when searching for idle
>> CPUs, resulting in lower iteration count.
>>
> I believe this can co-exist with latency-nice? We can derive the 'nr' in
> select_idle_cpu from latency-nice and use the new mask to iterate.
> 

I agree, can be done with latency-nice.

Maybe something like below?
smt = nr_cpus / nr_cores
nr = smt + (p->latency_nice * (total_cpus-smt) / max_latency_nice)

This limits lower bounds to 1 core and goes through all the cores if
latency_nice is maximum for a task.


Thanks
Parth

