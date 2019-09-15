Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC56C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 11:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8D52053B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 11:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2PFXSz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfIOLAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 07:00:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33050 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfIOLAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 07:00:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id t11so15248566plo.0;
        Sun, 15 Sep 2019 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=onavb0e2ood33KFMvNjhoEGksMpgSjp5WP0eiU3pFFM=;
        b=C2PFXSz8/2S8Rxi4yfVYAOn1wnt0TTtNx0HD4ZIztgHq+u9V7csa5rhBehzFXP0Ajc
         f7nKEqn4L04kA+b2VxBlgepJb85085P3W1ozlado15+0ujVaEskQuKkmqU/ZOg+0qLcR
         PUjVJigwCEb7TePJSaFmcRIOq/N4ZIXtiF4A+VAtK2jjoszomIPCH/gFyqAL1dPxzRxR
         vyizdeAKEfpEtMRvMhvqIDA64G3LXQ5mm4dctbqUgs4LCAx9HoCwZ9aNRQ4waeo264Hy
         Hdb+kSXp9BtkVNVxnnHvYjEr4Az0U+k25DhtzzlaLLYprYhvU6NBg8t4t22MNpE4OyDJ
         ee3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=onavb0e2ood33KFMvNjhoEGksMpgSjp5WP0eiU3pFFM=;
        b=o/rQuc9ONk4xXZJI4PHVv2u0a+DBaGRyREFaGu1IwfdHDszV4lwdEXU0StSMvO60x3
         k+D0Qu4jDQ/Y/ZCKLj1IjrILSC/hJpxP+tGAtDJf5z6xDpf5xgav+Gij5m6te3NbtkLK
         ZZWSTvDZ4rdmqsri8dw3bpVioERl5akmj7K481kp7LfXA2bURIb285Xk1ptYAsHcWPjY
         FTzIOBahES4oi7Z5N+g7/nvE/S+QHTh3B7cXKl9XvftO9aUD2elyDRUPET1wWguD73ie
         KaPzIBItDClQByLi1hO1FuvixYWb9dco70xeAhjY1Yq3YAxlkVh8yBpy6BjdameQaiCI
         kcAQ==
X-Gm-Message-State: APjAAAXYlsbmbSUl5DqVqSihOGn30UL+Ihu/cGSHSwfVAKaxt7ll2RzN
        3IuVQuIPrSHFy69enO7cAPU=
X-Google-Smtp-Source: APXvYqyAjqlXX6YjQfWUrSTnFOyG4df0eAg3o6EhHSHlkj4JEpnp6sScVQRmKx69N15/KZjx/jTZFQ==
X-Received: by 2002:a17:902:a5c5:: with SMTP id t5mr56138389plq.316.1568545252898;
        Sun, 15 Sep 2019 04:00:52 -0700 (PDT)
Received: from nishad ([106.51.235.3])
        by smtp.gmail.com with ESMTPSA id s97sm8014912pjc.4.2019.09.15.04.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Sep 2019 04:00:52 -0700 (PDT)
Date:   Sun, 15 Sep 2019 16:30:46 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: rc: Use the correct style for SPDX License Identifier
Message-ID: <20190915110042.GA21443@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in header file related to Remote Controller Driver for Linux.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/media/rc/rc-core-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/rc-core-priv.h b/drivers/media/rc/rc-core-priv.h
index 9f21b3e8b377..5f36244cc34f 100644
--- a/drivers/media/rc/rc-core-priv.h
+++ b/drivers/media/rc/rc-core-priv.h
@@ -1,5 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * SPDX-License-Identifier: GPL-2.0
  * Remote Controller core raw events header
  *
  * Copyright (C) 2010 by Mauro Carvalho Chehab
-- 
2.17.1

