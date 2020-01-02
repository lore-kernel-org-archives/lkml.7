Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBA4C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386E8222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004486;
	bh=iPj0zluIWzyqWRoO57oi2l4TB1Hqdaa8CAffhmRVyYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17k/ySmpLtuHjjiER+9Ho1Vctid3O8NCILTaT+VcCQlwDEyg6mMd5f+bp9cI+qEnm
	 O12lPspX4e50mSWFl+teCJu0VWQjnPYH9I14svmR42m2LRlXnekuJNO1qkgKuGnbRf
	 LmIRnAAPcui6VhaeIYac2H8+X/c7fAKaCwSUB2sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgABWeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:34:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbgABWek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:34:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E37FD222C3;
        Thu,  2 Jan 2020 22:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004480;
        bh=iPj0zluIWzyqWRoO57oi2l4TB1Hqdaa8CAffhmRVyYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1LsM/EpNxU6oLoddAAYHEzBfAHf4QbGhz7XJCD4yRWji8phJnZrE364WLqQxKLULk
         Rqqe3iJJEbwFZ0OSQHFv5qaXL+lwryyHu50TDY+JMVhh609EfmgNimImurK3xDIOZ2
         LTCAgWMlaYgFvOrZ8zxv29INUtf25fJION0WW3ls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 004/137] ALSA: hda/ca0132 - Avoid endless loop
Date:   Thu,  2 Jan 2020 23:06:17 +0100
Message-Id: <20200102220547.179018042@linuxfoundation.org>
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

commit cb04fc3b6b076f67d228a0b7d096c69ad486c09c upstream.

Introduce a timeout to dspio_clear_response_queue() so that it won't
be caught in an endless loop even if the hardware doesn't respond
properly.

Fixes: a73d511c4867 ("ALSA: hda/ca0132: Add unsol handler for DSP and jack detection")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191213085111.22855-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1300,13 +1300,14 @@ struct scp_msg {
 
 static void dspio_clear_response_queue(struct hda_codec *codec)
 {
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 	unsigned int dummy = 0;
-	int status = -1;
+	int status;
 
 	/* clear all from the response queue */
 	do {
 		status = dspio_read(codec, &dummy);
-	} while (status == 0);
+	} while (status == 0 && time_before(jiffies, timeout));
 }
 
 static int dspio_get_response_data(struct hda_codec *codec)


