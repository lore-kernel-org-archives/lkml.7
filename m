Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF6C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D4C20717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520363;
	bh=KO3vXSYLDbK8UNt87SuJS8TyyPyYA34rfIsJRPBk7ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u+7X0s1cEdQQvE9K7KBM3VaItZYZ0R6CjUGWOMijSVLzPxgkbgiiEOdD36ITReRoH
	 J4KnnFh42SXnUPesY1VLXLVJwK2lft9wExJpC1Hy04Y0bZ9nTy5MndVPowwBJYnVfJ
	 I32u+SZwD3DhZzDDGrOOGS78hkCDP6dc6vurGDkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbfLPSTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:19:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731758AbfLPSTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:19:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43853218AC;
        Mon, 16 Dec 2019 18:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520356;
        bh=KO3vXSYLDbK8UNt87SuJS8TyyPyYA34rfIsJRPBk7ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlwwlMnbVs/1HQ5ACdYlxkbf7KMT6XKLr8VNOKzcLsN+aXFyNz3a+v0h93x7ByaS8
         BxcoVP8+8BUvTTL3fpNUnsKyIMv2PlhvqX6q1D+MpcKfrqHS7Hg8//9q0to7xQ0TDo
         KSKOW4g3xI3Q8TFrqDhSGw+3nAXeoATIzk5bTf60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 120/177] ALSA: oxfw: fix return value in error path of isochronous resources reservation
Date:   Mon, 16 Dec 2019 18:49:36 +0100
Message-Id: <20191216174843.200388791@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 59a126aa3113fc23f03fedcafe3705f1de5aff50 upstream.

Even if isochronous resources reservation fails, error code doesn't return
in pcm.hw_params callback.

Cc: <stable@vger.kernel.org> #5.3+
Fixes: 4f380d007052 ("ALSA: oxfw: configure packet format in pcm.hw_params callback")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20191209151655.GA8090@workstation
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/oxfw/oxfw-pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/oxfw/oxfw-pcm.c
+++ b/sound/firewire/oxfw/oxfw-pcm.c
@@ -255,7 +255,7 @@ static int pcm_playback_hw_params(struct
 		mutex_unlock(&oxfw->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int pcm_capture_hw_free(struct snd_pcm_substream *substream)


