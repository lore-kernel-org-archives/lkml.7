Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B1BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780A420836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688463;
	bh=pgolEGnIE0uG+IjklK0BrOO3tZ0Pj0FrFB3C0F15Ezk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YLJD+QbRnYYQ2P26qnDvVmIyLwaRRxQBmjxrrVeOVCUtM9BTajP/fwFhofGW8J0xw
	 jtkmlc+jRm3uxyzUnrf9yqHwkyNLC3RELQij2XKTC+KZIeE+ZdyDe3UFj1OZgjIbyt
	 QUBGDw3ATdGed6T03G0+oi1oyUsgalVR1xzvJnyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfCDIeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfCDIeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:34:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48EB20823;
        Mon,  4 Mar 2019 08:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688459;
        bh=pgolEGnIE0uG+IjklK0BrOO3tZ0Pj0FrFB3C0F15Ezk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjP9+Qh6CDoUytiNaC3aL/LNLzgGcxElTN7SUgZIRKwvCH33pDzXAZPHuyiAKqzMh
         dj8IIMXgebNVNxm1dTdEhr6XDvrorhPBheqPheYeO47R6gFch9DX31oaxcgsdDxL7f
         3PWBQG3tKOVw6r8JflPHuRrHz+Vb5UeQfKFmvxtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 16/88] ASoC: core: Make snd_soc_find_component() more robust
Date:   Mon,  4 Mar 2019 09:21:59 +0100
Message-Id: <20190304081631.219694595@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5a7b2aabc1aa0393f067d9325ada96fdf67f8cb7 ]

There are some use cases where you're checking for a lot of things on a
card and it makes sense that you might end up trying to call
snd_soc_find_component() without either a name or an of_node.  Currently
in that case we try to dereference the name and crash but it's more
useful to allow the caller to just treat that as a case where we don't
find anything, that error handling will already exist.

Inspired by a patch from Ajit Pandey fixing some callers.

Fixes: 8780cf1142a5 ("ASoC: soc-core: defer card probe until all component is added to list")
Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2d49492d60692..78f953be8aad8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -742,7 +742,7 @@ static struct snd_soc_component *soc_find_component(
 		if (of_node) {
 			if (component->dev->of_node == of_node)
 				return component;
-		} else if (strcmp(component->name, name) == 0) {
+		} else if (name && strcmp(component->name, name) == 0) {
 			return component;
 		}
 	}
-- 
2.19.1



