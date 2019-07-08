Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2949BC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED29D214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599398;
	bh=fYiUsu4wzAHAeLPGcXP9HexqGaEUj1/KrAmDgh4Lwl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W9UDLTZXlzJT8yM3X2KysZZztl714KtmMMPqIdskq6PW002EAHZAHJgGquwWsXXMH
	 BZGwDAGDey1DvUJw1IkuCJIiBuxEPzjPN8kh/ARyxurPYJsGNYsWMuOSXgHVnp76qR
	 r7NEC2drCCCIqKIM0zr9lj0HVrV3IAm2S4Oab2Zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbfGHPXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388144AbfGHPXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:23:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70E9B204EC;
        Mon,  8 Jul 2019 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599390;
        bh=fYiUsu4wzAHAeLPGcXP9HexqGaEUj1/KrAmDgh4Lwl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6+D6u10p2AjlOTDkJ4uvLK7ospfaHpUQM1NkpBYmpyr1uHqmPqgyKYfEt0RWnL9t
         aFeVj72zRZz4NBXXZqUwe2W5qwipSqAaovw0jmEBzhVyvbb7hcE6oqr7nG65Lngusp
         Ewfh9mi7Sandru0BsSMw1rTRPtZBJwSSDpmlPAfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 089/102] ALSA: firewire-lib/fireworks: fix miss detection of received MIDI messages
Date:   Mon,  8 Jul 2019 17:13:22 +0200
Message-Id: <20190708150531.071686088@linuxfoundation.org>
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

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 7fbd1753b64eafe21cf842348a40a691d0dee440 upstream.

In IEC 61883-6, 8 MIDI data streams are multiplexed into single
MIDI conformant data channel. The index of stream is calculated by
modulo 8 of the value of data block counter.

In fireworks, the value of data block counter in CIP header has a quirk
with firmware version v5.0.0, v5.7.3 and v5.8.0. This brings ALSA
IEC 61883-1/6 packet streaming engine to miss detection of MIDI
messages.

This commit fixes the miss detection to modify the value of data block
counter for the modulo calculation.

For maintainers, this bug exists since a commit 18f5ed365d3f ("ALSA:
fireworks/firewire-lib: add support for recent firmware quirk") in Linux
kernel v4.2. There're many changes since the commit.  This fix can be
backported to Linux kernel v4.4 or later. I tagged a base commit to the
backport for your convenience.

Besides, my work for Linux kernel v5.3 brings heavy code refactoring and
some structure members are renamed in 'sound/firewire/amdtp-stream.h'.
The content of this patch brings conflict when merging -rc tree with
this patch and the latest tree. I request maintainers to solve the
conflict to replace 'tx_first_dbc' with 'ctx_data.tx.first_dbc'.

Fixes: df075feefbd3 ("ALSA: firewire-lib: complete AM824 data block processing layer")
Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/amdtp-am824.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/amdtp-am824.c
+++ b/sound/firewire/amdtp-am824.c
@@ -388,7 +388,7 @@ static void read_midi_messages(struct am
 	u8 *b;
 
 	for (f = 0; f < frames; f++) {
-		port = (s->data_block_counter + f) % 8;
+		port = (8 - s->tx_first_dbc + s->data_block_counter + f) % 8;
 		b = (u8 *)&buffer[p->midi_position];
 
 		len = b[0] - 0x80;


