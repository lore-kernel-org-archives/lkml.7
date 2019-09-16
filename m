Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1149C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2FD214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfIPVnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:43:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:54985 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfIPVnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:43:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198479866"
Received: from dgitin-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.142.45])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2019 14:42:58 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 01/12] ASoC: soc-acpi: add link_mask field
Date:   Mon, 16 Sep 2019 16:42:40 -0500
Message-Id: <20190916214251.13130-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
References: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When interfaces can be pin-muxed, static information from ACPI might
not be enough. Add information on which links needs to be enabled by
hardware/firmware for a specific machine driver to be selected.

When walking through the list of possible machines, links will be
checked, which implies that configurations where multiple links are
required need to be checked first.

Additional criteria will be needed later, such as which SoundWire
Slave devices are actually enabled, but for now this helps detect
between basic configurations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 35b38e41e5b2..c0fb71c7b3ad 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -75,6 +75,7 @@ struct snd_soc_acpi_mach_params {
  * all firmware/topology related fields.
  *
  * @id: ACPI ID (usually the codec's) used to find a matching machine driver.
+ * @link_mask: describes required board layout, e.g. for SoundWire.
  * @drv_name: machine driver name
  * @fw_filename: firmware file name. Used when SOF is not enabled.
  * @board: board name
@@ -90,6 +91,7 @@ struct snd_soc_acpi_mach_params {
 /* Descriptor for SST ASoC machine driver */
 struct snd_soc_acpi_mach {
 	const u8 id[ACPI_ID_LEN];
+	const u32 link_mask;
 	const char *drv_name;
 	const char *fw_filename;
 	const char *board;
-- 
2.20.1

