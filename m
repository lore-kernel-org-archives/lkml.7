Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D13C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A812083E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfCBDHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:07:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbfCBDHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 22:07:35 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x222xAR3007031
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 22:07:35 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qydkx8cpq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 22:07:35 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Sat, 2 Mar 2019 03:07:32 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 2 Mar 2019 03:07:30 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2237ToR27590888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 2 Mar 2019 03:07:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 010DB52050;
        Sat,  2 Mar 2019 03:07:29 +0000 (GMT)
Received: from [9.199.40.144] (unknown [9.199.40.144])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DD4AE5204F;
        Sat,  2 Mar 2019 03:07:26 +0000 (GMT)
Subject: Re: [PATCH] perf c2c: Fix c2c report for empty numa node
To:     Jiri Olsa <jolsa@redhat.com>, acme@kernel.org
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        eranian@google.com, linux-kernel@vger.kernel.org, tonyj@suse.com,
        nasastry@in.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190228153719.23411-1-ravi.bangoria@linux.ibm.com>
 <20190228161231.GB8674@krava> <20190228162208.GC8674@krava>
 <9ee9ca23-bb29-2038-5fe3-d52bcf4cd049@linux.ibm.com>
 <20190301102644.GC2979@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Sat, 2 Mar 2019 08:37:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301102644.GC2979@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030203-0012-0000-0000-000002FC0223
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030203-0013-0000-0000-00002133B3E9
Message-Id: <400ca5f3-5048-2d58-d108-3cde2a9074af@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-02_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903020018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/1/19 3:56 PM, Jiri Olsa wrote:
> Ravi Bangoria reported that we fail with empty
> numa node with following message:
> 
>   $ lscpu
>   NUMA node0 CPU(s):
>   NUMA node1 CPU(s):   0-4
> 
>   $ sudo ./perf c2c report
>   node/cpu topology bugFailed setup nodes
> 
> Fixing this by detecting empty node and keeping
> its cpu set empty.
> 
> Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Link: http://lkml.kernel.org/n/tip-dyq5jo6pn1j3yqavb5ukjwwu@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reported-by: Nageswara R Sastry <nasastry@in.ibm.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

