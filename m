Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D42C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CCC21880
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 06:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfGCGU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 02:20:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725927AbfGCGU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 02:20:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x636HJTh059160
        for <linux-kernel@vger.kernel.org>; Wed, 3 Jul 2019 02:20:26 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tgm3edmmw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 02:20:26 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 3 Jul 2019 07:20:24 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Jul 2019 07:20:22 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x636KLda59965480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jul 2019 06:20:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD62EAE04D;
        Wed,  3 Jul 2019 06:20:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FE4DAE061;
        Wed,  3 Jul 2019 06:20:19 +0000 (GMT)
Received: from [9.85.75.18] (unknown [9.85.75.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Jul 2019 06:20:18 +0000 (GMT)
Subject: Re: [PATCH] powerpc/hw_breakpoint: move instruction stepping out of
 hw_breakpoint_handler()
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <f8cdc3f1c66ad3c43ebc568abcc6c39ed4676284.1561737231.git.christophe.leroy@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 3 Jul 2019 11:50:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f8cdc3f1c66ad3c43ebc568abcc6c39ed4676284.1561737231.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070306-0020-0000-0000-0000034FB580
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070306-0021-0000-0000-000021A34A66
Message-Id: <57148696-b9a5-d3c1-1e29-82673c558927@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=665 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907030076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/19 9:25 PM, Christophe Leroy wrote:
> On 8xx, breakpoints stop after executing the instruction, so
> stepping/emulation is not needed. Move it into a sub-function and
> remove the #ifdefs.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Just one neat below...

[...]

> -#ifndef CONFIG_PPC_8xx
> -	/* Do not emulate user-space instructions, instead single-step them */
> -	if (user_mode(regs)) {
> -		current->thread.last_hit_ubp = bp;
> -		regs->msr |= MSR_SE;
> +	if (!IS_ENABLED(CONFIG_PPC_8xx) && !stepping_handler(regs, bp, info->address))

May be split this line. It's 86 chars long and checkpatch.pl is warning
about this:

WARNING: line over 80 characters
#257: FILE: arch/powerpc/kernel/hw_breakpoint.c:282:
+	if (!IS_ENABLED(CONFIG_PPC_8xx) && !stepping_handler(regs, bp, info->address))

