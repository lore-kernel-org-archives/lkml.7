Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48E3C3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8009522525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003998;
	bh=jAIf3CT/v5lg8WB6/KwtNml/dKqKx7WIzBVB3nUMhVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RmqG+H61LLsSXR8uXQebuobHi8OsoH/4d0cWY/1mAZQEtmXHrTfvS87pLFWg1jCWr
	 FUlQ4yxrFH2IHZDKYzh6gAZzxr09J8/rtHwj6GbhOmVNcKIkn1x354PtQbU1CpeYJq
	 r2FKkyTcWstUaSGZ3Jyv282SfFbfhs1vAQzR0vbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgABW0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:26:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:53886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbgABW0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:26:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B12D222C3;
        Thu,  2 Jan 2020 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003990;
        bh=jAIf3CT/v5lg8WB6/KwtNml/dKqKx7WIzBVB3nUMhVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0JczxWfZqkgu1tbRlr7yOpWITHMn5JMKTCQo9ciKe6/KuX7TTlLNTypmoq8KVkPk+
         sUDe++7Oj9dmIZTbIq2PZe+MkGAW7y8B/ifg45v2SXpWlFw4da2h9ey385uxuWKYSE
         Q4fQZyxDPiHgTbcFEaTOB4HYP9wy39NpLkc1f5ss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+b3028ac3933f5c466389@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 58/91] ALSA: hda - Downgrade error message for single-cmd fallback
Date:   Thu,  2 Jan 2020 23:07:40 +0100
Message-Id: <20200102220439.850142478@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
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
 sound/pci/hda/hda_controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 8fcb421193e0..fa261b27d858 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -883,7 +883,7 @@ static int azx_rirb_get_response(struct hdac_bus *bus, unsigned int addr,
 		return -EAGAIN; /* give a chance to retry */
 	}
 
-	dev_WARN(chip->card->dev,
+	dev_err(chip->card->dev,
 		"azx_get_response timeout, switching to single_cmd mode: last cmd=0x%08x\n",
 		bus->last_cmd[addr]);
 	chip->single_cmd = 1;
-- 
2.20.1



