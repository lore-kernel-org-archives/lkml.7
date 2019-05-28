Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABCCC07542
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4A02081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 02:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIc21H9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfE1CTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 22:19:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40843 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfE1CTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 22:19:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so10467527pfn.7;
        Mon, 27 May 2019 19:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ElrAVYgD/pSAQ+6wQeGjrI42nh6rZoHmZOAfKuzcT8A=;
        b=vIc21H9T5LGBgUwhAb/LkJd3XusoSLmb4Q14pPQ5a9BIlSGrc3P3Jjs+ShUFsvA7S1
         x2VL371PJR10mD2sZhvpZZ7chIBmKgAFze604Ij1JHj9P4mcwK5Id0v2/a3I/tMg4Bza
         xtGCQ3NNVBxsBoC1XQ9GG92hrSa3mIoVKhZyU7eq6WRCT0xuUtTkWZY+g1ycIyFW6QhO
         gMrYlsY/xrlAIbN9E/QLVvU3eCJaF+RAQmGIpH3fsdCr5GnImqUH89lMcEX5OxcrzoWi
         qw5iKfVVnbuZru0kuNoTLm8DsMm3F/eyPXVxU4VN8nCKr+kKFrqtEgFkXZ0Ee/OIHxeo
         vUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ElrAVYgD/pSAQ+6wQeGjrI42nh6rZoHmZOAfKuzcT8A=;
        b=WzIKQak6jimLDRESfnkF5kLQjoqvU7OrbiQhVWeuRDiDkkYeTMFnh07VB8hliUC0BU
         khhKljDXBq0st4U8xjFaH28yV6p6TFTY7Q284OnwguS4BNT5zpsFJJ4lijHyJW+HHRKA
         UTEEDr8qumBHbGLtG5THjG7kXXsLulMe1ZYBQG9hAJqfelbClU0pZIRAUCxUaQYSdw4m
         MWGZFA53p8uyeGFhJCqnpHoJeOLavE55saTzB1POHARQY/rB3Rhz/WX/C8QwACn4Szyl
         NqiAaCZ+54LP0i1RjFkVKQ293kOp03pigXnEISeIMEQ0GEUkNiM8hVUozV7sOcz6am0+
         iGdg==
X-Gm-Message-State: APjAAAVdWsQ+B+Ikxp/F1NytFIiGfjx8PWxc91kSKr0+/J8ytGL2afhT
        Z3kcZweP+9MrNZVLFpkGl0s=
X-Google-Smtp-Source: APXvYqyJg8sXr+xQ9KqbTq8xkIhL3JBqyrbB/O7RzkwuyYMQNIFZxwzPKpJQsz1wMhFHwE8RQ7PWeA==
X-Received: by 2002:a17:90a:8586:: with SMTP id m6mr2256305pjn.129.1559009954183;
        Mon, 27 May 2019 19:19:14 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id b4sm12463484pfd.120.2019.05.27.19.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 19:19:13 -0700 (PDT)
Date:   Tue, 28 May 2019 10:18:51 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     emilio@elopez.com.ar, mturquette@baylibre.com, sboyd@kernel.org,
        maxime.ripard@bootlin.com, wens@csie.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk-sunxi: fix a missing-check bug in sunxi_divs_clk_setup()
Message-ID: <20190528021851.GA14526@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sunxi_divs_clk_setup(), 'derived_name' is allocated by kstrndup().
It returns NULL when fails. 'derived_name' should be checked.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index f5b1c00..830bfb7 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -989,6 +989,8 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 		if (endp) {
 			derived_name = kstrndup(clk_name, endp - clk_name,
 						GFP_KERNEL);
+			if (!derived_name)
+				return NULL;
 			factors.name = derived_name;
 		} else {
 			factors.name = clk_name;
---
