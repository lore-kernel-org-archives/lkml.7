Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51AAC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A8A207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbfKGObH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:31:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbfKGObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:31:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7EPH7r120325
        for <linux-kernel@vger.kernel.org>; Thu, 7 Nov 2019 09:31:05 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w4jw4qcjb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:31:05 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 7 Nov 2019 14:31:03 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Nov 2019 14:30:59 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7EUweZ13041862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Nov 2019 14:30:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72424AE05D;
        Thu,  7 Nov 2019 14:30:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44EC0AE065;
        Thu,  7 Nov 2019 14:30:54 +0000 (GMT)
Received: from [9.199.52.7] (unknown [9.199.52.7])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Nov 2019 14:30:53 +0000 (GMT)
Subject: Re: [PATCH v6 0/7] Powerpc/Watchpoint: Few important fixes
To:     mpe@ellerman.id.au
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>, mikey@neuling.org,
        npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20191017093204.7511-1-ravi.bangoria@linux.ibm.com>
 <10cce8b1-8142-39d3-cd91-58b85dac7c8c@linux.ibm.com>
 <ecb3eda1-f111-9485-c28c-e20020ae1d46@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Thu, 7 Nov 2019 20:00:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ecb3eda1-f111-9485-c28c-e20020ae1d46@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110714-0008-0000-0000-0000032C6F23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110714-0009-0000-0000-00004A4B7495
Message-Id: <047a102b-9578-88cc-872f-06c2952fb74c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=875 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/19 7:31 PM, Christophe Leroy wrote:
> 
> 
> Le 29/10/2019 à 05:54, Ravi Bangoria a écrit :
>>
>>
>> On 10/17/19 3:01 PM, Ravi Bangoria wrote:
>>> v5: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-October/198069.html
>>>
>>> v5->v6:
>>>   - patch 6/7: mpe reported that the perf-hwbreak.c doesn't compile with older
>>>     gcc:
>>>          perf-hwbreak.c:182:2: error: dereferencing type-punned pointer will
>>>          break strict-aliasing rules [-Werror=strict-aliasing]
>>>              temp16 = *((__u16 *)target);
>>>              ^
>>>     Fixed that.
>>>
>>
>> Hi Christophe, Are you ok with the series wrt 8xx?
> 
> Yes it looks ok on my 885:
> 
> root@vgoip:~# ./ptrace-hwbreak
> test: ptrace-hwbreak
> tags: git_version:v5.4-rc4-835-gb235e63aa9f0-dirty
> PTRACE_SET_DEBUGREG, WO, len: 1: Ok
> PTRACE_SET_DEBUGREG, WO, len: 2: Ok
> PTRACE_SET_DEBUGREG, WO, len: 4: Ok
> PTRACE_SET_DEBUGREG, WO, len: 8: Ok
> PTRACE_SET_DEBUGREG, RO, len: 1: Ok
> PTRACE_SET_DEBUGREG, RO, len: 2: Ok
> PTRACE_SET_DEBUGREG, RO, len: 4: Ok
> PTRACE_SET_DEBUGREG, RO, len: 8: Ok
> PTRACE_SET_DEBUGREG, RW, len: 1: Ok
> PTRACE_SET_DEBUGREG, RW, len: 2: Ok
> PTRACE_SET_DEBUGREG, RW, len: 4: Ok
> PTRACE_SET_DEBUGREG, RW, len: 8: Ok
> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
> PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
> success: ptrace-hwbreak
> 
> Also ok on book3s/32:

mpe, Can you please pull the series.

Ravi

