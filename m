Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E28CC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2D121D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213124;
	bh=xcYe53B6Y5/aBuFSE0AZhBG0EhSJ7aq0oFLt5lotR4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t3kyR3S/Wmf/DLv2zzswRBNM2uuxnflRJlu6eT5PACd71+fK7eT7ELpT1Sd7RZwPX
	 dP32RlsBhdXNjoZT57YwiZfaXAyMP280DNTR6CxVL3sVI1IJzYOrMwUsPQDo3ikHKw
	 eupsui8QlhrTfmY68I0KAT7sh0lthjqFsJlTRFio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732794AbfKHLin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:38:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732701AbfKHLic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6796321D7E;
        Fri,  8 Nov 2019 11:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213112;
        bh=xcYe53B6Y5/aBuFSE0AZhBG0EhSJ7aq0oFLt5lotR4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+nGnyFHt7vZFjmMEwSfiSMiKugJg11rO18xUz8vBY0Noankb9v4V5UQNu8TQfTnQ
         C09LsRXgs/zdQc2ZU/apIutLflxBZRrL0i6nrvASGUNwrF/x+wUgkxzR1aJD6WtQPg
         0iZs1tIdP91L2xxWW2nzU3EOEs3NjEB7oyUA2jHM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 034/205] ASoC: dapm: Don't fail creating new DAPM control on NULL pinctrl
Date:   Fri,  8 Nov 2019 06:35:01 -0500
Message-Id: <20191108113752.12502-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit a5cd7e9cf587f51a84b86c828b4e1c7b392f448e ]

devm_pinctrl_get will only return NULL in the case that pinctrl
is not built into the kernel and all the pinctrl functions used
by the DAPM core are appropriately stubbed for that case. There
is no need to error out of snd_soc_dapm_new_control_unlocked
if pinctrl isn't built into the kernel, so change the
IS_ERR_OR_NULL to just an IS_ERR.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4ce57510b6236..ff31d9f9ecd64 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3514,7 +3514,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 		break;
 	case snd_soc_dapm_pinctrl:
 		w->pinctrl = devm_pinctrl_get(dapm->dev);
-		if (IS_ERR_OR_NULL(w->pinctrl)) {
+		if (IS_ERR(w->pinctrl)) {
 			ret = PTR_ERR(w->pinctrl);
 			if (ret == -EPROBE_DEFER)
 				return ERR_PTR(ret);
-- 
2.20.1

