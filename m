Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061C3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C079220818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356241;
	bh=bZSfbFHcG3jH00gD3d3eKSTrGyCjUTsQJvkndIPrh+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YKhfkrzRNV0YRLPcK5LPOdL2EZqvCZnwpri37p89EeXTHGw3Bcc7rnJAA5FgTIzx+
	 5ncKl8dhvkYAcqxqcPV/aTB9Ds6p3KBXuOAX6IRXtAwkqYbmqxgVpmU9hYum75xuR6
	 5p4bX7ovnXEKD+e6H8vgi4BiXhWT20Eb6gPJmIpc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfDOTGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730005AbfDOTGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E60DD218A1;
        Mon, 15 Apr 2019 19:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355198;
        bh=bZSfbFHcG3jH00gD3d3eKSTrGyCjUTsQJvkndIPrh+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgZc0rhDwXnUWyYII/CEeBQFN8rdOLMrvcA8+KE30PWOjWIUSa40vT1SPzvJhgHaZ
         sBKevqIjAXBIQgRJwWJ0KS/IEnit+tFkmDxytJp+TLY9sxdcA/Sh5K5kO/pTpd2pjQ
         gSY0FcwsMaggDpcn0OkgXW2MwDtvny+tt5zqS0jg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zubin Mithra <zsm@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 050/101] ALSA: seq: Fix OOB-reads from strlcpy
Date:   Mon, 15 Apr 2019 20:58:48 +0200
Message-Id: <20190415183743.215721697@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
@@ -1252,7 +1252,7 @@ static int snd_seq_ioctl_set_client_info
 
 	/* fill the info fields */
 	if (client_info->name[0])
-		strlcpy(client->name, client_info->name, sizeof(client->name));
+		strscpy(client->name, client_info->name, sizeof(client->name));
 
 	client->filter = client_info->filter;
 	client->event_lost = client_info->event_lost;
@@ -1530,7 +1530,7 @@ static int snd_seq_ioctl_create_queue(st
 	/* set queue name */
 	if (!info->name[0])
 		snprintf(info->name, sizeof(info->name), "Queue-%d", q->queue);
-	strlcpy(q->name, info->name, sizeof(q->name));
+	strscpy(q->name, info->name, sizeof(q->name));
 	snd_use_lock_free(&q->use_lock);
 
 	return 0;
@@ -1592,7 +1592,7 @@ static int snd_seq_ioctl_set_queue_info(
 		queuefree(q);
 		return -EPERM;
 	}
-	strlcpy(q->name, info->name, sizeof(q->name));
+	strscpy(q->name, info->name, sizeof(q->name));
 	queuefree(q);
 
 	return 0;


