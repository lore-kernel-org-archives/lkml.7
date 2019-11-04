Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E794FCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC429204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905577;
	bh=dtedUUNYdKE+VVmQFQSzK9xIZLBlAcMYOmBLUMfQseY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Xl7By/eGeXmP6crTqHxUJezkrbNZGMd4A/6lLP+7Rtp/PXbU5FHmLgqQs/ycnmgf
	 BLGQk7TxVc+1AwbmEKuk5rTBoLjlxEJPKogf6Iair3oPBrkB9c6HHcugGaj9ZFNP3r
	 c/o49z1xLnYGVixHI0hh3P92OLP/e0KkID1YURvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390539AbfKDWKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390535AbfKDWK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:10:26 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF712084D;
        Mon,  4 Nov 2019 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905424;
        bh=dtedUUNYdKE+VVmQFQSzK9xIZLBlAcMYOmBLUMfQseY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z2J6hMHycPCWSa0WOzUfIu2M7mH5GTwRWxHpbo7g0juoOS0nzwoTZRf1vMq2ed+NW
         PW8My3ugswfn4abmPxEXReJx61yJb403k+czefEYcR/eblDqDAjiqHXe8xlQRNLai6
         bLRouRDV68MtQELS6HPZqRWWFZJRvsn4VkCAbdqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 5.3 098/163] ALSA: timer: Fix mutex deadlock at releasing card
Date:   Mon,  4 Nov 2019 22:44:48 +0100
Message-Id: <20191104212147.192229503@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit a39331867335d4a94b6165e306265c9e24aca073 upstream.

When a card is disconnected while in use, the system waits until all
opened files are closed then releases the card.  This is done via
put_device() of the card device in each device release code.

The recently reported mutex deadlock bug happens in this code path;
snd_timer_close() for the timer device deals with the global
register_mutex and it calls put_device() there.  When this timer
device is the last one, the card gets freed and it eventually calls
snd_timer_free(), which has again the protection with the global
register_mutex -- boom.

Basically put_device() call itself is race-free, so a relative simple
workaround is to move this put_device() call out of the mutex.  For
achieving that, in this patch, snd_timer_close_locked() got a new
argument to store the card device pointer in return, and each caller
invokes put_device() with the returned object after the mutex unlock.

Reported-and-tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/timer.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -226,7 +226,8 @@ static int snd_timer_check_master(struct
 	return 0;
 }
 
-static int snd_timer_close_locked(struct snd_timer_instance *timeri);
+static int snd_timer_close_locked(struct snd_timer_instance *timeri,
+				  struct device **card_devp_to_put);
 
 /*
  * open a timer instance
@@ -238,6 +239,7 @@ int snd_timer_open(struct snd_timer_inst
 {
 	struct snd_timer *timer;
 	struct snd_timer_instance *timeri = NULL;
+	struct device *card_dev_to_put = NULL;
 	int err;
 
 	mutex_lock(&register_mutex);
@@ -261,7 +263,7 @@ int snd_timer_open(struct snd_timer_inst
 		list_add_tail(&timeri->open_list, &snd_timer_slave_list);
 		err = snd_timer_check_slave(timeri);
 		if (err < 0) {
-			snd_timer_close_locked(timeri);
+			snd_timer_close_locked(timeri, &card_dev_to_put);
 			timeri = NULL;
 		}
 		goto unlock;
@@ -313,7 +315,7 @@ int snd_timer_open(struct snd_timer_inst
 			timeri = NULL;
 
 			if (timer->card)
-				put_device(&timer->card->card_dev);
+				card_dev_to_put = &timer->card->card_dev;
 			module_put(timer->module);
 			goto unlock;
 		}
@@ -323,12 +325,15 @@ int snd_timer_open(struct snd_timer_inst
 	timer->num_instances++;
 	err = snd_timer_check_master(timeri);
 	if (err < 0) {
-		snd_timer_close_locked(timeri);
+		snd_timer_close_locked(timeri, &card_dev_to_put);
 		timeri = NULL;
 	}
 
  unlock:
 	mutex_unlock(&register_mutex);
+	/* put_device() is called after unlock for avoiding deadlock */
+	if (card_dev_to_put)
+		put_device(card_dev_to_put);
 	*ti = timeri;
 	return err;
 }
@@ -338,7 +343,8 @@ EXPORT_SYMBOL(snd_timer_open);
  * close a timer instance
  * call this with register_mutex down.
  */
-static int snd_timer_close_locked(struct snd_timer_instance *timeri)
+static int snd_timer_close_locked(struct snd_timer_instance *timeri,
+				  struct device **card_devp_to_put)
 {
 	struct snd_timer *timer = timeri->timer;
 	struct snd_timer_instance *slave, *tmp;
@@ -395,7 +401,7 @@ static int snd_timer_close_locked(struct
 			timer->hw.close(timer);
 		/* release a card refcount for safe disconnection */
 		if (timer->card)
-			put_device(&timer->card->card_dev);
+			*card_devp_to_put = &timer->card->card_dev;
 		module_put(timer->module);
 	}
 
@@ -407,14 +413,18 @@ static int snd_timer_close_locked(struct
  */
 int snd_timer_close(struct snd_timer_instance *timeri)
 {
+	struct device *card_dev_to_put = NULL;
 	int err;
 
 	if (snd_BUG_ON(!timeri))
 		return -ENXIO;
 
 	mutex_lock(&register_mutex);
-	err = snd_timer_close_locked(timeri);
+	err = snd_timer_close_locked(timeri, &card_dev_to_put);
 	mutex_unlock(&register_mutex);
+	/* put_device() is called after unlock for avoiding deadlock */
+	if (card_dev_to_put)
+		put_device(card_dev_to_put);
 	return err;
 }
 EXPORT_SYMBOL(snd_timer_close);


