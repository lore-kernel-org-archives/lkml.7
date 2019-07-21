Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A27C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B02F21743
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yam6/Ypa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGUV2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:28:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33378 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGUV2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:28:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so16379729pfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 14:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uzae+Qd1Byrv0UOQeZfaSHTaSyqBzZD/Hpc9kz59NfY=;
        b=Yam6/YpaOP6bPTYwljYxwlWuX3jMD/lCzg3QiuYIa6gRAmzrU8wKPQ1ILS3OSpKirO
         6lgKvjPdvFrJbgH0wxsT4NvWeTYQ2s8uSe2i9aN1Py8mVBesyKmO1HZu9FlE4wRth2bq
         5akk3QyFYHwG65RBQtkuXuYQCrA3PhblISq3qdjG8wu4GKvan7RSC8e8X71FwVQQVzVp
         0itzSO0NGWzPCAL27VKQWrigRihwjsvNBpBKhob/jS3hyfTTbEP+qrJL+2I9IsnAHpwA
         /TVXO53jGoMgl0ca5aGaqvQE1tT9E6aHqeOeLmOROgWrphmueA6auBYxwMDalqZBAL8Q
         XNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uzae+Qd1Byrv0UOQeZfaSHTaSyqBzZD/Hpc9kz59NfY=;
        b=mX/Ouyt/UpfEmiriQEyByVbYDlcGLPYU5j/0dGWZ16hXCEuZsyJFIB2zOpkhSOCOit
         LBlGydh8o7HRoc1nRujF/DBslIRg5qYTJCwjo3TGGsdf033IwDyS6zpcWmWKJKTP43Nj
         4lV8KD4zUFkoUKdSF1gFLcMpXIJu12Nm1SiQiGZtuTiYIgjFU4tCz70NrkDaSiPoT68s
         b1G5z+OJ1freVvOUZsiKVBc5uwQpz87TYQ6LaQjoZqzPTxcbt06dg61HpC2WOkrrQnXv
         wG1e/pZrJgdSWginMhmkFmOZhoxGFwn9krHBchtgaJkv5pHNEgkgakftrIC6R/evsKbB
         MBYQ==
X-Gm-Message-State: APjAAAXHK/Lp/LP2L7ulMyUcrQcbCD0LNmOBUZmQ4VQuycTlr12qE+RQ
        xuHnRtin5u7GvkkRB1Q5sDs=
X-Google-Smtp-Source: APXvYqy3imS8LcCW0KIw5rHT/3yUpApQ1RumQtdmq4C5tgkebLhe6k/q9lQLM0Z0ng/Cs7C7tMUwSg==
X-Received: by 2002:a17:90a:ab0b:: with SMTP id m11mr75527588pjq.73.1563744523798;
        Sun, 21 Jul 2019 14:28:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:105:2ef8:a909:5e8d:6363:7009])
        by smtp.gmail.com with ESMTPSA id t9sm37970510pji.18.2019.07.21.14.28.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 14:28:43 -0700 (PDT)
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
Cc:     Yury Norov <yury.norov@gmail.com>, Yury Norov <ynorov@marvell.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 7/7] cpumask: don't calculate length of the input string
Date:   Sun, 21 Jul 2019 14:27:53 -0700
Message-Id: <20190721212753.3287-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190721212753.3287-1-yury.norov@gmail.com>
References: <20190721212753.3287-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <ynorov@marvell.com>

New design of inner bitmap_parse() allows to avoid
calculating the size of a null-terminated string.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <ynorov@marvell.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 21755471b1c31..d55d015edc58a 100644
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
2.20.1

