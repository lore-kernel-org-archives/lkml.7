Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA794C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E242083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbfCALuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:50:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbfCALuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:50:09 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21Bo0hu032443
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 06:50:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qy1x4pv01-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:50:07 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 1 Mar 2019 11:50:05 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 11:49:58 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x21Bnvjh59637792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Mar 2019 11:49:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 988DF4C04E;
        Fri,  1 Mar 2019 11:49:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72BA84C04A;
        Fri,  1 Mar 2019 11:49:55 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.73])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Mar 2019 11:49:55 +0000 (GMT)
Date:   Fri, 1 Mar 2019 13:49:53 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Steven Price <steven.price@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2 03/13] mm: Add generic p?d_large() macros
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
 <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
 <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
 <20190221145706.zqwfdoyiirn3lc7y@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221145706.zqwfdoyiirn3lc7y@kshutemo-mobl1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19030111-0012-0000-0000-000002FBBE8F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030111-0013-0000-0000-000021336E7D
Message-Id: <20190301114953.GD5156@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On Thu, Feb 21, 2019 at 05:57:06PM +0300, Kirill A. Shutemov wrote:
> On Thu, Feb 21, 2019 at 02:46:18PM +0000, Steven Price wrote:
> > On 21/02/2019 14:28, Kirill A. Shutemov wrote:
> > > On Thu, Feb 21, 2019 at 11:34:52AM +0000, Steven Price wrote:
> > >> From: James Morse <james.morse@arm.com>
> > >>
> > >> Exposing the pud/pgd levels of the page tables to walk_page_range() means
> > >> we may come across the exotic large mappings that come with large areas
> > >> of contiguous memory (such as the kernel's linear map).
> > >>
> > >> For architectures that don't provide p?d_large() macros, provided a
> > >> does nothing default.
> > > 
> > > Nak, sorry.
> > > 
> > > Power will get broken by the patch. It has pmd_large() inline function,
> > > that will be overwritten by the define from this patch.
> > > 
> > > I believe it requires more ground work on arch side in general.
> > > All architectures that has huge page support has to provide these helpers
> > > (and matching defines) before you can use it in a generic code.
> > 
> > Sorry about that, I had compile tested on power, but obviously not the
> > right config to actually see the breakage.
> 
> I don't think you'll catch it at compile-time. It would silently override
> the helper with always-false.

Can you explain why the compiler would override the helper define in, e.g.
arch/powerpc/include/asm/pgtable.h with the generic (0)?
Actually, I've tried to compile this on power with deliberately adding
errors to both power-specific and the generic definition of pmd_large and
the compilation failed the way I expected in the power-specific helper.
 
> > I'll do some grepping - hopefully this is just a case of exposing the
> > functions/defines that already exist for those architectures.
> 
> I see the same type of breakage on s390 and sparc.
> 
> > Note that in terms of the new page walking code, these new defines are
> > only used when walking a page table without a VMA (which isn't currently
> > done), so architectures which don't use p?d_large currently will work
> > fine with the generic versions. They only need to provide meaningful
> > definitions when switching to use the walk-without-a-VMA functionality.
> 
> How other architectures would know that they need to provide the helpers
> to get walk-without-a-VMA functionality? This looks very fragile to me.
> 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.

