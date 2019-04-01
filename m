Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64DB20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140111;
	bh=YFzDX4g1YLadfTz40ZqaBTeeD0Fl18NddYg30awzy9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UoQGGlgpQ1h21tQJFu5mzttsBu2FlJ6pILmFwKaX2no4aQXrUFhxEI2zI1CRzLjFA
	 O4XHMHOcWKnEGS5aK7dFkYXGxWimWddudaLC4O2uoHaChcAS7vB16vv6QK6RqyuZOY
	 LdGRux826WAH8WDJYfALHwmyme6g+JYv0Qx+Ix/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfDARfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387654AbfDARfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0187C20896;
        Mon,  1 Apr 2019 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140104;
        bh=YFzDX4g1YLadfTz40ZqaBTeeD0Fl18NddYg30awzy9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0uTZLaM55vuxn3BKX4mXi5JdJYAjNzmJ47jg5e+QiFPIiqnBilywYmoYxr22rjWU
         3bzurI1+xJcKyfB3x8cxww1BS3XNCet+6hM4rX2PGVqzOjq42+nu1ihO6dN/R28GjA
         t/Pc3ZTLx2anFPIHdLTpUY4OLVXFmGKjjc99AsZM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 4.4 107/131] ALSA: pcm: Dont suspend stream in unrecoverable PCM state
Date:   Mon,  1 Apr 2019 19:02:57 +0200
Message-Id: <20190401170100.724860365@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 113ce08109f8e3b091399e7cc32486df1cff48e7 upstream.

Currently PCM core sets each opened stream forcibly to SUSPENDED state
via snd_pcm_suspend_all() call, and the user-space is responsible for
re-triggering the resume manually either via snd_pcm_resume() or
prepare call.  The scheme works fine usually, but there are corner
cases where the stream can't be resumed by that call: the streams
still in OPEN state before finishing hw_params.  When they are
suspended, user-space cannot perform resume or prepare because they
haven't been set up yet.  The only possible recovery is to re-open the
device, which isn't nice at all.  Similarly, when a stream is in
DISCONNECTED state, it makes no sense to change it to SUSPENDED
state.  Ditto for in SETUP state; which you can re-prepare directly.

So, this patch addresses these issues by filtering the PCM streams to
be suspended by checking the PCM state.  When a stream is in either
OPEN, SETUP or DISCONNECTED as well as already SUSPENDED, the suspend
action is skipped.

To be noted, this problem was originally reported for the PCM runtime
PM on HD-audio.  And, the runtime PM problem itself was already
addressed (although not intended) by the code refactoring commits
3d21ef0b49f8 ("ALSA: pcm: Suspend streams globally via device type PM
ops") and 17bc4815de58 ("ALSA: pci: Remove superfluous
snd_pcm_suspend*() calls").  These commits eliminated the
snd_pcm_suspend*() calls from the runtime PM suspend callback code
path, hence the racy OPEN state won't appear while runtime PM.
(FWIW, the race window is between snd_pcm_open_substream() and the
first power up in azx_pcm_open().)

Although the runtime PM issue was already "fixed", the same problem is
still present for the system PM, hence this patch is still needed.
And for stable trees, this patch alone should suffice for fixing the
runtime PM problem, too.

Reported-and-tested-by: Jon Hunter <jonathanh@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_native.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1254,8 +1254,15 @@ static int snd_pcm_pause(struct snd_pcm_
 static int snd_pcm_pre_suspend(struct snd_pcm_substream *substream, int state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	if (runtime->status->state == SNDRV_PCM_STATE_SUSPENDED)
+	switch (runtime->status->state) {
+	case SNDRV_PCM_STATE_SUSPENDED:
 		return -EBUSY;
+	/* unresumable PCM state; return -EBUSY for skipping suspend */
+	case SNDRV_PCM_STATE_OPEN:
+	case SNDRV_PCM_STATE_SETUP:
+	case SNDRV_PCM_STATE_DISCONNECTED:
+		return -EBUSY;
+	}
 	runtime->trigger_master = substream;
 	return 0;
 }


