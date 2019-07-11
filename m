Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B0EC74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F9220863
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh8bol5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfGKRVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:21:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46717 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKRVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:21:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id i8so3239700pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gqIivKQ4VDY/9EJ1sbwK6dLkOFlogSrMQDe9qqiMbzY=;
        b=Lh8bol5uLGKKTqXXXFbj8SySQvu9msm/TdCvjInq2ukTZqn6RGBCUjha/KUKBRGYls
         i6SPZzkfh3QlXjGM0stTHbhpmRbzZER0lgqUd2/c16m4cGpkJDH8aZls4CblfcQNcXzG
         LoAiNF1DZghDcr/hRzM1aXcAOXsDbHLwJ0H2MlDszfsXcsSXuBtuiGmjo+ACIZWElKGK
         uskBrAlSsozclJqt6ZBMxoTN6wj6b5i0KlZdmNhijH4wNwZ2f4M4AgYvXPm04CpnFx4n
         N65rrYxLXmfYOuHKxqWNXdOZDLT7sirf+iqxG8GfYZPC5lnvawYThxUaZxagNvqFOAjb
         ya0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gqIivKQ4VDY/9EJ1sbwK6dLkOFlogSrMQDe9qqiMbzY=;
        b=AefZPj6cl2Wj2Xjv4xU+/Hnc2sVO3zzD4DflHfsxQiKVD9TgMsqUHYwkQox8MOhhb/
         tNaO8Z7knb+tXkjCyOTiH8BFjkw1jEBDC+EL6gxuVzFpF3J+u1PaP+9Rx5+1ZeDxeW3y
         I7SxrSkhIGEhrGD/kQCQfj7h2XDZmwg1nMRvMkcSHW5PeeBX1EYCR2Z7xsa8F5QL/1jO
         cOMJUEh2by7Ju9IqjlEIepcppZlYVw3G2njPGYIHX04pIZwN3+NW2i/57WVHvUTYGsYB
         A5olu2bUQSIbA9MbwsePP0QjXxc6VRj5KfVzwiLwvB4V0KDrj3bWW8q8wcQ5fDKnU7dJ
         InxQ==
X-Gm-Message-State: APjAAAUBubvTKHrueYkFHPNj6UAFF6u6Yvo3OsC5rNhH9H7cT3I6NJPw
        VCyqk5xKeClRCtIg7Zp8KIA=
X-Google-Smtp-Source: APXvYqzPcdiAOvWKSNm+hzapTSSmXf8/fGwVdxN3iKtzUnxAXQ7T2pQR9v94JJeawAjbMGky8hIJ4A==
X-Received: by 2002:a17:90a:db08:: with SMTP id g8mr5893223pjv.39.1562865673539;
        Thu, 11 Jul 2019 10:21:13 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id t7sm5111414pjq.15.2019.07.11.10.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:21:13 -0700 (PDT)
Date:   Thu, 11 Jul 2019 22:51:07 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: pci: rme9652: Unneeded variable: "result".
Message-ID: <20190711172107.GA5008@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issue reported by coccicheck

sound/pci/rme9652/rme9652.c:2161:5-11: Unneeded variable: "result".
Return "0" on line 2167

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/pci/rme9652/rme9652.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index cb9818a..4c851f8 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -2158,13 +2158,12 @@ static int snd_rme9652_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
 	unsigned long flags;
-	int result = 0;
 
 	spin_lock_irqsave(&rme9652->lock, flags);
 	if (!rme9652->running)
 		rme9652_reset_hw_pointer(rme9652);
 	spin_unlock_irqrestore(&rme9652->lock, flags);
-	return result;
+	return 0;
 }
 
 static const struct snd_pcm_hardware snd_rme9652_playback_subinfo =
-- 
2.7.4

