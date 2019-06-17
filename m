Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30362C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E4B2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QTmcXq1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfFQWUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:20:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44501 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfFQWUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:20:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so18390072edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=keIi3BaqC0xYU7aMFSSUotIwruTj0L0tQgh/AopoR1I=;
        b=QTmcXq1wOn+lNqaytoo/jSuig7HGGTT8//0AfavQRn/g3Ls3f71azmFYjOMeFygxlc
         ih122LJ0Q9/+xVl8ZYmxO2MeoqllfLSph7wfiaQOJXibAF1Lrjq+L1nCYIinl3HCq9mO
         P5BOOQJ8j6RHN7dzGNVd+JzaMOEZq3ixOPjHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=keIi3BaqC0xYU7aMFSSUotIwruTj0L0tQgh/AopoR1I=;
        b=msZ9ue6xWlgVThG3JgLKMC+w2JYyd+bIHOxklSqIoBr81/2IXWPdfqajTZR6SfFENW
         AtVjrQPphswFN016dLtS1a/6RCB+CZ5TZmWvOq9lxMgR1gWjWXQLVJevIJXlm8nC7914
         UF5aV3d9xxBmOyr2ONIc9SUvRJtO485KsCBvGzm+p4w6s83t6eXHSQgMuLQPLjkwK47V
         YpK884U9gQpA38yOlfcspwcuZOZhvIqsTu8JW0EDkEnw9eU3rWd5UcLI2lnz6xlabVB+
         PLvDW1aNFTz9tg7ziYM4Tiw7PC/3l0AerUFOX+2THhhZJx+3nXcnBLqAQyogXI3QJewj
         uIFg==
X-Gm-Message-State: APjAAAV1c+CGJmLvPa2Kpc/7xxT5J2Kerm8kPfCuGDa3jfCzHrJ+gXjE
        JHo/6br72Plj7CFWZo2aqTHniw==
X-Google-Smtp-Source: APXvYqxWO/6swOglZ6QtjM51EtbNpra6XHo68OmBbZ4d/COdwq0W06Duzydtph061WNgch9yymiydg==
X-Received: by 2002:a50:92c4:: with SMTP id l4mr18071273eda.34.1560810043605;
        Mon, 17 Jun 2019 15:20:43 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-113-204.cgn.fibianet.dk. [5.186.113.204])
        by smtp.gmail.com with ESMTPSA id 9sm1034852ejg.49.2019.06.17.15.20.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 15:20:43 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 1/8] linux/device.h: use unique identifier for each struct _ddebug
Date:   Tue, 18 Jun 2019 00:20:27 +0200
Message-Id: <20190617222034.10799-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes on x86-64 later in this series require that all struct _ddebug
descriptors in a translation unit uses distinct identifiers. Realize
that for dev_dbg_ratelimited by generating such an identifier via
__UNIQUE_ID and pass that to an extra level of macros.

No functional change.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/device.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 848fc71c6ba6..eaba6952c2b3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1563,7 +1563,7 @@ do {									\
 	dev_level_ratelimited(dev_info, dev, fmt, ##__VA_ARGS__)
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /* descriptor check is first to prevent flooding with "callbacks suppressed" */
-#define dev_dbg_ratelimited(dev, fmt, ...)				\
+#define _dev_dbg_ratelimited(descriptor, dev, fmt, ...)			\
 do {									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
 				      DEFAULT_RATELIMIT_INTERVAL,	\
@@ -1574,6 +1574,8 @@ do {									\
 		__dynamic_dev_dbg(&descriptor, dev, dev_fmt(fmt),	\
 				  ##__VA_ARGS__);			\
 } while (0)
+#define dev_dbg_ratelimited(dev, fmt, ...)				\
+	_dev_dbg_ratelimited(__UNIQUE_ID(ddebug), dev, fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
 do {									\
-- 
2.20.1

