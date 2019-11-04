Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6C5CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46374204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572906532;
	bh=v0IrQyRi9n+bfhh9+5Fe2BJGlZxsDr2cCWzbbt2oXfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F86/8JdYPq5BobdqNHKTFZY3iI9JwxF9eNGp2MqRIR2ByOEpDYmNYbKOaky30b1cG
	 IixKHzGtR1fODPc674o+NyvQZZMPDEzZ8Qfohb2xT24O9ZPpLueG+kB03pqNvqCCsa
	 ynh71PBo9PemcFSoBUX0KHJLtW8jM7FdLh8hJsgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbfKDW2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:28:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729968AbfKDVsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:48:33 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECDB020B7C;
        Mon,  4 Nov 2019 21:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904113;
        bh=v0IrQyRi9n+bfhh9+5Fe2BJGlZxsDr2cCWzbbt2oXfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bi5lUsitl4EWPmRj9xYuadr0X1yueiJ8Sje8AH7w96q20cp9/Osrje2gv/aiTpx3M
         YI9bwEmfI+Ze2ygzTTtLrQa2bveSwOUMPThtnYNzQiwjABmn+kWxEPxxTsS1SIzIFy
         6d39lRR/JqvdoOHG3yMW9ZkHkqEK2cSX3O3MODnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 27/46] ALSA: bebob: Fix prototype of helper function to return negative value
Date:   Mon,  4 Nov 2019 22:44:58 +0100
Message-Id: <20191104211859.776154553@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211830.912265604@linuxfoundation.org>
References: <20191104211830.912265604@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit f2bbdbcb075f3977a53da3bdcb7cd460bc8ae5f2 upstream.

A helper function of ALSA bebob driver returns negative value in a
function which has a prototype to return unsigned value.

This commit fixes it by changing the prototype.

Fixes: eb7b3a056cd8 ("ALSA: bebob: Add commands and connections/streams management")
Cc: <stable@vger.kernel.org> # v3.16+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20191026030620.12077-1-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/bebob/bebob_stream.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -253,8 +253,7 @@ end:
 	return err;
 }
 
-static unsigned int
-map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
+static int map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
 {
 	unsigned int sec, sections, ch, channels;
 	unsigned int pcm, midi, location;


