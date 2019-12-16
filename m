Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF3CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FAF207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520359;
	bh=vp9h9sH+3jUCNoXaY9XmcYdycZ30TI2SG5ijrITR6Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hgCfBC8YjgMHMSwjuCjjmIth3HsEF+F7nLyglfeRDy5uddN3l4cWeqnJc4QdRkR/A
	 EHHqJJxmIAuL8ZGOD6G4Nu+tXUT+i71AEe9N2nD3iT8iOBLMt7lVczYpgBPWL2oMvk
	 RlsImwM0fs83HbEKyeG5tSBkAHrbJpnh6VYx5ll0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfLPSTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:19:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731911AbfLPSTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:19:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAA8E20717;
        Mon, 16 Dec 2019 18:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520354;
        bh=vp9h9sH+3jUCNoXaY9XmcYdycZ30TI2SG5ijrITR6Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSw+KqRDX+y3E2Olxp66qJ0Iw5cew2A/ik8TWLfpzFUyubERIlEr9X6P7663ssZpi
         JvEVy5JPPfvR2S0V89uRTPNoom4ZCYAj3oCIsF2SzI6jpOa7fP2+9da/lndkdHCRyq
         ZbTOvmJyiX4qPOayPImqOpuDOLRoEDdzJbd9spjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 119/177] ALSA: fireface: fix return value in error path of isochronous resources reservation
Date:   Mon, 16 Dec 2019 18:49:35 +0100
Message-Id: <20191216174843.080446202@linuxfoundation.org>
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

commit 480136343cbe89426d6c2ab74ffb4e3ee572c7ee upstream.

Even if isochronous resources reservation fails, error code doesn't return
in pcm.hw_params callback.

Cc: <stable@vger.kernel.org> #5.3+
Fixes: 55162d2bb0e8 ("ALSA: fireface: reserve/release isochronous resources in pcm.hw_params/hw_free callbacks")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20191209151655.GA8090@workstation
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/fireface/ff-pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -219,7 +219,7 @@ static int pcm_hw_params(struct snd_pcm_
 		mutex_unlock(&ff->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int pcm_hw_free(struct snd_pcm_substream *substream)


