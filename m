Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1680C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8213222CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNDOxqZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfH1Ugi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:36:38 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33112 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfH1Ugi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:36:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id w18so1033153qki.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46Ne7YWhhGVSNBj1PAVeg9+1026jUGq5ei9X7Tyvb8Q=;
        b=uNDOxqZHC+NV9+n+ZUO+6qv0GU0pO5phsV/KoljwJWoaDKQsKdgx+Rtj/ytcOplT4E
         XD6jc2avq+9unyF0rEK/ArmURuex07kQl49NAKPXGfgdCZMYjSDsK6RYjPcPzMqfN/IK
         iTbbXJaDIjpj0A7P6yoSUWij1iU4TLG2pE7kWe03hZwYsnoD8xpQLBX6JtmyiDebxWGE
         xstZMOrPWjjkP843JA/SIXkH/0qGaE8y6/W6NGWiEyO9LzWf7KSEGVmnxI24mVrid6mY
         +XCInls2ZjC6XG0MGaCqi6LjlDu3wIqSkdZNg2x7++L/ui5fINW4fwPx7AY0IRYIDpzU
         QGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46Ne7YWhhGVSNBj1PAVeg9+1026jUGq5ei9X7Tyvb8Q=;
        b=OSWZo0o57gpeMSRCIxIV0xhEtd0FEDR28nBhksU4+4gnPTSZ+UhOjkBCa8/LBHGMXe
         4efAd2Os1MJfsraDsqIrh1NM0o6Iv+PVF/8nJvVyYNNgu+EV6tEPox9yu1qihLMmvf3R
         ZiLzJwXAOEa05UN2y3mM9PvKDM3ixJpiKy58A72LfIbmLBteA18YsD1uE17yy+cWHtqm
         fYarg7C8Wb2S9EnWGbFdX3TYC8fWZVwsPRvN7SVOZb5bDSFgtn16pLJE/IWN6aCtX0i+
         S0pOlhB/dEFteD05+7+Vr7YvZafP4k5sBuBpB9vVICtdcEK4HpZCfdxYHPrfkn23SABH
         HXZA==
X-Gm-Message-State: APjAAAVRKQKPK49mPJcShPHh3Yl4mOVvpiRuG1girMufDWZPvS6XHZg0
        eHl39X/h9kgv5l1l9+eXZ2E=
X-Google-Smtp-Source: APXvYqyAJKmliA/4EfHD1afxMuBBhrspDELcQQzUK5S8jrmaVq9kWjuXsP9Fc2W61mBvckHsmcHAqQ==
X-Received: by 2002:a37:8844:: with SMTP id k65mr5766729qkd.77.1567024596354;
        Wed, 28 Aug 2019 13:36:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b715])
        by smtp.gmail.com with ESMTPSA id b1sm126411qkk.8.2019.08.28.13.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:36:35 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     minyard@acm.org
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, kernel-team@fb.com
Subject: [PATCH 1/1] ipmi_si_intf: Fix race in timer shutdown handling
Date:   Wed, 28 Aug 2019 16:36:25 -0400
Message-Id: <20190828203625.32093-2-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190828203625.32093-1-Jes.Sorensen@gmail.com>
References: <20190828203625.32093-1-Jes.Sorensen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

smi_mod_timer() enables the timer before setting timer_running. This
means the timer can be running when we get to stop_timer_and_thread()
without timer_running having been set, resulting in del_timer_sync()
not being called and the timer being left to cause havoc during
shutdown.

Instead just call del_timer_sync() unconditionally

Signed-off-by: Jes Sorensen <jsorensen@fb.com>
---
 drivers/char/ipmi/ipmi_si_intf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index da5b6723329a..53425e25ecf4 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1828,8 +1828,7 @@ static inline void stop_timer_and_thread(struct smi_info *smi_info)
 	}
 
 	smi_info->timer_can_start = false;
-	if (smi_info->timer_running)
-		del_timer_sync(&smi_info->si_timer);
+	del_timer_sync(&smi_info->si_timer);
 }
 
 static struct smi_info *find_dup_si(struct smi_info *info)
-- 
2.21.0

