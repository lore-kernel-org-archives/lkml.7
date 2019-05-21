Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83154C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625862182B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfEUKg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:36:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45533 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfEUKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:36:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id g57so28582599edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=iCa3sIkXRS0MUvhZrMU0I1kSnN7S8DExfC/yTx1vxTA=;
        b=ehLe7oQGXaKsq/0SS7sqLsGcsMdnNNY13RFm9xkkFbbVkm9y0qXdCxvoguWp3gcQtz
         b5Y79VoHtZPY9rS880nC2E2lcxcv5zkc6Q+GU8hQZhHuIQnkTOk1hzZU+DPfy04frgEq
         C3D9Pu9nYhEkKWFGX2sXkT3n6RHVmu2hKTg+vvliVA8O4pWcVaSn90D/6tLsGR9lSQLB
         qGdMaW6lZzO9/j2YyqsomQNX48nWwI2bRsrC7kQG2nkKCSmCuuF2VawE1DgJ3YAaTCzE
         PB/QLQzZcIS44wReAR2l6txxGIe1kkexqqAhIhf33UYwGFxkuyXoSSG6n+aOlKo69uUu
         7WVA==
X-Gm-Message-State: APjAAAX1ZEHDd3qXqCqoGq70DWsX3iEQi+P3mk7hdpN6sKqMpi0bUw7q
        uokabLr8lsfEGChLGw3vYm3ZlOb2jZmZ6eLD78I2VSMh5dUT5Qzegq/Vk0rajtrm5im3U6CIKpX
        FrYxcGDy71YXmIC7m
X-Google-Smtp-Source: APXvYqxeWQK82QeOi5z+lBMdAAErKeezVrdKlYCVRXGcKGYFNE9+MsqmQD8PS6/9oZTtpGtxLKg45A==
X-Received: by 2002:a17:906:22d8:: with SMTP id q24mr62970353eja.261.1558434997802;
        Tue, 21 May 2019 03:36:37 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id e43sm6202423edb.38.2019.05.21.03.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:36:37 -0700 (PDT)
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v1 3/6] ASoC: sgtl5000: Fix of unmute outputs on probe
Date:   Tue, 21 May 2019 13:36:16 +0300
Message-Id: <20190521103619.4707-4-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable "zero cross detect" for ADC/HP, change
HP_ZCD_EN/ADC_ZCD_EN bits only instead of writing the whole
CHIP_ANA_CTRL register.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 sound/soc/codecs/sgtl5000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git sound/soc/codecs/sgtl5000.c sound/soc/codecs/sgtl5000.c
index bb58c997c691..e813a37910af 100644
--- sound/soc/codecs/sgtl5000.c
+++ sound/soc/codecs/sgtl5000.c
@@ -1289,6 +1289,7 @@ static int sgtl5000_probe(struct snd_soc_component *component)
 	int ret;
 	u16 reg;
 	struct sgtl5000_priv *sgtl5000 = snd_soc_component_get_drvdata(component);
+	unsigned int zcd_mask = SGTL5000_HP_ZCD_EN | SGTL5000_ADC_ZCD_EN;
 
 	/* power up sgtl5000 */
 	ret = sgtl5000_set_power_regs(component);
@@ -1316,9 +1317,8 @@ static int sgtl5000_probe(struct snd_soc_component *component)
 	       0x1f);
 	snd_soc_component_write(component, SGTL5000_CHIP_PAD_STRENGTH, reg);
 
-	snd_soc_component_write(component, SGTL5000_CHIP_ANA_CTRL,
-			SGTL5000_HP_ZCD_EN |
-			SGTL5000_ADC_ZCD_EN);
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_CTRL,
+		zcd_mask, zcd_mask);
 
 	snd_soc_component_update_bits(component, SGTL5000_CHIP_MIC_CTRL,
 			SGTL5000_BIAS_R_MASK,
-- 
2.20.1


-- 

Ciklum refers to one or more of Ciklum Group Holdings LTD. and its 
subsidiaries and affiliates each of which is a legally separate entity. 
Ciklum LLC is a limited liability company registered in Ukraine under 
EDRPOU code 31902643, with its registered address at 12 Amosova St., 03680, 
Kyiv, Ukraine.



The contents of this e-mail (including any attachments) 
are confidential and may be legally privileged. If you are not the intended 
recipient of this e-mail, please notify the sender immediately and then 
delete it (including any attachments) from all your systems. Any 
unauthorised use, reproduction, distribution, disclosure and/or 
modification of this message and/or its contents are strictly prohibited. 
We cannot guarantee that this e-mail is secure or error-free. Ciklum cannot 
be held liable for any loss or damage caused by software viruses or 
resulting from any use of or reliance on this email by anyone, other than 
the intended addressee to the extent agreed in a contract for the matter to 
which this email relates (if any). Messages sent to and from Ciklum may be 
monitored; by replying to this e-mail you give your consent to such 
monitoring.  Notice: we do not accept service by e-mail of court 
proceedings, other processes or formal notices of any kind without specific 
prior written agreement. This email does not constitute a binding offer or 
acceptance for Ciklum unless so set forth in a separate document.


