Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD463C73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F882080C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUE1adA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfGJCjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:39:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42066 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJCjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:39:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so312089pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 19:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eYXNQQatx5CsTvcWnAhx8hozPNi1nTqqLqSrJNAWy6w=;
        b=hUE1adA9ehAy7iETpmQ8DNp3I53GbtbDOpYXs19uYfbIeOI7Jh7sZe4hHXjymkDZQs
         hZ7qW12GR1twmIEm7NT3T5lAYCepIFPOe6U95PJ+OlUGT2SUkGj3GnbMI7Cbgo5ITSd9
         J0D//1L6lMdg0qoHBdNNCnVl7GJ4obVkGLHFIVI2XXykumF67E0odyhvCX+38mqcfvwT
         mtJkBJQcqD3C+B+RGOfaCary++05pvc1tRN4x21wktTQT+JvgntqaPM+0E/XZC9ib5MR
         HKo0gX0SrwvcuRgRss3BufISgUN28PS40ArtDEVC4WqOk5GlvdO7pwf/Gv1A5Dsam3yh
         c7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eYXNQQatx5CsTvcWnAhx8hozPNi1nTqqLqSrJNAWy6w=;
        b=bja8JWXExv8iEs6Dhr5wf2MRfLt44gBSFZV8EztTpakYjs5COJrMzv9APwP3nbG3bR
         brinFQARTDH5h40bXR/UXihsjTY2QOdsAELLl2rGcB2iwQt/jnR65nMk3HZPtNmh/Hyb
         VPWrPhwIhvWu5tu1kJ0RUc/yFFVLhCSYygXx+bCTXSIgdcO/hoaalbrk5giIb7EAh91r
         LQBKGZpq/f99xjurJKAfLU/sGxXHZi9NeeZvOYCE3pIMJnwgAf29h2POsbSSnfQ0pGro
         lK4LFa+mFbXR6xONxHGLoLryYHfU9EfQYuE+UR8C7uzYmTPq4jURf6eEhNaYPmYCV6Iz
         p1IQ==
X-Gm-Message-State: APjAAAUrfFTOiFw0EY2benbxyylBktOFF3vEKkM3alUPmjUui3hQFQSc
        Y+NzRKflxhe/qqJn+lMskZA=
X-Google-Smtp-Source: APXvYqzV4cvph+x4iw9QnWrbLU+PYZ7pHPVu5gaXf5zLuHL5eAGc0SdNKwVpnfRK/oSfv6jyQqrQ8A==
X-Received: by 2002:a17:90a:fa07:: with SMTP id cm7mr3831866pjb.115.1562726392001;
        Tue, 09 Jul 2019 19:39:52 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id x12sm360063pgj.79.2019.07.09.19.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 19:39:51 -0700 (PDT)
Date:   Wed, 10 Jul 2019 08:09:46 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Geoff Levand <geoff@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: ppc: snd_ps3: Remove Unneeded variable: "ret"
Message-ID: <20190710023946.GA15604@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issue reported by coccicheck
sound/ppc/snd_ps3.c:631:5-8: Unneeded variable: "ret". Return "0" on
line 668

We cannot change return type of snd_ps3_pcm_trigger as it is registered
with snd_pcm_ops->trigger

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/ppc/snd_ps3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 71b7fd3..c213eb7 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -628,7 +628,6 @@ static int snd_ps3_pcm_trigger(struct snd_pcm_substream *substream,
 			       int cmd)
 {
 	struct snd_ps3_card_info *card = snd_pcm_substream_chip(substream);
-	int ret = 0;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -665,7 +664,7 @@ static int snd_ps3_pcm_trigger(struct snd_pcm_substream *substream,
 
 	}
 
-	return ret;
+	return 0;
 };
 
 /*
-- 
2.7.4

