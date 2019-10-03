Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD72C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675D6215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118557;
	bh=XVOD64NLFfzI9rE1FouGmQQ3XmG0h12oUjaJb84NWGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zfN3tqsJ1TRJauBWC9Qg9X/s1+V4Oum0B2vwVqITZTsjpmn7f5Odsg/eP3kdfqE2b
	 pgoeX29b9bsI44uoGt++jg3q8LjLRS3rGLW1Cy/FJWjqFBgUh2sQwGNfIIEykBGkb2
	 /4U/J+pB49O+BHKFTFmEeYAU7qsoXvsszl0YgO+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfJCQCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731994AbfJCQC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:02:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B2A21848;
        Thu,  3 Oct 2019 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118547;
        bh=XVOD64NLFfzI9rE1FouGmQQ3XmG0h12oUjaJb84NWGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tN44vM7HiJihMVjh4FR+lV6v75wJRb1pctHTLY5D9ffLHJCtVf+WZE4b6JeQ4k0bn
         a7pb6seXPWwIUjJQiGxS1R2B0vH1+NJYyLdZdMTDkzXQrrmMXkhcIpYt7N8q02ujPZ
         LVNOJkgBTF2Hx17hGVWKszhsw3CoWK0aYif2GnC0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 051/129] ALSA: hda - Show the fatal CORB/RIRB error more clearly
Date:   Thu,  3 Oct 2019 17:52:54 +0200
Message-Id: <20191003154339.930826620@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit dd65f7e19c6961ba6a69f7c925021b7a270cb950 ]

The last fallback of CORB/RIRB communication error recovery is to turn
on the single command mode, and this last resort usually means that
something is really screwed up.  Instead of a normal dev_err(), show
the error more clearly with dev_WARN() with the caller stack trace.

Also, show the bus-reset fallback also as an error, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_controller.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 85dbe2420248d..c5e82329348b3 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -866,10 +866,13 @@ static int azx_rirb_get_response(struct hdac_bus *bus, unsigned int addr,
 	 */
 	if (hbus->allow_bus_reset && !hbus->response_reset && !hbus->in_reset) {
 		hbus->response_reset = 1;
+		dev_err(chip->card->dev,
+			"No response from codec, resetting bus: last cmd=0x%08x\n",
+			bus->last_cmd[addr]);
 		return -EAGAIN; /* give a chance to retry */
 	}
 
-	dev_err(chip->card->dev,
+	dev_WARN(chip->card->dev,
 		"azx_get_response timeout, switching to single_cmd mode: last cmd=0x%08x\n",
 		bus->last_cmd[addr]);
 	chip->single_cmd = 1;
-- 
2.20.1



