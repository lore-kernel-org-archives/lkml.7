Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DEBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E5121D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572012353;
	bh=iI2WbB/rCnOHq0Uw2puFP3RXiZkcf6+ZTzmBSTYmT9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FvS7iweOIY+2i5SweAaZVLaCS10QVyPEu4FwHn2t/kjldQDlp1Wy4T73c4MW7KLB/
	 leUUsmEnUwuyMl7wzgakDzV4iyRfrgKU0RVCmIPeQex/VHaHP50kVtD3DEaeyqzz8j
	 H5Gr7yyiROr4SPN4E2tJQW8Qz0zYsfQrhGDzEOX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502705AbfJYOFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505194AbfJYNz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:55:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FC30222CD;
        Fri, 25 Oct 2019 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572011756;
        bh=iI2WbB/rCnOHq0Uw2puFP3RXiZkcf6+ZTzmBSTYmT9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npENqa+Mm1SxruPsddlpj+5wIXAq+ysTDVKvoRk6uZxlPikfkG0K4C3VNatszz4Cz
         aghIKSZK5z6AzHjwZabRF4o0PRE4FSCXA6Vyy9j6hKSvPi3bDvnGe1dl2KC/IrzFcF
         Ac+0UkKuCGLCxDM8MPbTpdwyKmn2kytJB2ycLchc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 32/33] ALSA: hda: Add codec on bus address table lately
Date:   Fri, 25 Oct 2019 09:55:04 -0400
Message-Id: <20191025135505.24762-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025135505.24762-1-sashal@kernel.org>
References: <20191025135505.24762-1-sashal@kernel.org>
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
index b26cc93e7e103..033bcef8751a8 100644
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

