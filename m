Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75690C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437F82083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbfCALqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:46:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387677AbfCALqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:46:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21Bj2p1138866
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 06:46:16 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qy2cj5cj3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:46:13 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 1 Mar 2019 11:46:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 11:46:03 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x21Bk2Cb32505906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 11:46:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E71CA404D;
        Fri,  1 Mar 2019 11:46:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5AB8A4051;
        Fri,  1 Mar 2019 11:45:57 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.73])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Mar 2019 11:45:57 +0000 (GMT)
Date:   Fri, 1 Mar 2019 13:45:54 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v3 09/34] m68k: mm: Add p?d_large() definitions
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-10-steven.price@arm.com>
 <CAMuHMdXCjuurBiFzQBeLPUFu=mmSowvb=37XyWmF_=xVhkQm4g@mail.gmail.com>
 <20190228113653.GB3766@rapoport-lnx>
 <CAMuHMdU5gn6ftAHNwHNPDoUy_JvcZLcXbkk1hvUmYxtfJRfTTQ@mail.gmail.com>
 <a17f5ad7-9fba-9d51-4d6e-7a9effe81e4e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a17f5ad7-9fba-9d51-4d6e-7a9effe81e4e@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19030111-0012-0000-0000-000002FBBE46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030111-0013-0000-0000-000021336E2C
Message-Id: <20190301114553.GC5156@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:04:08PM +0000, Steven Price wrote:
> On 28/02/2019 11:53, Geert Uytterhoeven wrote:
> > Hi Mike,
> > 
> > On Thu, Feb 28, 2019 at 12:37 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >> On Wed, Feb 27, 2019 at 08:27:40PM +0100, Geert Uytterhoeven wrote:
> >>> On Wed, Feb 27, 2019 at 6:07 PM Steven Price <steven.price@arm.com> wrote:
> >>>> walk_page_range() is going to be allowed to walk page tables other than
> >>>> those of user space. For this it needs to know when it has reached a
> >>>> 'leaf' entry in the page tables. This information is provided by the
> >>>> p?d_large() functions/macros.
> >>>>
> >>>> For m68k, we don't support large pages, so add stubs returning 0
> >>>>
> >>>> CC: Geert Uytterhoeven <geert@linux-m68k.org>
> >>>> CC: linux-m68k@lists.linux-m68k.org
> >>>> Signed-off-by: Steven Price <steven.price@arm.com>
> >>>
> >>> Thanks for your patch!
> >>>
> >>>>  arch/m68k/include/asm/mcf_pgtable.h      | 2 ++
> >>>>  arch/m68k/include/asm/motorola_pgtable.h | 2 ++
> >>>>  arch/m68k/include/asm/pgtable_no.h       | 1 +
> >>>>  arch/m68k/include/asm/sun3_pgtable.h     | 2 ++
> >>>>  4 files changed, 7 insertions(+)
> >>>
> >> Maybe I'm missing something, but why the stubs have to be defined in
> >> arch/*/include/asm/pgtable.h rather than in include/asm-generic/pgtable.h?
> > 
> > That would even make more sense, given most architectures don't
> > support huge pages.
> 
> Where the architecture has folded a level stubs are provided by the
> asm-generic layer, see this later patch:
> 
> https://lore.kernel.org/lkml/20190227170608.27963-25-steven.price@arm.com/
> 
> However just because an architecture port doesn't (currently) support
> huge pages doesn't mean that the architecture itself can't have large[1]
> mappings at higher levels of the page table. For instance an
> architecture might use large pages for the linear map but not support
> huge page mappings for user space.

Well, I doubt m68k can support large mappings at higher levels at all.
This, IMHO, applies to many other architectures and spreading p?d_large all
over those architecture seems wrong to me...

> My previous posting of this series attempted to define generic versions
> of p?d_large(), but it was pointed out to me that this was fragile and
> having a way of knowing whether the page table was a 'leaf' is actually
> useful, so I've attempted to implement for all architectures. See the
> discussion here:
> https://lore.kernel.org/lkml/20190221113502.54153-1-steven.price@arm.com/T/#mf0bd0155f185a19681b48a288be212ed1596e85d

I'll reply on that thread, somehow I missed it then.
 
> Steve
> 

-- 
Sincerely yours,
Mike.

