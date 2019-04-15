Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADECC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092362075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfDOOjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:39:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727319AbfDOOjW (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:39:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FEZZIG103070
        for <Linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:39:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rvuh419qv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <Linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:39:20 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <Linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 15 Apr 2019 15:39:18 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 15:39:14 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FEdDir57802906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 14:39:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69FD9A4062;
        Mon, 15 Apr 2019 14:39:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB249A4064;
        Mon, 15 Apr 2019 14:39:10 +0000 (GMT)
Received: from [9.85.69.153] (unknown [9.85.69.153])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Apr 2019 14:39:10 +0000 (GMT)
Subject: Re: [PATCH v4 3/4] perf stat: Support 'percore' event qualifier
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <1555077590-27664-1-git-send-email-yao.jin@linux.intel.com>
 <1555077590-27664-4-git-send-email-yao.jin@linux.intel.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Mon, 15 Apr 2019 20:09:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555077590-27664-4-git-send-email-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041514-4275-0000-0000-000003280D12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041514-4276-0000-0000-000038373961
Message-Id: <bba8359b-7986-0938-16ea-9bc179ef76cb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/19 7:29 PM, Jin Yao wrote:
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 39c05f8..1e312c2 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -43,6 +43,10 @@ report::
>  	  param1 and param2 are defined as formats for the PMU in
>  	  /sys/bus/event_source/devices/<pmu>/format/*
>  
> +	  'percore' is a event qualifier that sums up the event counts for both
> +	  hardware threads in a core.

s/both/all/  :

  $ lscpu | grep Thread
  Thread(s) per core:    4


Apart from that, for the series:
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

