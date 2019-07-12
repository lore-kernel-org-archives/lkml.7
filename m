Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F3CC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D791216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934011;
	bh=WTJYuDg0F9tQb+CDIWT+Ta6Xl+NN8NzOF8W1ILpr0Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Arc+nr8XU7KkmG8CdS+4TVJCRXXt/FrMzdqeO0Kze0r8nprFyRagVywr/FfdQMR3R
	 0RRtrBHR5REGr27Y2VhIbnzg7gGp8VLcqUUYfYxLqF8NfzO4OyogpWjKHnoqKoyEGx
	 ERdiYm8KIAEc6BTKq51IkzEVobmllutpgCA9QeCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfGLMUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbfGLMUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:20:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1EE21670;
        Fri, 12 Jul 2019 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934007;
        bh=WTJYuDg0F9tQb+CDIWT+Ta6Xl+NN8NzOF8W1ILpr0Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCxwHGxNjqTaZiJSBPgPTlNjBc4Lm9xdW5EDu8RRIMUX1RF+Q+D/817uU3xgzFUxQ
         gh1/K4cD5DJH7nkwk+AyyQ+6zQSjvTYRQJ9t2EDc64tWKAVJ9cPUPwOtW25LNZ+S8T
         lKwWoUWNOrlYrH4A/tzo2U+lB7n5h4Lxag7v2mUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 17/91] soundwire: intel: set dai min and max channels correctly
Date:   Fri, 12 Jul 2019 14:18:20 +0200
Message-Id: <20190712121622.315811542@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 0a8990e758f9..a6e2581ada70 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -651,8 +651,8 @@ static int intel_create_dai(struct sdw_cdns *cdns,
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



