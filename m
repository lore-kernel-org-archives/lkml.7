Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CABC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E3D2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138916;
	bh=rwuz49IjaP+mQZNQyy8xdDAXeEaI4CkIizylPBb760w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Gpq6fWG6fltpCXjaSL4BaSW4cMw+fdllDbHtiBklzBewIfYaJwEDa5H1ymZS83rE
	 2Zpik23izpPTot1yxr4WiDpd/cgf++u5oozDCuprr8IgGNPQqN1RnzxC5C0sNeXt8L
	 uMK7PSTbdh/UN0LtZtvjOy2tXcXrsnC4pRbcBvsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfDARPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbfDARPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:15:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A93920856;
        Mon,  1 Apr 2019 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138912;
        bh=rwuz49IjaP+mQZNQyy8xdDAXeEaI4CkIizylPBb760w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgMitgKABq/neB2d9nXAv3zUP3zl2IZKZyJdUMnHy5YPaRLS9lAy/t1ESVjI87XRU
         +yBpqeBDobLUxaizNR8Yn/8yBvzdLwADcqRo+3CC1kat2Qe8L/DtL6uIoYB4h2SxkQ
         3EoQWXGXKWKY3rSNUmyW7eoopTQmuCnHoOotTQwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 057/134] ALSA: rawmidi: Fix potential Spectre v1 vulnerability
Date:   Mon,  1 Apr 2019 19:01:33 +0200
Message-Id: <20190401170049.967599412@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 2b1d9c8f87235f593826b9cf46ec10247741fff9 upstream.

info->stream is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/core/rawmidi.c:604 __snd_rawmidi_info_select() warn: potential spectre issue 'rmidi->streams' [r] (local cap)

Fix this by sanitizing info->stream before using it to index
rmidi->streams.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://lore.kernel.org/lkml/20180423164740.GY17484@dhcp22.suse.cz/

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/rawmidi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/nospec.h>
 #include <sound/rawmidi.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -601,6 +602,7 @@ static int __snd_rawmidi_info_select(str
 		return -ENXIO;
 	if (info->stream < 0 || info->stream > 1)
 		return -EINVAL;
+	info->stream = array_index_nospec(info->stream, 2);
 	pstr = &rmidi->streams[info->stream];
 	if (pstr->substream_count == 0)
 		return -ENOENT;


