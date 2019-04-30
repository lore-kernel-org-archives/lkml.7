Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F814C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1939D2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDVy5cQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfD3UBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:01:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50447 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfD3UBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:01:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id p21so5155367wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=4+Rp/OQZEkVz9ANlwYNqq4aD6edbQOGd5WFLx5kOqMs=;
        b=tDVy5cQqzPNv4O+IQczPxWS8AJof0ww4LxOG56q4P/4pp6W3l3BV7S7P4YXwHuqjeK
         6s8V3jhQhCQEYMbLpbixd7IcKRQ3+cg8dH//bF/WwHQ2yA3ZXV34EI5r8lKbBnKPTeiV
         G0LPY7Q1kCjXnO1baUuB7vFOlGGI6iTQSSQi8BPLeQutEyqnlVvLCRfbGj7rn+rXW5mD
         n2pTlagvx5KF0AuoXrviCt7aEdu3haaD1XvndcJMY1H5+GxB5nzpuXwimm0xEi1OvUf/
         k8dryi45mKi8ECMiiVk2sGjLyxUUTmZ0Iu4YcnSJq3BRmSxqsPPNzFXdmgsfVKLnwa4L
         7vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=4+Rp/OQZEkVz9ANlwYNqq4aD6edbQOGd5WFLx5kOqMs=;
        b=CURjOhamSjn4fuO42zgQGKvtdcgndW363oUoQtWXC30Il3wvZBIWYrhz7GaIStn7G4
         HOUHHtDDW93ZMUXl9RMfvAUpxUO9ors/6QROuL7eksEcK729EEix5LmYDIkGJVvWyEzm
         1En62g8pjeUI7Ci2Hv58yQGhpOnsEgrEkz6+3n74h/2BjBwS/TxT2PnEUzjTnTmIj4B3
         OrS/T7IRO/J+J9o6Ws1LOYguEJsTuIqeh5/g/dIJa148HXQ7DlPDK+HuuDdOSBKmfm+s
         JFIBzK8oUvpQ71hFUVPIPfhDVPU9bDG3hRzJJEMtywBBdCMNCS33hb+hK/q79PuStabd
         1eYg==
X-Gm-Message-State: APjAAAWTMhNpfDo1Mg33Y8/uVqm665HwchOMgtRma1GMrzXrXuljqTFH
        v0TGOtBcIM9J2Ye9bBo3AN+DkCO7
X-Google-Smtp-Source: APXvYqxHhu8Rl0AyMaRtY0p7rIs+NQKfd5e/OKf/mSkRVbYYKjhAFwg3Kvzfcj/XMQvuRK5wEmj1xg==
X-Received: by 2002:a1c:f119:: with SMTP id p25mr4248002wmh.4.1556654489976;
        Tue, 30 Apr 2019 13:01:29 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6192.dip0.t-ipconnect.de. [91.63.97.146])
        by smtp.gmail.com with ESMTPSA id s124sm4020346wmf.42.2019.04.30.13.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 13:01:28 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: tlv320aic3x: Add support for high power analog output
Date:   Tue, 30 Apr 2019 22:01:18 +0200
Message-Id: <20190430200118.13014-1-sravanhome@gmail.com>
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
    Changes in V2:
    - Removed power control as it is handled by DAPM
    - Added level control for left channel

 sound/soc/codecs/tlv320aic3x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 516d17cb2182..90f53f9b5c2f 100644
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
+			4, 9, 0, hp_tlv);
+	SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTRL,
+			4, 9, 0, hp_tlv);
 };
 
 /* For other than tlv320aic3104 */
-- 
2.17.1

