Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E665FC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25A32171F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbfHGXHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:07:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:3582 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729624AbfHGXHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:07:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 16:07:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,358,1559545200"; 
   d="scan'208";a="179655889"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga006.jf.intel.com with ESMTP; 07 Aug 2019 16:07:37 -0700
Date:   Wed, 7 Aug 2019 16:07:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     'Christoph Hellwig' <hch@lst.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     'Arnd Bergmann' <arnd@arndb.de>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        "'linux-ia64@vger.kernel.org'" <linux-ia64@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: remove sn2, hpsim and ia64 machvecs
Message-ID: <20190807230737.GA11458@agluck-desk2.amr.corp.intel.com>
References: <20190807133049.20893-1-hch@lst.de>
 <3908561D78D1C84285E8C5FCA982C28F7F41388B@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4143CB@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F4143CB@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 01:26:17PM -0700, Luck, Tony wrote:
> Ugh! The rule to do the compression was in arch/ia64/hp/sim/boot/Makefile
> which went away as part of the deletion of hpsim.

This fixes it ... should fold into the patch that dropped the
arch/ia64/hp/sim/boot/Makefile

I just cut/pasted in those cmd_gzip and cmd_objcopy definitions
from elsewhere in the tree. It might be possible to simplify them.

---
 arch/ia64/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 6eaa0ffd15ca..e0bb2b6aaa35 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -39,6 +39,12 @@ $(error Sorry, you need a newer version of the assember, one that is built from
 		ftp://ftp.hpl.hp.com/pub/linux-ia64/gas-030124.tar.gz)
 endif
 
+quiet_cmd_gzip = GZIP    $@
+cmd_gzip = cat $(real-prereqs) | gzip -n -f -9 > $@
+
+quiet_cmd_objcopy = OBJCOPY $@
+cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
+
 KBUILD_CFLAGS += $(cflags-y)
 head-y := arch/ia64/kernel/head.o
 
@@ -57,7 +63,11 @@ compressed: vmlinux.gz
 
 vmlinuz: vmlinux.gz
 
-vmlinux.gz: vmlinux
+vmlinux.gz: vmlinux.bin FORCE
+	$(call if_changed,gzip)
+
+vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
 
 unwcheck: vmlinux
 	-$(Q)READELF=$(READELF) $(PYTHON) $(srctree)/arch/ia64/scripts/unwcheck.py $<
-- 
2.20.1

