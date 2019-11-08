Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999DBC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2362178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 08:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfKHIgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 03:36:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730463AbfKHIgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:36:19 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA88a3T1144557
        for <linux-kernel@vger.kernel.org>; Fri, 8 Nov 2019 03:36:19 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w54339w83-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 03:36:16 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 8 Nov 2019 08:35:22 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 08:35:20 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA88Yhbv38207830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 08:34:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37507AE04D;
        Fri,  8 Nov 2019 08:35:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F251BAE045;
        Fri,  8 Nov 2019 08:35:17 +0000 (GMT)
Received: from [9.199.52.75] (unknown [9.199.52.75])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 08:35:17 +0000 (GMT)
Subject: Re: [RFC] perf record: Add option to print perf_event_open args and
 return value
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20191108035949.32644-1-ravi.bangoria@linux.ibm.com>
 <20191108080440.GB28919@krava>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Fri, 8 Nov 2019 14:05:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108080440.GB28919@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19110808-4275-0000-0000-0000037BE6CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110808-4276-0000-0000-0000388F3A80
Message-Id: <9d4831b6-71cc-63db-f48c-2627ad97515b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/19 1:34 PM, Jiri Olsa wrote:
> On Fri, Nov 08, 2019 at 09:29:49AM +0530, Ravi Bangoria wrote:
>> Perf record with verbose=2 already prints this information along with
>> whole lot of other traces which requires lot of scrolling. I thought
>> to show this information in verbose=1 but I fear that it will be too
>> much for level 1. So finally created a new option specifically for
>> printing this.
>>
>> Sample o/p:
>>    $ ./perf record --peo-args -- ls > /dev/null
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      size                             112
>>      { sample_period, sample_freq }   4000
>>      sample_type                      IP|TID|TIME|PERIOD
>>      read_format                      ID
>>      disabled                         1
>>      inherit                          1
>>      exclude_kernel                   1
>>      mmap                             1
>>      comm                             1
>>      freq                             1
>>      enable_on_exec                   1
>>      task                             1
>>      precise_ip                       3
>>      sample_id_all                    1
>>      exclude_guest                    1
>>      mmap2                            1
>>      comm_exec                        1
>>      ksymbol                          1
>>      bpf_event                        1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid 4308  cpu 0  group_fd -1  flags 0x8 = 4
>>    sys_perf_event_open: pid 4308  cpu 1  group_fd -1  flags 0x8 = 5
>>    sys_perf_event_open: pid 4308  cpu 2  group_fd -1  flags 0x8 = 6
>>    sys_perf_event_open: pid 4308  cpu 3  group_fd -1  flags 0x8 = 8
>>    sys_perf_event_open: pid 4308  cpu 4  group_fd -1  flags 0x8 = 9
>>    sys_perf_event_open: pid 4308  cpu 5  group_fd -1  flags 0x8 = 10
>>    sys_perf_event_open: pid 4308  cpu 6  group_fd -1  flags 0x8 = 11
>>    sys_perf_event_open: pid 4308  cpu 7  group_fd -1  flags 0x8 = 12
>>    ------------------------------------------------------------
>>    perf_event_attr:
>>      type                             1
>>      size                             112
>>      config                           0x9
>>      watermark                        1
>>      sample_id_all                    1
>>      bpf_event                        1
>>      { wakeup_events, wakeup_watermark } 1
>>    ------------------------------------------------------------
>>    sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
>>    sys_perf_event_open failed, error -13
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.002 MB perf.data (9 samples) ]
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> right, -vv is already poluted ;-) but we have the perf --debug
> option for specific debug:
> 
>         --debug
>             Setup debug variable (see list below) in value range (0, 10). Use like: --debug verbose # sets verbose = 1 --debug verbose=2 # sets verbose = 2
> 
>                 List of debug variables allowed to set:
>                   verbose          - general debug messages
>                   ordered-events   - ordered events object debug messages
>                   data-convert     - data convert command debug messages
>                   stderr           - write debug output (option -v) to stderr
>                                      in browser mode
> 
> so I think something like this would fit better:
> 
>    perf --debug event-open[=X] record ...
>    perf --debug perf-event-open[=X] record ...

Thanks Jiri. This looks better. Will respin.

