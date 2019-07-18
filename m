Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273AC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBF9208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 21:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391358AbfGRV3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:29:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727685AbfGRV3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:29:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6ILLvtB121374;
        Thu, 18 Jul 2019 17:28:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ttxpnvm7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 17:28:47 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x6ILOcNC126851;
        Thu, 18 Jul 2019 17:28:47 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ttxpnvm6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 17:28:47 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6ILOaeT005158;
        Thu, 18 Jul 2019 21:28:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 2trtmrjjgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 21:28:46 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6ILSjR139584190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 21:28:45 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C547AC062;
        Thu, 18 Jul 2019 21:28:45 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A8D7AC059;
        Thu, 18 Jul 2019 21:28:43 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.186.82])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 21:28:42 +0000 (GMT)
References: <20190713060023.8479-1-bauerman@linux.ibm.com> <20190713060023.8479-4-bauerman@linux.ibm.com> <70f8097f-7222-fe18-78b4-9372c21bfc9d@ozlabs.ru> <20190718195850.GU20882@gate.crashing.org>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/13] powerpc/prom_init: Add the ESM call to prom_init
In-reply-to: <20190718195850.GU20882@gate.crashing.org>
Date:   Thu, 18 Jul 2019 18:28:36 -0300
Message-ID: <875znz3ud7.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Segher,

Thanks for your review and suggestions!

Segher Boessenkool <segher@kernel.crashing.org> writes:

> (Sorry to hijack your reply).
>
> On Thu, Jul 18, 2019 at 06:11:48PM +1000, Alexey Kardashevskiy wrote:
>> On 13/07/2019 16:00, Thiago Jung Bauermann wrote:
>> >From: Ram Pai <linuxram@us.ibm.com>
>> >+static int enter_secure_mode(unsigned long kbase, unsigned long fdt)
>> >+{
>> >+	register uint64_t func asm("r3") = UV_ESM;
>> >+	register uint64_t arg1 asm("r4") = (uint64_t)kbase;
>> >+	register uint64_t arg2 asm("r5") = (uint64_t)fdt;
>> 
>> What does UV do with kbase and fdt precisely? Few words in the commit 
>> log will do.
>> 
>> >+
>> >+	asm volatile("sc 2\n"
>> >+		     : "=r"(func)
>> >+		     : "0"(func), "r"(arg1), "r"(arg2)
>> >+		     :);
>> >+
>> >+	return (int)func;
>> 
>> And why "func"? Is it "function"? Weird name. Thanks,

Yes, I believe func is for function. Perhaps ucall would be clearer
if the variable wasn't reused for the return value as Segher points out.

> Maybe the three vars should just be called "r3", "r4", and "r5" --
> r3 is used as return value as well, so "func" isn't a great name for it.

Yes, that does seem simpler.

> Some other comments about this inline asm:
>
> The "\n" makes the generated asm look funny and has no other function.
> Instead of using backreferences you can use a "+" constraint, "inout".
> Empty clobber list is strange.
> Casts to the return type, like most other casts, are an invitation to
> bugs and not actually useful.
>
> So this can be written
>
> static int enter_secure_mode(unsigned long kbase, unsigned long fdt)
> {
> 	register uint64_t r3 asm("r3") = UV_ESM;
> 	register uint64_t r4 asm("r4") = kbase;
> 	register uint64_t r4 asm("r5") = fdt;
>
> 	asm volatile("sc 2" : "+r"(r3) : "r"(r4), "r"(r5));
>
> 	return r3;
> }

I'll adopt your version, it is cleaner inded. Thanks for providing it!

> (and it probably should use u64 instead of both uint64_t and unsigned long?)

Almost all of prom_init.c uses unsigned long, with u64 in just a few
places. uint64_t isn't used anywhere else in the file. I'll switch to
unsigned long everywhere, since this feature is only for 64 bit.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
