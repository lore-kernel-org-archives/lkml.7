Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CC1C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE952609B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZsN93pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfEaBOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:14:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38223 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfEaBOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:14:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so3279127plb.5;
        Thu, 30 May 2019 18:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yp6vwmQ3UFg1RpTqex0tXos3VmAEaOYrUMRIMtSICN0=;
        b=qZsN93pwjg7V6N/NY7PV07aDyLaI9nzUvIhSPYgt/NlMTnkBvCERqLbEfq5iBP+IBx
         7h3lx+OJf+SRWXgrQjqfpn/Zk0t9WSh+PrcTZgIz1g3RbmIza70KnUzmY09lodiJRkY5
         ZVIhoHB3GUoVdDZe4W7HKGjXjjlDF5lBnFwLnOo+0vzirtByWnCh9Gk994M91ALLhpKG
         JA/iVZGTNSglz5kYTbjI05UFwWMzI0gtMAbA7nt0d+moAXz12OlKx7SKjht13VTIcx1Y
         gELxjdvjlKkc3pIqLhO1I26MuoFGV/ci5FX7TFBnvcyMedcDZMiUfeSOeeP/+phsbifx
         34Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yp6vwmQ3UFg1RpTqex0tXos3VmAEaOYrUMRIMtSICN0=;
        b=ubFCZD5KwFCEB1f9NIioLr8VUVhvTYgSd0DGDR+XdIyM2z9PqDmU56UZaUoEqv+spR
         8PubMVjb6Mj1UraTMMGxaYbmjbXRv3QRomJ+qeNy6+aHzHdB8Yo62zBqO/EdHnLiTQPJ
         pJ+pysRZnNsWc90rQoXd812C0a+wfP9LtN2ZwaIrbBqfdDvCpii60xAhck9yn0K0aeMh
         uCV3o8aiOZ31xroQDO6TjBgSfkq640WWPCHmk2NFYov3OwEhrpeS4c61TsIuYV687tXO
         RCsWNRkoJhr3f6hzaSPNl3TaBHlmyUS4U+D9UxLSdoQLzFxRkOAKLbH1UkPOGuPUCQSh
         ZrFQ==
X-Gm-Message-State: APjAAAUjjqxjg0Igl29euNOcuYYSwBY9fQRRJAEqRopQ4Glt9aBWIT4L
        GJm38Kefq/uCaSoUbRCwsEw=
X-Google-Smtp-Source: APXvYqwI5ZUlEfNeQUTFSSdnkiKoDQGizVzIkKhm4FHz44k07OLvM6sJ9IGMvekxUddYWftfdCc/tg==
X-Received: by 2002:a17:902:ab97:: with SMTP id f23mr6500325plr.237.1559265273866;
        Thu, 30 May 2019 18:14:33 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id j97sm3747107pje.5.2019.05.30.18.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 18:14:33 -0700 (PDT)
Date:   Fri, 31 May 2019 09:14:24 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: fix a missing-free bug in clk_cpy_name()
Message-ID: <20190531011424.GA4374@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In clk_cpy_name(), '*dst_p'('parent->name'and 'parent->fw_name') and 
'dst' are allcoted by kstrdup_const(). According to doc: "Strings 
allocated by kstrdup_const should be freed by kfree_const". So 
'parent->name', 'parent->fw_name' and 'dst' should be freed.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756..85c4d3f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3435,6 +3435,7 @@ static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
 	if (!dst)
 		return -ENOMEM;
 
+	kfree_const(dst);
 	return 0;
 }
 
@@ -3491,6 +3492,8 @@ static int clk_core_populate_parent_map(struct clk_core *core)
 				kfree_const(parents[i].name);
 				kfree_const(parents[i].fw_name);
 			} while (--i >= 0);
+			kfree_const(parent->name);
+			kfree_const(parent->fw_name);
 			kfree(parents);
 
 			return ret;
---
