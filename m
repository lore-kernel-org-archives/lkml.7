Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E02EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5262177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428483;
	bh=ZXHsWRQ1nISxNPdDvFHgbRBPGB32dxP9CQAt2ndDmVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vw85k07jiX91TEAlEe1M1I9uk9/UNhVgfjFfdrVL9zag6KRpOYyL0iXCYpEb1OnjE
	 0SA72SD3f/AsuC15JpY4AqKrRWrsEjSxSLs4pbDX74e9o0Fx7AcxCIgERZzoTvbe2J
	 mHu3FkI6hOYIhHBPJw4+6Rk9YpWZ11OvYe+suGzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfEITBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbfEISuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:50:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 466F920578;
        Thu,  9 May 2019 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427853;
        bh=ZXHsWRQ1nISxNPdDvFHgbRBPGB32dxP9CQAt2ndDmVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9e5MuCUzYHQ+z3FQnnAUHdIL9FJ5CJf2EG8t+aXL5GOwRxaK9FYURFWYIAiC0j8c
         ZOOKDCzgAURH+3MG4HVbDCMjC2bbQ269KEMYm2xmly2dOe60CapeGiQo5vxDkIyLyR
         +90Sfe8AvYgR+JN+C7svSFhWCe2QdQhFDIdeK0w8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 28/95] ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_free_kcontrol
Date:   Thu,  9 May 2019 20:41:45 +0200
Message-Id: <20190509181311.275503510@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cacea3a90e211f0c111975535508d446a4a928d2 ]

w_text_param can be NULL and it is being dereferenced without checking.
Add the missing sanity check to prevent  NULL pointer dereference.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 20bad755888b1..08ab5fef75dca 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3840,6 +3840,10 @@ snd_soc_dapm_free_kcontrol(struct snd_soc_card *card,
 	int count;
 
 	devm_kfree(card->dev, (void *)*private_value);
+
+	if (!w_param_text)
+		return;
+
 	for (count = 0 ; count < num_params; count++)
 		devm_kfree(card->dev, (void *)w_param_text[count]);
 	devm_kfree(card->dev, w_param_text);
-- 
2.20.1



