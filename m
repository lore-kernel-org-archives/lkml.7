Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8F8C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9D120872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbfIJO2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:28:40 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:36922 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfIJO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:28:40 -0400
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AER1DP009525;
        Tue, 10 Sep 2019 14:28:13 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uxa9hjxv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 14:28:12 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 2572860;
        Tue, 10 Sep 2019 14:28:12 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id C6AE445;
        Tue, 10 Sep 2019 14:28:10 +0000 (UTC)
Date:   Tue, 10 Sep 2019 09:28:10 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
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
Message-ID: <20190910142810.GA7834@swahl-linux>
References: <20190906212950.GA7792@swahl-linux>
 <20190909081414.5e3q47fzzruesscx@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909081414.5e3q47fzzruesscx@box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909100141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 11:14:14AM +0300, Kirill A. Shutemov wrote:
> On Fri, Sep 06, 2019 at 04:29:50PM -0500, Steve Wahl wrote:
> > ...
> > The answer is to invalidate the pages of this table outside the
> > address range occupied by the kernel before the page table is
> > activated.  This patch has been validated to fix this problem on our
> > hardware.
> 
> If the goal is to avoid *any* mapping of the reserved region to stop
> speculation, I don't think this patch will do the job. We still (likely)
> have the same memory mapped as part of the identity mapping. And it
> happens at least in two places: here and before on decompression stage.

I imagine you are likely correct, ideally you would not map any
reserved pages in these spaces.

I've been reading the code to try to understand what you say above.
For identity mappings in the kernel, I see level2_ident_pgt mapping
the first 1G.  And I see early_dyanmic_pgts being set up with an
identity mapping of the kernel that seems to be pretty well restricted
to the range _text through _end.

Within the decompression code, I see an identity mapping of the first
4G set up within the 32 bit code.  I believe we go past that to the
startup_64 entry point.  (I don't know how common that path is, but I
don't have a way to test it without figuring out how to force it.)

From a pragmatic standpoint, the guy who can verify this for me is on
vacation, but I believe our BIOS won't ever place the halt-causing
ranges in a space below 4GiB.  Which explains why this patch works for
our hardware.  (We do have reserved regions below 4G, just not the
ones that hardware causes a halt for accessing.)

In case it helps you picture the situation, our hardware takes a small
portion of RAM from the end of each NUMA node (or it might be pairs or
quads of NUMA nodes, I'm not entirely clear on this at the moment) for
its own purposes.  Here's a section of our e820 table:

[    0.000000] BIOS-e820: [mem 0x000000007c000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000002f7fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000002f80000000-0x000000303fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000003040000000-0x0000005f7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000005f7c000000-0x000000603fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000006040000000-0x0000008f7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000008f7c000000-0x000000903fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000009040000000-0x000000bf7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000bf7c000000-0x000000c03fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000c040000000-0x000000ef7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000ef7c000000-0x000000f03fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000f040000000-0x0000011f7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000011f7c000000-0x000001203fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000012040000000-0x0000014f7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000014f7c000000-0x000001503fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000015040000000-0x0000017f7bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000017f7c000000-0x000001803fffffff] reserved

Our problem occurs when KASLR (or kexec) places the kernel close
enough to the end of one of the usable sections, and the 1G of 1:1
mapped space includes a portion of the following reserved section, and
speculation touches the reserved area.

--> Steve Wahl
-- 
Steve Wahl, Hewlett Packard Enterprise
