Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B727FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AA9218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354079;
	bh=Z+0BH9rrIJ2/xEPwPe5vRIkDigzEUH1mKpbqEuDS2NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GFsSWb3Lqg7fGW25ibG2JRnfzQEbveqICttO30rsmI8jWtBwfdgI/GtZ/naYz+VGr
	 jsSWUoZ8oxqlPsf0w6z8jV/C17o1t1p0kQ+6MyJnGv9eszGEe/W56F8Pupniypgt4j
	 X5qTsbd3R/waw495ow3U03U0+BRpMOi/ChHJXKAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfDOSr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfDOSrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14996218EA;
        Mon, 15 Apr 2019 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354074;
        bh=Z+0BH9rrIJ2/xEPwPe5vRIkDigzEUH1mKpbqEuDS2NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfPL0eyLnhwm5KAvIcoDJ1RjDs7rsZgAZqf97+hU/CWSlxryZwwfUsXTFsMSXmVrs
         1kZqx/7SjqfM93QtB38H1eaAES5idxmdx4AxXfnP89SN12FTj/0bLQw72HiFePmpJG
         x0WwPm9iidWt2jnaBI3Y27v+P6xQApz33AFHAVzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zubin Mithra <zsm@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 63/76] ALSA: seq: Fix OOB-reads from strlcpy
Date:   Mon, 15 Apr 2019 20:44:27 +0200
Message-Id: <20190415183725.660783720@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zubin Mithra <zsm@chromium.org>

commit 212ac181c158c09038c474ba68068be49caecebb upstream.

When ioctl calls are made with non-null-terminated userspace strings,
strlcpy causes an OOB-read from within strlen. Fix by changing to use
strscpy instead.

Signed-off-by: Zubin Mithra <zsm@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_clientmgr.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1249,7 +1249,7 @@ static int snd_seq_ioctl_set_client_info
 
 	/* fill the info fields */
 	if (client_info->name[0])
-		strlcpy(client->name, client_info->name, sizeof(client->name));
+		strscpy(client->name, client_info->name, sizeof(client->name));
 
 	client->filter = client_info->filter;
 	client->event_lost = client_info->event_lost;
@@ -1527,7 +1527,7 @@ static int snd_seq_ioctl_create_queue(st
 	/* set queue name */
 	if (!info->name[0])
 		snprintf(info->name, sizeof(info->name), "Queue-%d", q->queue);
-	strlcpy(q->name, info->name, sizeof(q->name));
+	strscpy(q->name, info->name, sizeof(q->name));
 	snd_use_lock_free(&q->use_lock);
 
 	return 0;
@@ -1589,7 +1589,7 @@ static int snd_seq_ioctl_set_queue_info(
 		queuefree(q);
 		return -EPERM;
 	}
-	strlcpy(q->name, info->name, sizeof(q->name));
+	strscpy(q->name, info->name, sizeof(q->name));
 	queuefree(q);
 
 	return 0;


