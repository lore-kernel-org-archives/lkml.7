Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83209C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE292075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddjgq39Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfCZRXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:23:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38278 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:23:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id g37so1940513plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=l19F8lJd5IdArfySDoFtGyFlcftIi55XoMtqQbgctkY=;
        b=Ddjgq39Yp+OUaC/VdMUmib8F9+AVVPOeJWFH/q0LHlRbcU3bEVtW4HgJ6dCmMUSyRN
         8QhEexMOLLjL1VHeT4Nyw2fOWBrDs8HNWf12octbjiSI6MdUAUODcmgBkD3Xm7w0GxdR
         Kfiugswwo3myJ2tGRvwr/T0cDYE1zMjwxVzI7PIJWNyP15dg2Cvo7hjgTaVvc9ZjoZ+9
         7vwe3VgwMmhiuJrT67wsnh56w1w2dx+Sip0kki3aDl5OR0VzH1u9b+hxypsrTK3/ix/7
         hRDDbiRpVEsSkN4/fnnsAHvO6hxYip6Jqay5RPgevM3hAnJ7bF5RTUmF9Syd8RDPirAe
         ZhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=l19F8lJd5IdArfySDoFtGyFlcftIi55XoMtqQbgctkY=;
        b=BB9huz8o43/Xp8jVV/VFV3I2ZFHHmiwHolzq/rkkf5VZ2aY02wp8WiPImUml+3wLQ7
         +LUdihsvkEtPFnNd5gPgFN4SATgHPcS402ftnr2vYH9JouWTydyQed+Mg1zCBRxbJaF2
         +svhy51Yh23IMtRB2qjrLS3bhdHSHJOTHhRyiRFEuIFTiroY/cY/o8/p4U8QGdx02OI+
         a0DqigT6phdGeUfx0XwCTT3tB0A7ua0Wf/6a67icZlHbZJBlUQa6FZMS1M7QFcRCYY0X
         0dQpyA9nD/jyzh8pzErhG2obDJcolF2Wij+Z0uIsH/aLHvHo/VbYgMHvilnAF7guh4uU
         l55Q==
X-Gm-Message-State: APjAAAWqacd3C6sjkSGcKaQ64QGl4Pz9E7oexBUDHZQpCerobiOMDvOy
        leuVVP0FXQWPiHRbxf1+1X4=
X-Google-Smtp-Source: APXvYqwqye670U+s9/HlBGXx39l4yXubaJAPM4MZp+yU2Sp4IU+zXuXF7VeO9TbRzaLuDsW/U7NSTw==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr32336145plb.191.1553621022777;
        Tue, 26 Mar 2019 10:23:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v12sm4310670pfe.148.2019.03.26.10.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:23:41 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ASoC: core: Fix use-after-free after deferred card registration
Date:   Tue, 26 Mar 2019 10:23:38 -0700
Message-Id: <1553621018-8944-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If snd_soc_register_card() fails because one of its links fails
to instantiate with -EPROBE_DEFER, and the to-be-registered link
is a legacy link, a subsequent retry will trigger a use-after-free
and quite often a system crash.

Example:

byt-max98090 byt-max98090: ASoC: failed to init link Baytrail Audio
byt-max98090 byt-max98090: snd_soc_register_card failed -517
....
BUG: KASAN: use-after-free in snd_soc_init_platform+0x233/0x312
Read of size 8 at addr ffff888067c43070 by task kworker/1:1/23

snd_soc_init_platform() allocates memory attached to the card device.
This memory is released when the card device is released. However,
the pointer to the memory (dai_link->platforms) is only cleared from
soc_cleanup_platform(), which is called from soc_cleanup_card_resources(),
but not if snd_soc_register_card() fails early.

Add the missing call to soc_cleanup_platform() in the error handling
code of snd_soc_register_card() to fix the problem.

Fixes: 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")
Cc: Curtis Malainey <cujomalainey@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 93d316d5bf8e..6bf9884d0863 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2799,6 +2799,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 		if (ret) {
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
+			soc_cleanup_platform(card);
 			mutex_unlock(&client_mutex);
 			return ret;
 		}
-- 
2.7.4

