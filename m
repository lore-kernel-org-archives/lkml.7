Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6395C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAA32054F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180417;
	bh=6mRKLFwnrjiSPq0K3P6kBNneWVhgDLHWGC4dntafiTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZWG+9osrFXRDRcZp23l6yRzCYFveL3vQQO6/ajWPeqoQEVjtbQiGJ8Lc24sNR0i4d
	 mSwcD47yk6eV++QYmkpuU2WozqCsDC4Xagwx/memqVt6EztRbKx9SI4J2wyKD2q7D7
	 cEAI1/Y1Gf+RAXFHcq37q8XJg17KIHIV7VqXPd+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbfIVT04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390601AbfIVSvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:51:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AB4D2190F;
        Sun, 22 Sep 2019 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178297;
        bh=6mRKLFwnrjiSPq0K3P6kBNneWVhgDLHWGC4dntafiTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2F7IlYiDz5hOMZy21wyVZLNmlCeTUO30XrH0u+THxZ8+8UZDK3DHH7xEJ9qir9GYu
         l4j8cIQpxTZsvuc+SmMizpCuPneK4S7ypYGRDmDBDXv5yXyr5he4iyb1rSLzWpBigt
         b2kNOWiu4PYQm5XocMoJsv7OPVvH/ZCt9DYfnAEQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 072/185] ALSA: hda: Add codec on bus address table lately
Date:   Sun, 22 Sep 2019 14:47:30 -0400
Message-Id: <20190922184924.32534-72-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit ee5f85d9290fe25d460bd320b7fe073075d72d33 ]

The call of snd_hdac_bus_add_device() is needed only for registering
the codec onto the bus caddr_tbl[] that is referred essentially only
in the unsol event handler.  That is, the reason of this call and the
release by the counter-part function snd_hdac_bus_remove_device() is
just to assure that the unsol event gets notified to the codec.

But the current implementation of the unsol notification wouldn't work
properly when the codec is still in a premature init state.  So this
patch tries to work around it by delaying the caddr_tbl[] registration
at the point of snd_hdac_device_register().

Also, the order of snd_hdac_bus_remove_device() and device_del() calls
are shuffled to make sure that the unsol event is masked before
deleting the device.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204565
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/hdac_device.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 3842f9d34b7cf..02b2950d1d0e6 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -61,10 +61,6 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 	pm_runtime_get_noresume(&codec->dev);
 	atomic_set(&codec->in_pm, 0);
 
-	err = snd_hdac_bus_add_device(bus, codec);
-	if (err < 0)
-		goto error;
-
 	/* fill parameters */
 	codec->vendor_id = snd_hdac_read_parm(codec, AC_NODE_ROOT,
 					      AC_PAR_VENDOR_ID);
@@ -143,15 +139,22 @@ int snd_hdac_device_register(struct hdac_device *codec)
 	err = device_add(&codec->dev);
 	if (err < 0)
 		return err;
+	err = snd_hdac_bus_add_device(codec->bus, codec);
+	if (err < 0)
+		goto error;
 	mutex_lock(&codec->widget_lock);
 	err = hda_widget_sysfs_init(codec);
 	mutex_unlock(&codec->widget_lock);
-	if (err < 0) {
-		device_del(&codec->dev);
-		return err;
-	}
+	if (err < 0)
+		goto error_remove;
 
 	return 0;
+
+ error_remove:
+	snd_hdac_bus_remove_device(codec->bus, codec);
+ error:
+	device_del(&codec->dev);
+	return err;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_device_register);
 
@@ -165,8 +168,8 @@ void snd_hdac_device_unregister(struct hdac_device *codec)
 		mutex_lock(&codec->widget_lock);
 		hda_widget_sysfs_exit(codec);
 		mutex_unlock(&codec->widget_lock);
-		device_del(&codec->dev);
 		snd_hdac_bus_remove_device(codec->bus, codec);
+		device_del(&codec->dev);
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_device_unregister);
-- 
2.20.1

