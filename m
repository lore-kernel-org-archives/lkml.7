Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863EDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6612070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbfC0KFf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:05:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732920AbfC0KFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:05:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RA4qXB030824
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:05:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rg5vf3j9q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:05:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 27 Mar 2019 10:05:30 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Mar 2019 10:05:22 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2RA5Ld536831236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 10:05:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA8ADAE045;
        Wed, 27 Mar 2019 10:05:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44B49AE051;
        Wed, 27 Mar 2019 10:05:15 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.102.0.57])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Mar 2019 10:05:15 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Alexandre Ghiti <alex@ghiti.fr>, mpe@ellerman.id.au,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v8 4/4] hugetlb: allow to free gigantic pages regardless of the configuration
In-Reply-To: <e7637427-5f17-b4f4-93a2-70cac9b3a264@ghiti.fr>
References: <20190327063626.18421-1-alex@ghiti.fr> <20190327063626.18421-5-alex@ghiti.fr> <f6e74ad8-acca-3b1e-27eb-a2881ac8437d@linux.ibm.com> <fbae7220-2e6f-8516-cf93-fbe430452043@ghiti.fr> <aabfc780-1681-c69a-9927-4645d6499984@linux.ibm.com> <e7637427-5f17-b4f4-93a2-70cac9b3a264@ghiti.fr>
Date:   Wed, 27 Mar 2019 15:35:13 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19032710-4275-0000-0000-0000031FC8B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032710-4276-0000-0000-0000382E6206
Message-Id: <87pnqcws2u.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Ghiti <alex@ghiti.fr> writes:

> On 03/27/2019 09:55 AM, Aneesh Kumar K.V wrote:
>> On 3/27/19 2:14 PM, Alexandre Ghiti wrote:
>>>
>>>
>>> On 03/27/2019 08:01 AM, Aneesh Kumar K.V wrote:
>>>> On 3/27/19 12:06 PM, Alexandre Ghiti wrote:
>

.....

>>
>> This is now
>> #define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>> static inline bool gigantic_page_runtime_supported(void)
>> {
>> if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>>         return false;
>>
>>     return true;
>> }
>>
>>
>> I am wondering whether it should be
>>
>> #define __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>> static inline bool gigantic_page_runtime_supported(void)
>> {
>>
>>    if (!IS_ENABLED(CONFIG_CONTIG_ALLOC))
>>         return false;
>
> I don't think this test should happen here, CONFIG_CONTIG_ALLOC only allows
> to allocate gigantic pages, doing that check here would prevent powerpc
> to free boottime gigantic pages when not a guest. Note that this check
> is actually done in set_max_huge_pages.
>
>
>>
>> if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
>>         return false;
>
> Maybe I did not understand this check: I understood that, in the case 
> the system
> is virtualized, we do not want it to hand back gigantic pages. Does this 
> check
> test if the system is currently being virtualized ?
> If yes, I think the patch is correct: it prevents freeing gigantic pages 
> when the system
> is virtualized but allows a 'normal' system to free gigantic pages.
>
>
>>

Ok double checked the patch applying the the tree. I got confused by the
removal of that #ifdef. So we now disallow the runtime free by checking
for gigantic_page_runtime_supported() in  __nr_hugepages_store_common.
Now if we allow and if CONFIG_CONTIG_ALLOC is disabled, we still should
allow to free the boot time allocated pages back to buddy.

The patch looks good. You can add for the series

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

-aneesh

