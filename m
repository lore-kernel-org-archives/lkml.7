Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0196AC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A5E208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520497;
	bh=bDkVQeypVwfhZfCq1//tGQg0D9nICTUmO2ePc9iVSdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YDGPa0jHycQptZFliDBCqEgwZvmhLpwuYS3PPmPPYWn8UezX9yODaDalEWy1az5pC
	 8CqYZXuk+HNCM++xfactykMmhL+EQxMPSIxEhNLb2tFq1OyxZE8cXECboNqWiaGb+G
	 YWdvZACEXsst29xC7KPTO+tevmWUJG+idENZcSg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfFZDlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfFZDlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:41:35 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E002C2146E;
        Wed, 26 Jun 2019 03:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520495;
        bh=bDkVQeypVwfhZfCq1//tGQg0D9nICTUmO2ePc9iVSdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6epzu6BdolQ6IDJJvGF27MzA3qoXZM/1sFZiISFvIxefN31YhE+jTxpDksiGmlfM
         C3HLWVo1Db5VPDDp8dYkj4GfitQgJcEVmmwC9iSd0FecurSdyeskeroaBRkzLqgAkt
         wU9y8N/ntLuyhxL5fVSjUyAshIZ9lwOGIAIUi2EM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 07/51] ASoC: soc-dpm: fixup DAI active unbalance
Date:   Tue, 25 Jun 2019 23:40:23 -0400
Message-Id: <20190626034117.23247-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034117.23247-1-sashal@kernel.org>
References: <20190626034117.23247-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit f7c4842abfa1a219554a3ffd8c317e8fdd979bec ]

snd_soc_dai_link_event() is updating snd_soc_dai :: active,
but it is unbalance.
It counts up if it has startup callback.

	case SND_SOC_DAPM_PRE_PMU:
		...
		snd_soc_dapm_widget_for_each_source_path(w, path) {
			...
			if (source->driver->ops->startup) {
				...
=>				source->active++;
			}
			...
		}
		...

But, always counts down

	case SND_SOC_DAPM_PRE_PMD:
		...
		snd_soc_dapm_widget_for_each_source_path(w, path) {
			...
=>			source->active--;
			...
		}

This patch always counts up when SND_SOC_DAPM_PRE_PMD.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5d9d7678e4fa..1ee67716d558 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3831,8 +3831,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 						ret);
 					goto out;
 				}
-				source->active++;
 			}
+			source->active++;
 			ret = soc_dai_hw_params(&substream, params, source);
 			if (ret < 0)
 				goto out;
@@ -3853,8 +3853,8 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 						ret);
 					goto out;
 				}
-				sink->active++;
 			}
+			sink->active++;
 			ret = soc_dai_hw_params(&substream, params, sink);
 			if (ret < 0)
 				goto out;
-- 
2.20.1

