Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF229C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F1D20673
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEP03OVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfFOC5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 22:57:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35907 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFOC5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 22:57:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so777905plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 19:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Hk9/rZ5IrrvyieyUT40Z8jtQcnNXuEHhlbj1tNc2gC0=;
        b=fEP03OVWpozICesufQ36bx6UeijE1T/zB8Be00A488QYvCO/KibQIdhloQRoT+rsKa
         ciN0Nu8NLXNVM/7SObKjsr8N+8wCyCdRHy0iMyMqFvEoyWepGN8sUAW6HlQuJwNyJDyG
         Ezv4Uu+WpWhmqZqAI5JMnW/Ny2VIF/l9unpiEJRYYkzwLFQwRMsnIuqDSpqIgEu/zJrJ
         YV4RCC0RkKcpqPDPvNYkmam5njVkWzUuVx3SKQxaYK4CgRDQ3Z5h2HOZoXKgtkQ4Ftgb
         BL9pz68S4/MZNJO3DCBJ9jBwKhmtRaFy3BZT9PBYLligADFfd2Akt+kmk4FbJc0Y+f82
         +2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Hk9/rZ5IrrvyieyUT40Z8jtQcnNXuEHhlbj1tNc2gC0=;
        b=r4bQ+I1TP9P1NVeW0MEXZkFOMU8Uqw4SKEDtqUPsus5mF90y4/ZTXONeqIlUO+ePBy
         aPV5cP/MdWoa/6BgJ9Fl+SCKNsQ95S0wddgrtLvX2dC/U5+qg9VTlIMwoBqfWwu5LaFm
         1uvDGbX+yQFVogv/ItLtuXamLbn9fpAZ4ffkdEoF2LTz+0GKV+Sdv1evP9QBG4Km9L0f
         s4JJLIy21gWmx4Naycs9beo8eMvG1gotI5I873BEcEDvx2IeBWzQv4njYdV8+TXinF3F
         gRVCmL1/nb4eVsYgsMt12pej2qsPsqe7w+g0w90ug+/hoFle37e1GsL9HSdzCoKpxnqN
         fyjA==
X-Gm-Message-State: APjAAAWyGib9EF2QtvCWfQg037aYAiNB8GIMzsPY0ckwZIt9uaK9hqtv
        YxtZt1YmUnLr0fCQ24r3dmU=
X-Google-Smtp-Source: APXvYqwtBSm7wnA6d9emV81aKBlj4yxn9/JIKKP9jZ093cgUGTgXE2+6t1q7G6+h3dwGVBeOMG0N6g==
X-Received: by 2002:a17:902:e58b:: with SMTP id cl11mr75302758plb.24.1560567469410;
        Fri, 14 Jun 2019 19:57:49 -0700 (PDT)
Received: from nishad (p3261240-ipngn21201hodogaya.kanagawa.ocn.ne.jp. [153.202.122.240])
        by smtp.gmail.com with ESMTPSA id h21sm732297pgg.75.2019.06.14.19.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 19:57:49 -0700 (PDT)
Date:   Sat, 15 Jun 2019 08:27:42 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsi: cf-fsi-fw: Use the correct style for SPDX License
 Identifier
Message-ID: <20190615025738.GA29870@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header file related to Drivers for FRU Support Interface.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/fsi/cf-fsi-fw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/cf-fsi-fw.h b/drivers/fsi/cf-fsi-fw.h
index 712df0461911..1118eaf7ee39 100644
--- a/drivers/fsi/cf-fsi-fw.h
+++ b/drivers/fsi/cf-fsi-fw.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 #ifndef __CF_FSI_FW_H
 #define __CF_FSI_FW_H
 
-- 
2.17.1

