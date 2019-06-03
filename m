Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5A4C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACE523A81
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="jXTnxI2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfFCLIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:08:01 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:21981 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfFCLIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:08:00 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jun 2019 07:08:00 EDT
X-IronPort-AV: E=Sophos;i="5.60,546,1549926000"; 
   d="scan'208";a="7665930"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Jun 2019 12:58:11 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 03 Jun 2019 12:58:12 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 03 Jun 2019 12:58:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1559559491; x=1591095491;
  h=from:to:cc:subject:date:message-id;
  bh=W9GQMQ3nEmL01MlgBQ683CPdonwLrFB8qrhTZhg3YNw=;
  b=jXTnxI2NcbxsldYXEqjnpH16mc0K29vGBYKrtdwRiTYt1qVA6byxqnqb
   QT/5J2fK0vhpWv8bUzKzn+4nubKl1fDaZPM1VUTsztEbgcb0It5P8//L2
   Mtc4VxfIWBhCPcqr34rTtcn61qXZxoS5GImvPGlOek1tD5JtfnjfTgg/N
   vN4CMfWQ0tHNTYmMzYqdUwLyKbNTBuomp7lyjj/XPDzRllUL+wr4F1X66
   EHcsK6cUDrjkHA8Y6nhGZEdI6lC9KLqizs9YidCamoiOLmAOtk7mK2Pfg
   O6CW4funJEgBcGVe6wgjYKZSyNV1dfsnn4L8vu+OsU0i73+l/SGR7qJUH
   A==;
X-IronPort-AV: E=Sophos;i="5.60,546,1549926000"; 
   d="scan'208";a="7665929"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Jun 2019 12:58:11 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5EBEA280074;
        Mon,  3 Jun 2019 12:58:15 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Russell King <linux@armlinux.org.uk>, Jessica Yu <jeyu@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH modules 0/2] Fix handling of exit unwinding sections (on ARM)
Date:   Mon,  3 Jun 2019 12:57:24 +0200
Message-Id: <20190603105726.22436-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some time (050d18d1c651 "ARM: 8650/1: module: handle negative
R_ARM_PREL31 addends correctly", v4.11+), building a kernel without
CONFIG_MODULE_UNLOAD would lead to module loads failing on ARM systems with
certain memory layouts, with messages like:

  imx_sdma: section 16 reloc 0 sym '': relocation 42 out of range
  (0x7f015260 -> 0xc0f5a5e8)

(0x7f015260 is in the module load area, 0xc0f5a5e8 a regular vmalloc
address; relocation 42 is R_ARM_PREL31)

This is caused by relocatiosn in the .ARM.extab.exit.text and
.ARM.exidx.exit.text sections referencing the .exit.text section. As the
module loader will omit loading .exit.text without CONFIG_MODULE_UNLOAD,
there will be relocations from loaded to unloaded sections; the resulting
huge offsets trigger the sanity checks added in 050d18d1c651.

IA64 might be affected by a similar issue - sections with names like
.IA_64.unwind.exit.text and .IA_64.unwind_info.exit.text appear in the ld
script - but I don't know much about that arch.

Also, I'm not sure if this is stable-worthy - just enabling
CONFIG_MODULE_UNLOAD should be a viable workaround on affected kernels.


Kind regards,
Matthias


Matthias Schiffer (2):
  module: allow arch overrides for .exit section names
  ARM: module: recognize unwind exit sections

 arch/arm/include/asm/module.h | 11 +++++++++++
 include/linux/moduleloader.h  |  8 ++++++++
 kernel/module.c               |  2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.17.1

