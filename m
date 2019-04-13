Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02934C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 09:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CCE2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 09:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCE+jE3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDMJ0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:26:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54846 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfDMJ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 05:26:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so14083723wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L5k4AjfcQhtb2vk+GG1PuhrK51n5+tL2rKsNkgCukUE=;
        b=WCE+jE3A/sEpKyvy2ESFMqUqnmlTMXKaQlJRyK0EJ+1XpKXuovEQjUQpZxV1bbeDJ5
         csTPydIXP5HU1JWEq+va9KUDbhqOXpNuTIAUInwn98l/kWumnAL8tngtg+hswAnGYM7s
         AkZn9PINDQI/yodwvJk496pkQHl5aICTxEwu7V1K3R5WedTkroCh96IleQYHoPsltXTy
         KP+wtPLPu4C4aExUHzIix3UhwShtlmoXCQENBviQRLv5MSKbE+8t3H/riVAszLljfG6E
         2WoPrAxaY9Z2tfb3C8HzNz0XEAgUBNC6Y47DGJgtQQZtgcIohd3jZADWbh/Tj0drQIys
         Zgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L5k4AjfcQhtb2vk+GG1PuhrK51n5+tL2rKsNkgCukUE=;
        b=ESv3JDpmxsKCEoO4NM+pG/jMFfs0dtJTKhu7yq7h7V6EHVxWwySrHbziupqGDBREjj
         uxXbwSg8fUOK7vbYD0yVE2XZXYDq2Yiid1cnIAx7ZhCtB6NJdANiGwmHianK4hxvVVR+
         CAMi29nKZ+0GeXfgqRWD3ZkGcWVUaTZ62b9ymeplCyxt4IlPt4/VoSmyyru4XpagTBJe
         TNAXacORAaGCOdJDGuOCNnvYHIxbqfaF1tAL36pfDZFK/uRZicmLhHtRtuMvS3scL+Nm
         +peiQuV+CLH8IuwnIXQfwDION4c81bqU2zCcJ+rxe0sXqWVok4T25vWm9HhSvb7caCC3
         cZwA==
X-Gm-Message-State: APjAAAXVqqlhvqpm1RahBtpVvjIGrNliY3e5pOFoIMqFJ6P7BYpZ5g4Y
        fouElwlsPAg93kcC5VNHbj54Lv90
X-Google-Smtp-Source: APXvYqyhJRgcoX4xqiRW0sL4xbO3tgsV6yjHvVSo9ef9oTviCa6CM+MbUVJzDkwcTfVFguu9BR44uw==
X-Received: by 2002:a1c:a9d4:: with SMTP id s203mr13844254wme.117.1555147562897;
        Sat, 13 Apr 2019 02:26:02 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2def:500:2ca3:f513:3ec4:694])
        by smtp.gmail.com with ESMTPSA id h12sm42356702wrq.95.2019.04.13.02.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 02:26:01 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michael Hennerich <michael.hennerich@analog.com>
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: normalize Michael Hennerich's email address
Date:   Sat, 13 Apr 2019 11:25:48 +0200
Message-Id: <20190413092548.13995-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS contains a lower-case and upper-case variant of
Michael Hennerich' s email address.

Only keep the lower-case variant in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index afa019b5c461..b486b9e5d73c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -949,7 +949,7 @@ F:	drivers/dma/dma-axi-dmac.c
 
 ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
-M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Michael Hennerich <michael.hennerich@analog.com>
 W:	http://wiki.analog.com/
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
-- 
2.17.1

