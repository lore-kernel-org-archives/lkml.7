Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2656DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D282071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nMwsgi9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKNTJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:09:23 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:34451 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfKNTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:09:22 -0500
Received: by mail-il1-f196.google.com with SMTP id p6so6369964ilp.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 11:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJlTqX3MqyfjXLCncAwsXq4lCz1EaZQPrfo2kGeMxys=;
        b=nMwsgi9Ldl5oVcuBJVDG6vjkLlyAm7KANIbKWmxzWr2ow1HeKmK48ST99X0n+DiSlY
         2OtKaB7zkDvQPL+1a6cEDXYbZhuks0scvxmpVWCOqxl9kE3cZ9SL4vfrU5DMXshAeuTi
         Tb9Xnbuv6AgYw3Mf01HsxRdO3Swt4PnFus7q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJlTqX3MqyfjXLCncAwsXq4lCz1EaZQPrfo2kGeMxys=;
        b=AHTQfEP4mngTvyL1L//q0ijPtP5A1Fk5URXUDH6WPQHuddCJl84cMGMJzkaY4LNwvo
         Xx7KQr+2r9yGA/Xq5rDjSuhwuU0MuAcM4YA7JE1PvWsQjiKGoxfRpyIyaDEv0Zl+QWoH
         7DcI60s06vvtfzoj8b/MDgbIlpBtqj63qn55707c5BM4xiBjRfE8nhXDa35VDs+nH+//
         RtQCTgVkgWUTOQ0xN+QbTBTYzgYZmrx/NDm7tDTMOc/x4uz2EWqC6EeA6dVLMClxmBPe
         GW2SoMaHCCVMPcJodqp9jpiC1QYF3D30qkDZu/nkOTNEAQ1cGCnyD9cN4bx6Noo5loPP
         Pq8g==
X-Gm-Message-State: APjAAAVEOS57XzTx+73oF0WAIKAiVc2vmp+PL2r7CTmLD8qoh8AgA1X6
        BqQpP9ff5vWgzkm9JeL3DZDC8P5ssUI=
X-Google-Smtp-Source: APXvYqwe1HDVydnGRLk9ezbGgJTiowfbINKqTqtC5f1FRIEOCuGuQwJ6B0firqVAFlDUi5Vow51/qQ==
X-Received: by 2002:a05:6e02:c8e:: with SMTP id b14mr11794924ile.44.1573758561685;
        Thu, 14 Nov 2019 11:09:21 -0800 (PST)
Received: from localhost ([2620:15c:183:200:2bde:b0e1:a0d8:ffc6])
        by smtp.gmail.com with ESMTPSA id k199sm881586ilk.20.2019.11.14.11.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 11:09:21 -0800 (PST)
From:   Jacob Rasmussen <jacobraz@chromium.org>
X-Google-Original-From: Jacob Rasmussen <jacobraz@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jacob Rasmussen <jacobraz@google.com>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        zwisler@google.com, stable@vger.kernel.org
Subject: [PATCH] ASoC: rt5645: Fixed typo for buddy jack support.
Date:   Thu, 14 Nov 2019 12:08:44 -0700
Message-Id: <20191114190844.42484-1-jacobraz@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Had a typo in e7cfd867fd98 that resulted in buddy jack support not being
fixed.

Fixes: e7cfd867fd98 ("ASoC: rt5645: Fixed buddy jack support.")
Cc: <zwisler@google.com>
Cc: <jacobraz@google.com>
CC: stable@vger.kernel.org
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 902ac98a3fbe..19662ee330d6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3271,7 +3271,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 				    report, SND_JACK_MICROPHONE);
 		return;
 	case 4:
-		val = snd_soc_component_read32(rt5645->component, RT5645_A_JD_CTRL1) & 0x002;
+		val = snd_soc_component_read32(rt5645->component, RT5645_A_JD_CTRL1) & 0x0020;
 		break;
 	default: /* read rt5645 jd1_1 status */
 		val = snd_soc_component_read32(rt5645->component, RT5645_INT_IRQ_ST) & 0x1000;
-- 
2.24.0.432.g9d3f5f5b63-goog

