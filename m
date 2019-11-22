Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F847C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E5320715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKVRyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:54:13 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:26900 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfKVRyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:54:13 -0500
IronPort-SDR: lyx0+ym+YXQrL0N7r44MK2b8kLmv2zOQdgxOdmycJaI3Ul9fFXm69XC5/mmH7CV6HL8/iPc7To
 /fRfHAR2dKNpt/TsBvn/bS0QV8tL1bT7sH7hIJ5JuNOzD+vqVgbMskvwH8zd8BkqdIcPExCjrS
 6+4vCYHi3YAXp77kBMv9TqQLsW6k2OA5VmuND9CmNDXd1PDD1w8z2ht2jQdvcxGSU4ccyDdNkU
 79M26AbRhdYy9O0SlMFp6J/xdGFmySk1TRRe6VAfgPMp1HctjR0VzR9OTL/At0nX5QgYpqH7WE
 w9I=
X-IronPort-AV: E=Sophos;i="5.69,230,1571731200"; 
   d="scan'208";a="43434819"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 22 Nov 2019 09:53:15 -0800
IronPort-SDR: 2gCvD/dQEOuAHYexa/Y5xnz/L+2hxKOQnlRoNmnKdX8n+7SX1wRjZJ9js11Z1yXmCbCUJJ1RO7
 h5rdzTNVMa/xLwc0d7woUuf4VqFyQHjfNugZF4wuQXkYhtucY5g+FWXorbGYYHDzSHtO4G47vj
 nycLJlCNZt1jGZ0GG8OqmLzg2T3xBIW950ppdf4xb4hfit5QrHrlchnmgsmjddr8WAYSt+kYhH
 FTl9vhrSXQHQHPH1pT0kYZSlVP7DHdtaTqSml6MFZwLienqXlrUhqD3QyEjOTaFSbOks6Pbfil
 8tw=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH 2/2] ALSA: aloop: Avoid unexpected timer event callback tasklets
Date:   Fri, 22 Nov 2019 11:52:18 -0600
Message-ID: <20191122175218.17187-2-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122175218.17187-1-andrew_gabbasov@mentor.com>
References: <20191122175218.17187-1-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-09.mgc.mentorg.com (139.181.222.9) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loopback_snd_timer_close_cable() function waits until all
scheduled tasklets are completed, but the timer is closed after that
and can generate more event callbacks, scheduling new tasklets,
that will not be synchronized with cable closing.
Move tasklet_kill() call to be executed after snd_timer_close()
call to avoid such case.

Fixes: 26c53379f98d ("ALSA: aloop: Support selection of snd_timer instead of jiffies")
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 6408932f5f72..0ebfbe70db00 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -302,15 +302,16 @@ static int loopback_snd_timer_close_cable(struct loopback_pcm *dpcm)
 	if (!cable->snd_timer.instance)
 		return 0;
 
-	/* wait till drain tasklet has finished if requested */
-	tasklet_kill(&cable->snd_timer.event_tasklet);
-
 	/* will only be called from free_cable() when other stream was
 	 * already closed. Other stream cannot be reopened as long as
 	 * loopback->cable_lock is locked. Therefore no need to lock
 	 * cable->lock;
 	 */
 	snd_timer_close(cable->snd_timer.instance);
+
+	/* wait till drain tasklet has finished if requested */
+	tasklet_kill(&cable->snd_timer.event_tasklet);
+
 	snd_timer_instance_free(cable->snd_timer.instance);
 	memset(&cable->snd_timer, 0, sizeof(cable->snd_timer));
 
-- 
2.21.0

