Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6A4C73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A91220651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcSDpgWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfGJCbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:31:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40502 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJCbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:31:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so414012pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 19:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4cRP2WCZtummGCJmZjETlwBuipDUxE57gp0VCpL4ho0=;
        b=TcSDpgWZpw8sLhLS8hOEKXei4aNVrcM8KH61CL66GmWu2wgPFvVSi1uI0KpG/X5wx7
         U3/NtP/DhFikSl/ERcT7WzTpI5aoHCqbd5myNR8Lqz5jvDq4I3tPLttR77m+WWBI53+R
         8yIev1fHE3BiekEOcKVZVG0TKmytVuJFlSoSFRh/HvdVgEHk3NCAuIxVczM6S0shEyQ7
         4aZlPQDVNc6BSxjU1WKFcr54DcTQIU13U03lCUhpxuAkHl18SC1YRIcwceeVqWwyAJ+4
         P/tIyqBMyaX4otCiZMtZiPFWxHTr93pRnBMiin2SlBQeTPbbVs2efCYCtLRWHWjR8Dry
         hoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4cRP2WCZtummGCJmZjETlwBuipDUxE57gp0VCpL4ho0=;
        b=D0fIuFQPVp7Fjjj7VLMSp+7cHUnBQdKpxdBglcWwHuX0UKBS2rdJUIQCCVIxxcPktE
         ZiFbaooe71Zjtx9GaOu/XMRahaemkiNNf7cheQEouMuuq3HwnCv3ahUKxszZzZFkiplQ
         kIyN2UFa+g2oib1grWjDUnWAK+IkkfZ8c05oVG6XRTG5nUHKgxmUwDWk/sjRao0PvV9p
         5H/N1toJfTzBkOOzz2vyblmjmYJS1/cRWukHHI11olQM6UUYUVHI5dDN9lRHhGjgElzc
         WEoFG1VZ1ukOa2iaLT+kIfQCqovY0hu7gAtRkYkDiK1ZB09D0YTCi1Xy8jG8V/x4FKuO
         XLPQ==
X-Gm-Message-State: APjAAAVGbDAQLl8+mP9qy1LZ4VN6/Bl9IqLndNsN73k5QxuhRNGW0uQT
        YzydFYz0J0I8NpXJREdRntM=
X-Google-Smtp-Source: APXvYqzY/mS53Xz6A6fiZt/w7HVVhNTxk8ojhH/ywhjWnS0wRHa/saBxl3uWe++xDS6GzuH2JUorYg==
X-Received: by 2002:a17:90a:8c18:: with SMTP id a24mr3622949pjo.111.1562725864971;
        Tue, 09 Jul 2019 19:31:04 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id r7sm387790pfl.134.2019.07.09.19.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 19:31:04 -0700 (PDT)
Date:   Wed, 10 Jul 2019 08:00:59 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: pci: lx6464es: Remove unneeded variable err
Message-ID: <20190710023059.GA14204@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issue reported by coccicheck
sound/pci/lx6464es/lx6464es.c:256:5-8: Unneeded variable: "err". Return
"0" on line 258

We cannot change return value as its registered with snd_pcm_ops->close

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/pci/lx6464es/lx6464es.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 1771a6d..583ca73 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -253,9 +253,8 @@ static int lx_pcm_open(struct snd_pcm_substream *substream)
 
 static int lx_pcm_close(struct snd_pcm_substream *substream)
 {
-	int err = 0;
 	dev_dbg(substream->pcm->card->dev, "->lx_pcm_close\n");
-	return err;
+	return 0;
 }
 
 static snd_pcm_uframes_t lx_pcm_stream_pointer(struct snd_pcm_substream
-- 
2.7.4

