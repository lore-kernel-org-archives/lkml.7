Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A75BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069BA2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qG97ZO7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfCKUyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:54:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46383 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfCKUyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:54:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id v16so312948ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZEF3oKCVpObZ8A3c3Q5bQmTJpDHKDqfO0yTANqAzP1A=;
        b=qG97ZO7CCTF68kjtM0uuD1kyrtf60I+Rfynz/ksPXbwD/QjRMokJhzfwTcKvx1p919
         a14QFvrO3PspC2CY1E3HK+NgACqRfl8ZsxYZdXL+sGW+xZhrKRSGrjpVIYsdU3oC8h/+
         PmC4cXziKCRBVcC2qQ0GfyRQG5/wIE1MW3Qjj8MQqm/tDgu9oKkafyzyNVrRJKUyIFU5
         xM1BiYBLMkR7t+66PFo/iKsGuWeoPRpwkEXCihuiIemCrBW/1V+0NDTCl1NrcRdawegS
         PmrJL2csNqtJjxw3AtBY9hsUSB4SUkzB29Um0FooRGHStSZmhHRb4QHgaduYFJKI2xwC
         Fjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZEF3oKCVpObZ8A3c3Q5bQmTJpDHKDqfO0yTANqAzP1A=;
        b=JwlBMy2OMRovfMBNV1rw88LEWiOzbdBMIG3UFJ3PsiGQXAR/w9wXEhOlzPjKzBjl9s
         Pnp4dLOODkT88dd7LcbZqRXQwqtEPTCjkJFsPf3/SS/dGwYuRhiI3EAoAOe1ZNHTeFuo
         Nl10dmWg/ooyJ4XfA6akeRBVv8crEClFAJiAlwIvhX759r5xlOTx+faWp/OZ19TseJOm
         +/SEjaWHoszK5dBaednk28M1yIHF1UcWNVfdP7l0BOdkXBEXTMDIp7hawoTvUVqo96lY
         3xuRoawhMb99BlVZ514t4oX6Ev+qf0nAkVaBxqqS+YTeZ/If9oD2H9+0nhmRjM5B5MWZ
         6dwQ==
X-Gm-Message-State: APjAAAWXwLf9ATtN6Py33lhazvKl9dFbVuv/+BqAtWCjC3dOqhOGpo9Y
        ewGjSmVolwGb56grTbXNdBw=
X-Google-Smtp-Source: APXvYqxI7r3HJfUtSpj/wbI/Rdur1vde2Yr3KowM73Za4jbDHLAkimaDZjuDeP82l/TyoNA+9OhyFg==
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr17250936ljj.89.1552337654158;
        Mon, 11 Mar 2019 13:54:14 -0700 (PDT)
Received: from localhost.localdomain (89-68-132-187.dynamic.chello.pl. [89.68.132.187])
        by smtp.gmail.com with ESMTPSA id c1sm1246894lfk.79.2019.03.11.13.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 13:54:13 -0700 (PDT)
From:   Mariusz Ceier <mceier+kernel@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ravindra Lokhande <rlokhande@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mohan Kumar D <mkumard@nvidia.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Mariusz Ceier <mceier+kernel@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] sound/hda/hdac_stream: Avoid NULL pointer dereference
Date:   Mon, 11 Mar 2019 21:53:57 +0100
Message-Id: <20190311205357.7573-2-mceier+kernel@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190311205357.7573-1-mceier+kernel@gmail.com>
References: <20190311205357.7573-1-mceier+kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ca0132 codec, azx_dev->stream is NULL during firmware loading.
Calling snd_hdac_get_stream_stripe_ctl unconditionally causes NULL
pointer dereference in that function.

Signed-off-by: Mariusz Ceier <mceier+kernel@gmail.com>
---
 sound/hda/hdac_stream.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index f5dd288d1a7a..76e9b41fcea2 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -95,7 +95,10 @@ void snd_hdac_stream_start(struct hdac_stream *azx_dev, bool fresh_start)
 			      1 << azx_dev->index,
 			      1 << azx_dev->index);
 	/* set stripe control */
-	stripe_ctl = snd_hdac_get_stream_stripe_ctl(bus, azx_dev->substream);
+	if (azx_dev->substream)
+		stripe_ctl = snd_hdac_get_stream_stripe_ctl(bus, azx_dev->substream);
+	else
+		stripe_ctl = 0;
 	snd_hdac_stream_updateb(azx_dev, SD_CTL_3B, SD_CTL_STRIPE_MASK,
 				stripe_ctl);
 	/* set DMA start and interrupt mask */
-- 
2.21.0

