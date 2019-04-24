Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649F5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3531D21903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125987;
	bh=GtY64T+JO5BDbWkofFFH4I+06tx8KPa/rlDWb5tELS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=akcJU5G5JFkjmRaDgPE1dqQ1i53Z5OcmrSNyDQVvn90VvVhtCCq4xTc6ouYK0bHKw
	 1AcOh2BQT0vjINeF/vKypQ1g0GPrAiIK29Fx+5eUFO9Y9f6VI1XTQwP2kYaN9/NbOM
	 mDH3+3PcYIIZaNI+iXYbdXL9nzoZrjPvtR1+4oB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbfDXRNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387766AbfDXRNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:04 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5425F218FE;
        Wed, 24 Apr 2019 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125983;
        bh=GtY64T+JO5BDbWkofFFH4I+06tx8KPa/rlDWb5tELS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JI8xddKJwxzJv4zKwdVqU1Qe77/jHBtSVYUYomKe+qa6dnT3xnhegVbE2Gt3/XB/B
         Dugj5a7cCB6RLQhjI7YNyEqeKfpWagpvDCgzZFMi17lS0rJEBvCIs76HG6QErqivkJ
         4FdRIkflW6qYEMFcfMCjsC8AiUUmem7CrcnyfLB0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zubin Mithra <zsm@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 052/104] ALSA: seq: Fix OOB-reads from strlcpy
Date:   Wed, 24 Apr 2019 19:09:09 +0200
Message-Id: <20190424170901.848335532@linuxfoundation.org>
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
 	if (client_info.name[0])
-		strlcpy(client->name, client_info.name, sizeof(client->name));
+		strscpy(client->name, client_info.name, sizeof(client->name));
 
 	client->filter = client_info.filter;
 	client->event_lost = client_info.event_lost;
@@ -1564,7 +1564,7 @@ static int snd_seq_ioctl_create_queue(st
 	/* set queue name */
 	if (! info.name[0])
 		snprintf(info.name, sizeof(info.name), "Queue-%d", q->queue);
-	strlcpy(q->name, info.name, sizeof(q->name));
+	strscpy(q->name, info.name, sizeof(q->name));
 	queuefree(q);
 
 	if (copy_to_user(arg, &info, sizeof(info)))
@@ -1642,7 +1642,7 @@ static int snd_seq_ioctl_set_queue_info(
 		queuefree(q);
 		return -EPERM;
 	}
-	strlcpy(q->name, info.name, sizeof(q->name));
+	strscpy(q->name, info.name, sizeof(q->name));
 	queuefree(q);
 
 	return 0;


