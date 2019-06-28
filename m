Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA8DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DAD208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMOoigyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfF1Cuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:50:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46335 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF1Cux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:50:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so2176516pfy.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F0GZtLBtco0OGsuekl6L6Sm8t8dj7LSLjNvFPb4po3A=;
        b=OMOoigySa27Ebqls8JGEjkQYipYUPgnN24ja9hC3JvuTlSLBCj2VmHwcPLIfIlyMNW
         i+FPVcvo62rXh1Rt7hZB0wkhv9qZvAy401spXeCyXD5VxMLlSAxweBLHcW/tWlh2lC5G
         rMcZJfaQJu/ss3l80QiYdC8Nu7Iv534Lf6RP0D8lghj3QcjyIjwFtx3l2u+Y3PIPeNfu
         mWdbY0NQ24O2Vvx/HaTzAEesjRH0SHGGQ+dpSjIVsLPiX18fUCYpZ/NLmuEAbXRht5NT
         Tu5AC2UYvqzvAGqy6LoICuGiSu+CPFDli96AcaYLkkfowx6Jk5GTqLEIhHwmLbgTGk/v
         9Agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F0GZtLBtco0OGsuekl6L6Sm8t8dj7LSLjNvFPb4po3A=;
        b=ZxrvH7/qC64Xzu6EunkyAOI0b/Tsbbd466/i7NPo2IgI+eHlXlKlCayY4ZxXzysjET
         VAlLapautpX0cTqlvlqK6OtnGWT9a6spdrpXTBQe/cB7heauYTmOA5tvFmhjehiOcEtX
         Al3bugLSoeC3vd2aRWNZbVpdhcUuFVdBDsOibXxcwZADQuyCznD/Irat50C5VpiM+PUT
         Gd31N4HVwu/fJ+POUZcFfLdMSrSEqEyJARIoqz5v+PazBZMokV7rjBpdtytTh66hFcCf
         I0v0sgevdRDKFGZhMKsOPu4QdFwcgn/MwxiOngnpbOrZrOyCJKrXykbhQvj/ShmqSWrY
         tqRw==
X-Gm-Message-State: APjAAAXxA4qs1a1K+LSBZBgJ8dUvT8enTblfbiQcHRp5WISh6eG+ErBG
        DLuoBx46F0Bxc9bCNnPm9y5H1MSLkfbtXw==
X-Google-Smtp-Source: APXvYqznY1Wol2rASo8YS+K58U5LNR/loQAj+GVGr9S3nFp22CPoBautxWfldQrpAGZkreJ8HHSjzw==
X-Received: by 2002:a63:4d4a:: with SMTP id n10mr6804907pgl.396.1561690253101;
        Thu, 27 Jun 2019 19:50:53 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id bo20sm513338pjb.23.2019.06.27.19.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:50:52 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/27] sound: oss: use kzalloc rather than kmalloc with memset
Date:   Fri, 28 Jun 2019 10:50:43 +0800
Message-Id: <20190628025044.16187-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use zeroing allocator instead of using allocator followed
with memset with 0.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/core/seq/oss/seq_oss_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index 6dc94efc19c9..6e8020d4368a 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -66,7 +66,7 @@ snd_seq_oss_create_client(void)
 	struct snd_seq_port_info *port;
 	struct snd_seq_port_callback port_callback;
 
-	port = kmalloc(sizeof(*port), GFP_KERNEL);
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port) {
 		rc = -ENOMEM;
 		goto __error;
@@ -81,7 +81,6 @@ snd_seq_oss_create_client(void)
 	system_client = rc;
 
 	/* create annoucement receiver port */
-	memset(port, 0, sizeof(*port));
 	strcpy(port->name, "Receiver");
 	port->addr.client = system_client;
 	port->capability = SNDRV_SEQ_PORT_CAP_WRITE; /* receive only */
-- 
2.11.0

