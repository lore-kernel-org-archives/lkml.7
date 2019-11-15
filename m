Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10789C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC2620674
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKOSBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:01:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:60146 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKOSA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:00:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 10:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,309,1569308400"; 
   d="scan'208";a="203452177"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Nov 2019 10:00:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B964E3A0; Fri, 15 Nov 2019 20:00:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v1 3/5] ALSA: hda: Drop duplicate check for size parameter of memremap()
Date:   Fri, 15 Nov 2019 20:00:42 +0200
Message-Id: <20191115180044.83659-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115180044.83659-1-andriy.shevchenko@linux.intel.com>
References: <20191115180044.83659-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since memremap() returns NULL pointer for size = 0, there is no need
to duplicate this check in the callers.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/hda/intel-nhlt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/hda/intel-nhlt.c b/sound/hda/intel-nhlt.c
index 097ff6c10099..5fc10f1b244c 100644
--- a/sound/hda/intel-nhlt.c
+++ b/sound/hda/intel-nhlt.c
@@ -16,7 +16,7 @@ struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
 	acpi_handle handle;
 	union acpi_object *obj;
 	struct nhlt_resource_desc *nhlt_ptr;
-	struct nhlt_acpi_table *nhlt_table = NULL;
+	struct nhlt_acpi_table *nhlt_table;
 
 	handle = ACPI_HANDLE(dev);
 	if (!handle) {
@@ -36,8 +36,7 @@ struct nhlt_acpi_table *intel_nhlt_init(struct device *dev)
 	}
 
 	nhlt_ptr = (struct nhlt_resource_desc  *)obj->buffer.pointer;
-	if (nhlt_ptr->length)
-		nhlt_table = (struct nhlt_acpi_table *)
+	nhlt_table = (struct nhlt_acpi_table *)
 			memremap(nhlt_ptr->min_addr, nhlt_ptr->length,
 				 MEMREMAP_WB);
 	ACPI_FREE(obj);
-- 
2.24.0

