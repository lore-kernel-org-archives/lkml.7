Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E522C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 03:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13AA20678
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 03:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtQC19RT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbfINDLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 23:11:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35333 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfINDLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 23:11:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so19241015pfw.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Vfk9w/GJVFM2A1hYfttl1e1/w+Ekq5Tkv2QLT8UtUcw=;
        b=HtQC19RTCtWkpPa3AzA0IaJha3OniY2qfkFNB29+EoWlkCoC8LUR8buxtkOWwijljj
         15WEJ7YlagxnnW/1RWU/q6i1f4db1MKRpf+QkRbZojw4FWOFqV0LRHMhBeQxQMRRQdr2
         2d+UKgdaQIPgWbSKM9n2NQ+NSOvWfFv2fjm49Xf5jyN2lIS0d1r1oeB2qcFnf6wcfd2Z
         coGh9Yr8CM7CZ6ZWdsUEc1VICWDjiNp2Fq8EjlYr16tTV4ngaVI96b140emBZeJQ7QBl
         DocLJCF7YuNIW22g36OJKoBjy60YS69T/lyw3+rTN7ID6XBSxf+e4TbwwxLGiF5ndP0G
         cooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Vfk9w/GJVFM2A1hYfttl1e1/w+Ekq5Tkv2QLT8UtUcw=;
        b=b522OPe85FcULcBy2Q/hEIh0sSMhS5G4kMWZhAFYwuyV6Sxli4eZ2BiGC4WTWZ1Gip
         HUvTA3ijeKJB6PBkHSpKLrweHicMLs/Jq+qsZ6JhjWOJT8OH6SnTNoidXB8UbRWkzv/y
         +zkL87VRbDhx1je1fXovC3hxUIPCjkAd44kI2xCkLpUU1wQTt7U53hsuNvpgsBuXE0Ex
         xK9UfvhJTfhjgQzE9mCheVRbxeYm7trnZYXIqnn7j6UYfqplgbES9tCooLCQ5o7FNPb/
         70BINFyYu+DVRG6CiAFiNQXWK0WpOv3YJqxZOh4DOtpZ9lKhVWQQBVJJe+K/awZh8JqZ
         SYzg==
X-Gm-Message-State: APjAAAXvzCyCh0JkuoR9YtxQdEDWUCtMLTSyOOI9uB7dMoz0+K5gkxmb
        kKFh8HaWgetsUMkfXfBfZQw=
X-Google-Smtp-Source: APXvYqzFX35TNyC2LTu/xqLiSx9fxR3d6Y/zpV1PcfWtp0yw9B61j4ok1TIe35syoqGr/dWcw7lU3w==
X-Received: by 2002:a17:90a:d981:: with SMTP id d1mr8653586pjv.79.1568430707377;
        Fri, 13 Sep 2019 20:11:47 -0700 (PDT)
Received: from SD ([106.222.12.17])
        by smtp.gmail.com with ESMTPSA id w187sm7244262pgw.88.2019.09.13.20.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 20:11:46 -0700 (PDT)
Date:   Sat, 14 Sep 2019 08:41:33 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, broonie@kernel.org,
        tiwai@suse.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: sdm845: remove unneeded semicolon
Message-ID: <20190914031133.GA28447@SD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove excess semicolon after closing parenthesis.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 sound/soc/qcom/sdm845.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 882f52ed8231..28f3cef696e6 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -319,7 +319,7 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
 				0, SNDRV_PCM_STREAM_PLAYBACK);
-		};
+		}
 		break;
 
 	case SECONDARY_MI2S_TX:
-- 
2.20.1

