Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16030C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C4E205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfHVKls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:41:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbfHVKls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:41:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MAcTtq130317
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:41:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uhs8ngmrx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:41:46 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Thu, 22 Aug 2019 11:41:44 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Aug 2019 11:41:39 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7MAfcZE54853694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 10:41:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD156A4057;
        Thu, 22 Aug 2019 10:41:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1C75A4053;
        Thu, 22 Aug 2019 10:41:34 +0000 (GMT)
Received: from oc3276512013.ibm.com (unknown [9.120.237.31])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Aug 2019 10:41:34 +0000 (GMT)
Subject: Re: [PATCH V1]Perf: Return error code for perf_session__new function
 on failure
To:     Mukesh Ojha <mojha@codeaurora.org>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, jeremie.galarneau@efficios.com,
        shawn@git.icu, tstoyanov@vmware.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, adrian.hunter@intel.com,
        songliubraving@fb.com, ravi.bangoria@linux.ibm.com
References: <20190820105645.4920.55590.stgit@localhost.localdomain>
 <a35bc9b3-f9af-1cfc-160c-b5951d5d994b@codeaurora.org>
From:   Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Date:   Thu, 22 Aug 2019 16:11:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a35bc9b3-f9af-1cfc-160c-b5951d5d994b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19082210-4275-0000-0000-0000035BD699
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082210-4276-0000-0000-0000386DFC57
Message-Id: <91b4e3c1-d2b3-c8a0-088d-1ff6466873ca@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/08/19 1:07 AM, Mukesh Ojha wrote:
>
> On 8/20/2019 4:51 PM, Mamatha Inamdar wrote:
>> This Patch is to return error code of perf_new_session function
>> on failure instead of NULL
>> ----------------------------------------------
>> Test Results:
>>
>> Before Fix:
>>
>> $ perf c2c report -input
>> failed to open nput: No such file or directory
>>
>> $ echo $?
>> 0
>> ------------------------------------------
>> After Fix:
>>
>> $ ./perf c2c report -input
>> failed to open nput: No such file or directory
>>
>> $ echo $?
>> 254
>>
>> Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
>> Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
>> Tested-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
>
> Looks good to me.
>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
>
> Thanks,
> Mukesh
>
Mukesh,

Thanks for reviewing the patch..

