Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8836C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704512075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259790;
	bh=GPPHb0N4V5rNMD5NDMCRzchC/HhEPs2uzcObAbigUaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mTuzAZVrxZLMXLZPIsL5rqG6qDCQEvMmEJuINx3nb7s6MvyshhkwVtnS+OpM1ITcI
	 c6tEdrmRN0o3XU4iq8cj0/7oPJ0OhwS3H81kLVQJOSDt27nykztG4OPG+SMgATC3Iw
	 1WeukgasZF6FpJPOhloOFCSvK95nZA1egKnVfeHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfCVLkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731296AbfCVLkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:40:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EAC2082C;
        Fri, 22 Mar 2019 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254846;
        bh=GPPHb0N4V5rNMD5NDMCRzchC/HhEPs2uzcObAbigUaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xY0vF7zMHFT8kaTL/ZzO5KtEd14OisRaJdsV0XaJor5ie7r1EMmh8CpCxV6Cbvntm
         j6CljV2s56iPl9Wv4ic5JMM2dk0z7kSkvlwf0671AeunTletCqV0mevpCgvpi0GI23
         a8jGl2Uja1vzqRSe6PxXHB0iiwxFFceg9Sn/u5Eg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 029/118] ASoC: topology: free created components in tplg load error
Date:   Fri, 22 Mar 2019 12:15:01 +0100
Message-Id: <20190322111218.223767030@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index d6b48c796bfc..086fe4d27f60 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1989,6 +1989,7 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
 	struct snd_soc_tplg_ops *ops, const struct firmware *fw, u32 id)
 {
 	struct soc_tplg tplg;
+	int ret;
 
 	/* setup parsing context */
 	memset(&tplg, 0, sizeof(tplg));
@@ -2002,7 +2003,12 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
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



