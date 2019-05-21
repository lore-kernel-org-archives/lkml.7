Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445C3C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C76217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfEUKgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:36:44 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:44807 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfEUKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:36:42 -0400
Received: by mail-ed1-f49.google.com with SMTP id b8so28604880edm.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=WylUw4wo5vM+M15++6VSkI9SZq4ULyzzIp7SQ2Wc8DM=;
        b=Eet5Ale6H35PJWP488ZbFr4yxzvBDxgfw6d2lM2Pxd4t8kj0EP6X458unAnOZ6yYSv
         qlbPBvVAY/50cfijVKT2/vXQXNmMQn5pnyB4tknNNVszBKqb1lM9LwqAG1gdhGC3sCB1
         PwUrm4PFfyT3CHAaZNqvPd5xEiEMPrC3bRimbHFubRZssDfjZfrHnE4tWhCNKxh2fPJO
         E4pqCsHe31bAB7+MNvJLqWWKp1GMJkMt5fAHSmqfESCPNtJj7lodIJaM8P4aEG93vrFg
         Z0pWD93jx//4QSYm99Lpo4O1QgTuQAeNQaqtiECrndio5myZHL/yae/NKyogFMkt1I5v
         Z/IA==
X-Gm-Message-State: APjAAAW9zekzxpqoIkuFC+BOkYZJwOIn/7y1on36qaF/Zvb+PNytpOoc
        eleUmJ+zOziDWLfEbPgc9RRMX/PiSkwiiWMfG5AhloTeSpetnxiTeM21hV2e0Eku0ryu3Riq+HA
        86j/IMShZbNMXhY4s
X-Google-Smtp-Source: APXvYqxSOa2oON0KK+1w6bVqEDQDP5+bCZW1+KQrM92fr0fjjSQ6TMlD8gJY8HRJghhdLjC22eCW/w==
X-Received: by 2002:aa7:d381:: with SMTP id x1mr649159edq.251.1558435000706;
        Tue, 21 May 2019 03:36:40 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id z10sm6186868edl.35.2019.05.21.03.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:36:40 -0700 (PDT)
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 5/6] ASoC: Define a set of DAPM pre/post-up events
Date:   Tue, 21 May 2019 13:36:18 +0300
Message-Id: <20190521103619.4707-6-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare to use SND_SOC_DAPM_PRE_POST_PMU definition to
reduce coming code size and make it more readable.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 include/sound/soc-dapm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git include/sound/soc-dapm.h include/sound/soc-dapm.h
index c00a0b8ade08..6c6694160130 100644
--- include/sound/soc-dapm.h
+++ include/sound/soc-dapm.h
@@ -353,6 +353,8 @@ struct device;
 #define SND_SOC_DAPM_WILL_PMD   0x80    /* called at start of sequence */
 #define SND_SOC_DAPM_PRE_POST_PMD \
 				(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)
+#define SND_SOC_DAPM_PRE_POST_PMU \
+				(SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU)
 
 /* convenience event type detection */
 #define SND_SOC_DAPM_EVENT_ON(e)	\
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


