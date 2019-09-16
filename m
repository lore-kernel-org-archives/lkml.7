Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C4BC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C84220678
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfIPQSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:18:50 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:4324 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbfIPQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:18:50 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8GFHhvk012323;
        Mon, 16 Sep 2019 16:17:05 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2v24xewwkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 16:17:04 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id B36DF6F;
        Mon, 16 Sep 2019 16:17:03 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 2D86D4C;
        Mon, 16 Sep 2019 16:17:02 +0000 (UTC)
Date:   Mon, 16 Sep 2019 11:17:01 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
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
Message-ID: <20190916161701.GI7834@swahl-linux>
References: <20190906212950.GA7792@swahl-linux>
 <20190909081414.5e3q47fzzruesscx@box>
 <20190910142810.GA7834@swahl-linux>
 <20190911002856.mx44pmswcjfpfjsb@box.shutemov.name>
 <20190911200835.GD7834@swahl-linux>
 <20190912101917.mbobjvkxhfttxddd@box>
 <20190913151415.GG7834@swahl-linux>
 <20190916090058.mteofmkkl37ob47k@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916090058.mteofmkkl37ob47k@box.shutemov.name>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_03:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 12:00:58PM +0300, Kirill A. Shutemov wrote:
> On Fri, Sep 13, 2019 at 10:14:15AM -0500, Steve Wahl wrote:
> > On Thu, Sep 12, 2019 at 01:19:17PM +0300, Kirill A. Shutemov wrote:
> > > On Wed, Sep 11, 2019 at 03:08:35PM -0500, Steve Wahl wrote:
> > > > Thank you for your time looking into this with me!
> > > 
> > > With all this explanation the original patch looks sane to me.
> > > 
> > > But I would like to see more information from this thread in the commit
> > > message and some comments in the code on why it's crucial not to map more
> > > than needed.
> > 
> > I am working on this.
> > 
> > > I think we also need to make it clear that this is workaround for a broken
> > > hardware: speculative execution must not trigger a halt.
> > 
> > I think the word broken is a bit loaded here.  According to the UEFI
> > spec (version 2.8, page 167), "Regions that are backed by the physical
> > hardware, but are not supposed to be accessed by the OS, must be
> > returned as EfiReservedMemoryType."  Our interpretation is that
> > includes speculative accesses.
> 
> +Dave.
> 
> I don't think it is. Speculative access is done by hardware, not OS.

But the OS controls speculative access to physical addresses by their
presence or absence in the page tables.  Speculation is done with
calculations based on virtual addresses, without a valid translation
to physical addresses it doesn't progress to an externally visible
action.

> BTW, isn't it a BIOS issue?
> 
> I believe it should have a way to hide a range of physical address space
> from OS or force a caching mode on to exclude it from speculative
> execution. Like setup MTRRs or something.

This is their intent in marking it as reserved in the memory tables.
They have explored many other avenues (I've even suggested a couple
since pinning down this problem) and for each one there is a reason it
doesn't work.

> > I'd lean more toward "tightening of adherence to the spec required by
> > some particular hardware."  Does that work for you?
> 
> Not really, no. I still believe it's issue of the platform, not OS.

My current wording for a comment to go above the code is:

/*
 * Only the region occupied by the kernel has so far been checked against
 * the table of usable memory regions provided by the firmware, so
 * invalidate pages outside that region.  A page table entry that maps to
 * a reserved area of memory would allow processor speculation into that
 * area, and on some hardware (particularly the UV platform) speculation
 * into reserved areas can cause a system halt.
 */

How close does that come to working for you?  (I'm going to dive
specifically into the phrase "region occupied by the kernel" in a
reply to Dave in another message; I understand that phrase may need
work.  I'm more asking about the remainder of it here.)

--> Steve

> -- 
>  Kirill A. Shutemov

-- 
Steve Wahl, Hewlett Packard Enterprise
