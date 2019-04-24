Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCE6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0752190C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126374;
	bh=AiAas9CzoldVE1sCjQUkrwaG3fGgf9LVZs/f4IgRrpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v2rYOnvsp4J3G3UFcJQ4oHSYlalAEZNAM/fJYFPE4YwhU0WUci3/aueHpB+xMnmkR
	 EQqoCD/B7trOCFtsd6zSGwEe/FlCPNGiMfpTiJDsysl5IlV/MVuL7KQfmwGrTvqfAj
	 bmaGkUZZBu3Ny7VXZ9gCHs0R8jYeD2sCZk5Z+Wdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbfDXRTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388594AbfDXRTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:19:30 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8BE92190C;
        Wed, 24 Apr 2019 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126369;
        bh=AiAas9CzoldVE1sCjQUkrwaG3fGgf9LVZs/f4IgRrpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWxieMXlozULmSSbX6/VvnNFYHMB6fljF+ApHWdYq6XsmCvJqvKbVHEagbGGtIoPD
         L2Ed44G0lnfH2hA/Q6ixxqU9oYm90haxGLXvdg0OUq+DrFBEuQP1XUxlXrfsf2nCvt
         wqbn7bFWgD1e3OWrGyB1DpaQfOK7R+wP5SOO2R50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zubin Mithra <zsm@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 087/168] ALSA: seq: Fix OOB-reads from strlcpy
Date:   Wed, 24 Apr 2019 19:08:51 +0200
Message-Id: <20190424170928.929796508@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
@@ -1558,7 +1558,7 @@ static int snd_seq_ioctl_create_queue(st
 	/* set queue name */
 	if (! info.name[0])
 		snprintf(info.name, sizeof(info.name), "Queue-%d", q->queue);
-	strlcpy(q->name, info.name, sizeof(q->name));
+	strscpy(q->name, info.name, sizeof(q->name));
 	snd_use_lock_free(&q->use_lock);
 
 	if (copy_to_user(arg, &info, sizeof(info)))
@@ -1636,7 +1636,7 @@ static int snd_seq_ioctl_set_queue_info(
 		queuefree(q);
 		return -EPERM;
 	}
-	strlcpy(q->name, info.name, sizeof(q->name));
+	strscpy(q->name, info.name, sizeof(q->name));
 	queuefree(q);
 
 	return 0;


