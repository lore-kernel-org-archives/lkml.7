Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A74C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20FC2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599936;
	bh=m1F4gOf1GzHgIVFNY+Ku69eEaZjxA9gyJ9dRODh94uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UUO/0HasFOm8gz6Dj2PxYss8GJdO8K+JMDof0yDuTMIvGFMpL12nFvUZL9WAafZVA
	 corGamlXpi8XJ8ei9sq4otOSJMGU4RryoUjtNCucYHMyI+CvF1c59xqBRGppaiBny7
	 HQXej2F9oJCfKVGIXerI3Kw14IJCbJFiQpnkKimU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390098AbfGHPcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390076AbfGHPcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:32:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7391E21743;
        Mon,  8 Jul 2019 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599931;
        bh=m1F4gOf1GzHgIVFNY+Ku69eEaZjxA9gyJ9dRODh94uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CZlN/pX170O3Rr4u7ks37xf3TlDT5O24RD14vx1Ucj2+mxPJPfzxsEygDaUdQOVlP
         Sg/+bRhN/bxKs+VcZqw2vVcKLmcokEDq1o8q8ZaZwZyUzhYvfxqdnpFLOEUSk7fzpk
         jvj/ZlRgcxlkur0FDUqtXqHjGsiKvxH6HPELJC/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 36/96] ALSA: hdac: fix memory release for SST and SOF drivers
Date:   Mon,  8 Jul 2019 17:13:08 +0200
Message-Id: <20190708150528.515587974@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



