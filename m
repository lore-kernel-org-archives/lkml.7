Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A4FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A8320863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687835;
	bh=gBWDXwjNEq+JsPda45TvLrgrRVlOSSjbfCEIoS2BXBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ymj3BFqRpZ0tQp7nU4Osa3L1KjgkM24k7rjebZ1hvoQyUkynkjq9kuKNc5Ubv2JRO
	 6f9LfX3JjSFP6Uo8yPzSGFWRS1AZ0mMx4ZA9FIyu0qIhPvBTEP2ejGN6on8ue0fv6f
	 pwQwWzrxQ4O47drbpSv8Vj5s1jzx25R1qUusPytg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCDIXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:23:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfCDIXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:23:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C14C320823;
        Mon,  4 Mar 2019 08:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687830;
        bh=gBWDXwjNEq+JsPda45TvLrgrRVlOSSjbfCEIoS2BXBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgBzfsU7XCV8Gv7db1dum2q7cFdvCoeSD8J/Y/bnrUzaJxXj0UuAKPIKH8zYbFzR4
         owYh3sL3gm6mMDA5QJkLSis/FD0VC5ldccVA9eIEdkKSgAuqadCf5yXSDPpDMrJfFP
         a0FBBB/TsJvu1qS3XYp0g3qaYAQBotSHcxh2GsdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rander Wang <rander.wang@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 06/32] ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field
Date:   Mon,  4 Mar 2019 09:21:54 +0100
Message-Id: <20190304081602.761786323@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
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

[ Upstream commit 906a9abc5de73c383af518f5a806f4be2993a0c7 ]

For some reason this field was set to zero when all other drivers use
.dynamic = 1 for front-ends. This change was tested on Dell XPS13 and
has no impact with the existing legacy driver. The SOF driver also works
with this change which enables it to override the fixed topology.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/broadwell.c | 2 +-
 sound/soc/intel/boards/haswell.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 7486a0022fdea..993d2c105ae14 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -191,7 +191,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.stream_name = "Loopback",
 		.cpu_dai_name = "Loopback Pin",
 		.platform_name = "haswell-pcm-audio",
-		.dynamic = 0,
+		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
diff --git a/sound/soc/intel/boards/haswell.c b/sound/soc/intel/boards/haswell.c
index 863f1d5e2a2c9..11d0cc2b0e390 100644
--- a/sound/soc/intel/boards/haswell.c
+++ b/sound/soc/intel/boards/haswell.c
@@ -145,7 +145,7 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
 		.stream_name = "Loopback",
 		.cpu_dai_name = "Loopback Pin",
 		.platform_name = "haswell-pcm-audio",
-		.dynamic = 0,
+		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
-- 
2.19.1



