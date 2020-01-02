Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB71BC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB2021734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvwUp7Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgABEbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:31:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40181 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbgABEbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:31:21 -0500
Received: by mail-qk1-f196.google.com with SMTP id c17so30614988qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vQjqa8LyABcBdUeE2JB5NAzR+hXd6lMpx7BCUYqPi/M=;
        b=RvwUp7XlHPAhl+sESC0uANnFLglo7t0+euz6UR3seyqX0O1hossA2B64dzgTT1JhmE
         SiSVmEeOzoEFwsl652KzZXIsXZs06XR9BY0/f8Faa73+Sg4SjwSie4C3rTdxhu39MoqZ
         BUMq2Bh3LRfqSeGUyLuicmFhZebOJ0UAaXnPhJlOLwyMhdx2JJSKOWLTox+ouck9dSlR
         kKyS8FTdxr/kIDyAoVChJ0Egf0cStkmnIKol81UNKPGWNm7GPXu84WKvKn9ONOhWOVNS
         XL2d8zX1bl61uia72dWPH2tXr2jKoUUEV6RAtn9ypOls5g/drpcLrrGZ0HEGWeJUL2N+
         eWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vQjqa8LyABcBdUeE2JB5NAzR+hXd6lMpx7BCUYqPi/M=;
        b=q3cIgXua6z/YmDjSj6dIRLlwSDHYb0+ujmF1NfRbnwcfuyNvsrqAi5ZcC4Y70pCfAQ
         1ubGZ8ahlxgRRZDO2SQs/wXuH+v6L+X9/GCKW4X1Sf4i0XARPUaoGZTOjkeIrU8rnoHK
         dYaikkzbKm326V4ojVmftcEIhzDFWzQ4VX4piWmXIP8/zsVRAlXFd+UhMDRu3RxGgsSy
         U40pEiQ7Lz49jsnihIi+DgoPSkk8Z/8d1xaWYmpBssRhb+mqfboWxEU89Rdcti5d1F8f
         64f3yPSMujBG+/DNt3J0Q9MIW4pDvzjb4wA+JH0ynw0eIKiHK8yJZU0KdNMne4hSNWk5
         u5DA==
X-Gm-Message-State: APjAAAXqALPcHjetzM2eOm8W5SgMoBDVojKPW5mS7i7VrXM8zgabgYg7
        pQV0A/DeGlZl6YuG2NPi35g=
X-Google-Smtp-Source: APXvYqzZkF8qqwlW2leReKONWBDhTwZKaJkR3cYtufHA7ObNTymVTB+lnxvWzbmMFNwmUZZfqnto+w==
X-Received: by 2002:a37:c244:: with SMTP id j4mr64044378qkm.433.1577939480463;
        Wed, 01 Jan 2020 20:31:20 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id 16sm14876857qkj.77.2020.01.01.20.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 20:31:20 -0800 (PST)
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
Date:   Wed,  1 Jan 2020 20:30:31 -0800
Message-Id: <20200102043031.30357-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102043031.30357-1-yury.norov@gmail.com>
References: <20200102043031.30357-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <yury.norov@gmail.com>

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

