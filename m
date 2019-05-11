Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63BFC04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 02:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9642173B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 02:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfEKCrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 22:47:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbfEKCrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 22:47:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4B2lPh8044834
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 22:47:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sdfrrusjb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 22:47:29 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Sat, 11 May 2019 03:47:28 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 11 May 2019 03:47:26 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4B2lPOf57016466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 May 2019 02:47:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B06EA4051;
        Sat, 11 May 2019 02:47:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3C91A4040;
        Sat, 11 May 2019 02:47:22 +0000 (GMT)
Received: from [9.102.0.124] (unknown [9.102.0.124])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 11 May 2019 02:47:22 +0000 (GMT)
Subject: Re: [PATCH 2/2] powerpc/perf: Fix mmcra corruption by bhrb_filter
To:     peterz@infradead.org, jolsa@redhat.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190511024217.4013-1-ravi.bangoria@linux.ibm.com>
 <20190511024217.4013-2-ravi.bangoria@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Sat, 11 May 2019 08:17:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511024217.4013-2-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051102-0016-0000-0000-0000027A828D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051102-0017-0000-0000-000032D7406C
Message-Id: <4f3cab49-7ee5-cb01-65d9-0dce79db581d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905110017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/19 8:12 AM, Ravi Bangoria wrote:
> Consider a scenario where user creates two events:
> 
>   1st event:
>     attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
>     attr.branch_sample_type = PERF_SAMPLE_BRANCH_ANY;
>     fd = perf_event_open(attr, 0, 1, -1, 0);
> 
>   This sets cpuhw->bhrb_filter to 0 and returns valid fd.
> 
>   2nd event:
>     attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
>     attr.branch_sample_type = PERF_SAMPLE_BRANCH_CALL;
>     fd = perf_event_open(attr, 0, 1, -1, 0);
> 
>   It overrides cpuhw->bhrb_filter to -1 and returns with error.
> 
> Now if power_pmu_enable() gets called by any path other than
> power_pmu_add(), ppmu->config_bhrb(-1) will set mmcra to -1.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Fixes: 3925f46bb590 ("powerpc/perf: Enable branch stack sampling framework")

