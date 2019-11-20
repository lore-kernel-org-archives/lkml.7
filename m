Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2469C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9586E206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfKTRvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:51:40 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:41430 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfKTRvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:51:40 -0500
IronPort-SDR: Wbjc88YuwB9sjhLjE0qODRi50l4gvtksjUBS/ZtR7hWucQePfpVOjJLo82xNyCScxyXwJ3Y7j9
 SkmYDEmKtkAdz2qVZqkUlEIGTaskBOhdeB2Ak1fvF9so+cZIe9qNzHbT+cc+CTQGVVNX2LSW1W
 OC3krEwOLTevOPzmqsREXvPn/WF+domN/cQsxIBsIVwJqMSr8yk5kFqNomcd/yU2OX0EQ6vdxY
 B6tsJzw7xnVGydaE9otGSf3RS9d/Y+MX5UXFgjmKzgU57VXdjU+fCRL+wue+9JE+TOxirjWT/8
 R8Q=
X-IronPort-AV: E=Sophos;i="5.69,222,1571731200"; 
   d="scan'208";a="43363013"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 20 Nov 2019 09:51:39 -0800
IronPort-SDR: feMpX7Cuy7dYFlszDMfkSaIqzvrwHGbFGGvhlhOdljrVdu0zfrVH9p43ALWMZZQmCGsJJNjDNs
 KFZ2s7RsoBXS1tLaJb6vcwGUeeYCvLLdb1vUPEYMJcuMDb+oivOwM7U9R8UPyIvxglgZE0RQVv
 5JxJ7PuhpQeveflcilQTxCyZp+ZfvP/S7hIef7TFSiXxbdGqeKIAdqwL1wNgkGhUk1bUFRRPd4
 LUHmcxS4a7/BJhljCao1ASsk0HIdmoR6hep8bj70Rtov4hSjoZC1wMWb3SD+ACcpD+lIQgUZOU
 v+M=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v5 7/7] ALSA: aloop: Support runtime change of snd_timer via info interface
Date:   Wed, 20 Nov 2019 11:49:55 -0600
Message-ID: <20191120174955.6410-8-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120174955.6410-7-andrew_gabbasov@mentor.com>
References: <20191120174955.6410-1-andrew_gabbasov@mentor.com>
 <20191120174955.6410-2-andrew_gabbasov@mentor.com>
 <20191120174955.6410-3-andrew_gabbasov@mentor.com>
 <20191120174955.6410-4-andrew_gabbasov@mentor.com>
 <20191120174955.6410-5-andrew_gabbasov@mentor.com>
 <20191120174955.6410-6-andrew_gabbasov@mentor.com>
 <20191120174955.6410-7-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show and change sound card timer source with read-write info
file in proc filesystem. Initial string can still be set as
module parameter.

The timer source string value can be changed at any time,
but it is latched by PCM substream open callback (the first one
for a particular cable). At this point it is actually used, that
is the string is parsed, and the timer is looked up and opened.

The timer source is set for a loopback card (the same as initial
setting by module parameter), but every cable uses the value,
current at the moment of open.

Setting the value to empty string switches the timer to jiffies.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index e8a85f887222..1408403f727a 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1666,7 +1666,7 @@ static void print_cable_info(struct snd_info_entry *entry,
 	mutex_unlock(&loopback->cable_lock);
 }
 
-static int loopback_proc_new(struct loopback *loopback, int cidx)
+static int loopback_cable_proc_new(struct loopback *loopback, int cidx)
 {
 	char name[32];
 
@@ -1687,6 +1687,36 @@ static void loopback_set_timer_source(struct loopback *loopback,
 						      value, GFP_KERNEL);
 }
 
+static void print_timer_source_info(struct snd_info_entry *entry,
+				    struct snd_info_buffer *buffer)
+{
+	struct loopback *loopback = entry->private_data;
+
+	mutex_lock(&loopback->cable_lock);
+	snd_iprintf(buffer, "%s\n",
+		    loopback->timer_source ? loopback->timer_source : "");
+	mutex_unlock(&loopback->cable_lock);
+}
+
+static void change_timer_source_info(struct snd_info_entry *entry,
+				     struct snd_info_buffer *buffer)
+{
+	struct loopback *loopback = entry->private_data;
+	char line[64];
+
+	mutex_lock(&loopback->cable_lock);
+	if (!snd_info_get_line(buffer, line, sizeof(line)))
+		loopback_set_timer_source(loopback, strim(line));
+	mutex_unlock(&loopback->cable_lock);
+}
+
+static int loopback_timer_source_proc_new(struct loopback *loopback)
+{
+	return snd_card_rw_proc_new(loopback->card, "timer_source", loopback,
+				    print_timer_source_info,
+				    change_timer_source_info);
+}
+
 static int loopback_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
@@ -1719,8 +1749,9 @@ static int loopback_probe(struct platform_device *devptr)
 	err = loopback_mixer_new(loopback, pcm_notify[dev] ? 1 : 0);
 	if (err < 0)
 		goto __nodev;
-	loopback_proc_new(loopback, 0);
-	loopback_proc_new(loopback, 1);
+	loopback_cable_proc_new(loopback, 0);
+	loopback_cable_proc_new(loopback, 1);
+	loopback_timer_source_proc_new(loopback);
 	strcpy(card->driver, "Loopback");
 	strcpy(card->shortname, "Loopback");
 	sprintf(card->longname, "Loopback %i", dev + 1);
-- 
2.21.0

