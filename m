Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3699C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE92B216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599819;
	bh=PlbhsP/1l0Cu+F69o8LIBKwjU4G9z5OkTVqCpdeIhS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=POKOiepkGAnAZ6PQPfZ2vmSsM5No1JAkM6YkHyeSt1muBl5fdzaMn7cUGAZNKhlAl
	 Bs2OKG+706ZqB9YYQLMa+vnoQ5Qp0EZM7rQeIx4RtZNbhdRNEQ5MVhVxL/1+4+5CLs
	 4fYv+N2Yn9dDc+7gr1IC7IFJBBr0Nkq4BJqsbOe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389554AbfGHPaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731917AbfGHPaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:30:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F7C320645;
        Mon,  8 Jul 2019 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599814;
        bh=PlbhsP/1l0Cu+F69o8LIBKwjU4G9z5OkTVqCpdeIhS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbRjqIgA0ejIPMKOmQgiSzacYlI0iz1XAtivkZA4xy6lta7KpoWNzVZhQA9evyZee
         Xe32gA6n3+rw9u2LcHPxznixAbj9zhs2raVSTSfTaBO4bGkgkKx54riwFaZzVX9Kak
         V2eEfnl0rkXXTDeZaj0xOjIfh/BFgKTTvpCGq300=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 44/90] ALSA: seq: fix incorrect order of dest_client/dest_ports arguments
Date:   Mon,  8 Jul 2019 17:13:11 +0200
Message-Id: <20190708150524.787056824@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
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


