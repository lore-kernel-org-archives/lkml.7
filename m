Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F248BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED68206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 04:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfJJEoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 00:44:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726201AbfJJEoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 00:44:15 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9A4fYWf038681
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 00:44:14 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vht4b5741-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 00:44:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 10 Oct 2019 05:44:11 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Oct 2019 05:44:08 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9A4i72M42992074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 04:44:07 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 356945204F;
        Thu, 10 Oct 2019 04:44:07 +0000 (GMT)
Received: from [9.124.31.69] (unknown [9.124.31.69])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9E9D252050;
        Thu, 10 Oct 2019 04:44:05 +0000 (GMT)
Subject: Re: [PATCH v4 0/5] Powerpc/Watchpoint: Few important fixes
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20190925040630.6948-1-ravi.bangoria@linux.ibm.com>
 <19b222ce-3013-7de5-1c04-48c6fd00fe81@linux.ibm.com>
 <0d98e256-44ee-f920-cb2f-f79545584769@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Thu, 10 Oct 2019 10:14:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <0d98e256-44ee-f920-cb2f-f79545584769@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101004-0028-0000-0000-000003A8B5B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101004-0029-0000-0000-0000246ABC78
Message-Id: <3e31e5f7-f948-512a-054c-9ad10103ccc0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-10_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=931 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910100042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> @Christophe, Is patch5 works for you on 8xx?
>>
> 
> Getting the following :
> 
> root@vgoip:~# ./ptrace-hwbreak
> test: ptrace-hwbreak
> tags: git_version:v5.4-rc2-710-gf0082e173fe4-dirty
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
> PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO, len: 6: Ok
> PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, RO, len: 6: Fail
> failure: ptrace-hwbreak
> 

Thanks Christophe. I don't have any 8xx box. I checked qemu and it seems
qemu emulation for 8xx is not yet supported. So I can't debug this. Can
you please check why it's failing?

-Ravi

