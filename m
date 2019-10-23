Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0A7CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B3120650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCy1E55h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436523AbfJWQaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:30:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41806 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733066AbfJWQah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:30:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so20323177qkg.8;
        Wed, 23 Oct 2019 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYgftd2K8E8go6dCNMYIgx6K/W9Ge4PxegoF3wHYU3E=;
        b=dCy1E55hDsAjxQkiX5GhMpmqTL9uI76H1e5PNjFchBvecUy2B+e1tODI0wXOMWN1sn
         0MCyWyrDehNtD9FvKAe6ROFsAo9oRz3xtsCeQBFrbu69fkuYDCE9gLLYwMj+TC+zT0By
         AIV784ejMABZAch9RDozoOmtn54UBvrQsmyfJMpfM8JWfgePgY6lQ1uxe43iHTZW8hq6
         FpNllPsdx2qsAz8l8YVIB1sGiJ+QiPVDMMjAMoOYWrUyV59KDXNyc3nnwXeORn8FP45w
         xaQloBDs7mplIsGlL6bSSDbjxJHGlnonUW/0S6Q472CUqR4zMzxhAC+pob2XJrG24iLk
         /foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYgftd2K8E8go6dCNMYIgx6K/W9Ge4PxegoF3wHYU3E=;
        b=mi+5G3323QM3o1tgD3BYHuTB8Y0yKHzJ6SvFHe5IWKulxzGG14TOyD9yIlfme4vuWc
         0EAWwhA7cNsNxwz982JyPxmRtL3mYv3bM0SAwNFeYUBSjnQp+glX25hwgGxb4nh/+LRX
         glRpfVJ3oCESUA+vXAsJJ+qaf1jxi6NN19AxTtzy6RuGKajP76oPC42CfrllkkqN+MMK
         fiavUpaVmpQbV9nUa0DnFkKSCMqVR4Qs/kL0BQ55P8UMKzZVfSO4HSxwqZJ82vIgQqP2
         IVMDAffiDZzV2zh3RrkDo9bpj/h2EdMK8MzfXgU2nX10A8apjRn7X/gfKaehWSKhuXSu
         7RbQ==
X-Gm-Message-State: APjAAAW5b/xpzWMQYWBsjpWUb4mDd9rAp3/wCcxU8j+Qm+tW0X0xbau2
        Yura8g3ZnNbxgI0F1Ai110CzQQ/MLCY=
X-Google-Smtp-Source: APXvYqwxkA4DrX9v8F+Q+HJoksaXxlOaxtpEDuojTHcca2QXtnQzSaI2etcK0PsD1F+c+7S/Kv2e9A==
X-Received: by 2002:a37:7b44:: with SMTP id w65mr9301660qkc.409.1571848236668;
        Wed, 23 Oct 2019 09:30:36 -0700 (PDT)
Received: from localhost.localdomain ([201.53.210.37])
        by smtp.gmail.com with ESMTPSA id t13sm8349067qtn.18.2019.10.23.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 09:30:36 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v3 0/2] staging: sm750fb: format description of parameters to the kernel-doc format
Date:   Wed, 23 Oct 2019 13:30:12 -0300
Message-Id: <20191023163016.30217-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cluster comments that describes parameters of functions and create one
single comment before the function in kernel doc format.

Gabriela Bittencourt (2):
  staging: sm750fb: format description of parameters in accel.c
  staging: sm750fb: format description of parameters in accel.h

 drivers/staging/sm750fb/sm750_accel.c | 72 +++++++++++++++----------
 drivers/staging/sm750fb/sm750_accel.h | 75 ++++++++++++++++-----------
 2 files changed, 90 insertions(+), 57 deletions(-)

-- 
2.20.1

