Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A790C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C62214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803382;
	bh=8obzKNZ7UGz3iDjYP52sVheyg1q6J65532QJ2C+znhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tgweVnTD43X6Xbs8j0zdppC4Zpg/ppqqtF0ge+JdFky/2h0+cKMco7QyP5dMxkFLC
	 Dt8vSE4kGrqDryXKEtBIpgew2/Op85rzDZ6+xp7ud1Wy8VX+X0Qt2pVL1LFYdo8Bmf
	 Li8e9cXkIoSUVzm0JiNYil1K7gqRx7axmwqjtOrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfHNRXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730062AbfHNRII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:08:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91FE521721;
        Wed, 14 Aug 2019 17:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802488;
        bh=8obzKNZ7UGz3iDjYP52sVheyg1q6J65532QJ2C+znhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqZmvdXNSTWkWNQfn+6IFAJFOAvGjbrehInst+/Hvf4b9VbgT60dwTRtqXAzL4NXs
         T33wbGFD30SoLnKsUjLAjliDuQyMdllveecVMzFJJwdS3XQ0SeeKXQpVf3RPnoAbko
         8rzQEliS6Any4p/B2C4Fcu2PNhnAfIUV5FaXGKkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 119/144] ALSA: usb-audio: fix a memory leak bug
Date:   Wed, 14 Aug 2019 19:01:15 +0200
Message-Id: <20190814165804.907321722@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

commit a67060201b746a308b1674f66bf289c9faef6d09 upstream.

In snd_usb_get_audioformat_uac3(), a structure for channel maps 'chmap' is
allocated through kzalloc() before the execution goto 'found_clock'.
However, this structure is not deallocated if the memory allocation for
'pd' fails, leading to a memory leak bug.

To fix the above issue, free 'fp->chmap' before returning NULL.

Fixes: 7edf3b5e6a45 ("ALSA: usb-audio: AudioStreaming Power Domain parsing")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/stream.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1043,6 +1043,7 @@ found_clock:
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
+			kfree(fp->chmap);
 			kfree(fp->rate_table);
 			kfree(fp);
 			return NULL;


