Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CF4C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAA620578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKmsmkpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfEGK0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:26:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41081 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfEGK0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:26:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id l132so3474881pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sLt8k/Ibit5MXW+2DcTy1x+/PaPOiRW0J72G+A/4PHY=;
        b=OKmsmkpVX1GWo4n6EuuYNx3ev2lqwZzR/saFLgXL8WaxXKLuX/fHhBi4I9e3PUm0SW
         x3j+ZL/4U2LSuDBvcXu1Yc+ISrlUjm598fdc+a68nCrvGGDyJlejuBmTa0bvHmzp2Bfu
         t2y6ZPnLIO6eK+ZKzBUHbdxzzAfbv8oMQdMlEVQHinAXo3JI7d9yGKV8UekGXsWFs6p/
         3XVqQz1gqkdPy+I3NMpt1FXyy7VQIHK3BejMQKrAfJpJKEv+lR5b+WZvHbgXexktnw6g
         J/Dxf2zo++G8J89BNQ74cyDMSd3zHByeY8inkFGzVPyixM0zLfUQThhJkR8qx/zcinjC
         FkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sLt8k/Ibit5MXW+2DcTy1x+/PaPOiRW0J72G+A/4PHY=;
        b=esPM1BCMUzfZQwoo0peASyzeqwDhZoM7YbJYaxvCgPsHC2/ieILhMJ0vw/wc/Eb/I1
         PTf+WSuV6+HNnkHN9toZeRXIvxh7plimdUKRt+T8e8AKceIBx8Bj13DIMmg5eMwgHLXG
         a6NOlOIk/3XeUSYqWz94BRhNAmmV3cgyBqOdkxIO6Rg7wMq2e3UU3ww36p7NAcnpHUN6
         wpiEfMI1uZODQDjrfoi4ol3qisf8Maee6f0iQfg9lkAb4irvCosXnodq38Q+tzoz72Rk
         C+/kwf8eb6jy61nDhPZc4PMl6eGpDdMrfOGYoXV4fvaMG3AO3b6oPb5TLwKplZt45UG7
         0z4A==
X-Gm-Message-State: APjAAAXKfz2z7a3sYJ4DCa74NhiYiUXk0ZbpREazDWLbbWCLPKhsKuzY
        /TAOr/+Mqxek8mX717rsndc=
X-Google-Smtp-Source: APXvYqyp30i6Tlo5D4c9BcoBQCHXBNTyHMUqXt2iDVFysO6A3yCt9BbeBsRn4Bmd6F3usKLscraP1Q==
X-Received: by 2002:a63:5c5f:: with SMTP id n31mr39262217pgm.325.1557224813794;
        Tue, 07 May 2019 03:26:53 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id i75sm22993533pfj.80.2019.05.07.03.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 03:26:53 -0700 (PDT)
From:   Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To:     greentime@andestech.com, linux-kernel@vger.kernel.org
Cc:     green.hu@gmail.com
Subject: [PATCH] MAINTAINERS: update nds32 git repo path
Date:   Tue,  7 May 2019 18:22:25 +0800
Message-Id: <20190507102225.4174-1-greentime@andestech.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use git.kernel.org to put nds32's latest code instead of github.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c2fce72e694..967ac42d1a89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -963,7 +963,7 @@ F:	drivers/staging/iio/*/ad*
 ANDES ARCHITECTURE
 M:	Greentime Hu <green.hu@gmail.com>
 M:	Vincent Chen <deanbo422@gmail.com>
-T:	git https://github.com/andestech/linux.git
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
 S:	Supported
 F:	arch/nds32/
 F:	Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
-- 
2.18.0

