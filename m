Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620A2214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfH0ONF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:13:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:10800 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729931AbfH0OND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:13:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 07:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="264282459"
Received: from xxx.igk.intel.com ([10.237.93.170])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2019 07:13:00 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@intel.com>
Subject: [PATCH 4/6] ASoC: Intel: Skylake: Print module type instead of id
Date:   Tue, 27 Aug 2019 16:17:10 +0200
Message-Id: <20190827141712.21015-5-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>

When we are printing module params, we were actually printing module id
instead of type, but debug message was saying that number we get is type.
So print module type, as it is useful when debugging paths, but also
keep printing module id, as it is used in all other logs.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index d43496c5f29e..476ef1897961 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -867,8 +867,9 @@ static int skl_set_module_format(struct skl_dev *skl,
 
 	}
 
-	dev_dbg(skl->dev, "Module type=%d config size: %d bytes\n",
-			module_config->id.module_id, param_size);
+	dev_dbg(skl->dev, "Module type=%d id=%d config size: %d bytes\n",
+			module_config->m_type, module_config->id.module_id,
+			param_size);
 	print_hex_dump_debug("Module params:", DUMP_PREFIX_OFFSET, 8, 4,
 			*param_data, param_size, false);
 	return 0;
-- 
2.17.1

