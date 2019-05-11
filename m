Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14809C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 13:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D156F2146F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 13:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjHMIV7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbfEKNlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 09:41:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40372 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfEKNlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 09:41:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so4395329pgl.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=fMbhxbGSMg6IyfZVoXPipxwzBU2Akzjdq8jUr8r58Es=;
        b=WjHMIV7z89eRvB7MKFxUJmzX14CLSFQdjYN/CWmy3f3zArIrZI4+3wlGNA6BSqdM9M
         OZ036V09A0yaMcSuduAqBLdBqmXn9W30UcwbTN0PPDsPOHZpCvfB1rteWL5GCHUd3jLP
         a8P39aksSv/X0jySZpPY1Hpo3OGyvActIE2iTLIre3nc7Ie1ilJLDGSa3LgnKKxQ+4xf
         HxA/U/dxOgpVq75IILg57kMhwOeI3/u1TMzQi3vRzKiJRDTzLOzQdFoGtQJ80YDqiZCR
         JUdVJjsMjnxS+CgnbTMK3zvOsw4H5hzjB/5GLJdx3zjDIbGfLdhrTIA8C4eH06Iuu2sc
         jN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=fMbhxbGSMg6IyfZVoXPipxwzBU2Akzjdq8jUr8r58Es=;
        b=bxyP3/VRxg3JUFuwYteWz4d7JCUvGjkmfbqFMCy4WRk2gVjpKAP0cU6ujSHlpy4+ZZ
         937b5xq8OTnRtyutp6H1CWVzz+/SovKE6R9bPhjeeIxApeyvyGaqRwhqpYGSOQ9EtZKi
         S5zqdPJ5YqNbZZpYSPM4nWbO1h2dT359CkfaaE3jjh7cyQHgsID1yXCqng1GNkN3355m
         0lMZI1facgFSDybbiPL8G5436tFvpXwIzmLMUQ99z6XwbbQrp/xg6ZBhcOE7pS+4+Djw
         lGGxjyddSaRShRnlQje0FsCKjuJbFh257RM/dS3UtaI5pQ3RcYOfHyzoYnVv0JeNGS2b
         P1AA==
X-Gm-Message-State: APjAAAXQkQZHi19orRaItuNJI0z9cVLbtRCtnu0AfQs31JKYsjCCK87M
        nhMy+YqARgTDhH9plc2bZfTgFDkW
X-Google-Smtp-Source: APXvYqyQ2Q4LRWGH2zCQqkTNkeYBRTC9/zl1HH+gmEa+mh71EI2WR5NG+Gw0RgAsL44ne6CaNG0Xlg==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr21066887pgc.140.1557582083914;
        Sat, 11 May 2019 06:41:23 -0700 (PDT)
Received: from sabyasachi ([2405:205:6182:13c5:4c7b:e4f7:a66c:4459])
        by smtp.gmail.com with ESMTPSA id 132sm9981863pga.79.2019.05.11.06.41.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 May 2019 06:41:22 -0700 (PDT)
Message-ID: <5cd6d102.1c69fb81.b7df1.aae9@mx.google.com>
X-Google-Original-Message-ID: <20190511134117.GA5069@sabyasachi.linux@gmail.com>
Date:   Sat, 11 May 2019 19:11:17 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     linux@armlinux.org.uk
Cc:     jrdr.linux@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/tty.h which is included more than once

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 643d5f2..0016d25 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -22,7 +22,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-- 
2.7.4

