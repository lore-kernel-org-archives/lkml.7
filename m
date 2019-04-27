Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F480C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A773206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329854;
	bh=Vjb5DB4eL9LF5XxxPfHZjsMAugU5tNqJgdfcKbIGs2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OwsDDxOq8PBJXUwZ/f2vu+fnpxpSdgqp4AqnrDx4COBPawO95XpUZYbItPjZDD+jx
	 x8jWuLNEYhUuSInyhzJBXh8b/gxS/FoaxcDDcqPwa5eEfYFdaqMsmLhiBXxBjXY1oD
	 nMRpROBena0UeXtUdJaPk8KgrvswRn94u3K82diI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfD0Bux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbfD0BlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D5352168B;
        Sat, 27 Apr 2019 01:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329276;
        bh=Vjb5DB4eL9LF5XxxPfHZjsMAugU5tNqJgdfcKbIGs2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPcTycNzgGCUyyIdXQHGsFJPzGry5EViG/MHNRgyi4DNAJ4W/oXUlXC8iRZ+hr3c0
         RbKZR0DXz8tUCtlmtl3XyXaN7tDqImxdlRMj9rsvXJu0yL7RLUGeA66a2CbQENz/Xi
         JOyEl7XbzjvFV8z9mRnswuGmVCVyjQr/YO2J+Tn4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 17/53] ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_free_kcontrol
Date:   Fri, 26 Apr 2019 21:40:14 -0400
Message-Id: <20190427014051.7522-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>

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
index 9b78fb3daa7b..2257b1b0151c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3847,6 +3847,10 @@ snd_soc_dapm_free_kcontrol(struct snd_soc_card *card,
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
2.19.1

