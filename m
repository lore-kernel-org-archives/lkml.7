Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14173C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD83A2196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGm/mKgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387799AbfIIDdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:33:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39630 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387619AbfIIDdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:33:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id j16so11227675ljg.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 20:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7HrLaUycn7d84Voxa4K45NCBL5KXP9evMiq59t0jDTA=;
        b=QGm/mKgP1l6sLr+I+MVnGSwdvru5M3VOm+YZZAFcrgUEk2DR6o93771mUDvyewLUz4
         Pt+vvHA2sCeCkEpQhVzxFQOZzER5FtMgpgMIT06inVSWAPZodnzVzfB2Zk9ZRHCsrIS/
         AGpvfeV45BNeL2fcuIOiAO7o/6IjqmLn9byTMkr9GOK8PgA0dLGr+lVRftlMD8RXMlAt
         WpgnqrjBTmwtEO7azK+El3MVw4JLoqPms8sfGbHhnocmT5PWePTHuFZLagCx6tkIJ/nr
         pSY/tWMEoRFP37I3AXqWMkwoX0HxUxGH1/m6B4GmcB6pj3rBzlLhrnFt8wK6redEPF80
         /Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7HrLaUycn7d84Voxa4K45NCBL5KXP9evMiq59t0jDTA=;
        b=aKM1ejfE3Fm9Rc7s8DVYx4LNrv3X5zvV+O0dmd/xFDvRHDy0YrYe8MRs0wsZZ7ljn1
         MSsXPytwKPhChWL2gROVoIfUT4QsHzPQefufkRdgaLOh5VmnnkEqI5Pse1xpQoJieNJY
         zuZbU8emiVCATnGsgwXmsaAhnuRZum19QMtvt9VZuUMWa8by7rERGCpza9C3Wd7AcxSC
         wtX8ofTlECaAUqJ5XKDVGsqFBrdKZ8vdgP80lvIkyob6kXbOkLxYzvNSz/AMx3s9CYih
         Xmxs5PI7FKqA31agDbFQcoKh8GFkFNv83fybO90cCU8xRpb/YR4UP0ADU5q74g9vaUXF
         4Ymw==
X-Gm-Message-State: APjAAAUzCY9sOoAXzL6QkV8nDqC/7WlMddsTfNlwO3XpJIUDlrB6d4LL
        oL5tCcyNZ+a6q57kjTy6jmg=
X-Google-Smtp-Source: APXvYqyhGodpiklMJnNZAHntJKm2hzeJiG5QDa/Vy0/gVENIIn2BkY7GY3I5guwqe3EFgVjMF17A6A==
X-Received: by 2002:a2e:819a:: with SMTP id e26mr6059579ljg.197.1568000000346;
        Sun, 08 Sep 2019 20:33:20 -0700 (PDT)
Received: from localhost.localdomain (128-73-37-85.broadband.corbina.ru. [128.73.37.85])
        by smtp.gmail.com with ESMTPSA id f22sm2783605lfk.56.2019.09.08.20.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 20:33:19 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
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
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 7/7] cpumask: don't calculate length of the input string
Date:   Sun,  8 Sep 2019 20:30:21 -0700
Message-Id: <20190909033021.11600-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909033021.11600-1-yury.norov@gmail.com>
References: <20190909033021.11600-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New design of inner bitmap_parse() allows to avoid
calculating the size of a null-terminated string.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 78a73eba64dd6..d5cc88514aee6 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -663,9 +663,7 @@ static inline int cpumask_parselist_user(const char __user *buf, int len,
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
2.20.1

