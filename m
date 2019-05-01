Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C73C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA3721743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="JDPD1J3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfEAJEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 05:04:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44534 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfEAJEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:04:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id d14so5695996qkl.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qoj+Gg0Ie+V2P3vdKcUMBKk9Ht4HM0XQ72NvNmgC6k=;
        b=JDPD1J3+a4YeIuGvGMAoqmYEA5npUqAW61TV1IUuFuKdv8/Kfvk1fUxt3vUDSnR2AQ
         lCPhm0cdA04neXkMxUyLtixjjaqWLS4+xdvOG5cUx2dxILtHVmewYzAx9am6ZjivhAsS
         kmBVsuSjuHiSNeO12VGK3Y+Ce09Amgc9B1TvUh5Cze6+MsEso/x+PwclTAld53iPDcYa
         31TGfRdmMhBSURYdYPQL0sMzyXYFLkj64ldCMMuYRHcd6qd9KnRLN0ZmmvrvOaeqD1zi
         AVJPZ+b79EWruZo8sXiCDE4D8kkMhmdPA093YN8vjTKiMyQWPxoyBAjNiPjjWBkdltqw
         vv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qoj+Gg0Ie+V2P3vdKcUMBKk9Ht4HM0XQ72NvNmgC6k=;
        b=SHQjEDZnugp1lJ7vS+02s/KDXVw4vaMFhOzJjw9UHTH9Y9rqHLUNuQoV0JIoEepEba
         CKKVJ7A5uDqbHn8IeSuaQTm5SNCne0iFbTybvFH0Io7MIuS/xCWc/re/mpW5flNZNbvu
         Yhg3tLeQVUuui6CtEt483biGI6m3h+0saO87sEcYYJjQ20ipP080bv8+omO7TT93HHiV
         CxmrZtltETR/Ujcmuqoe/xIpkx6kYgHw6I1otuVgoH4jruUXzexFFs+uggVbkanCOWLP
         dJvB+MmfgatGDhZFTcYGvhIf27odVi6oOPmJyObGWYWbjz9a29zf/KNidt2l3D1iZKZG
         UceQ==
X-Gm-Message-State: APjAAAXrf3uc1mJcLQrrBMxyrnOBY2Ji1o43IhOiWFcwsxvh+bpzlJ5W
        ew/pHMXn7VCfu756KoZbIK6ljg==
X-Google-Smtp-Source: APXvYqwWtu0OPXTZRNoHqHJOZ0MQiw4981/F7mq00OKu19obOvhOzJapf2aq4cJqA7r6h4cQuXnLrQ==
X-Received: by 2002:a37:5a46:: with SMTP id o67mr53956614qkb.31.1556701474032;
        Wed, 01 May 2019 02:04:34 -0700 (PDT)
Received: from ts-system.timesys.com ([49.204.220.208])
        by smtp.gmail.com with ESMTPSA id l15sm11000984qti.12.2019.05.01.02.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 May 2019 02:04:33 -0700 (PDT)
From:   Logesh Kolandavel <logesh.kolandavel@timesys.com>
To:     support.opensource@diasemi.com
Cc:     Adam.Thomson.Opensource@diasemi.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        logesh.kolandavel@timesys.com
Subject: [PATCH v2] ASoC: da7213: fix DAI_CLK_EN register bit overwrite
Date:   Wed,  1 May 2019 14:34:24 +0530
Message-Id: <20190501090424.28861-1-logesh.kolandavel@timesys.com>
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
Changes in v2:
-Include the mask DA7213_DAI_BCLKS_PER_WCLK_MASK

 sound/soc/codecs/da7213.c | 5 ++++-
 sound/soc/codecs/da7213.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 92d006a5283e..425c11d63e49 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1305,7 +1305,10 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* By default only 64 BCLK per WCLK is supported */
 	dai_clk_mode |= DA7213_DAI_BCLKS_PER_WCLK_64;
 
-	snd_soc_component_write(component, DA7213_DAI_CLK_MODE, dai_clk_mode);
+	snd_soc_component_update_bits(component, DA7213_DAI_CLK_MODE,
+			    DA7213_DAI_BCLKS_PER_WCLK_MASK |
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

