Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8B4C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7A920856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfILJn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:43:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730337AbfILJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:43:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8C9htqU089594
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 05:43:55 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uyhj84rak-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 05:43:55 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Thu, 12 Sep 2019 10:43:47 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Sep 2019 10:43:43 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8C9hgVL50725114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Sep 2019 09:43:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52F4D4C04A;
        Thu, 12 Sep 2019 09:43:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49FF54C046;
        Thu, 12 Sep 2019 09:43:41 +0000 (GMT)
Received: from oc0383214508.ibm.com (unknown [9.124.35.231])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Sep 2019 09:43:41 +0000 (GMT)
Subject: Re: [PATCH] cpupower : Handle set and info subcommands for powerpc
To:     shuah <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trenn@suse.com, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
References: <20190911095424.49605-1-huntbag@linux.vnet.ibm.com>
 <3326dc53-f8a1-dd7b-5ae8-b86ef5ef8b24@kernel.org>
From:   Abhishek <huntbag@linux.vnet.ibm.com>
Date:   Thu, 12 Sep 2019 15:13:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3326dc53-f8a1-dd7b-5ae8-b86ef5ef8b24@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19091209-0020-0000-0000-0000036B5D12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091209-0021-0000-0000-000021C0EDF9
Message-Id: <f43715dd-219b-d3ae-58a9-f343fe745d7d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

Thanks for the review. Few comments below.


On 09/11/2019 03:41 PM, shuah wrote:
> On 9/11/19 3:54 AM, Abhishek Goel wrote:
>> Cpupower tool has set and info options which are not being used by
>> POWER machines. For powerpc, we will return directly for these two
>> subcommands. This removes the ambiguous error message while using set
>> option in case of power systems.
>
> What is the error message you see? Please include it in the commit log.
>

Sure. Will include it in next version.

>>
>> Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
>> ---
>>   tools/power/cpupower/utils/cpupower-info.c | 5 +++++
>>   tools/power/cpupower/utils/cpupower-set.c  | 5 +++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/tools/power/cpupower/utils/cpupower-info.c 
>> b/tools/power/cpupower/utils/cpupower-info.c
>> index 4c9d342b70ff..674b707a76af 100644
>> --- a/tools/power/cpupower/utils/cpupower-info.c
>> +++ b/tools/power/cpupower/utils/cpupower-info.c
>> @@ -39,6 +39,11 @@ int cmd_info(int argc, char **argv)
>>       } params = {};
>>       int ret = 0;
>>   +    #ifdef __powerpc__
>> +    printf(_("Cannot read info as system does not support 
>> performance bias setting\n"));
>> +    return 0;
>> +    #endif
>> +
>

We see something like this for "cpupower info" --->
"System does not support Intel's performance bias setting"

> I am not in favor of bailing out this early with this ifdef switch.
> I would rather see this checked somehow(?) when the ambiguous error
> happens.

Since these two options are not being used by any other architecture
except x86, I suggest these options should not even be shown for
other architecture. So we can do something like this in cpupower.c :

static struct cmd_struct commands[] = {
          .............
+#if defined (__x86_64__) || defined (__i386__)
         { "set",        cmd_set,        1    },
         { "info",        cmd_info,        0    },
+#endif
         ..............

Is this Okay?

>
>>       setlocale(LC_ALL, "");
>>       textdomain(PACKAGE);
>>   diff --git a/tools/power/cpupower/utils/cpupower-set.c 
>> b/tools/power/cpupower/utils/cpupower-set.c
>> index 3cd95c6cb974..c95b29278780 100644
>> --- a/tools/power/cpupower/utils/cpupower-set.c
>> +++ b/tools/power/cpupower/utils/cpupower-set.c
>> @@ -41,6 +41,11 @@ int cmd_set(int argc, char **argv)
>>       int perf_bias = 0;
>>       int ret = 0;
>>   +    #ifdef __powerpc__
>> +    printf(_("System does not support performance bias setting\n"));
>> +    return 0;
>> +    #endif
>> +
>
> Same here.
>

For "cpupower set -b 10", we get something like :
"Error setting perf-bias value on CPU"


>>       setlocale(LC_ALL, "");
>>       textdomain(PACKAGE);
>>
>
> thanks,
> -- Shuah

Thanks,
-- Abhishek

