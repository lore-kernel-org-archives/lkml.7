Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC382C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7A3206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806660;
	bh=/W2GDSSfhmcFCYLBTRD+1nC0aSX/pAnuIWfuvhvjAt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lC1wn29CFt235LqGDpZLoNeUZMzkVskT6Ht/TyuA91barbD7Fn/yLgkJlMELINttB
	 W5lUYNEy/uzxlCWcTIjNpLW6OU0nmQO4g2eg7+BOCLn+85M9Ka5qfFa/jIBELv4KNZ
	 4S1XDVs5ckMlhPaQgFUbtY+M7qRQtAGgom4lXJCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfFQVYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbfFQVYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:24:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C8D120657;
        Mon, 17 Jun 2019 21:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806655;
        bh=/W2GDSSfhmcFCYLBTRD+1nC0aSX/pAnuIWfuvhvjAt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3oRZYqgaCtYT6nDfLZPZb7c70xV1MXfa5qg4aSQJIS7XP2683xz6Q3HydF7Op6ou
         l1HiiIUP2gzEkgBWeMMwSmzNmDHhpa/CzMyE713/Kgj9SpcONK/WGOGoURIcd7uRFy
         eG8E3dp9986+Jgr+zJ4b/t9hJ5k78NfT0K/dWET8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 12/75] ALSA: firewire-motu: fix destruction of data for isochronous resources
Date:   Mon, 17 Jun 2019 23:09:23 +0200
Message-Id: <20190617210753.352669029@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210752.799453599@linuxfoundation.org>
References: <20190617210752.799453599@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 0e3fb6995bfabb23c172e8b883bf5ac57102678e upstream.

The data for isochronous resources is not destroyed in expected place.
This commit fixes the bug.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 9b2bb4f2f4a2 ("ALSA: firewire-motu: add stream management functionality")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/motu/motu-stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -345,7 +345,7 @@ static void destroy_stream(struct snd_mo
 	}
 
 	amdtp_stream_destroy(stream);
-	fw_iso_resources_free(resources);
+	fw_iso_resources_destroy(resources);
 }
 
 int snd_motu_stream_init_duplex(struct snd_motu *motu)


