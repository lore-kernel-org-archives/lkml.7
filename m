Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C730AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5913204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 05:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKZFk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:40:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38800 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbfKZFk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 00:40:57 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQ5b5SB188350
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 00:40:55 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wf0f7j6y3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 00:40:55 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 26 Nov 2019 05:40:53 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Nov 2019 05:40:50 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAQ5eAuF49152364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 05:40:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C1834C050;
        Tue, 26 Nov 2019 05:40:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02C394C04E;
        Tue, 26 Nov 2019 05:40:47 +0000 (GMT)
Received: from [9.199.58.15] (unknown [9.199.58.15])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Nov 2019 05:40:46 +0000 (GMT)
Subject: Re: [PATCH v6 1/2] perf: support multiple debug options separated by
 ','
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20191125151446.10948-1-changbin.du@gmail.com>
 <20191125151446.10948-2-changbin.du@gmail.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 26 Nov 2019 11:10:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125151446.10948-2-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19112605-0016-0000-0000-000002CC5232
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112605-0017-0000-0000-0000332E29DE
Message-Id: <c22da5eb-71dd-511b-bc9a-4981c3b22d4c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_06:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/19 8:44 PM, Changbin Du wrote:
>   	List of debug variables allowed to set:
> -	  verbose          - general debug messages
> -	  ordered-events   - ordered events object debug messages
> -	  data-convert     - data convert command debug messages
> -	  stderr           - write debug output (option -v) to stderr
> -	                     in browser mode
> -	  perf-event-open  - Print perf_event_open() arguments and
> -			     return value
> +	  verbose=level		- general debug messages
> +	  ordered-events=level	- ordered events object debug messages
> +	  data-convert=level	- data convert command debug messages
> +	  stderr		- write debug output (option -v) to stderr
> +	  perf-event-open	- Print perf_event_open() arguments and
> +	                          return value in browser mode
Shouldn't this be:

	  stderr		- write debug output (option -v) to stderr
	  			  in browser mode
	  perf-event-open	- Print perf_event_open() arguments and
	                          return value

-Ravi

