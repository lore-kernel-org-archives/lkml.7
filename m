Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC77CC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC50821783
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600809;
	bh=PlbhsP/1l0Cu+F69o8LIBKwjU4G9z5OkTVqCpdeIhS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cWk+Xtg1AaU2a7CQfF5G3k8QqZVhiuVFsMWt4V5mN7Ft6W+t7fXpKq3/hlqmGjdQM
	 J0+gs1215k8pnXzpSdOGlmN8u+eplSWsLpnqacRuKylTC8Z1QlzwrOulhGtP3mpqfR
	 rkxeYIU1L3mnU3mbtoqRYbhbdGpJC5OIBS80A/ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbfGHPWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388067AbfGHPWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:22:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F3B1216E3;
        Mon,  8 Jul 2019 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599369;
        bh=PlbhsP/1l0Cu+F69o8LIBKwjU4G9z5OkTVqCpdeIhS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laKYfFVFEZoL2/It8PhG8tOa2OWe53ZfiDO0pIiWcFrig6lCZlwsnCYfKyqRSBWEX
         s9ZJnC5cSoe3mLlln59JgFUe9P7Zgto/TTRZnYU+kDMAO04584Oh5PUbVXkjxZYHuf
         3hFNNc9yhXv+/6qqaIviogHJPhnx2C1OD/fQ+ZJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 088/102] ALSA: seq: fix incorrect order of dest_client/dest_ports arguments
Date:   Mon,  8 Jul 2019 17:13:21 +0200
Message-Id: <20190708150531.018521243@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit c3ea60c231446663afd6ea1054da6b7f830855ca upstream.

There are two occurrances of a call to snd_seq_oss_fill_addr where
the dest_client and dest_port arguments are in the wrong order. Fix
this by swapping them around.

Addresses-Coverity: ("Arguments in wrong order")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/oss/seq_oss_ioctl.c |    2 +-
 sound/core/seq/oss/seq_oss_rw.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/seq/oss/seq_oss_ioctl.c
+++ b/sound/core/seq/oss/seq_oss_ioctl.c
@@ -62,7 +62,7 @@ static int snd_seq_oss_oob_user(struct s
 	if (copy_from_user(ev, arg, 8))
 		return -EFAULT;
 	memset(&tmpev, 0, sizeof(tmpev));
-	snd_seq_oss_fill_addr(dp, &tmpev, dp->addr.port, dp->addr.client);
+	snd_seq_oss_fill_addr(dp, &tmpev, dp->addr.client, dp->addr.port);
 	tmpev.time.tick = 0;
 	if (! snd_seq_oss_process_event(dp, (union evrec *)ev, &tmpev)) {
 		snd_seq_oss_dispatch(dp, &tmpev, 0, 0);
--- a/sound/core/seq/oss/seq_oss_rw.c
+++ b/sound/core/seq/oss/seq_oss_rw.c
@@ -174,7 +174,7 @@ insert_queue(struct seq_oss_devinfo *dp,
 	memset(&event, 0, sizeof(event));
 	/* set dummy -- to be sure */
 	event.type = SNDRV_SEQ_EVENT_NOTEOFF;
-	snd_seq_oss_fill_addr(dp, &event, dp->addr.port, dp->addr.client);
+	snd_seq_oss_fill_addr(dp, &event, dp->addr.client, dp->addr.port);
 
 	if (snd_seq_oss_process_event(dp, rec, &event))
 		return 0; /* invalid event - no need to insert queue */


