Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A10C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3E921721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJZeN1la"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfJIKqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:46:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38061 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIKqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:46:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so2010799wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLt5Gpr+TBYMqPJckYDfypWA6Ci7GEvQRrL7skWxG/M=;
        b=RJZeN1la5DmYjMu7aEtVsZxkzkziIx5DoE0FOl6k0Gy69PkBvwxSj7bKVvvAX5NSAv
         7C4BiuBGD1HbiwaeB7rJIP7sG6AFMKZJtHieX2I5hXxGttR6KG6m6P2t9VdR7ngJXgPX
         C8thnd80knly0m37L9CTTL0FnJ0z0KrgTIXoCgY8daWSx1pKdyy2BhGg/k0A0GroKDZI
         rPzUMzf1HVUycYXUG0buy4nw8hHIZvOtjOunUOqnPrFnF0eDJk5R9Hw9RZl5BDXjQg3Q
         waqeilWohfIHKefEDD6kOe6zAjwVGuYCy49sTvsnvKkjbDsW4VFuZWsso0/q5Xe3Wsbn
         aj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bLt5Gpr+TBYMqPJckYDfypWA6Ci7GEvQRrL7skWxG/M=;
        b=J+bZAH/i+hwbbFgoqfOQQziaHNBbUI7SdCyqIRPi/zzi/rUBfR7hZJFEBpwS5K2zyc
         D4eAm4YinY6LxOtxv/XO1DEN419zc3Qw3w6PWThWrBgJ4Lf2r3wFVgXiuhRIFbPnbNIP
         cQqEotwO4GL48KDZ4VOxQ+qzBuEQsePbkWtcXtql8nMJbW4ClzvEwonYFVpGpNc2Ptn6
         Xp4JrKpjeLxzuoprG0DgRnSQkVd793S4pVk0Rrr+5OIBJjLUtXdozyXMUTRQC5NFdUXE
         u1PfcmURz2F1Mi716gYjenpOb3KN3GVZdzQ5aZbsUr8MOh7wrbhnlg1Km7aroRQ1Dit8
         eRZA==
X-Gm-Message-State: APjAAAWGCxnwXnXv7ZeccUdid9YgC9OaWCAxSZbRu6N+YqacqDZji2Bs
        /nLo0nVy6mEkiR2BXCED+TLdlA==
X-Google-Smtp-Source: APXvYqyHCZJHAK2FkQAKsfFkzde/fa2r2D1UAddHZlRYXktMUnNw5SOqGgFY6CIRgjSVSyMGvTmoMA==
X-Received: by 2002:a1c:1901:: with SMTP id 1mr2091192wmz.28.1570617978608;
        Wed, 09 Oct 2019 03:46:18 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id g4sm2131248wrw.9.2019.10.09.03.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:46:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     spapothi@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        vkoul@kernel.org, bgoswami@codeaurora.org,
        Gopikrishnaiah Anandan <agopik@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH] ASoC: soc-dapm: Skip suspending widgets with ignore flag
Date:   Wed,  9 Oct 2019 11:46:03 +0100
Message-Id: <20191009104603.15412-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudheer Papothi <spapothi@codeaurora.org>

For wigdets which have set the suspend ignore flag asoc framework
shouldn't mark them as dirty when ASoC suspend function is called.
This change adds check to skip suspending the widgets with the flag set.

Signed-off-by: Gopikrishnaiah Anandan <agopik@codeaurora.org>
Signed-off-by: Sudheer Papothi <spapothi@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/soc-dapm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 13544f7c850b..4ecfd32e59b8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -303,6 +303,8 @@ void dapm_mark_endpoints_dirty(struct snd_soc_card *card)
 	mutex_lock(&card->dapm_mutex);
 
 	list_for_each_entry(w, &card->widgets, list) {
+		if (w->ignore_suspend)
+			continue;
 		if (w->is_ep) {
 			dapm_mark_dirty(w, "Rechecking endpoints");
 			if (w->is_ep & SND_SOC_DAPM_EP_SINK)
-- 
2.21.0

