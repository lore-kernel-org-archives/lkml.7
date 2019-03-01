Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853C6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546482084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbfCAHHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:07:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725290AbfCAHHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:07:02 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2176q4g038310
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 02:07:01 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qxwxdcr8c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 02:06:58 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 1 Mar 2019 07:05:48 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 07:05:46 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2175jv319333218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 07:05:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B3254203F;
        Fri,  1 Mar 2019 07:05:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B3FB4204C;
        Fri,  1 Mar 2019 07:05:40 +0000 (GMT)
Received: from [9.102.3.242] (unknown [9.102.3.242])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Mar 2019 07:05:40 +0000 (GMT)
Subject: Re: [PATCH] perf c2c: Fix c2c report for empty numa node
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, tonyj@suse.com, nasastry@in.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190228153719.23411-1-ravi.bangoria@linux.ibm.com>
 <20190228161231.GB8674@krava> <20190228162208.GC8674@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 1 Mar 2019 12:35:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228162208.GC8674@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030107-0020-0000-0000-0000031CB4F9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030107-0021-0000-0000-0000216E2A7E
Message-Id: <9ee9ca23-bb29-2038-5fe3-d52bcf4cd049@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/19 9:52 PM, Jiri Olsa wrote:
> how about attached change (untested)?

LGTM. Would you mind sending a patch.

> 
> but I wonder there are some other hidden
> bugs wrt empty node
> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 4272763a5e96..9e6cc868bdb4 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2056,6 +2056,12 @@ static int setup_nodes(struct perf_session *session)
>  		if (!set)
>  			return -ENOMEM;
>  
> +		nodes[node] = set;
> +
> +		/* empty node, skip */
> +		if (cpu_map__empty(map))
> +			continue;
> +
>  		for (cpu = 0; cpu < map->nr; cpu++) {
>  			set_bit(map->map[cpu], set);
>  
> @@ -2064,8 +2070,6 @@ static int setup_nodes(struct perf_session *session)
>  
>  			cpu2node[map->map[cpu]] = node;
>  		}
> -
> -		nodes[node] = set;
>  	}
>  
>  	setup_nodes_header();
> 

