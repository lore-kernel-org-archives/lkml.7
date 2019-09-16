Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2086EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F256C214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfIPRPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 13:15:21 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:19548 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729297AbfIPRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:15:20 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8GHBrix025324;
        Mon, 16 Sep 2019 17:14:58 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 2v26gj34jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 17:14:58 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 9BC39A8;
        Mon, 16 Sep 2019 17:14:56 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 54A6045;
        Mon, 16 Sep 2019 17:14:55 +0000 (UTC)
Date:   Mon, 16 Sep 2019 12:14:55 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: [PATCH] x86/boot/64: Make level2_kernel_pgt pages invalid
 outside kernel area.
Message-ID: <20190916171455.GJ7834@swahl-linux>
References: <20190906212950.GA7792@swahl-linux>
 <20190909081414.5e3q47fzzruesscx@box>
 <20190910142810.GA7834@swahl-linux>
 <20190911002856.mx44pmswcjfpfjsb@box.shutemov.name>
 <20190911200835.GD7834@swahl-linux>
 <20190912101917.mbobjvkxhfttxddd@box>
 <20190913151415.GG7834@swahl-linux>
 <20190916090058.mteofmkkl37ob47k@box.shutemov.name>
 <4de3e0c2-7b59-c325-8d88-58220d721f71@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de3e0c2-7b59-c325-8d88-58220d721f71@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_07:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1011 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 07:25:48AM -0700, Dave Hansen wrote:
> On 9/16/19 2:00 AM, Kirill A. Shutemov wrote:
> >>> I think we also need to make it clear that this is workaround for a broken
> >>> hardware: speculative execution must not trigger a halt.
> >> I think the word broken is a bit loaded here.  According to the UEFI
> >> spec (version 2.8, page 167), "Regions that are backed by the physical
> >> hardware, but are not supposed to be accessed by the OS, must be
> >> returned as EfiReservedMemoryType."  Our interpretation is that
> >> includes speculative accesses.
> > +Dave.
> > 
> > I don't think it is. Speculative access is done by hardware, not OS.
> > 
> > BTW, isn't it a BIOS issue?
> > 
> > I believe it should have a way to hide a range of physical address space
> > from OS or force a caching mode on to exclude it from speculative
> > execution. Like setup MTRRs or something.
> 
> Ugh.  I bet that was a fun one to chase down.  Have the hardware
> engineers learned a lesson or are they hiding behind the EFI spec in an
> act of pure cowardice? ;)

Yes, it was fun.  My main BIOS contact has explained to me how they are
stuck between a rock and a hard place on any other options for this.

> The patch is small and fixes a real problem.  The changelog is OK,
> although I'd prefer some differentiation between "occupied by the
> kernel" and the kernel *image*.

OK, is the phrase "kernel image" generally understood to cover
everything from _text to _end, including the bss?  As long as that's
true, I will adopt this phrase.

> The code is also gloriously free of any comments about what it's
> doing or why.

I'm intending to add something like this in the next version:

/*
 * Only the region occupied by the kernel image has so far been checked against
 * the table of usable memory regions provided by the firmware, so
 * invalidate pages outside that region.  A page table entry that maps to
 * a reserved area of memory would allow processor speculation into that
 * area, and on some hardware (particularly the UV platform) speculation
 * into reserved areas can cause a system halt.
 */


> But, I'm left with lots of questions:
> 
> Why do PMD-level changes fix this?  Is it because we 2MB pad the kernel
> image?  Why can't we still get within 2MB of the memory address in
> question?

This fix works for our hardware because the problematic reserved
regions are 64M aligned, and going up to the next 2MB boundary from
_end is not going to cross the next 64M boundary.

One could argue the next step would be going into
boot/compressed/{kaslr.c, misc.c} and rounding the size of the kernel
up to the next 2MB boundary to ensure the chosen random location is
covered by usable RAM up to the next PMD-level boundary.  I did not go
there because for us it is not necessary.

> Is it in the lower 1MB, by chance?

No, this is a reserved range at the top physical addresses for each
NUMA node in a collection of them.  

> If this is all about avoiding EFI reserved ranges, why doesn't the
> patch *LOOK* At EFI reserved ranges?

Because the range the kernel image is located in is already checked
against them in boot/compressed/kaslr.c.  This will now be explained
in the comment I mention above, which you had not yet seen.

--> Steve Wahl


-- 
Steve Wahl, Hewlett Packard Enterprise
