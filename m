Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCEA2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901447;
	bh=RJIMLS9pgwQA69lo7Q1tJLEgZfLdzfGvZ5zM5lbTnuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZHkx6oV1q2lPjXsZZ5e2YkHkHvvRYC7s5yPlXaFEXzR3tkkMsaN7SOHWJmO8gEQzI
	 3POkB7GOJx7Qea+rQg14F6/zedwy8DcleMNlnuU1ELf61vXmZtq90W1bJtMk4gekap
	 c9i+8n3tSiQHVsugtRCK2w6eOJ8/5/Dw9WCG41dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfCRJap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbfCRJae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:30:34 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E392075C;
        Mon, 18 Mar 2019 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901433;
        bh=RJIMLS9pgwQA69lo7Q1tJLEgZfLdzfGvZ5zM5lbTnuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liQFQpQN5ddXY9vR+hLtV/ojEcOlmBswpPI9Bn09XLG9jKKYhUZAu154HGX7Hm8Xh
         V5U8RbDkJjSzlY6avrhuDNiDR17h1diWgyjybKb552G0ob8q8e8oeO7fJFKtFmMbLI
         tyaSwtGd7Xa9cZXromNAUInCgakNA8NEK+dy4aK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paul Menzel <pmenzel+alsa-devel@molgen.mpg.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 43/52] ALSA: hda: Extend i915 component bind timeout
Date:   Mon, 18 Mar 2019 10:25:30 +0100
Message-Id: <20190318083848.851660496@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


