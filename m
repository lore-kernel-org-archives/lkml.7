Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51569C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AC3217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901736;
	bh=iQf7QXMcYGyirz9ERm0ut/OhgOuuGocUCo/B+/ympFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=narlxIm/4FDtl2oSujUAe+iVvNZS5m60ZTf9TX158VNbVnnEZbZeGenriLGHJwBQL
	 /gJPXVmI8DVC2jJunAfVEMdtwsu1YTfS4YcMyHXDLm+hpH3+rdmlvF1dPAbvmmEu0L
	 t+qkfFCsO6P3ALKr5e42TJutQ6Jv9CGXzKxpye9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbfCRJfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387447AbfCRJfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:35:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E99DE2087C;
        Mon, 18 Mar 2019 09:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901731;
        bh=iQf7QXMcYGyirz9ERm0ut/OhgOuuGocUCo/B+/ympFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ynYqq8mtGprSmO+0EYZNz0jQ6p4Fvq28weFXB/pI5afYi7WoHUjYHU1M2UJVWaxDe
         +dk9oWS36DGngW1f60FGR7caJdFSvSB7hsyJraSEGQNjIiQ39xtcEWy7RSUGCPU0cU
         Qmc8srmsKOZjqCy3vPFuUp/FNbjmCHbKV50q/q1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Peter=20Sj=C3=B6berg?= <autopeter@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 30/34] ALSA: firewire-motu: fix construction of PCM frame for capture direction
Date:   Mon, 18 Mar 2019 10:25:54 +0100
Message-Id: <20190318084149.097681097@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
References: <20190318084144.657740413@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit f97a0944a72b26a2bece72516294e112a890f98a upstream.

In data blocks of common isochronous packet for MOTU devices, PCM
frames are multiplexed in a shape of '24 bit * 4 Audio Pack', described
in IEC 61883-6. The frames are not aligned to quadlet.

For capture PCM substream, ALSA firewire-motu driver constructs PCM
frames by reading data blocks byte-by-byte. However this operation
includes bug for lower byte of the PCM sample. This brings invalid
content of the PCM samples.

This commit fixes the bug.

Reported-by: Peter Sjöberg <autopeter@gmail.com>
Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 4641c9394010 ("ALSA: firewire-motu: add MOTU specific protocol layer")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/motu/amdtp-motu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -136,7 +136,9 @@ static void read_pcm_s32(struct amdtp_st
 		byte = (u8 *)buffer + p->pcm_byte_offset;
 
 		for (c = 0; c < channels; ++c) {
-			*dst = (byte[0] << 24) | (byte[1] << 16) | byte[2];
+			*dst = (byte[0] << 24) |
+			       (byte[1] << 16) |
+			       (byte[2] << 8);
 			byte += 3;
 			dst++;
 		}


