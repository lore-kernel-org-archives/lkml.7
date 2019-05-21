Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE51EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF69217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfEUKgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:36:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42819 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfEUKgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:36:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id l25so28604839eda.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=odw0Br10pd/FID0oLpxhs9oyem6lxu+oPFxMjbKBkEQ=;
        b=cOjMTKYz7SArJMq/Tu/+r5YWlJCR0KjKMCwBsSYiOHb5+u1PiYi6tBhp6VBkdXHykR
         gqNKw08IMSbFq8sZT1419KDhAA9koYW8vlXRwLLCTfYEb2LkERfzkdxSiE22H+JvDz+v
         SiD6hr2VnvHEaxKk37zSjxl8GQbnNHOvGjnbFhjFDxCH1xEIIxyTrCy9aAWzrkM2XNaZ
         eyaeZuRFQ+479rT83LrDddSw8/NEjoJ5h0tmNdLRa4fSjFDvTb8TFiZXe7dEzDjWzein
         Wz6bVBUU5uKeVkydHfEilLMfiHbH7gtF3x0sVlEM1xNY6MPy3QTMhht71qjI4ZXufkU0
         ItsA==
X-Gm-Message-State: APjAAAX/vpHoIAtOFONO264XfFOsr6LdZFgWIoEJIg199ATDhLi/qKs7
        bYUIVLZTt53Eq6NSBC+bmzDXp9BjQCuY8pfrmRQQW3FPuuFx4Fdb2m3Qn3hGj8LmzKv9LUZrh9r
        eCAXe2/Hkh3TYV+JLR1En7S61
X-Google-Smtp-Source: APXvYqybcyoaWgALzKgHnX9qkZKOL1y9QhO/tydUl9gFPtCPfkc2n+gdnaHhGjgsCSNAwAtctNFBuA==
X-Received: by 2002:a17:906:90c6:: with SMTP id v6mr40526940ejw.111.1558434996456;
        Tue, 21 May 2019 03:36:36 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id ay6sm3507075ejb.20.2019.05.21.03.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:36:35 -0700 (PDT)
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v1 2/6] ASoC: sgtl5000: add ADC mute control
Date:   Tue, 21 May 2019 13:36:15 +0300
Message-Id: <20190521103619.4707-3-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This control mute/unmute the ADC input of SGTL5000
using its CHIP_ANA_CTRL register.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 sound/soc/codecs/sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git sound/soc/codecs/sgtl5000.c sound/soc/codecs/sgtl5000.c
index 5e49523ee0b6..bb58c997c691 100644
--- sound/soc/codecs/sgtl5000.c
+++ sound/soc/codecs/sgtl5000.c
@@ -556,6 +556,7 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 			SGTL5000_CHIP_ANA_ADC_CTRL,
 			8, 1, 0, capture_6db_attenuate),
 	SOC_SINGLE("Capture ZC Switch", SGTL5000_CHIP_ANA_CTRL, 1, 1, 0),
+	SOC_SINGLE("Capture Switch", SGTL5000_CHIP_ANA_CTRL, 0, 1, 1),
 
 	SOC_DOUBLE_TLV("Headphone Playback Volume",
 			SGTL5000_CHIP_ANA_HP_CTRL,
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


