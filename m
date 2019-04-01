Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D74DC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364DE2063F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139634;
	bh=QNXv7/8RXSvK203CoLihJBZx9tTjGwjQJ8BAGbFnupk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uEn55w+f3XehORraMGOiDbRvror7H6Bu9PckcaAGdiw1HuKWssASJ/DjU2Xo15wyV
	 sul0+wZMud5sRyTABXaVWLxxY2M3Tv2YfdhxhL+uwoGqecCzE60wopfRm9gkMjUrxp
	 cAvY+GcjcOHPXDvfGaSnxBHlOpNZHMaGbsiaXzTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfDAR1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732188AbfDAR1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:27:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A433A20880;
        Mon,  1 Apr 2019 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139627;
        bh=QNXv7/8RXSvK203CoLihJBZx9tTjGwjQJ8BAGbFnupk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYYIcBRCYDpwszv1jkmZGVXRfgvwkCNIteGyznHJMjiM9U8JAFLcTe8fqkxv8AcTn
         dq+yZEmFq1qVI1VCd3y6Fh1bGfE6QNc33zMqYBbk57ilQeW9XzigV1ANOlQDTKaSXh
         vQmV6p8y2SMk9SMdP1RvGmcVhFA2BCdAjR7w+qOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 23/56] ALSA: rawmidi: Fix potential Spectre v1 vulnerability
Date:   Mon,  1 Apr 2019 19:02:39 +0200
Message-Id: <20190401170105.254898108@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -29,6 +29,7 @@
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/nospec.h>
 #include <sound/rawmidi.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -591,6 +592,7 @@ static int __snd_rawmidi_info_select(str
 		return -ENXIO;
 	if (info->stream < 0 || info->stream > 1)
 		return -EINVAL;
+	info->stream = array_index_nospec(info->stream, 2);
 	pstr = &rmidi->streams[info->stream];
 	if (pstr->substream_count == 0)
 		return -ENOENT;


