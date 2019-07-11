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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC1C31E41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B87D20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVLvDXf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfGKRNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:13:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32859 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfGKRNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:13:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so3260060pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3BwU5VUAF0JCMzSqok1tl/llhm5KGPd/qDOXI6NcGqQ=;
        b=cVLvDXf7lEbJm1xTumokzjX8xvvH/V50wlFXN8tgKkY8uPL34hAGnWF7HOsGitjkqX
         8ADm88GAnLkpJhhLNslnzh59oW+pkjENrNJA1nvStYiOee2k7Gjltb1KRtGnvTapWEX9
         pZ/rMkO3tuErbjlwTDGxVmK8tNUhrl8se5RBhMnjxSJ2QmVJ6rGWMGW9GzKiFMDGNs24
         D8QTUtLEyJDbdN0dGai1euN7SNVoDY5JZruX7CxJkaFAescjeWKYZd7Bh0r+yJKj92Sk
         fSNZ7EInbbdgIbA3JF22tKYtIfs4GSqd2fJwfZcTvIwJKOdjaXgf7bYnFHAi9vfxgS4v
         pB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3BwU5VUAF0JCMzSqok1tl/llhm5KGPd/qDOXI6NcGqQ=;
        b=DwefM9qOidnqqkR3YojiKrGLr/XG5/mK3DonkRX4Mg0lXPp40rSkz37veiYjL589V7
         Qdfb+O17rsifS3EIBCJSHvzPDKlg4nWh+5hTk1RwP7TkNThAssXyx+uWBjM3iS+boCnZ
         GVAdxl5AtYZ/aCouT2RIaV6zCATPcGm4oNt7IbwjqJJMngvuWfoYDRVmBvVHpnEb4XHB
         SsMDagrQ/JWNVCx0CbOnsg0KWlYpNsTxyonqZMSQ9DQdK6uF/+3bEmoxuhhgr1auigxu
         hqX3alqMjq6hXyUSMkmMl0yrPC5jBwC5n+X8GXvHNjMjWSriRyVP5+CMhtEfPFtoYdCu
         vFHw==
X-Gm-Message-State: APjAAAWi36ArZxFCJkxn6uXeo3WOuNtde+Z4XPhn2eqLqPPGiIh+whUJ
        h7Kl+umL/Uy/W8tpMYQ3aNY=
X-Google-Smtp-Source: APXvYqwV2pfHsALRPjvfCplIdA5zsECBYJGwyAdmquJN8p+FJJ/6eR6ilYh1DX7TRvGyMuwUCuk6Dg==
X-Received: by 2002:a65:648e:: with SMTP id e14mr5629964pgv.317.1562865191372;
        Thu, 11 Jul 2019 10:13:11 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id 185sm5994081pfd.125.2019.07.11.10.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:13:10 -0700 (PDT)
Date:   Thu, 11 Jul 2019 22:43:02 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: pci: au88x0: Remove unneeded variable: "changed"
Message-ID: <20190711171302.GA3445@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below issues reported by coccicheck

sound/pci/au88x0/au88x0_a3d.c:821:8-15: Unneeded variable: "changed".
Return "1" on line 834
sound/pci/au88x0/au88x0_a3d.c:768:5-12: Unneeded variable: "changed".
Return "1" on line 777
sound/pci/au88x0/au88x0_a3d.c:804:5-12: Unneeded variable: "changed".
Return "1" on line 813
sound/pci/au88x0/au88x0_a3d.c:786:8-15: Unneeded variable: "changed".
Return "1" on line 796

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/pci/au88x0/au88x0_a3d.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/pci/au88x0/au88x0_a3d.c b/sound/pci/au88x0/au88x0_a3d.c
index 7347103..2db183f 100644
--- a/sound/pci/au88x0/au88x0_a3d.c
+++ b/sound/pci/au88x0/au88x0_a3d.c
@@ -765,7 +765,7 @@ snd_vortex_a3d_hrtf_put(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
 	a3dsrc_t *a = kcontrol->private_data;
-	int changed = 1, i;
+	int i;
 	int coord[6];
 	for (i = 0; i < 6; i++)
 		coord[i] = ucontrol->value.integer.value[i];
@@ -774,7 +774,7 @@ snd_vortex_a3d_hrtf_put(struct snd_kcontrol *kcontrol,
 	vortex_a3d_coord2hrtf(a->hrtf[1], coord);
 	a3dsrc_SetHrtfTarget(a, a->hrtf[0], a->hrtf[1]);
 	a3dsrc_SetHrtfCurrent(a, a->hrtf[0], a->hrtf[1]);
-	return changed;
+	return 1;
 }
 
 static int
@@ -783,7 +783,7 @@ snd_vortex_a3d_itd_put(struct snd_kcontrol *kcontrol,
 {
 	a3dsrc_t *a = kcontrol->private_data;
 	int coord[6];
-	int i, changed = 1;
+	int i;
 	for (i = 0; i < 6; i++)
 		coord[i] = ucontrol->value.integer.value[i];
 	/* Translate orientation coordinates to a3d params. */
@@ -793,7 +793,7 @@ snd_vortex_a3d_itd_put(struct snd_kcontrol *kcontrol,
 	a3dsrc_SetItdTarget(a, a->itd[0], a->itd[1]);
 	a3dsrc_SetItdCurrent(a, a->itd[0], a->itd[1]);
 	a3dsrc_SetItdDline(a, a->dline);
-	return changed;
+	return 1;
 }
 
 static int
@@ -801,7 +801,6 @@ snd_vortex_a3d_ild_put(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_value *ucontrol)
 {
 	a3dsrc_t *a = kcontrol->private_data;
-	int changed = 1;
 	int l, r;
 	/* There may be some scale tranlation needed here. */
 	l = ucontrol->value.integer.value[0];
@@ -810,7 +809,7 @@ snd_vortex_a3d_ild_put(struct snd_kcontrol *kcontrol,
 	/* Left Right panning. */
 	a3dsrc_SetGainTarget(a, l, r);
 	a3dsrc_SetGainCurrent(a, l, r);
-	return changed;
+	return 1;
 }
 
 static int
@@ -818,7 +817,7 @@ snd_vortex_a3d_filter_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	a3dsrc_t *a = kcontrol->private_data;
-	int i, changed = 1;
+	int i;
 	int params[6];
 	for (i = 0; i < 6; i++)
 		params[i] = ucontrol->value.integer.value[i];
@@ -831,7 +830,7 @@ snd_vortex_a3d_filter_put(struct snd_kcontrol *kcontrol,
 	a3dsrc_SetAtmosCurrent(a, a->filter[0],
 			       a->filter[1], a->filter[2],
 			       a->filter[3], a->filter[4]);
-	return changed;
+	return 1;
 }
 
 static const struct snd_kcontrol_new vortex_a3d_kcontrol = {
-- 
2.7.4

