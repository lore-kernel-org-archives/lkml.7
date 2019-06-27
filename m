Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8517C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC80F217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595546;
	bh=3q5NkPuwYcrdFZGGTnXHOPF47o8P3WTa+m8JyIuXga8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tAk4uTci/uJTiJkbiAVSFZf3wOYOLsW3Qcq1fMPrm3xXB9KOppui2d8Qv9N78iFPI
	 WCV/J8wYf7cZDe0aA1iQYj1vPU+lMuTNwq3dVFLgMnVSPpUvA7+g90TnplRlDXIh9R
	 2UztYJ2tehVpczVd3SxawM7nfM6x+HT1EvVDMXOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfF0AcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfF0AcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:32:23 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F5021738;
        Thu, 27 Jun 2019 00:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595542;
        bh=3q5NkPuwYcrdFZGGTnXHOPF47o8P3WTa+m8JyIuXga8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0bYabLbsa4bVECE4uLw4llqQx8PS8PDeXmM5fIyDkRHtRS7p/w1rS9OcYxshTiiWA
         2pyPw6Z6gxYa5fmCS9GiPfVqpnq+t8Ju31Tdbuu6uouReCkLY51Bgxbbx9DxV5BLXa
         y3k1TPY8ewWu2O3iOOd7cZJjqoImc93Psc1c+ja4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 35/95] soundwire: intel: set dai min and max channels correctly
Date:   Wed, 26 Jun 2019 20:29:20 -0400
Message-Id: <20190627003021.19867-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 39194128701bf2af9bbc420ffe6e3cb5d2c16061 ]

Looks like there is a copy paste error.
This patch fixes it!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index fd8d034cfec1..5ba641858e21 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -714,8 +714,8 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 				return -ENOMEM;
 			}
 
-			dais[i].playback.channels_min = 1;
-			dais[i].playback.channels_max = max_ch;
+			dais[i].capture.channels_min = 1;
+			dais[i].capture.channels_max = max_ch;
 			dais[i].capture.rates = SNDRV_PCM_RATE_48000;
 			dais[i].capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
 		}
-- 
2.20.1

