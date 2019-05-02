Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0E6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A3E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggtQCBfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfEBSNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:13:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45620 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfEBSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:13:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so4638005wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Rmr9swsP9mexZbGo2Ob3HCdnRpjtEiyM8vvaodXClP4=;
        b=ggtQCBfvcEGmgkThJofofXW6bdpldDkwpwYDmCiFeziCy1YJRJQPJtjZsGvnXJIj4X
         IFhm3ahc8Q39r0nM2vZAIPePMVWE15rMJsIXinOmeRlhqjM9JXBK4Zh61t8tZ6D9MV97
         1kIofdv1wFa05bBhDBP3za2NHPQ5CkvDWnduwkqqwzU69QrNVn9NV4Wa0WEIBO/3ml/9
         3QCemAMT5nuXU73LjNllkSqIcNMXXYJa/2aSVYZ1RaOTUoAL+2d9Nfl/2uRdEL1NQvC/
         iCSio36jpVIDcgqn9wlz/URPPoaYBqHa1sF+1CSb77gmdgYMRUfJN1BvaUssk+c+JjfG
         Er1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Rmr9swsP9mexZbGo2Ob3HCdnRpjtEiyM8vvaodXClP4=;
        b=PUix9NWYlpmG6Zti6fQmpCHWPD8hMdF6I1qEzbJ2V99hQYVPZvf7j57Co42ddMJQZt
         UE5fcl20Ubejkv55WvsyULxw+GuEHFwGMn94ZrbpuQG6hDgHD4Iaex5CGjiMaCh6fNzF
         WlR+IDApCZHZWiQGPB9hixaSYWsAD+/1RTLbb5+zAN0mSiIi9/dZL7MiUQ7rTCxtrRwr
         X4aSsFuhtHVyeLeXj1/+k5yAnxzL2u05VDxIzbc9V9Y+m+McY+jsEHPSUI95LHustTZo
         3AHOa9Uv1k2m3ms5K/g0NjDfJptvI2AavW+DqgnQrxm7K64XJ3Ds2WdpzZapmo3rAqyP
         TpYA==
X-Gm-Message-State: APjAAAXPVOgWc9aWqNI1suTYJi0wM9hpvlPtOawigSnNJpVxskE8t+2v
        Sns6GblJNJgpsjdBMb6bJ+U=
X-Google-Smtp-Source: APXvYqy8WVZHfflnbU0wUejzRScvp4aPuyhdyBaPwhvnCVvtrg8PLaStuGBe+tMC/8R2HcCk8pYotw==
X-Received: by 2002:adf:da51:: with SMTP id r17mr3945752wrl.118.1556820822652;
        Thu, 02 May 2019 11:13:42 -0700 (PDT)
Received: from localhost.localdomain (p5B3F672C.dip0.t-ipconnect.de. [91.63.103.44])
        by smtp.gmail.com with ESMTPSA id x14sm7812142wmj.3.2019.05.02.11.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 11:13:41 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: tlv320aic3x: Add support for high power analog output
Date:   Thu,  2 May 2019 20:13:32 +0200
Message-Id: <20190502181332.5503-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to output level control for the analog high power output
drivers HPOUT and HPCOM.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---

Notes:
    Changes in V3:
    -Fixed compilation error
    
    Changes in V2:
    - Removed power control as it is handled by DAPM
    - Added level control for left channel

 sound/soc/codecs/tlv320aic3x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 516d17cb2182..489a6d89d63d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -324,6 +324,9 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
  */
 static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
 
+/* HP/HPCOM volumes. From 0 to 9 dB in 1 dB steps */
+static DECLARE_TLV_DB_SCALE(hp_tlv, 0, 100, 0);
+
 static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Output */
 	SOC_DOUBLE_R_TLV("PCM Playback Volume",
@@ -419,6 +422,12 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Pop reduction */
 	SOC_ENUM("Output Driver Power-On time", aic3x_poweron_time_enum),
 	SOC_ENUM("Output Driver Ramp-up step", aic3x_rampup_step_enum),
+
+	/* Analog HPOUT, HPCOM output level controls */
+	SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL,
+			4, 9, 0, hp_tlv),
+	SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTRL,
+			4, 9, 0, hp_tlv),
 };
 
 /* For other than tlv320aic3104 */
-- 
2.17.1

