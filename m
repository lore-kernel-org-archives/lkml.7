Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5599BC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F021206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfD0Pc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:32:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60650 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726617AbfD0PPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:11 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0000zL-Ng; Sat, 27 Apr 2019 16:15:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004Ol-Eg; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        "Kangjie Lu" <kjlu@umn.edu>, "Mark Brown" <broonie@kernel.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.470177912@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 015/202] ASoC: atom: fix a missing check of
 snd_pcm_lib_malloc_pages
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kangjie Lu <kjlu@umn.edu>

commit 44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661 upstream.

snd_pcm_lib_malloc_pages() may fail, so let's check its status and
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -383,7 +383,13 @@ static snd_pcm_uframes_t sst_platform_pc
 static int sst_platform_pcm_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
-	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	int ret;
+
+	ret =
+		snd_pcm_lib_malloc_pages(substream,
+				params_buffer_bytes(params));
+	if (ret)
+		return ret;
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
 
 	return 0;

