Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD8EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6542084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfKLOUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:20:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726939AbfKLOUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:20:32 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACEEH5p054438
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:20:31 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7w3y3nvm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:20:31 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 12 Nov 2019 14:20:28 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 14:20:25 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACEKO9842991740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 14:20:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51BFBA4040;
        Tue, 12 Nov 2019 14:20:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8330A4055;
        Tue, 12 Nov 2019 14:20:22 +0000 (GMT)
Received: from [9.199.52.230] (unknown [9.199.52.230])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 14:20:22 +0000 (GMT)
Subject: Re: [PATCH] perf report: Fix segfault with '-F phys_daddr'
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@redhat.com, kan.liang@intel.com,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20191112054946.5869-1-ravi.bangoria@linux.ibm.com>
 <20191112110417.GH9365@kernel.org>
 <53a89f25-d29f-0df4-61c9-77d70a507117@linux.ibm.com>
 <20191112141801.GA10207@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 12 Nov 2019 19:50:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112141801.GA10207@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111214-4275-0000-0000-0000037D16FE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111214-4276-0000-0000-000038907514
Message-Id: <7673a8f6-d4f2-0247-e8fc-ba94a9b16996@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/19 7:48 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Nov 12, 2019 at 07:28:06PM +0530, Ravi Bangoria escreveu:
>>
>>
>> On 11/12/19 4:34 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Nov 12, 2019 at 11:19:46AM +0530, Ravi Bangoria escreveu:
>>>> If perf.data file is not recorded with mem-info, adding 'phys_daddr'
>>>> to output field in perf report results in segfault. Fix that.
>>>>
>>>> Before:
>>>>     $ ./perf record ls
>>>>     $ ./perf report -F +phys_daddr
>>>>     Segmentation fault (core dumped)
>>>>
>>>> After:
>>>>     $ ./perf report -F +phys_daddr
>>>>     Samples: 11  of event 'cycles:u', Event count (approx.): 1485821
>>>>     Overhead  Data Physical Address  Command  Shared Object  Symbol
>>>>       22.57%  [.] 0000000000000000   ls       libc-2.29.so   [.] __strcoll_l
>>>>       21.87%  [.] 0000000000000000   ls       ld-2.29.so     [.] _dl_relocate_object
>>>>       ...
>>>
>>> Shouldn't we instead just bail out and state that this isn't possible
>>> and leave the user wondering why what was asked isn't presented?
>>
>> You mean popup with something like "phys_daddr is not available in perf.data"
>> and also don't show that column in perf report?
> 
> Just bail out completely, something like:
> 
> 
>     $ ./perf report -F +phys_daddr
>     "phys_daddr" is not available in perf.data, use 'record -e some,thing' to have it.

Sure. Thanks for the suggestion. Will re-spin.

Ravi

