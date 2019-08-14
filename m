Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1016BC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECED206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803203;
	bh=AHWUpoMKIU/hMxsyuBEYRj2U3/8RmdJg0tIgVoejCkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJWnQEV4WVPVwmhlCJ7itB1p5LfOBTLTFUnUaFNkcBOwxEwsMsUoTyMwHA4hY3hPZ
	 cw93qkto2xRpzlMe/sg1rL0BJe93JKLDidvNmS6FEeAM6q/yy6HNDx5rltsGcaztyy
	 aq5tEbbWswOSsz1mi36ASNsFGKNY7Y0LYNjS1Wzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfHNRUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730047AbfHNRLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:11:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B469214DA;
        Wed, 14 Aug 2019 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802669;
        bh=AHWUpoMKIU/hMxsyuBEYRj2U3/8RmdJg0tIgVoejCkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXUsGxAvtdPgG2AqN75oXyTADeUXwbpM3VEuGCXu1k4bMGgw7EaTZNlJNWRkzJI2q
         JKonQV/XaD+pW0qSUM0tYY+sVwFFEfU5gMMt8Cf8SAwVVlvSUm44DC8pC/Jjp8AUSF
         KfcZw+hHkCQac5qeC+UVeX6WCKQnpat6/amdA/uo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 72/91] ALSA: usb-audio: fix a memory leak bug
Date:   Wed, 14 Aug 2019 19:01:35 +0200
Message-Id: <20190814165752.743785887@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
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
@@ -1053,6 +1053,7 @@ found_clock:
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
+			kfree(fp->chmap);
 			kfree(fp->rate_table);
 			kfree(fp);
 			return NULL;


