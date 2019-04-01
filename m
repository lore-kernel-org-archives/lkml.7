Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5BAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9104021939
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138398;
	bh=2sh/CqQ2/wXr4znOSU30+jaanCKqNvvlnLWvi0pZ708=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x2qqOHe5Wq2nVVcWFmaa111sCp72vGt+HmmTpGsbs3egDQq1cbmvUeio8K+3wSe1H
	 MAwBjo7AGNoe4KTHB4j25/pQvyROSlEs8T4syxX+F78+5kM1rJSGQJ3EU5VcEyQLPd
	 er2MUdpl0ILgBnGnOimG3RIYURExRZltG/KrBLQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfDARGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbfDARGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:06:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D01AA21925;
        Mon,  1 Apr 2019 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138394;
        bh=2sh/CqQ2/wXr4znOSU30+jaanCKqNvvlnLWvi0pZ708=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIIgaaSZzwOHeXY0cAYu2r8vUWrBDtMRubbQ9UdTGuQoRrXxwjOH14d2EaOx9fR+g
         qlFlIH5/y/TNSfvbGpm7ydSvfb7Z3GPjbTj5jEvS99gcu+HZ1J11O4CQo9Ba2OgJga
         9bukcWUBnbMcglZFwkoMu2BTlr5wB2awnSUWsQyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 054/146] ALSA: rawmidi: Fix potential Spectre v1 vulnerability
Date:   Mon,  1 Apr 2019 19:01:06 +0200
Message-Id: <20190401170053.196644960@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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


