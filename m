Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E477C17496
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28CF21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389819AbfKEOeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:34:50 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:53871 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389778AbfKEOeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:34:44 -0500
IronPort-SDR: rj8rzLwTwxJ1pbCyESwodYR1MGES4dwL/HqqEshRe4yjVPW44qBwANhXMYRFnpVFja8mspIjxr
 n+eNSv7iaDJVjLJvT+zeyqzOs77CahQKdN1GZ1IErs2knuaipuQr/cmxWYFeTrWAWZbBuVd4Ue
 56K9kEYt091AcYaxATKXKH2/ER+NrkdJ4ACMpJq8M146l3b+gHj978p2mkkH/XmjhXml+aMDvN
 Mj4d2b0Ogupw3zT/BCoYl/9eTklTrhAxeJSQRWB4iShq+/ND9CtgbJdqt2lEhdwNVH1Zruq0aj
 jfU=
X-IronPort-AV: E=Sophos;i="5.68,271,1569312000"; 
   d="scan'208";a="42878552"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 05 Nov 2019 06:34:43 -0800
IronPort-SDR: tcZgpC/pYlyvFflaFhrt2xaVVmdwpIyGNC28cR40IEDaNgeZcNKj4qd+wXAHt/PY/xppI+5Nxw
 vqatF4DztGGuX0IlfQuPrMLozaOGpLfHAl72b2dV9Wv0nRNpV1eae8fhSg3ttgj5laxMSA8Ljl
 FLQAmHh+iKpVa/95j2Wlqr1jSjSaFcM0awnw+T25ylv2R0lpKZJ5S+b392vB2PL4qhYgSudsQM
 w3iZulI7vbYcoiFr1KgyiE2RvW1ePzfqJoqtEdOXUvuSJQ9b5E+ddh/+ltbWYqS63Jgd2+opnU
 DGc=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v2 8/8] ALSA: aloop: Support runtime change of snd_timer via info interface
Date:   Tue, 5 Nov 2019 08:32:18 -0600
Message-ID: <20191105143218.5948-9-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105143218.5948-8-andrew_gabbasov@mentor.com>
References: <20191105143218.5948-1-andrew_gabbasov@mentor.com>
 <20191105143218.5948-2-andrew_gabbasov@mentor.com>
 <20191105143218.5948-3-andrew_gabbasov@mentor.com>
 <20191105143218.5948-4-andrew_gabbasov@mentor.com>
 <20191105143218.5948-5-andrew_gabbasov@mentor.com>
 <20191105143218.5948-6-andrew_gabbasov@mentor.com>
 <20191105143218.5948-7-andrew_gabbasov@mentor.com>
 <20191105143218.5948-8-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
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
 sound/drivers/aloop.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 6db70ebd46f6..16444a34d4b9 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1655,7 +1655,7 @@ static void print_cable_info(struct snd_info_entry *entry,
 	mutex_unlock(&loopback->cable_lock);
 }
 
-static int loopback_proc_new(struct loopback *loopback, int cidx)
+static int loopback_cable_proc_new(struct loopback *loopback, int cidx)
 {
 	char name[32];
 
@@ -1676,6 +1676,40 @@ static void loopback_set_timer_source(struct loopback *loopback,
 						      value, GFP_KERNEL);
 }
 
+static void print_timer_source_info(struct snd_info_entry *entry,
+				    struct snd_info_buffer *buffer)
+{
+	struct loopback *loopback = entry->private_data;
+
+	snd_iprintf(buffer, "%s\n",
+		    loopback->timer_source ? loopback->timer_source : "");
+}
+
+static void change_timer_source_info(struct snd_info_entry *entry,
+				     struct snd_info_buffer *buffer)
+{
+	struct loopback *loopback = entry->private_data;
+	char line[64];
+
+	if (!snd_info_get_line(buffer, line, sizeof(line)))
+		loopback_set_timer_source(loopback, strim(line));
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
@@ -1708,8 +1742,9 @@ static int loopback_probe(struct platform_device *devptr)
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

