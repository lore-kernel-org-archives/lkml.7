Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA9C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C4B20836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014546;
	bh=mZZJPkpXGAMnfeH+BanVpCPUZl+DzohFfp6s/AyksWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZDiyvcFFrAJ/S2ITM8vZVc2j2oWXs5obTINJnV0Lo7Av7zTm6WdrR+Ybp9OM6uMGf
	 J7b3nrsj1zlskd7AwU7ojq/0JaOyWUU+64SOzcer2IQPV8wYudn2mQo581sUDxhr3f
	 eLRyKA9YGFkxSwG7cFHzkV5KEiIHsn9YIs8Y/GqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfLJVIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfLJVIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:08:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDF2724687;
        Tue, 10 Dec 2019 21:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012116;
        bh=mZZJPkpXGAMnfeH+BanVpCPUZl+DzohFfp6s/AyksWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LuH4l1NwBTyuXAcqHNZ1XIwPH7SWKfSpjyV8QBAdwQE1hoG4Bg0Rb/+CTsJ403njR
         V5u3Wj8pbWegQO5zZkN7DcHCX8sZmVtw6uP0ZsKO1C+MZXk1N41wAC6Ton9PvK+vfo
         EsNwV/n26HINonKvdlIIev+e8DsdLkYrWoGLoKRU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 088/350] ASoC: SOF: enable sync_write in hdac_bus
Date:   Tue, 10 Dec 2019 16:03:13 -0500
Message-Id: <20191210210735.9077-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit f3416e7144f5d4ba0fc5dcef6ebfff891266c46a ]

Align SOF HDA implementation with snd-hda-intel driver and enable
sync_write flag for all supported Intel platforms in SOF. When set,
a sync is issued after each verb write.

Sync after write has helped to overcome intermittent delays in
system resume flow on Intel Coffee Lake systems, and most recently
probe errors related to the HDMI codec on Ice Lake systems.

Matches the snd-hda-intel driver change done in commit 2756d9143aa5
("ALSA: hda - Fix intermittent CORB/RIRB stall on Intel chips").

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191008164443.1358-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 06e84679087bc..5a5163eef2ef4 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -268,6 +268,7 @@ static int hda_init(struct snd_sof_dev *sdev)
 
 	bus->use_posbuf = 1;
 	bus->bdl_pos_adj = 0;
+	bus->sync_write = 1;
 
 	mutex_init(&hbus->prepare_mutex);
 	hbus->pci = pci;
-- 
2.20.1

