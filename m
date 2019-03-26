Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF16C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE6820856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbfCZHvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:51:10 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:49495 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCZHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:51:09 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 5CF9F3C013A;
        Tue, 26 Mar 2019 08:51:06 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m3kz7e6xXkoQ; Tue, 26 Mar 2019 08:50:59 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 695B33C02EC;
        Tue, 26 Mar 2019 08:50:34 +0100 (CET)
Received: from vmlxhi-087.adit-jv.com (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Tue, 26 Mar
 2019 08:50:34 +0100
From:   <twischer@de.adit-jv.com>
To:     <patch@alsa-project.org>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: [PATCH 09/10] ALSA: pcm: Add snd_pcm_ops for snd_pcm_link()
Date:   Tue, 26 Mar 2019 08:49:33 +0100
Message-ID: <1553586574-18608-5-git-send-email-twischer@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
 <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

snd_pcm_link() can be called by the user as long as the device is not
yet started. Therefore currently a driver which wants to iterate over
the linked substreams has to do this at the start trigger. But the start
trigger should not block for a long time. Therefore there is no callback
which can be used to iterate over the linked substreams without delaying
the start trigger.
This patch introduces a new callback function which will be called after
the linked substream list was updated by snd_pcm_link(). This callback
function is allowed to block for a longer time without interfering the
synchronized start up of linked substreams.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 include/sound/pcm.h     |  1 +
 sound/core/pcm_native.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 18bd8c3..a7e5dd2 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -90,6 +90,7 @@ struct snd_pcm_ops {
 			     unsigned long offset);
 	int (*mmap)(struct snd_pcm_substream *substream, struct vm_area_struct *vma);
 	int (*ack)(struct snd_pcm_substream *substream);
+	int (*link_changed)(struct snd_pcm_substream *substream);
 };
 
 /*
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index f731f90..57a8a66 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1981,6 +1981,27 @@ static bool is_pcm_file(struct file *file)
 /*
  * PCM link handling
  */
+/* Note: call with snd_pcm_link_rwsem locked */
+static int  snd_pcm_link_changed(struct snd_pcm_substream * const substream)
+{
+	struct snd_pcm_substream *s;
+
+	/* snd_pcm_link_rwsem is down whenever the link_list is changed.
+	 * Therefore this lock is sufficent for the iteration.
+	 */
+	snd_pcm_group_for_each_entry(s, substream) {
+		int err;
+
+		if (!s->ops->link_changed)
+			continue;
+		err = s->ops->link_changed(s);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 {
 	int res = 0;
@@ -2030,6 +2051,9 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	snd_pcm_group_assign(substream1, target_group);
 	snd_pcm_stream_unlock(substream1);
 	snd_pcm_group_unlock_irq(target_group, nonatomic);
+
+	if (res >= 0)
+		res = snd_pcm_link_changed(substream);
  _end:
 	up_write(&snd_pcm_link_rwsem);
  _nolock:
@@ -2076,6 +2100,11 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 	snd_pcm_group_unlock_irq(group, nonatomic);
 	if (do_free)
 		kfree(group);
+	if (res >= 0)
+		res = snd_pcm_link_changed(substream);
+	/* Also signal substream which was removed */
+	if (res >= 0 && substream->ops->link_changed)
+		res = substream->ops->link_changed(substream);
 
        _end:
 	up_write(&snd_pcm_link_rwsem);
-- 
2.7.4

