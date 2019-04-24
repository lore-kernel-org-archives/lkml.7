Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C66C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C51218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126123;
	bh=k2eKPaXRWHYfceogMRv/GjD1sh+twQhHOtvxTiw9KME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tut3Y4BfZ8/sgFt8hy/oFAdXJBkoakta/9GFdnvTPwIub7aRkcCXhGHjf/FVYonQO
	 k3/LGRqiPGYLMQE2EFduxAs+M/jm23o7jt9OaVnaa2Y63pLWCbl7tdoSc+KiD4Suaj
	 cOsHDYgOjyy7Duneq0Bga96yaJbw32AQfYTLFzGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbfDXRPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388202AbfDXRPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:15:17 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41F6D2054F;
        Wed, 24 Apr 2019 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126116;
        bh=k2eKPaXRWHYfceogMRv/GjD1sh+twQhHOtvxTiw9KME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oO3wbDHf9R1Y5DkEG0U7mKQjS/NdOIuEpaexfFy5GbgOFWTohf+g9YRUuatUT75V/
         A+uMiTcNBMA8zuGHi4lhb1WtpccpQ86AlFKwQs813l9UFEe+qytN92lZvrXWCsCHwe
         lt4swFaSR2Dn+IJ1Pzle+CFRqD0QuA2RDJOOHCJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+48df349490c36f9f54ab@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 100/104] ALSA: core: Fix card races between register and disconnect
Date:   Wed, 24 Apr 2019 19:09:57 +0200
Message-Id: <20190424170910.512217021@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 2a3f7221acddfe1caa9ff09b3a8158c39b2fdeac upstream.

There is a small race window in the card disconnection code that
allows the registration of another card with the very same card id.
This leads to a warning in procfs creation as caught by syzkaller.

The problem is that we delete snd_cards and snd_cards_lock entries at
the very beginning of the disconnection procedure.  This makes the
slot available to be assigned for another card object while the
disconnection procedure is being processed.  Then it becomes possible
to issue a procfs registration with the existing file name although we
check the conflict beforehand.

The fix is simply to move the snd_cards and snd_cards_lock clearances
at the end of the disconnection procedure.  The references to these
entries are merely either from the global proc files like
/proc/asound/cards or from the card registration / disconnection, so
it should be fine to shift at the very end.

Reported-by: syzbot+48df349490c36f9f54ab@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/init.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -389,14 +389,7 @@ int snd_card_disconnect(struct snd_card
 	card->shutdown = 1;
 	spin_unlock(&card->files_lock);
 
-	/* phase 1: disable fops (user space) operations for ALSA API */
-	mutex_lock(&snd_card_mutex);
-	snd_cards[card->number] = NULL;
-	clear_bit(card->number, snd_cards_lock);
-	mutex_unlock(&snd_card_mutex);
-	
-	/* phase 2: replace file->f_op with special dummy operations */
-	
+	/* replace file->f_op with special dummy operations */
 	spin_lock(&card->files_lock);
 	list_for_each_entry(mfile, &card->files_list, list) {
 		/* it's critical part, use endless loop */
@@ -412,7 +405,7 @@ int snd_card_disconnect(struct snd_card
 	}
 	spin_unlock(&card->files_lock);	
 
-	/* phase 3: notify all connected devices about disconnection */
+	/* notify all connected devices about disconnection */
 	/* at this point, they cannot respond to any calls except release() */
 
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
@@ -430,6 +423,13 @@ int snd_card_disconnect(struct snd_card
 		device_del(&card->card_dev);
 		card->registered = false;
 	}
+
+	/* disable fops (user space) operations for ALSA API */
+	mutex_lock(&snd_card_mutex);
+	snd_cards[card->number] = NULL;
+	clear_bit(card->number, snd_cards_lock);
+	mutex_unlock(&snd_card_mutex);
+
 #ifdef CONFIG_PM
 	wake_up(&card->power_sleep);
 #endif


