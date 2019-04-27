Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8567EC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480C9208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329147;
	bh=MOcfdTIdKt3r/THIT3X54QIQga8YcER8cuZphZfvyxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/g0ui5sODfi9cSv3X9VJWWqujesboIzTj56Qpd4OPVrOuBkSUCnUHbOjRi22jxB2
	 LBmGEJOlk/dKfgegCarc4sW7Sgh2g7gN81By9ZkBLXF1SPVo/W8gnvNNv7LJEI7AHY
	 Jkn6zLEG5Ul/8Ad3l6IJ+h26xqu/s53nCxzmM01o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfD0BjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbfD0BjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FBF2208CA;
        Sat, 27 Apr 2019 01:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329144;
        bh=MOcfdTIdKt3r/THIT3X54QIQga8YcER8cuZphZfvyxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOl+CINEY7rC8OB/Z7e/WATRh3sv9oGEq6Rd38St1batufAZgNctkDWsK19OinY7k
         Ker/BAUSU9Nhvux2aE5ClqfbeHx0g13YKn40+/TkDAjq9KsKx1JI0UT6J3dnhhAIDc
         iaIJb5UYQ/v4ncZ6DV+zFnAgSZlHzcR37beDb1l0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 22/79] ASoC: dapm: Fix NULL pointer dereference in snd_soc_dapm_free_kcontrol
Date:   Fri, 26 Apr 2019 21:37:41 -0400
Message-Id: <20190427013838.6596-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
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
index 20bad755888b..08ab5fef75dc 100644
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
2.19.1

