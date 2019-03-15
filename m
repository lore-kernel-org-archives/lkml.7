Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0748206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="A1xlO+x7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfCODv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:51:29 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:40092 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfCODv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 23:51:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49255D31
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 03:51:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IBqHTFs4uI4P for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 22:51:27 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 1A787D20
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 22:51:27 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id b16so1877291iot.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 20:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2wGZjKbtz1QF/ghOgMEBGMaGcmrFoxV01C02MHIOQq8=;
        b=A1xlO+x7H0g3WrScgUuVgfSyvytBge2bVchRnzsphU1hlCLaOJVEpSIOGSLsgl9R4s
         XCMe0q9n6dofA/MJBKQUPnqQBTDn9sj2CdZOelWk9ey+oyIqZNdWwBiyQirGujqVEKts
         p0Ub1mDGbjqjoLfMa0GrfJr/iEzoXP7nBp+iwXX493msknaKf1MMc9MMIFPCXEIKwO/d
         myzWr9AQKSvOTaGM5PTZ0zkYuQAxzAvvqZGPf6ZDic4oFKwhNgXyrUREf+H2arORWiW7
         lqKz59B2TcDuF8UWAvNff/xK9IjYKKGBrH0YR1iTCc5SSm/bHG1YliSCc6EcsO8o9roi
         Gr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2wGZjKbtz1QF/ghOgMEBGMaGcmrFoxV01C02MHIOQq8=;
        b=Zm7lO1uPVCCf28k6bY3ps8f8LAfcyT6/RNtDHVxtRpgPhT8FJRbduFbKYQcYQqUuOV
         k7wFD1gkAol5amBg1ozdx+9h/2HLvy08mApVY679W8z4UvjGFQ3HuTSuumClxg/EcciA
         H2lBRqhioEPgQBJe0Vq2iPfgogmYNLUSyETYhaJqljHTdWfZw6XP6uOXUUr/Q/XXlTb5
         yGuQ4oIWhKB7eu8R3hnglYa/k6IGFIcOtCe9WzTjhz24NhE2XxTmGcNV4Y+Glez24Yqc
         y1VoFJAjX1+Ta1mXJ/9hJs5iaKSyzqVTMbbQc+KqpLfyi1+coIv4ZI89CHdqbPWCvQUL
         gyww==
X-Gm-Message-State: APjAAAWhPKyQJxCRT8y2nJd+BtgLhZNqE2Go9ijTPLlzJF3zJKC6hH7B
        kbY5b9kMoumZDq5PC0kmpS3W067WnDk32bkGBGY4YJoMlH7ieO2JvimADe9sdlPcNDWVgU9KoZO
        JRenKeap0mxXdVWJi55Aebp5fsRty
X-Received: by 2002:a02:7b0b:: with SMTP id q11mr1140318jac.47.1552621886675;
        Thu, 14 Mar 2019 20:51:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzmESrHES9mWohtxnJQp7K5V7QRDFV8k3jO7R9ZxF+aWxz7e6Iokb7KzrMMatH4i5JG5Y3YNQ==
X-Received: by 2002:a02:7b0b:: with SMTP id q11mr1140311jac.47.1552621886434;
        Thu, 14 Mar 2019 20:51:26 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id v5sm497764iof.39.2019.03.14.20.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 20:51:25 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: cs43130: fix a NULL pointer dereference
Date:   Thu, 14 Mar 2019 22:51:20 -0500
Message-Id: <20190315035120.25913-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case create_singlethread_workqueue fails, the fix returns
-ENOMEM to avoid potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/soc/codecs/cs43130.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 3f7b255587e6..80d672710eae 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -2322,6 +2322,8 @@ static int cs43130_probe(struct snd_soc_component *component)
 			return ret;
 
 		cs43130->wq = create_singlethread_workqueue("cs43130_hp");
+		if (!cs43130->wq)
+			return -ENOMEM;
 		INIT_WORK(&cs43130->work, cs43130_imp_meas);
 	}
 
-- 
2.17.1

