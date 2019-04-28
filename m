Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA9BC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EB22077B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah239En4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfD1D35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:29:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40631 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfD1D3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:29:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so3410186plr.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 20:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OLqlCdGifnXbJDeVsXrWrzyh1Q2u7Oi69jQbP0f+asI=;
        b=ah239En42iuJ7me6T4fHnEcZH+drR1+tKtot9toQwo5G8dOXq0bXOCxE1rKtbmkc6i
         CG+7gKVAZ6uHV+lJo1/UcDMjhdOWDFp2PqCkSb4QvEdpBdiKhbp64vzcxpOtX7hfDngg
         occf2ycAE0rziQmQpDGFhUk3v3FmlMxu8/RSfxNXB1iRDyOE7hAYmULFMxS6TGCRDdg6
         3XWbKiXKcGB8++D5rK4jQzf5hYwfImQYke1YYYCeHhi+ouyKAXbauXzRmBgE+aJogIG/
         9sqdXUdyptGdIWTAikfNomxp0qCPeZN0UMP+P7v16zJfQ+gDXZIPOKtYtvpMABi8nwT9
         7Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OLqlCdGifnXbJDeVsXrWrzyh1Q2u7Oi69jQbP0f+asI=;
        b=SlRRKIItQD9+WfTa1U1S1hr8lMTUFJRfs/j2vjBy9p7VbiApuQ02xeoQ6ZHHJu2iV6
         CxlMnCrY5mIuVpj7uTBk6G/g7B0pw0dnw4y2Fovk+wTCn6O6yrq+erARW7M1HLpw4GQ+
         XNDPEdN5ZyOSvBCSvTCeVCSQFaFwdFFxqQ0JoWzHNGMD/vTidRdwq7xwAnf48byxNW3f
         psipLneFCPqUkRgJSCmKlD5Uyvv18yE5wW1pF8/ZgvQMEsl3h6H/gxf57JrpI3g6td2m
         FNO5A5Iw/xDT5kgSx850bNis2J45EGHzCH2rq5RJG8NUm1480DR/AMHmUZrdplVbPvMf
         wsBw==
X-Gm-Message-State: APjAAAVLylV4yJ9eHM3PUxos2WtcyKoysQzXe33e/fIziMTS9rXTD91R
        i2flKfHGV1vDmoSorwB3WrQ=
X-Google-Smtp-Source: APXvYqycFkoH0Fz362DI/R3ujrzVANYFmQIZK0QgzOdvsKX6Ndyrihk4aH5L7uQShX24LkGf+HxufQ==
X-Received: by 2002:a17:902:b190:: with SMTP id s16mr16229559plr.83.1556422193180;
        Sat, 27 Apr 2019 20:29:53 -0700 (PDT)
Received: from localhost ([2601:640:6:3484:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id s20sm35446587pgs.39.2019.04.27.20.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 20:29:52 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 6/6] cpumask: don't calculate length of the input string
Date:   Sat, 27 Apr 2019 20:29:36 -0700
Message-Id: <20190428032936.1317-7-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428032936.1317-1-ynorov@marvell.com>
References: <20190428032936.1317-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New design of inner bitmap_parse() allows to avoid
calculating the size of a null-terminated string.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 include/linux/cpumask.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 21755471b1c3..d55d015edc58 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -633,9 +633,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
  */
 static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
 {
-	unsigned int len = strchrnul(buf, '\n') - buf;
-
-	return bitmap_parse(buf, len, cpumask_bits(dstp), nr_cpumask_bits);
+	return bitmap_parse(buf, UINT_MAX, cpumask_bits(dstp), nr_cpumask_bits);
 }
 
 /**
-- 
2.17.1

