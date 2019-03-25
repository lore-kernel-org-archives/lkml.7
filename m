Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3125C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6EB20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbfCYVZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:25:15 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:58144 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729714AbfCYVZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:25:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 009513CF6;
        Mon, 25 Mar 2019 21:25:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: back78_fabd18bcf92e
X-Filterd-Recvd-Size: 4240
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:25:07 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Bad file pattern in MAINTAINERS section 'EDAC-SKYLAKE'
Date:   Mon, 25 Mar 2019 14:25:06 -0700
Message-Id: <20190325212506.26282-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	5684	EDAC-SKYLAKE
	5685	M:	Tony Luck <tony.luck@intel.com>
	5686	L:	linux-edac@vger.kernel.org
	5687	S:	Maintained
-->	5688	F:	drivers/edac/skx_edac.c

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'drivers/edac/skx_edac.c':

commit 4ec656bdf43a13a655a8259b79dd63bc1f0b1e41
Author: Tony Luck <tony.luck@intel.com>
Date:   Sat Aug 20 16:27:58 2016 -0700

    EDAC, skx_edac: Add EDAC driver for Skylake
    
    This is an entirely new driver instead of yet another set of patches
    to sb_edac.c because:
    
    1) Mapping from PCI devices to socket/memory controller is significantly
       different. Skylake scatters devices on a socket across a number of
       PCI buses.
    2) There is an extra level of interleaving via the "mcroute" register
       that would be a little messy to squeeze into the old driver.
    3) Validation is getting too expensive. Changes to sb_edac need to
       be checked against Sandy Bridge, Ivy Bridge, Haswell, Broadwell and
       Knights Landing.
    
    Acked-by: Aristeu Rozanski <aris@redhat.com>
    Acked-by: Borislav Petkov <bp@suse.de>
    Signed-off-by: Tony Luck <tony.luck@intel.com>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

 MAINTAINERS             |    6 +
 drivers/edac/Kconfig    |    8 +
 drivers/edac/Makefile   |    1 +
 drivers/edac/skx_edac.c | 1121 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1136 insertions(+)

3: ---------------------------------------------------------------------------

The last commit with a real presence of file pattern 'drivers/edac/skx_edac.c':

commit 98f2fc829e3b55a0ff1b82753fc1e10941535cb9
Author: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Date:   Wed Jan 30 11:15:18 2019 -0800

    EDAC, skx_edac: Delete duplicated code
    
    Delete the duplicated code from skx_edac.c and rename skx_edac.c to
    skx_base.c. Update the Makefile to build the skx_edac driver from
    skx_base.c and skx_common.c.
    
    Add SPDX to skx_base.c and clean out unnecessary #include lines.
    
     [ bp: Drop the license boilerplate - there's an SPDX identifier now. ]
    
    Co-developed-by: Tony Luck <tony.luck@intel.com>
    Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    Signed-off-by: Tony Luck <tony.luck@intel.com>
    Signed-off-by: Borislav Petkov <bp@suse.de>
    Cc: James Morse <james.morse@arm.com>
    Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
    Cc: linux-edac <linux-edac@vger.kernel.org>
    Link: https://lkml.kernel.org/r/20190130191519.15393-4-tony.luck@intel.com

 drivers/edac/Makefile   |    4 +-
 drivers/edac/skx_base.c |  650 +++++++++++++++++++++++
 drivers/edac/skx_edac.c | 1358 -----------------------------------------------
 3 files changed, 653 insertions(+), 1359 deletions(-)
