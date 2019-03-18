Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7FE2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901269;
	bh=oUfwWQJySni3YE0w8BylLJMgp3fX8EVSttZyssWUo7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lcPs5hbW6fWdwFPiys+2UENTdsR+EIwjUZ7KN36sc2SskQAviFSbsRa67ZgwuLEOH
	 maqt4O+O9RhSpWKTurnqSYs4hFmlV7rkKNuYWxUytRQ861VbJgwRZbLqtc9gDFomEW
	 2qdTycag6sLu3Z0njaYAGe5CYYe0fXbdrNx3yXIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfCRJ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbfCRJ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:44 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE4EB2083D;
        Mon, 18 Mar 2019 09:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901263;
        bh=oUfwWQJySni3YE0w8BylLJMgp3fX8EVSttZyssWUo7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTuVjtnlBtmCkF0jT3zRu4VD+Go0dXMQB5ZXnAbOlOOiQEzfvsJe01dzAPl7wobdk
         mD23+7JOmRg5fs6lAQBlVsfYeJjVdA6NhUwceHcvolVBnS8ok3s4MzCI/eYp94wDWz
         GJurIxWhoKaW1OjhVk+Kb2lPeWFKBiWpKbF3lr5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Peter=20Sj=C3=B6berg?= <autopeter@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 34/43] ALSA: firewire-motu: fix construction of PCM frame for capture direction
Date:   Mon, 18 Mar 2019 10:24:26 +0100
Message-Id: <20190318083716.867888344@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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


