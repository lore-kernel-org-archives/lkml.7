Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8A0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DEE206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCMQsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:48:31 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47255 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:48:30 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2A6EDFF822;
        Wed, 13 Mar 2019 16:48:21 +0000 (UTC)
Subject: Re: [PATCH v6 0/4] Fix free/allocation of runtime gigantic pages
To:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
References: <20190307132015.26970-1-alex@ghiti.fr>
 <875e6287-9528-45ec-788c-9c785e548942@intel.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <de40e6f1-c520-bcae-2009-19c0abbcd5d5@ghiti.fr>
Date:   Wed, 13 Mar 2019 17:48:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <875e6287-9528-45ec-788c-9c785e548942@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2019 05:41 PM, Dave Hansen wrote:
> On 3/7/19 5:20 AM, Alexandre Ghiti wrote:
>> This series fixes sh and sparc that did not advertise their gigantic page
>> support and then were not able to allocate and free those pages at runtime.
>> It renames MEMORY_ISOLATION && COMPACTION || CMA condition into the more
>> accurate CONTIG_ALLOC, since it allows the definition of alloc_contig_range
>> function.
>> Finally, it then fixes the wrong definition of ARCH_HAS_GIGANTIC_PAGE config
>> that, without MEMORY_ISOLATION && COMPACTION || CMA defined, did not allow
>> architectures to free boottime allocated gigantic pages although unrelated.
> Looks good, thanks for all the changes.  For everything generic in the
> set, plus the x86 bits:
>
> Acked-by: Dave Hansen <dave.hansen@intel.com>

Thanks Dave,

Alex
