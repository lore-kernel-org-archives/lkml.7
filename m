Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365E2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0184D213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="dq1Tii3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfCXX0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:26:02 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:52430 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfCXX0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:26:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 89C79817
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 23:26:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YqvYv8CUNkeH for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 18:26:00 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 5F5E77B9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 18:26:00 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id k2so6621604ioj.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EupXNjFmAVUQ1KkehjYFrq+B6zSPPjrnpYwRijF8xWE=;
        b=dq1Tii3erdYjYjUlwTZ4j6MXBiZlHkInWm4BYxcPGqRMRQQ7iYJ/Zl7cYur5fICxQz
         z/rYB8B1yCF46wrKQLsF+Rjs3vxS8CN51ptGQF3NgJYXiJPvTa/SATQMihDa1dyxNtJv
         zjoekY7hjQ2suXoi/tuN1MvjTR4NLCxsm4qx+lcw11lcj3/MRvFTd8DYFqOgCe+dOwRp
         IJNaxAc8HOZnbejrhTu5ap39G20SzhudIhRR0mjY5AutszqrGd8rlLyo80WK9ncm7NRh
         VWFu2Yv68U9HfgaGJr3qx6gjVipveFwQ4HggsS0zgC9MKwXeYe3014erWCSpbyCvCffE
         buSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EupXNjFmAVUQ1KkehjYFrq+B6zSPPjrnpYwRijF8xWE=;
        b=kBb1UBQ2xel+hAIONjS9R+xOIahGFxcs0d1CPuskyFzwe/QKxrFZV88ZyN9v/GTuYS
         oYGa20Pu9F+byNXCLoROkVOvcOKqltlVfx0gAaI5kx0La5tE3zVJ+zeLpth4tqSfA6m5
         edXU9yTH3Zs43oyipPn5eVxp8VjVE69Zc46yTXShOnJ6POFtD6tZesRzNYWXAUiEQIyY
         nw6o1vScX+b0x0v5pfikuNhBNFado8Cwk2olMUgclCsyMisFh2zxI+2LNPw3ZXKxXpeD
         ukTr0h7BB0IsCtBiZsZXqX0smsCZCnkyUFJetZb4xvRMR6TQpg/Mvwr2A51F4NkePRuQ
         ZttA==
X-Gm-Message-State: APjAAAUE0baDz9dmhiupvvgwhq5QMBvkIrvhxHJfqJwOxi+GmrVc32HW
        SgSXphm3Bhkmol7AOwdw6TeuLGrryrH+z0ObNUmGHv+oLvpLO7fU2yLS184s7OVtJdzsLregZI8
        sLdjrY/MddeTD0FOmeQDHxtQLQSWz
X-Received: by 2002:a02:7a48:: with SMTP id z8mr14816989jad.62.1553469959177;
        Sun, 24 Mar 2019 16:25:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8lcPwiJRV7XqDY3MpbNhmNUyqIda8L0XHocp2EvpR550oPpaYoYltFmDP3WBTP6gi93lE0A==
X-Received: by 2002:a02:7a48:: with SMTP id z8mr14816984jad.62.1553469958977;
        Sun, 24 Mar 2019 16:25:58 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id x25sm6482610ioh.63.2019.03.24.16.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 16:25:58 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: codecs: fix a missing check for regmap_update_bits
Date:   Sun, 24 Mar 2019 18:25:53 -0500
Message-Id: <20190324232553.10020-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_update_bits could fail. The fix checks its status and if
it fails, returns its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 sound/soc/codecs/cs35l34.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 5063c05afa27..a456b1ac9019 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -262,6 +262,8 @@ static int cs35l34_sdin_event(struct snd_soc_dapm_widget *w,
 		}
 		ret = regmap_update_bits(priv->regmap, CS35L34_PWRCTL1,
 					CS35L34_PDN_ALL, CS35L34_PDN_ALL);
+		if (ret < 0)
+			return ret;
 	break;
 	default:
 		pr_err("Invalid event = 0x%x\n", event);
-- 
2.17.1

