Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94E8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8772A2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgACMsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:48:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727494AbgACMsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:48:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003Clewq085489
        for <linux-kernel@vger.kernel.org>; Fri, 3 Jan 2020 07:48:38 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x88jfy4r3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 07:48:38 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
        Fri, 3 Jan 2020 12:48:36 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Jan 2020 12:48:34 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 003CmXvJ44892410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jan 2020 12:48:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10BCA52052;
        Fri,  3 Jan 2020 12:48:33 +0000 (GMT)
Received: from JAVRIS.in.ibm.com (unknown [9.199.47.17])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id F2C505204F;
        Fri,  3 Jan 2020 12:48:31 +0000 (GMT)
Subject: Re: [PATCH] objtool: use $(SRCARCH) to avoid compile error with
 ARCH=x86_64
To:     Shile Zhang <shile.zhang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20191227022931.142690-1-shile.zhang@linux.alibaba.com>
From:   Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date:   Fri, 3 Jan 2020 18:18:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191227022931.142690-1-shile.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010312-0028-0000-0000-000003CDECA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010312-0029-0000-0000-00002491F4BB
Message-Id: <3c752455-3fd3-b146-84c5-472574a3667e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_03:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=933
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001030122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/19 7:59 AM, Shile Zhang wrote:
> To build objtool with ARCH=x86_64 will failed as:
> 
>    $make ARCH=x86_64 -C tools/objtool
>    ...
>      CC       arch/x86/decode.o
>    arch/x86/decode.c:10:22: fatal error: asm/insn.h: No such file or directory
>     #include <asm/insn.h>
>                          ^
>    compilation terminated.
>    mv: cannot stat ‘arch/x86/.decode.o.tmp’: No such file or directory
>    make[2]: *** [arch/x86/decode.o] Error 1
>    ...
> 
> The root cause is the command-line variable 'ARCH' cannot be overridden.
> It can be replaced by the one 'SRCARCH' defined in
> 'tools/scripts/Makefile.arch'.
> 
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>


-- 
Kamalesh

