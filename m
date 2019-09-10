Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54DFC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C211F21479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbfIJOip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:38:45 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:9210 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728244AbfIJOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:38:45 -0400
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AER2uX023428;
        Tue, 10 Sep 2019 14:38:32 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 2uxc4t1jmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 14:38:32 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id E950D56;
        Tue, 10 Sep 2019 14:38:30 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id C54DF51;
        Tue, 10 Sep 2019 14:38:29 +0000 (UTC)
Date:   Tue, 10 Sep 2019 09:38:29 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Steve Wahl <steve.wahl@hpe.com>,
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
Message-ID: <20190910143829.GB7834@swahl-linux>
References: <20190906212950.GA7792@swahl-linux>
 <20190909081414.5e3q47fzzruesscx@box>
 <20190910061815.GA40059@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910061815.GA40059@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=912 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909100141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 08:18:15AM +0200, Ingo Molnar wrote:
> 
> * Kirill A. Shutemov <kirill@shutemov.name> wrote:
> 
> > On Fri, Sep 06, 2019 at 04:29:50PM -0500, Steve Wahl wrote:
> > > Our hardware (UV aka Superdome Flex) has address ranges marked
> > > reserved by the BIOS. These ranges can cause the system to halt if
> > > accessed.
> > > 
> > > During kernel initialization, the processor was speculating into
> > > reserved memory causing system halts.  The processor speculation is
> > > enabled because the reserved memory is being mapped by the kernel.
> > > 
> > > The page table level2_kernel_pgt is 1 GiB in size, and had all pages
> > > initially marked as valid, and the kernel is placed anywhere in this
> > > range depending on the virtual address selected by KASLR.  Later on in
> > > the boot process, the valid area gets trimmed back to the space
> > > occupied by the kernel.
> > > 
> > > But during the interval of time when the full 1 GiB space was marked
> > > as valid, if the kernel physical address chosen by KASLR was close
> > > enough to our reserved memory regions, the valid pages outside the
> > > actual kernel space were allowing the processor to issue speculative
> > > accesses to the reserved space, causing the system to halt.
> > > 
> > > This was encountered somewhat rarely on a normal system boot, and
> > > somewhat more often when starting the crash kernel if
> > > "crashkernel=512M,high" was specified on the command line (because
> > > this heavily restricts the physical address of the crash kernel,
> > > usually to within 1 GiB of our reserved space).
> > > 
> > > The answer is to invalidate the pages of this table outside the
> > > address range occupied by the kernel before the page table is
> > > activated.  This patch has been validated to fix this problem on our
> > > hardware.
> > 
> > If the goal is to avoid *any* mapping of the reserved region to stop
> > speculation, I don't think this patch will do the job. We still (likely)
> > have the same memory mapped as part of the identity mapping. And it
> > happens at least in two places: here and before on decompression stage.
> 
> Yeah, this really needs a fix at the KASLR level: it should only ever map 
> into regions that are fully RAM backed.
> 
> Is the problem that the 1 GiB mapping is a direct mapping, which can be 
> speculated into? I presume KASLR won't accidentally map the kernel into 
> the reserved region, right?

I believe you are correct.  There is code that limits KASLR's choice
of phyiscal addresses to valid RAM locations.  There are no bugs in it
that I've seen.

It's just that the 1G mapping includes wide regions of physical
address space on either or both sides of the chosen physical space for
the kernel, which are not limited to valid RAM regions, allowing
speculative accesses into reserved regions if the chosen kernel
physical address is close enough to one of them.

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
