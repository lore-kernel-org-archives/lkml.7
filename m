Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE98FC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A3D21883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 04:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfHJEaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 00:30:03 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33346 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfHJEaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 00:30:03 -0400
Received: by mail-yb1-f194.google.com with SMTP id b16so4923846ybq.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 21:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qpn09Q2IPVk1Zallzy6o+fiJZ4cg6kBGPdGeFP8iFUE=;
        b=eAkSRHdkpyACyVy1Arrycn9F87Kc5dtUNHYy9/0CZiE9yn0+gK0E0ON0uWfbu+HyNJ
         4WDlcQlVtIlO3j/dWUN7qMyyHP1Y5G6bbcf0ij3qAtfuhRypH+8sKnbaV7YXWuJxEKjR
         kWom8ONJPf1dYr3QNx+fvTgGutMv6L7zMclJTuohy/7ecCuHPytpmWoTLWTLHXkn/IYI
         0a4ntwCLnM9NtRlnrVvOgEZ5awfTf5Am2HSPIdXgJso+dT3pvM+uVQIi+LPfyPzeFnwS
         AYUZhodIHweMJecJNmfXZyYZMOjfoX2ZI0UBM6qiipvdCO+X6uqI+w963YBOgD3FdDNz
         pIKg==
X-Gm-Message-State: APjAAAVZzOtkA7ZIEkUIf1yYcOxPPpKNNPHmePf/9fCQn8lEmlz9A242
        WBRBD7wYFPGM3aciOzDVdLw=
X-Google-Smtp-Source: APXvYqwfKHOcF3+5sX+39qBI1GTLIQlNHuIdHvEGVBed9ILaHTwHRCaZUAl2NSo9E1anp4YT+mluow==
X-Received: by 2002:a25:8489:: with SMTP id v9mr14978725ybk.1.1565411402054;
        Fri, 09 Aug 2019 21:30:02 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id p141sm22736227ywg.78.2019.08.09.21.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Aug 2019 21:30:00 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda - Fix a memory leak bug
Date:   Fri,  9 Aug 2019 23:29:48 -0500
Message-Id: <1565411390-2684-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In snd_hda_parse_generic_codec(), 'spec' is allocated through kzalloc().
Then, the pin widgets in 'codec' are parsed. However, if the parsing
process fails, 'spec' is not deallocated, leading to a memory leak.

To fix the above issue, free 'spec' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/pci/hda/hda_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 485edab..8f2beb1 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -6100,7 +6100,7 @@ static int snd_hda_parse_generic_codec(struct hda_codec *codec)
 
 	err = snd_hda_parse_pin_defcfg(codec, &spec->autocfg, NULL, 0);
 	if (err < 0)
-		return err;
+		goto error;
 
 	err = snd_hda_gen_parse_auto_config(codec, &spec->autocfg);
 	if (err < 0)
-- 
2.7.4

