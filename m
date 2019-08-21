Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E173C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D171722D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 01:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbJFB5Bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfHUBj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 21:39:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37437 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHUBj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:39:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id bj8so402199plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 18:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqqKzrWZ2qS6dkegXVibW8kuKykZZ/rF7T52aZbqzg8=;
        b=bbJFB5BlSAycA6QyAKp6liX5bCCkHw6nKRuM37P1r6OdDcraPKjWnmWclRCV/MQOtV
         bzB9GhxXasVkGbfiddRw5PkD6dKN+BSruFLwouI2YaH8WNuGPoMaYgia41Uoaez1xmVg
         E9dB0GT/myQ2vaChXNgSkFLl19h+Dz9LTsS1UrhnJpRS5+OqkOkBU5pZ7/8Jg8K+ADs2
         1h0w7kxtye7pYMmzW9RrsYgF4l8zZSfAuttNxKqf9OYzEphkTETl74KqVyoOURO0wuT4
         S8MXZ3z136bKE/BYCz24idCgEZrgA4WqupO23T12PXcp9gn1UZqV0Tfd7A3eFhO83KEd
         j2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqqKzrWZ2qS6dkegXVibW8kuKykZZ/rF7T52aZbqzg8=;
        b=toEZnDVZblhsLDhCOkLRg8fI6hTCTWUCUuzQubijqZ3izWl8EXT1ICaaPGsn+S64Yq
         tzUhGpurZPp2PULB1+RhuZ1yshGZp5mbF1k1lp0zSDtlZRKtcGoHVViIlMag49jNLje1
         lJuhQmLLwThZ/LjImHEtswdB8WCUXUicho1uSS1MNxXEHn+kFBj3dh+cZpZBeiqmciEW
         8WxfpkPKHj8laQ30BhWDqjrEbrhn5Ocx1mME8j6liJZRdo/o68uk7Ph9yB2efJC7oaha
         NG3rr0++nJKLadodIX0buxYnWNLFodTmmwHssN2OBkwefalP2TMIPjm4Jev+whz6LpaO
         5nvw==
X-Gm-Message-State: APjAAAVPQk1c5uByCtLsaXvQOTSZ7q8Pc91A9ap0JdUssVChlx9NDHBp
        HXyYmAPeGqI79MUvB+V2mHY=
X-Google-Smtp-Source: APXvYqyekUZD4O/1faXol7aGwG8dEb17vfvxxK3EHSMCKJsevlinncbzs1Jrt5AqrPAeV69oLmkbvQ==
X-Received: by 2002:a17:902:9a8d:: with SMTP id w13mr30762630plp.157.1566351597472;
        Tue, 20 Aug 2019 18:39:57 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id 143sm23155295pgc.6.2019.08.20.18.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 18:39:56 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: vf610-zii-cfu1: Slow I2C0 down to 100 kHz
Date:   Tue, 20 Aug 2019 18:39:36 -0700
Message-Id: <20190821013936.12223-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fiber-optic modules attached to the bus are only rated to work at
100 kHz, so decrease the bus frequency to accommodate that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

 - Spelling fixes

[v1] lore.kernel.org/lkml/20190820030804.8892-1-andrew.smirnov@gmail.com

 arch/arm/boot/dts/vf610-zii-cfu1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index ff460a1de85a..28732249cfc0 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -207,7 +207,7 @@
 };
 
 &i2c0 {
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c0>;
 	status = "okay";
-- 
2.21.0

