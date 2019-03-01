Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19277C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6062083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfCALxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:53:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387478AbfCALxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:53:16 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x21BnMeK009718
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 06:53:14 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qy3e6akm5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:53:14 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 1 Mar 2019 11:53:12 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 1 Mar 2019 11:53:06 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x21Br55c31522890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 11:53:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41070A404D;
        Fri,  1 Mar 2019 11:53:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 127F4A4040;
        Fri,  1 Mar 2019 11:53:03 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.73])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Mar 2019 11:53:02 +0000 (GMT)
Date:   Fri, 1 Mar 2019 13:53:01 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Steven Price <steven.price@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
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
 <e0c7fc0c-7924-1106-a7a3-fc12136b7b82@arm.com>
 <20190221210618.voyfs5cnafpvgedh@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221210618.voyfs5cnafpvgedh@kshutemo-mobl1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19030111-0016-0000-0000-0000025C7989
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030111-0017-0000-0000-000032B6ED0A
Message-Id: <20190301115300.GE5156@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=939 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903010084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Him Kirill,

On Fri, Feb 22, 2019 at 12:06:18AM +0300, Kirill A. Shutemov wrote:
> On Thu, Feb 21, 2019 at 05:16:46PM +0000, Steven Price wrote:
> > >> Note that in terms of the new page walking code, these new defines are
> > >> only used when walking a page table without a VMA (which isn't currently
> > >> done), so architectures which don't use p?d_large currently will work
> > >> fine with the generic versions. They only need to provide meaningful
> > >> definitions when switching to use the walk-without-a-VMA functionality.
> > > 
> > > How other architectures would know that they need to provide the helpers
> > > to get walk-without-a-VMA functionality? This looks very fragile to me.
> > 
> > Yes, you've got a good point there. This would apply to the p?d_large
> > macros as well - any arch which (inadvertently) uses the generic version
> > is likely to be fragile/broken.
> > 
> > I think probably the best option here is to scrap the generic versions
> > altogether and simply introduce a ARCH_HAS_PXD_LARGE config option which
> > would enable the new functionality to those arches that opt-in. Do you
> > think this would be less fragile?
> 
> These helpers are useful beyond pagewalker.
> 
> Can we actually do some grinding and make *all* archs to provide correct
> helpers? Yes, it's tedious, but not that bad.

Many architectures simply cannot support non-leaf entries at the higher
levels. I think letting the use a generic helper actually does make sense.
 
> I think we could provide generic helpers for folded levels in
> <asm-generic/pgtable-nop?d.h> and rest has to be provided by the arch.
> Architectures that support only 2 level paging would need to provide
> pgd_large(), with 3 -- pmd_large() and so on.
> 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.

