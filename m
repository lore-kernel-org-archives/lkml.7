Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0138DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAC820700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120159;
	bh=kJC6Awz8EDg7dPEGltPbxNIzRDp5I4Bk/eB1xSqgAyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W8ptuOQEx4IZvloYn76qm5OBpvSmsNN9tdUVaJ7JXdyWlvHyspTGKu8Fg/d9RXUCe
	 XdKQ89vFcvCJwvil9MtYnvQbXCr+c7gOnuSAk+bk+6LnSof3Yqrxu/zdp8PcdNdW5l
	 r2jgu25D6/qoM8mSKl5GOAPXqiVVSlUcKa7T/Rwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391423AbfJCQ3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:29:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391425AbfJCQ3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:29:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827D52054F;
        Thu,  3 Oct 2019 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120155;
        bh=kJC6Awz8EDg7dPEGltPbxNIzRDp5I4Bk/eB1xSqgAyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C93D9+mtllinzHoQDDAwfbhI4/1qkLse1HsF7jzFpII4xfRtLNT8Ot85F4ii3Zpxe
         Bhw6Qf/5wArfKIjc8NSGOqHy/VsvQAfMET7gJ3K4yk1WL/qzflpAKBrs/1LBYMM79v
         tpTQxnaI5g2z5wVYVBKTctzGr/nPQsAkkr7Nr/Hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 080/313] ASoC: hdac_hda: fix page fault issue by removing race
Date:   Thu,  3 Oct 2019 17:50:58 +0200
Message-Id: <20191003154540.721673779@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keyon Jie <yang.jie@linux.intel.com>

[ Upstream commit 804cbf4bb063204ca6c2471baa694548aab02ce3 ]

There is a race between hda codec device removing and the
jack-detecting work, which will lead to a page fault issue as the
latter work is accessing codec device which could be already removed.

Here add the cancellation of jack-detecting work before codecs are actually
removed to avoid the race and fix the issue.

Bug: https://github.com/thesofproject/linux/issues/1067
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190807145030.26117-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 7d49402569149..91242b6f8ea7a 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -495,6 +495,10 @@ static int hdac_hda_dev_probe(struct hdac_device *hdev)
 
 static int hdac_hda_dev_remove(struct hdac_device *hdev)
 {
+	struct hdac_hda_priv *hda_pvt;
+
+	hda_pvt = dev_get_drvdata(&hdev->dev);
+	cancel_delayed_work_sync(&hda_pvt->codec.jackpoll_work);
 	return 0;
 }
 
-- 
2.20.1



