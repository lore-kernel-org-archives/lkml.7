Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45259C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E01820640
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 15:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403885AbfIMPPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:15:03 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:20160 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403864AbfIMPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 11:15:03 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8DF6YSB028924;
        Fri, 13 Sep 2019 15:14:18 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 2uyteddhe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 15:14:18 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 916FD61;
        Fri, 13 Sep 2019 15:14:17 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 3E90E46;
        Fri, 13 Sep 2019 15:14:16 +0000 (UTC)
Date:   Fri, 13 Sep 2019 10:14:15 -0500
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
Message-ID: <20190913151415.GG7834@swahl-linux>
References: <20190906212950.GA7792@swahl-linux>
 <20190909081414.5e3q47fzzruesscx@box>
 <20190910142810.GA7834@swahl-linux>
 <20190911002856.mx44pmswcjfpfjsb@box.shutemov.name>
 <20190911200835.GD7834@swahl-linux>
 <20190912101917.mbobjvkxhfttxddd@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912101917.mbobjvkxhfttxddd@box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_07:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 01:19:17PM +0300, Kirill A. Shutemov wrote:
> On Wed, Sep 11, 2019 at 03:08:35PM -0500, Steve Wahl wrote:
> > Thank you for your time looking into this with me!
> 
> With all this explanation the original patch looks sane to me.
> 
> But I would like to see more information from this thread in the commit
> message and some comments in the code on why it's crucial not to map more
> than needed.

I am working on this.

> I think we also need to make it clear that this is workaround for a broken
> hardware: speculative execution must not trigger a halt.

I think the word broken is a bit loaded here.  According to the UEFI
spec (version 2.8, page 167), "Regions that are backed by the physical
hardware, but are not supposed to be accessed by the OS, must be
returned as EfiReservedMemoryType."  Our interpretation is that
includes speculative accesses.

I'd lean more toward "tightening of adherence to the spec required by
some particular hardware."  Does that work for you?

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise
