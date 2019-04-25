Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311E6C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF763214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="g7DsbdZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbfDYFuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:50:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46549 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfDYFuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:50:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id w26so16340668qto.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bes2O0Ix7dqgSxsVxUY8gAIpWunOoHLCqTDP5AHA/iQ=;
        b=g7DsbdZE1NezLukQkiFmKBO12Htp3NwcWLxh/z3qX/uoS2IVvANinEIKTSRV+H/poG
         BUOmyjJg6CwWM+iQzI3tmT1b+hZ1nyNa6Cn7bswcdsXitXaiHcZ/4HtswOkjRg8XL8bo
         qKio0c/Rt4JRO4hbh7CPq7jHdpPVXGwdm6lXGm0mzc5uQsEiX7qzQdhh1HMiyl6Td2LX
         tUVN/5gGQJ5GqxJli9TWb5sft94S1omjr+Kqi9G309zJ2TS8NmBaUPDyhCShRmdYBY8Y
         oErlh3p7kJw27BK+Z+hsDkPUIZ/53leoe/HdXdlaUDMcli2bqA2PugefnxTnZVcijaue
         G6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bes2O0Ix7dqgSxsVxUY8gAIpWunOoHLCqTDP5AHA/iQ=;
        b=QTLDY8NujjoXdR3MepQdwGO439ha5ZKtmC4gf/e5e9vWQGaQOkCeZZNauOB75ecuZe
         srVdFLBK4eKMfScogsgAcp7vfCIPYgT/klOFerwIrMXT0Li7Svs6rkfhIXLalUyX4gzi
         APE2XIqNP5XBa0CszuC1KH0kWciALNtsn5rN4I3w/WaIfKdXI6XNlJ4pWNRuhgSi6bwd
         T3RfG4kWqiqzXkfIDG908R0DjbstBmWuH3Cts2X0n2TuN6khxgNOE971K7JqaNBh+xKt
         i+YDLEcjVTUOVfVCv++gVt6ZsEPEbquqpXIbObd4WxS47kTgQX1MTn+BX/d3Y8y/klIX
         oAHA==
X-Gm-Message-State: APjAAAVARySNiJkqMXbMew07nueD6wkqG+KJ9mxr+alHVvLUhw4JbbcW
        Dwn52Z+j8s45E9N9Fid0ZU0Ong==
X-Google-Smtp-Source: APXvYqxE4GA2/GUJanrd9N9UADU+nT0R4wxYOlg12nupj6xQLNwcP5COcyCOxjZUaTgyo7TLB7b+0A==
X-Received: by 2002:a0c:add2:: with SMTP id x18mr28972986qvc.23.1556171399054;
        Wed, 24 Apr 2019 22:49:59 -0700 (PDT)
Received: from ts-system.timesys.com ([49.207.191.18])
        by smtp.gmail.com with ESMTPSA id w58sm9470720qtw.93.2019.04.24.22.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Apr 2019 22:49:58 -0700 (PDT)
From:   Logesh Kolandavel <logesh.kolandavel@timesys.com>
To:     support.opensource@diasemi.com
Cc:     Adam.Thomson.Opensource@diasemi.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        logesh.kolandavel@timesys.com
Subject: [PATCH] ASoC: da7213: fix DAI_CLK_EN register bit overwrite
Date:   Thu, 25 Apr 2019 11:12:49 +0530
Message-Id: <20190425054249.5675-1-logesh.kolandavel@timesys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Logesh <logesh.kolandavel@timesys.com>

If the da7213 codec is configured as Master with the DAPM power down
delay time set, 'snd_soc_component_write' function overwrites the
DAI_CLK_EN bit of DAI_CLK_MODE register which leads to audio play
only once until it re-initialize after codec power up.

Signed-off-by: Logesh <logesh.kolandavel@timesys.com>
---
 sound/soc/codecs/da7213.c | 4 +++-
 sound/soc/codecs/da7213.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 92d006a5283e..306e01684bda 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1305,7 +1305,9 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* By default only 64 BCLK per WCLK is supported */
 	dai_clk_mode |= DA7213_DAI_BCLKS_PER_WCLK_64;
 
-	snd_soc_component_write(component, DA7213_DAI_CLK_MODE, dai_clk_mode);
+	snd_soc_component_update_bits(component, DA7213_DAI_CLK_MODE,
+			    DA7213_DAI_CLK_POL_MASK | DA7213_DAI_WCLK_POL_MASK,
+			    dai_clk_mode);
 	snd_soc_component_update_bits(component, DA7213_DAI_CTRL, DA7213_DAI_FORMAT_MASK,
 			    dai_ctrl);
 	snd_soc_component_write(component, DA7213_DAI_OFFSET, dai_offset);
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 5a78dba1dcb5..9d31efc3cfe5 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -181,7 +181,9 @@
 #define DA7213_DAI_BCLKS_PER_WCLK_256				(0x3 << 0)
 #define DA7213_DAI_BCLKS_PER_WCLK_MASK				(0x3 << 0)
 #define DA7213_DAI_CLK_POL_INV					(0x1 << 2)
+#define DA7213_DAI_CLK_POL_MASK					(0x1 << 2)
 #define DA7213_DAI_WCLK_POL_INV					(0x1 << 3)
+#define DA7213_DAI_WCLK_POL_MASK				(0x1 << 3)
 #define DA7213_DAI_CLK_EN_MASK					(0x1 << 7)
 
 /* DA7213_DAI_CTRL = 0x29 */
-- 
2.21.0

