Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1434DC0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A2720B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqWT4LSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfGEC5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:57:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39433 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGEC5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:57:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so3878544pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 19:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=69PbiH2nDR6ENHSGX1SX7mzvg/IBEPNGwMUur8Ydn8Y=;
        b=SqWT4LSERE8Un8SWCqBPl/lVC2TctRHJRA1BoSQhQc5vj+N/jt/q4KhEf46vCMxZk3
         V2gCn6rw1ZFYzREXuMI3pQIJO2pj0Gtxn/gaYGDp5uxhQHfUEpp2rfEq7R5uzFsPuC+z
         DHcAe8p5OcS5nbRZkEtbO6XOGTpo2/KPkIr0PGjiumUrEI8ZvaXXqn4cgRlAWBAOo6kW
         f5LsQpa1dPTVmIEwTxCA1fFRORx0oimeDAh4JH0HRjHD/kBF3YvCaukTg9u1mkTurrBK
         ekUnp0wg57nyKXmbNvF6cfZMzKbcyU5hv7Bn5bOgRosNcvTUnMeu0N1IBF7wWvwtQm5m
         E7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=69PbiH2nDR6ENHSGX1SX7mzvg/IBEPNGwMUur8Ydn8Y=;
        b=odwfVR3+Z8udJlwEXI4qAg2pGbPOf32GLLUfqTxVNhoPvMe7Ceyn1ejfirMaq3OeXD
         T0cEl5y6VxWTtSVx9lqSBusuBMjCQ0eZ5Okkq8Ob2S/EOcGqqPEdCAgZZE9VcnbeVLuf
         X2I8rpih/n2FC/NftStq7VwHL6TLIWujF4PS/dOIArf/0RVBX3q5lCZTpG7XKjWcvsZn
         lxVLpOQWB0cWwkNvlOoCYNQnRX46pzm/N63FC1kFlp0YA1rH4mV8PfSUAHDYZP8ojKTV
         E5odkALkU4qTHxXXb5DOpXNx2zxlJkrFCRuiT0xHjtY3papCaHjiHZEBMdmlDZMQhn4j
         idJA==
X-Gm-Message-State: APjAAAU7a4cJJ5srNsDSd/E0beul3yqJPH6BRqfS/RJZgAHQq/lEkvc+
        H08JIQJzNY5Uimu7A96w3Yw=
X-Google-Smtp-Source: APXvYqyd7c2Qd36MrpCqmvjc2EFmVYZhzaqZVpuSiaYh28oJzh0oZwYb7iFcyt+x1y2ppJ3DZSVrtA==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr1648503plb.299.1562295459717;
        Thu, 04 Jul 2019 19:57:39 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.81.29])
        by smtp.gmail.com with ESMTPSA id h14sm5944246pgn.51.2019.07.04.19.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 19:57:39 -0700 (PDT)
Date:   Fri, 5 Jul 2019 08:27:33 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Richard Fontana <rfontana@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: pci: asihpi: Remove unneeded variable change
Message-ID: <20190705025733.GA26285@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fixes below issue reported by coccicheck
sound/pci/asihpi/asihpi.c:1558:5-11: Unneeded variable: "change". Return
"1" on line 1564

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/pci/asihpi/asihpi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index e7234f3..2a21a3d 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1519,7 +1519,6 @@ static int snd_asihpi_volume_get(struct snd_kcontrol *kcontrol,
 static int snd_asihpi_volume_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	int change;
 	u32 h_control = kcontrol->private_value;
 	short an_gain_mB[HPI_MAX_CHANNELS];
 
@@ -1530,9 +1529,8 @@ static int snd_asihpi_volume_put(struct snd_kcontrol *kcontrol,
 	/*  change = asihpi->mixer_volume[addr][0] != left ||
 	   asihpi->mixer_volume[addr][1] != right;
 	 */
-	change = 1;
 	hpi_handle_error(hpi_volume_set_gain(h_control, an_gain_mB));
-	return change;
+	return 1;
 }
 
 static const DECLARE_TLV_DB_SCALE(db_scale_100, -10000, VOL_STEP_mB, 0);
@@ -1555,13 +1553,12 @@ static int snd_asihpi_volume_mute_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	u32 h_control = kcontrol->private_value;
-	int change = 1;
 	/* HPI currently only supports all or none muting of multichannel volume
 	ALSA Switch element has opposite sense to HPI mute: on==unmuted, off=muted
 	*/
 	int mute =  ucontrol->value.integer.value[0] ? 0 : HPI_BITMASK_ALL_CHANNELS;
 	hpi_handle_error(hpi_volume_set_mute(h_control, mute));
-	return change;
+	return 1;
 }
 
 static int snd_asihpi_volume_add(struct snd_card_asihpi *asihpi,
-- 
2.7.4

