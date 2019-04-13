Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA00BC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A033C20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6xqvnBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDMHw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:52:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53670 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfDMHw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:52:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so13924916wmj.3;
        Sat, 13 Apr 2019 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GY4d+NuTqiwQyUOOnbyEYbtFF/qVE3bSnQ0D1IhfHQk=;
        b=E6xqvnBbec8JgJGROdyogTcAe8J8naQqwefjbw+g8kxolGCmoIwxtJHQnOSNcTGt1S
         BFUJm/YrQXv41rRw9iuhBrj1CNxn/De125zrUIibtflw5/6QwvPeXRfAq6EqcSBL/qQx
         KAFuO+SvJ1wAnpZMrAnzhHRKIqUtCRCn/kYQ2KU2SXEnXj5wF0MGfs19lvXwAkkbv2y9
         16tc0UdWD5GIijM6ml/eZyACongiuAR22olXY8wC6hSK6bqWFoddnJzg+wrFtJ1plVRD
         XQJsa76KJaA3vLdeRFLptx3GBXeZe7lYAAFnBl6lOMeccnA5FMnx9ey30MHF4Vo4Cf2X
         34sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GY4d+NuTqiwQyUOOnbyEYbtFF/qVE3bSnQ0D1IhfHQk=;
        b=pztz0bBARW7Lz9JViFy1wqvuDhPF0hpgKWMhJWey3TgGe7ycrDbu7G2zULn+/8gA9i
         B+z3YQD5v3V1E/9HqaGcI0dDLIcCFYZvOuolXLny+OJKhAGomTGgLMAK2u8EnBxU5J3Z
         QIN+7253vc+lgPLwlj1AgWvjyMh49DPug8llmEktUGndHeps0IHC4WheqdxWg2EBjWw3
         fJNu5khVC1MEylCIPCkPqkFFoNP0xF5cAfgaXEZ35+lFy5qlvnit01+HlXARtAwTQ56C
         Ime/MnbwPJ00jeDFHVpmpxf5dLlWqFdvTwdPRXdF3BVBS/NbKQD5KZmN2OSPuKoTc1UA
         Zqqw==
X-Gm-Message-State: APjAAAV6tcT7VolIGEwFlazPPeO1S7WNvK8ITgUkFeK5nskMCip3x9Oi
        9I2Y0Tx6AzrymqDL5mUjbY8=
X-Google-Smtp-Source: APXvYqxy4SDzj4+iFTksOksMnBy9KvBHp5aKVo0S6f3WnMKDq55mflB8U+jOrLEKQhWjfDB2ACwFcw==
X-Received: by 2002:a1c:20c1:: with SMTP id g184mr14263983wmg.137.1555141944383;
        Sat, 13 Apr 2019 00:52:24 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2def:500:2ca3:f513:3ec4:694])
        by smtp.gmail.com with ESMTPSA id c16sm12892401wme.31.2019.04.13.00.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 00:52:23 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Woojung Huh <woojung.huh@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: normalize Woojung Huh's email address
Date:   Sat, 13 Apr 2019 09:52:15 +0200
Message-Id: <20190413075215.11889-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS contains a lower-case and upper-case variant of
Woojung Huh' s email address.

Only keep the lower-case variant in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2359e12e4c41..afa019b5c461 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10145,7 +10145,7 @@ F:	drivers/spi/spi-at91-usart.c
 F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
-M:	Woojung Huh <Woojung.Huh@microchip.com>
+M:	Woojung Huh <woojung.huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.17.1

