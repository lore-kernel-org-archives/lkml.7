Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FD0C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300462075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfFSHqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:46:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbfFSHqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:46:02 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5J7gYnN107081
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:46:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t7en1694d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:46:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 19 Jun 2019 08:45:58 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 08:45:56 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5J7jtFo48758878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 07:45:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87263A4053;
        Wed, 19 Jun 2019 07:45:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E55DFA4040;
        Wed, 19 Jun 2019 07:45:53 +0000 (GMT)
Received: from [9.124.31.60] (unknown [9.124.31.60])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jun 2019 07:45:53 +0000 (GMT)
Subject: Re: [PATCH 5/5] Powerpc/Watchpoint: Fix length calculation for
 unaligned target
To:     Michael Neuling <mikey@neuling.org>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, christophe.leroy@c-s.fr,
        naveen.n.rao@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190618042732.5582-1-ravi.bangoria@linux.ibm.com>
 <20190618042732.5582-6-ravi.bangoria@linux.ibm.com>
 <707bc0b664b8ebbb843a1541155fed219c216035.camel@neuling.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 19 Jun 2019 13:15:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <707bc0b664b8ebbb843a1541155fed219c216035.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061907-4275-0000-0000-000003439F99
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061907-4276-0000-0000-00003853C9AB
Message-Id: <8a8a17b6-bdd6-4efb-7937-b1af105e08e0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/19 7:02 PM, Michael Neuling wrote:
> On Tue, 2019-06-18 at 09:57 +0530, Ravi Bangoria wrote:
>> Watchpoint match range is always doubleword(8 bytes) aligned on
>> powerpc. If the given range is crossing doubleword boundary, we
>> need to increase the length such that next doubleword also get
>> covered. Ex,
>>
>>           address   len = 6 bytes
>>                 |=========.
>>    |------------v--|------v--------|
>>    | | | | | | | | | | | | | | | | |
>>    |---------------|---------------|
>>     <---8 bytes--->
>>
>> In such case, current code configures hw as:
>>   start_addr = address & ~HW_BREAKPOINT_ALIGN
>>   len = 8 bytes
>>
>> And thus read/write in last 4 bytes of the given range is ignored.
>> Fix this by including next doubleword in the length. Watchpoint
>> exception handler already ignores extraneous exceptions, so no
>> changes required for that.
> 
> Nice catch. Thanks.
> 
> I assume this has been broken forever? Should we be CCing stable? If so, it
> would be nice to have this self contained (separate from the refactor) so we can
> more easily backport it.

Yes this has been broken forever. I'll add Fixes: tag and cc stable.

> 
> Also, can you update 
> tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c to catch this issue?

Sure, will add the test case.

[...]

>> +u16 hw_breakpoint_get_final_len(struct arch_hw_breakpoint *brk,
>> +				unsigned long *start_addr,
>> +				unsigned long *end_addr)
> 
> I don't really like this.  "final" is not a good name. Something like hardware
> would be better.
> 
> Also, can you put the start_addr and end addr in the arch_hw_breakpoint rather
> than doing what you have above.  Call them hw_start_addr, hw_end_addr.
> 
> We could even set these two new addresses where we set the set of
> arch_hw_breakpoint rather than having this late call.

Sure, will use 'hw_' prefix for them.

