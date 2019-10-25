Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E38DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0525C222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572011838;
	bh=/zLnm0RKYSbzniMjkAEMUn9ZtqQAZnRLSH/3BjQG39s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l03QYeK0BsarBADbXZf5LYRljW1clmVOAbPiiDLr1C1fj5lTiDyzfjIWK+E2dMZAc
	 svFjG2SIhZf2CJnMPUEOzzvbkMboF5X3hES16f8pctZt/MtYs9Ta+9fPb0EHX6MZ/u
	 FCPSlCX3Q0S5tY7jFVk/FHJE2Fgzw05L9ltuPz7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632858AbfJYN5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393513AbfJYN5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:57:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ACF721E6F;
        Fri, 25 Oct 2019 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572011831;
        bh=/zLnm0RKYSbzniMjkAEMUn9ZtqQAZnRLSH/3BjQG39s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HTczkWqJxV7mIV8eMzEJjISbTIIcez4ItpF8cRNqLOqZWYLH7UM1YEH1a3iVi7JkQ
         UgAOBB1podyUHVxRrWeWEdEdHpBCtkvyOxlf8VCeGIv6fCylD9dfp63Q7IFISSmPSP
         E0oQKpEiJ0vwGTADg4PVuLAVCvOU5CadoATFsam8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 37/37] ALSA: hda: Add codec on bus address table lately
Date:   Fri, 25 Oct 2019 09:56:01 -0400
Message-Id: <20191025135603.25093-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025135603.25093-1-sashal@kernel.org>
References: <20191025135603.25093-1-sashal@kernel.org>
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
index 020fbbbcf6f5c..21807592343f5 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -60,10 +60,6 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 	pm_runtime_get_noresume(&codec->dev);
 	atomic_set(&codec->in_pm, 0);
 
-	err = snd_hdac_bus_add_device(bus, codec);
-	if (err < 0)
-		goto error;
-
 	/* fill parameters */
 	codec->vendor_id = snd_hdac_read_parm(codec, AC_NODE_ROOT,
 					      AC_PAR_VENDOR_ID);
@@ -142,15 +138,22 @@ int snd_hdac_device_register(struct hdac_device *codec)
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
 
@@ -164,8 +167,8 @@ void snd_hdac_device_unregister(struct hdac_device *codec)
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

