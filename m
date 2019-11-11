Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6434C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B8C204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573499442;
	bh=O8JqrFNL5fiRfUfBZHt8d/7Bp/awQ18JHCgSuhlLIGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qz8GzWp+sb/HhZKJQWb4VRQfg6KJJC7nGQI2vyGT2bAtp3AuwCBLYHBE/YHPPZtSq
	 G57RHNLYIkLPLridX8vpwbWnFSs1FDKICvr40Gxb9a5V5v8g/HgVUYeuRlAIi1w/8O
	 vxB85MH/iFgyAusG6sQBtESdPb+1uDk0WXSyE3AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfKKSbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfKKSbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:31:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A9A21655;
        Mon, 11 Nov 2019 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497102;
        bh=O8JqrFNL5fiRfUfBZHt8d/7Bp/awQ18JHCgSuhlLIGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v6CG+hn7ydaxhOUHEjR7Lgg7wKjVW/MZGcLifx4koYbhAvWIBFJCRfWuLiIJpWRne
         AThJDf9BQ4yZUajz5YOmxLBJ2pAs7+0czYBTXbNRhsvcPHjtLnkuGgiXr2GwcIVMjm
         /me7PBqYpZCFvnZCMwiCS2zqj32W2UeGa4w/4ME0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 08/43] ALSA: hda/ca0132 - Fix possible workqueue stall
Date:   Mon, 11 Nov 2019 19:28:22 +0100
Message-Id: <20191111181256.361449912@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181246.772983347@linuxfoundation.org>
References: <20191111181246.772983347@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 15c2b3cc09a31620914955cb2a89c277c18ee999 upstream.

The unsolicited event handler for the headphone jack on CA0132 codec
driver tries to reschedule the another delayed work with
cancel_delayed_work_sync().  It's no good idea, unfortunately,
especially after we changed the work queue to the standard global
one; this may lead to a stall because both works are using the same
global queue.

Fix it by dropping the _sync but does call cancel_delayed_work()
instead.

Fixes: 993884f6a26c ("ALSA: hda/ca0132 - Delay HP amp turnon.")
BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1155836
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191105134316.19294-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4440,7 +4440,7 @@ static void hp_callback(struct hda_codec
 	/* Delay enabling the HP amp, to let the mic-detection
 	 * state machine run.
 	 */
-	cancel_delayed_work_sync(&spec->unsol_hp_work);
+	cancel_delayed_work(&spec->unsol_hp_work);
 	schedule_delayed_work(&spec->unsol_hp_work, msecs_to_jiffies(500));
 	tbl = snd_hda_jack_tbl_get(codec, cb->nid);
 	if (tbl)


