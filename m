Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0758AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0B1208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520574;
	bh=8KgP9G391SzXZic0rr2SsYjcF9vMsNLj1iFKFLCunqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zbSJLSfqzgIJBUH7pVSAktxs9yGvr+fE6p1fuY9qk+FjSssTiNJQ02QPj3HDg4DZw
	 J7xxN25Lg1TRAjMMes9oYUZZqs7RfyoakTnue8XEo+a2y88c4nNi3VNT0j5W/ffu62
	 KmZO6kWC2u7enbZ40UE43rrADl5e5eO8RhP7nYBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfFZDmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfFZDmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:42:49 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92213216F4;
        Wed, 26 Jun 2019 03:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520569;
        bh=8KgP9G391SzXZic0rr2SsYjcF9vMsNLj1iFKFLCunqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=154DXg6iYNwkYDW9Zk9qPlNmCL5CxvUhMJASfjBEqJnGIvy/GBDU6tMXW7x7KheOs
         CGna1bo+DHwUdC0jE8P2tGL6d/HpfIWUPL/6rgaegCt85lfap9SrlDk1ncGIO4iFrX
         ITRE1Wnd0zyFW7FhqD4KxfNDsE1fDjm+W4KTTgZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 32/51] ALSA: hdac: fix memory release for SST and SOF drivers
Date:   Tue, 25 Jun 2019 23:40:48 -0400
Message-Id: <20190626034117.23247-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034117.23247-1-sashal@kernel.org>
References: <20190626034117.23247-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit 6d647b736a6b1cbf2f8deab0e6a94c34a6ea9d60 ]

During the integration of HDaudio support, we changed the way in which
we get hdev in snd_hdac_ext_bus_device_init() to use one preallocated
with devm_kzalloc(), however it still left kfree(hdev) in
snd_hdac_ext_bus_device_exit(). It leads to oopses when trying to
rmmod and modprobe. Fix it, by just removing kfree call.

SOF also uses some of the snd_hdac_ functions for HDAudio support but
allocated the memory with kzalloc. A matching fix is provided
separately to align all users of the snd_hdac_ library.

Fixes: 6298542fa33b ("ALSA: hdac: remove memory allocation from snd_hdac_ext_bus_device_init")
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/ext/hdac_ext_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index ec7715c6b0c0..c147ebe542da 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -172,7 +172,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_init);
 void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
 {
 	snd_hdac_device_exit(hdev);
-	kfree(hdev);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
 
-- 
2.20.1

