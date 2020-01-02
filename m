Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B7C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0F522B48
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004728;
	bh=8ptzUG2PeyEr2rau9AYI/YXSZyrBs6qffUwwHWVvqYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cTeEQaO05ncHxaf+4EfSikfSWEjgUYTIGiG6DGMTf8m7Lp1UNgoRY7vFClb0V/Wmk
	 Yu6XkGxbdXHk+vk2rBnLq7sgt6ts28bOvBTeFrJfCJkFjCSMwSPcfUw6XhgHvK+CFy
	 0S5cJIXjzIFh/W/ldxzUOjsjeJucXy9PySVku2/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbgABWir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731343AbgABWio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:38:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B874E2467D;
        Thu,  2 Jan 2020 22:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004724;
        bh=8ptzUG2PeyEr2rau9AYI/YXSZyrBs6qffUwwHWVvqYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGcO47MWpfhbMaRrRClnBjOi9mwNNBwb+qvHTYjD7Dbxc3FxSaitGoMKRSiDiHeOz
         xEdK3gvT1M3BJaMyMhzZX3/EOjaEwT9Kr3zvN8LqCLYHRUX/Ci1y6p6psqMjw+Ry1m
         rp+UPmdQMvDOc2YvXGFjPxseNnBbWBKzbygX3V/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+b3028ac3933f5c466389@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 127/137] ALSA: hda - Downgrade error message for single-cmd fallback
Date:   Thu,  2 Jan 2020 23:08:20 +0100
Message-Id: <20200102220604.236358907@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 475feec0c41ad71cb7d02f0310e56256606b57c5 ]

We made the error message for the CORB/RIRB communication clearer by
upgrading to dev_WARN() so that user can notice better.  But this
struck us like a boomerang: now it caught syzbot and reported back as
a fatal issue although it's not really any too serious bug that worth
for stopping the whole system.

OK, OK, let's be softy, downgrade it to the standard dev_err() again.

Fixes: dd65f7e19c69 ("ALSA: hda - Show the fatal CORB/RIRB error more clearly")
Reported-by: syzbot+b3028ac3933f5c466389@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/20191216151224.30013-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_controller.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -673,7 +673,7 @@ static int azx_rirb_get_response(struct
 		return -EAGAIN; /* give a chance to retry */
 	}
 
-	dev_WARN(chip->card->dev,
+	dev_err(chip->card->dev,
 		"azx_get_response timeout, switching to single_cmd mode: last cmd=0x%08x\n",
 		bus->last_cmd[addr]);
 	chip->single_cmd = 1;


