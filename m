Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478A7C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2288C205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juJeAFhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfE0OEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:04:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32824 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfE0OEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:04:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so9194977pgv.0;
        Mon, 27 May 2019 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yp6vwmQ3UFg1RpTqex0tXos3VmAEaOYrUMRIMtSICN0=;
        b=juJeAFheYBekNJQSoLUu8sN+VcoG8lAExtn/Q2xLayDMWJ+rVcSx3A5dew4RTixMRj
         3qh6nUbfTgGBLg5BZfcOuKzBjLmzObH911VnvKzeF7GZN/QjZ4i8sivx8htfkHnk9AL1
         GBP3RqKQ2Q63Vj8j+OpR1cY3C1XHdFBRD8EAF+1xAzUvAlVTpsLHjoIQP33L4h6RVRA5
         lmGhtSuT7hPuNZZUHpEW9qVdURrIY8fxTcCDMEaI81TEn1/PBlUNqhupoOgzgx9Oac6L
         O1JVD9mdmfHx+9Aji6dPIRdU/bggPeD5quZ8hmUvrqvH47mdFk36XiZ/GVaYVqEyS6pZ
         P/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yp6vwmQ3UFg1RpTqex0tXos3VmAEaOYrUMRIMtSICN0=;
        b=Dhy9YHUEKM7HkjKznREQ2HhWpXjPp5sq8/P4IneW7IfxGS8pjyxZEcuXnmZLMGkLSJ
         Jgmesrpx6YGtfxiIX7OFtwhWhUNBhJ+ynoKKTNBLScf15XGgROOL/vP5biymQs8mVxMz
         PcFQPft+zimfqvX+gpJH41D0mAvzQGHyy4RaB+kmVs5e8BS/hw/QyHPtplNYX8JD9N05
         mo307EeruQKPiD73yHqR5aRtQobyY/MLlWLcjgrLwKvdNCEo3QvoHclvkN+Q1LJoPgf5
         wz+cMOPA4scFXWkiuzwc57I1LzGJV3rGqsW9namc78ak5LxqHbpHFMVzPDu5dqW0au8J
         NOeA==
X-Gm-Message-State: APjAAAWKf23VnrfiLgclyf80kqYdvrLtIHWuS8lO5/CxvsXxY9D58qCE
        BGqEDfCdhzhCS7My8FFtUdA=
X-Google-Smtp-Source: APXvYqxtbBeuoDpbhTG5L3tAXZltOcherIxuW06KFPkKsCurMO/cw0DJ9i8Nt4ta3zMX7YyoNsVJ8A==
X-Received: by 2002:a63:e603:: with SMTP id g3mr17312029pgh.167.1558965883538;
        Mon, 27 May 2019 07:04:43 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id b35sm9951845pjc.15.2019.05.27.07.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 07:04:42 -0700 (PDT)
Date:   Mon, 27 May 2019 22:04:26 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: fix a missing-free bug in clk_cpy_name()
Message-ID: <20190527140426.GA6078@zhanggen-UX430UQ>
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
