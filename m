Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F74C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D442190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKKLKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:10:05 -0500
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:30879 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:10:05 -0500
IronPort-SDR: 19wiJVNAPVTtyZTCu0W8IIB0vHKrqFzh/VYR1yfR1+Ja+U8To7J8FQ+P3G9izTvkePS8VMen6G
 WjlnvOFINbv6LSuSZIWaEUArFZ+XMGrLADhp5P0QUvnKo+3x4Yr5QP4Io1HDOrgKiHil8gQpv6
 Bi4DIUAAAtWJFWLavlgZ6hy5eOZYtO4doRNwphGacTVYFFBv5TNLtB1drPu3hem1sERTUErCID
 mm/FXAXFUxNzUxLTjGd8tuLrNmZKuq1SzUuAkaXTYaDIR+MbrLLlU7NlD9M+qwswJV4Qz5zaqi
 lxs=
X-IronPort-AV: E=Sophos;i="5.68,292,1569312000"; 
   d="scan'208";a="42981217"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 11 Nov 2019 03:10:04 -0800
IronPort-SDR: i5nuYU4PmjFemi4jFGKxgJ8k6bM8E2x1VCxSi3kJn+hQ3M4horDJCv6WX/JqWmawukx4De5s9K
 FUuP0TT/JIZ3kYj+Z8GmoUIcitoCgXh6oxNswWbUo410HGX2aeT65TsZWknHqF2/yriz5gPvsm
 9E8Tux54li/18A2Wb8lrzpUVJspnLB14/JDVaud40SAwitylW0jAuFwsVfUr3PkrhCfkA6r7ev
 dp6TDN8T/Il1WHsFp5C9kI/pJ/hscUVa3GN6zmLPX9G00/KkBLLwVBfiDdT9tzwDAREUSQX/MC
 NyA=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v3 7/7] ALSA: aloop: Support runtime change of snd_timer via info interface
Date:   Mon, 11 Nov 2019 05:08:46 -0600
Message-ID: <20191111110846.18223-8-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111110846.18223-7-andrew_gabbasov@mentor.com>
References: <20191111110846.18223-1-andrew_gabbasov@mentor.com>
 <20191111110846.18223-2-andrew_gabbasov@mentor.com>
 <20191111110846.18223-3-andrew_gabbasov@mentor.com>
 <20191111110846.18223-4-andrew_gabbasov@mentor.com>
 <20191111110846.18223-5-andrew_gabbasov@mentor.com>
 <20191111110846.18223-6-andrew_gabbasov@mentor.com>
 <20191111110846.18223-7-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-05.mgc.mentorg.com (139.181.222.5) To
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
 sound/drivers/aloop.c | 45 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 2f08038f8792..430ab757a4c4 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1667,7 +1667,7 @@ static void print_cable_info(struct snd_info_entry *entry,
 	mutex_unlock(&loopback->cable_lock);
 }
 
-static int loopback_proc_new(struct loopback *loopback, int cidx)
+static int loopback_cable_proc_new(struct loopback *loopback, int cidx)
 {
 	char name[32];
 
@@ -1688,6 +1688,44 @@ static void loopback_set_timer_source(struct loopback *loopback,
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
+	struct snd_info_entry *entry;
+	int err;
+
+	err = snd_card_proc_new(loopback->card, "timer_source", &entry);
+	if (err < 0)
+		return err;
+
+	snd_info_set_text_ops(entry, loopback, print_timer_source_info);
+	entry->mode |= S_IWUSR;
+	entry->c.text.write = change_timer_source_info;
+	return 0;
+}
+
 static int loopback_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
@@ -1720,8 +1758,9 @@ static int loopback_probe(struct platform_device *devptr)
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

