Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8949BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A442192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256083;
	bh=MFmtybwV3bMEaPXHc09FxXCq1VEflH19Nw5wz2kedko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yOoLJCPeTFtlPPVkBfWEYFtsIkeBfLuNyVqaQUGiwc+CYNF0UJN2835D+eRUKL6zr
	 ojL0PCVdTcMdsEos6ed3c/ar4uD3V5jbRGYPnlDnomZcPB76JMFOYKX9Fk59dH53ZD
	 1ziKAEAG6UfJnsUDXLA0TWTKyunKmjrHc6PMwXmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbfCVMBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388190AbfCVMBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DDEC204FD;
        Fri, 22 Mar 2019 12:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256078;
        bh=MFmtybwV3bMEaPXHc09FxXCq1VEflH19Nw5wz2kedko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wzWbEmyI5VKVg/jgBv/fB4obcpCLSrgjv4AgmRr1G4v+yVYzi7IJB5oRk82CrmHf
         0icnrPYF/b7oSp/EUamX/Pgm/zRCtsz2B8DMdXGl4IyAVc0MR+pFbG5yliuwHC2mnH
         IGA4XBEbivZwiBqR6hm0CEUu8cvMNLwL1QdSRgMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 086/280] ASoC: topology: free created components in tplg load error
Date:   Fri, 22 Mar 2019 12:13:59 +0100
Message-Id: <20190322111311.251142681@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 304017d31df36fb61eb2ed3ebf65fb6870b3c731 ]

Topology resources are no longer needed if any element failed to load.

Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 66e77e020745..88a7e860b175 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2493,6 +2493,7 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
 	struct snd_soc_tplg_ops *ops, const struct firmware *fw, u32 id)
 {
 	struct soc_tplg tplg;
+	int ret;
 
 	/* setup parsing context */
 	memset(&tplg, 0, sizeof(tplg));
@@ -2506,7 +2507,12 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
 	tplg.bytes_ext_ops = ops->bytes_ext_ops;
 	tplg.bytes_ext_ops_count = ops->bytes_ext_ops_count;
 
-	return soc_tplg_load(&tplg);
+	ret = soc_tplg_load(&tplg);
+	/* free the created components if fail to load topology */
+	if (ret)
+		snd_soc_tplg_component_remove(comp, SND_SOC_TPLG_INDEX_ALL);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_tplg_component_load);
 
-- 
2.19.1



