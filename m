Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19F6C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98511206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380196;
	bh=P7jsQZzraoazkhJaduXNW6gku7OXXwlFf3f1jFYb+9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C1ev3+UtZ+8L6i/rLIVcftf+yNhkfAX7DEPococzmCdUJaC0eR8h0QI1NhoCGsjTm
	 g8UjCNCEfQLfXo+odqg5o0UcwkJ1MNsj0l4SXX8HpFxZlEQUQxe5fuOgAsasLnAVuh
	 l/JGm4Kuz/+NcqpUDdt9ajmNOEvl03Uj/FsvZ6uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbfIMNJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388579AbfIMNJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:09:54 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA1BB206BB;
        Fri, 13 Sep 2019 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380193;
        bh=P7jsQZzraoazkhJaduXNW6gku7OXXwlFf3f1jFYb+9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjISDUGjV/eX5WMZs0h8I29ma06BESD+NMRwfLTtkXIotD7nErZfma3aTkUqQAADe
         xx6Hs8o9THqHo36WFdBl8YRrpLoDhVb0xdXoWU/qvKlwaLpefJsCB6f3M+9W+9d29I
         o3evgV7mF6/N4+I12h2lQh1GPtFd4UoAzjmJJHUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 01/21] ALSA: hda - Fix potential endless loop at applying quirks
Date:   Fri, 13 Sep 2019 14:06:54 +0100
Message-Id: <20190913130502.425859767@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130501.285837292@linuxfoundation.org>
References: <20190913130501.285837292@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 333f31436d3db19f4286f8862a00ea1d8d8420a1 upstream.

Since the chained quirks via chained_before flag is applied before the
depth check, it may lead to the endless recursive calls, when the
chain were set up incorrectly.  Fix it by moving the depth check at
the beginning of the loop.

Fixes: 1f57825077dc ("ALSA: hda - Add chained_before flag to the fixup entry")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_auto_parser.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -828,6 +828,8 @@ static void apply_fixup(struct hda_codec
 	while (id >= 0) {
 		const struct hda_fixup *fix = codec->fixup_list + id;
 
+		if (++depth > 10)
+			break;
 		if (fix->chained_before)
 			apply_fixup(codec, fix->chain_id, action, depth + 1);
 
@@ -867,8 +869,6 @@ static void apply_fixup(struct hda_codec
 		}
 		if (!fix->chained || fix->chained_before)
 			break;
-		if (++depth > 10)
-			break;
 		id = fix->chain_id;
 	}
 }


