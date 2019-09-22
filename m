Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5D3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBC720665
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569177956;
	bh=kJC6Awz8EDg7dPEGltPbxNIzRDp5I4Bk/eB1xSqgAyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uafC0+vIkwi941vtaTjCOQvwov+Tmr7RY4PVbvZBxmfG/WCzWbTKBrjqebVeu2DYl
	 s1U8gsqX8tb62MnVQRlzpD67ntQVMztKtxdQVk3MT3SDjNN6UuxwebHzwj9q6+I/6d
	 XBLUYKgyLK3o0NTg88r0hb6KJe59ApfT3j3UWaAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbfIVSpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389612AbfIVSpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:45:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8FB206C2;
        Sun, 22 Sep 2019 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569177951;
        bh=kJC6Awz8EDg7dPEGltPbxNIzRDp5I4Bk/eB1xSqgAyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zzxNgGKzMqP+IthGwGq5O2KSgpFDa/oIBNgiML5wmkAg1utHG+UAcT0r7PuvE8wQZ
         nFFTihsTJAti4rllYuzMrqhac8cQ7kNH/g12GQKqDtR7aOtJYInVTVeDPzbIYQUu+4
         CSqv+zGLdxLf8M7a+Wv3Z97BthSx1uzAT3WM0jEc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keyon Jie <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 057/203] ASoC: hdac_hda: fix page fault issue by removing race
Date:   Sun, 22 Sep 2019 14:41:23 -0400
Message-Id: <20190922184350.30563-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184350.30563-1-sashal@kernel.org>
References: <20190922184350.30563-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

