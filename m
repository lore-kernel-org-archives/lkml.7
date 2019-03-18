Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB3FC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E482175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901273;
	bh=+CjhHb8SQhX+plNQVuO3dTQxUS+wXRh32UDx0Y7hVOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6I7uobeLcupz8ssHy6Jbv96RhpnGONZg8eNyBq6aVD7tybMEL0pGS8GFKEbCqmFl
	 c1BgCrzftT1bt8BUbbvBIwdKVyVgSQ9KxXbUWX0acjWwvUIsi5YttOz3WvJwGf588t
	 r2EfVl5DIM4qIepDzPEZCPW3Ar3VD+9YdikvCV4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfCRJ1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbfCRJ1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:46 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B80D214D8;
        Mon, 18 Mar 2019 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901266;
        bh=+CjhHb8SQhX+plNQVuO3dTQxUS+wXRh32UDx0Y7hVOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qO7WNshogJdPf9/ZCXl4GT3W5uPchz6Y/+TKPLKW/Yxp025QJnXJr9CKbtfITRz3i
         +Owo1Um1S4twZuVyf1WA8YnY+VEen2UZC4QrruMeOEhn9dUKv+DCAKBBJH2mFA6n8H
         L3Dx+DcMs19JEaBey5+UKCgT3c6f8ZHELeVMrJ4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Menzel <pmenzel+alsa-devel@molgen.mpg.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 35/43] ALSA: hda: Extend i915 component bind timeout
Date:   Mon, 18 Mar 2019 10:24:27 +0100
Message-Id: <20190318083716.902789445@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit cfc35f9c128cea8fce6a5513b1de50d36f3b209f upstream.

I set 10 seconds for the timeout of the i915 audio component binding
with a hope that recent machines are fast enough to handle all probe
tasks in that period, but I was too optimistic.  The binding may take
longer than that, and this caused a problem on the machine with both
audio and graphics driver modules loaded in parallel, as Paul Menzel
experienced.  This problem haven't hit so often just because the KMS
driver is loaded in initrd on most machines.

As a simple workaround, extend the timeout to 60 seconds.

Fixes: f9b54e1961c7 ("ALSA: hda/i915: Allow delayed i915 audio component binding")
Reported-by: Paul Menzel <pmenzel+alsa-devel@molgen.mpg.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/hda/hdac_i915.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -144,9 +144,9 @@ int snd_hdac_i915_init(struct hdac_bus *
 		return -ENODEV;
 	if (!acomp->ops) {
 		request_module("i915");
-		/* 10s timeout */
+		/* 60s timeout */
 		wait_for_completion_timeout(&bind_complete,
-					    msecs_to_jiffies(10 * 1000));
+					    msecs_to_jiffies(60 * 1000));
 	}
 	if (!acomp->ops) {
 		dev_info(bus->dev, "couldn't bind with audio component\n");


