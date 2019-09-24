Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A784DC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8425A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 21:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633505AbfIXVDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 17:03:52 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:34670 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2633481AbfIXVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:03:51 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8OKv7S3014201;
        Tue, 24 Sep 2019 21:03:24 GMT
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com with ESMTP id 2v796w0xc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Sep 2019 21:03:24 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id DA6986D;
        Tue, 24 Sep 2019 21:03:23 +0000 (UTC)
Received: from swahl-linux (swahl-linux.americas.hpqcorp.net [10.33.153.21])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id DC6313B;
        Tue, 24 Sep 2019 21:03:22 +0000 (UTC)
Date:   Tue, 24 Sep 2019 16:03:22 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: [PATCH v3 0/2] x86/boot/64: Avoid mapping reserved ranges in early
 page tables.
Message-ID: <cover.1569358538.git.steve.wahl@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-24_10:2019-09-23,2019-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909240169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set narrows the valid space addressed by the page table
level2_kernel_pgt to only contain ranges checked against the "usable
RAM" list provided by the BIOS.

Prior to this, some larger than needed mappings were occasionally
crossing over into spaces marked reserved, allowing the processor to
access these reserved spaces, which were caught by the hardware and
caused BIOS to halt on our platform (UV).

Changes since v1:

* Cover letter added because there's now two patches.

* Patch 1: Added comment and re-worked changelog text.

* Patch 2: New change requested by Dave Hansen to handle the case that
  the mapping of the last PMD page for the kernel image could cross a
  reserved region boundary.

Changes since v2:

* Patch 1: Added further inline comments.
* Patch 2: None.

Steve Wahl (2):
  x86/boot/64: Make level2_kernel_pgt pages invalid outside kernel area.
  x86/boot/64: round memory hole size up to next PMD page.

 arch/x86/boot/compressed/misc.c | 25 +++++++++++++++++++------
 arch/x86/kernel/head64.c        | 22 ++++++++++++++++++++--
 2 files changed, 39 insertions(+), 8 deletions(-)

-- 
2.21.0


-- 
Steve Wahl, Hewlett Packard Enterprise
