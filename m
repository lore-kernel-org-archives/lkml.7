Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA27CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FAE21897
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkajqyNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKAVs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:48:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41766 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAVs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:48:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id o3so14899382qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ydkaqiUndvm12oKsPXUCT8XdG0VC6PHW8cZ5YaD7Is=;
        b=VkajqyNcqBhTysuY+9L/fqxUYlJRoeFSBdotA9y5qE3URez6Jq5OwAJAvLmEOxg/fQ
         Mu3367pMl5vAKCTzUIaO5TJIGwVPUtpbPtm32kre4hIi7X4ks3TV8nWVS2fC0WpQQiet
         vd+uXgCXb+am1z3HG67PI8nSk3VdE7POz4Zqov4oDyCRbVCgF3SVBzUMj7UuSHNw9qsf
         vFsh+b/Cuq1f+JreP8BlILo4wn1gyyW/amCR6GK+UL8yqoQtlZeiK2zxp6yhQHHex5fw
         4HN9O7nzyxS66p2ZX73FAoJbB+03uawlH46258rLmCZCbHZtsjUbaGLKuzqLZGFDzfmo
         e6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ydkaqiUndvm12oKsPXUCT8XdG0VC6PHW8cZ5YaD7Is=;
        b=hlOxcGhmmoUGj0b93KRb1zeG1KtZfL2sEajc02w4x+eUMPCgu420+eLG6UtaWq0V2h
         d24JCj7Wh1lRHHOe6anysVhZtrF5hdC/OoBGGGYbvsq+5oDi1DlHkP92AMe4NdBwCZ6K
         /w+6rcBTAoFaC/2IcHht4YbL3VxNpzPiRTDR1dE1qj+fHyfpi9A4fvjwjOvMqyytCLjN
         C/g10GXPAJas3XvhkKm+nYPJi3M4U7T3+YvGorKmObj6EdTKQRj3++njM/vtRNstbN4E
         ewGHIUp14vwh0fGWktxCdftWtcUwdCxZ13hhNTKcmezVa6FhhZDpYcTWdltaNUjSGa5K
         59qA==
X-Gm-Message-State: APjAAAXviW8qMA7KAOhKCkDH6opbPLNraGT+l5swBFJJ0F5Ni/ZJT0iu
        bmcZC0+r0ZJVfBYcAJuD0mM=
X-Google-Smtp-Source: APXvYqzC91ObphFfFFrFsQgh1ScFvBn+AK56YCKyqplp9ASMS4yDktUIdICHLEO1znGXJAk6S9Kpbw==
X-Received: by 2002:ad4:57a7:: with SMTP id g7mr12254000qvx.30.1572644937106;
        Fri, 01 Nov 2019 14:48:57 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-84-14.wifi.ic.unicamp.br. [177.220.84.14])
        by smtp.gmail.com with ESMTPSA id w24sm5482300qta.44.2019.11.01.14.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 14:48:56 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v2 VKMS 0/2] drm/vkms: Changing some words in 'blend' function documentation
Date:   Fri,  1 Nov 2019 18:48:46 -0300
Message-Id: <20191101214848.7574-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- Add fixing typo in word 'destination'
- Add change of the preposition
- In v1 the name of the function was wrong, fix it in this version
- Add the patch changing the word 'TODO'

I've tested the patches using kernel-doc

Gabriela Bittencourt (2):
  drm/vkms: Fix typo and preposion in function documentation
  drm/vkms: Changing a 'Todo' to a 'TODO' in code comment

 drivers/gpu/drm/vkms/vkms_composer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.20.1

