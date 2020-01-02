Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F657C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A9F217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004603;
	bh=wQT4xWXNIzsEabQI1mSrwFFkt4xowQeeU7x6mRr+IQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ADmvwLa1+H1VhvAr3UYned09TkS4Tjlg8BJ34QANNpWMmop7sfmRDJntj5sZptlug
	 VVJgeQmQUlUoCPLzwQJyZdVzCes4OcE3UbMr1NEM6U6M+6laJpMNpRDq8966kI8f63
	 OPu7pAMZTdRsmNyNu45ucM/IfoSJ+PW5xj4KsmMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgABWgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:36:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730958AbgABWgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:36:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD8021D7D;
        Thu,  2 Jan 2020 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004595;
        bh=wQT4xWXNIzsEabQI1mSrwFFkt4xowQeeU7x6mRr+IQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UXkPWD9UMKSHZU8lvjIVrIAsY/SbyuRHmvYwvNbTYHEffX52Bf5ulUbss8Mrsv+by
         MF+o5fTQpjzMuqZ2xBqQVTYoDDfvcf0Uomj+z0twdacw5KQKdqOHmnEzDU203clMBo
         itUl/+NDWIf6PnEbhkYC+Z8GEW731BTWTjxQaQtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lionel Koenig <lionel.koenig@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 072/137] ALSA: pcm: Avoid possible info leaks from PCM stream buffers
Date:   Thu,  2 Jan 2020 23:07:25 +0100
Message-Id: <20200102220556.320922570@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit add9d56d7b3781532208afbff5509d7382fb6efe upstream.

The current PCM code doesn't initialize explicitly the buffers
allocated for PCM streams, hence it might leak some uninitialized
kernel data or previous stream contents by mmapping or reading the
buffer before actually starting the stream.

Since this is a common problem, this patch simply adds the clearance
of the buffer data at hw_params callback.  Although this does only
zero-clear no matter which format is used, which doesn't mean the
silence for some formats, but it should be OK because the intention is
just to clear the previous data on the buffer.

Reported-by: Lionel Koenig <lionel.koenig@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191211155742.3213-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_native.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -587,6 +587,10 @@ static int snd_pcm_hw_params(struct snd_
 	while (runtime->boundary * 2 <= LONG_MAX - runtime->buffer_size)
 		runtime->boundary *= 2;
 
+	/* clear the buffer for avoiding possible kernel info leaks */
+	if (runtime->dma_area)
+		memset(runtime->dma_area, 0, runtime->dma_bytes);
+
 	snd_pcm_timer_resolution_change(substream);
 	snd_pcm_set_state(substream, SNDRV_PCM_STATE_SETUP);
 


