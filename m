Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A50C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 19:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF69F20828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 19:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="klF/ucA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfLZTMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:12:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34830 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfLZTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 14:12:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so24330184wro.2;
        Thu, 26 Dec 2019 11:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mmT0zF9OrkbiD8lj/0dOwJG0ayj5vgSHBwzc+nFQ5Gg=;
        b=klF/ucA9NSUXwoHRk1+Si9sfnX9CSLC+s/ebG98azsGLVJj1eJB4Gh6K3XoDxFlgwf
         e4nZ54SihxAA0YFfk6F238dYP9TkFDlIdBWYh29QftbkX6XICz13muXv7qfEFCaUuUQp
         CoschbCdrD2XhSLd6SH9cxWtcrwocY4bonRfJDgF/CSuyvksP5uvGZLJz34FGSHXsrYg
         zsLYDYhhxGFxKmdmRKvL1TWzEJnbemd/PDUm2ivSnrRB7Y9/J1HMeXM/nofk/edIPYUi
         LHC/Mn0XfMUpeWAegjzOMgII4GO2Y5c/8pyPTtVL95QBAq4GwW17CZ6pacVbQsAwGKv0
         faqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mmT0zF9OrkbiD8lj/0dOwJG0ayj5vgSHBwzc+nFQ5Gg=;
        b=qljpTyowgcev/GpTKpIF1bbKMxxMJBHBfQTJwUrOsrX0sSjGHasmclpp+PMK7l6KZP
         6U1I2tp8hd2AsYh3EQh9GguTjbDOOw69TknhWue/slRheRSWixFHlbgM5hQqg/nJksPR
         YyMY/Qcj1wkbwkg+SMLiKG1qF39WzqsYN7AdUBWV/Z3M2VBykz08yC2A0a80fM6VpyxV
         q3KZn9FtAkuJRmqGZO+ImA7P+Ta9saxlM407jsUr2lcfmt+/H46YYHfy4zjMzCyIveiF
         k446i4r6wnH6MYXG/7n8nmVsRsOq207ozdZcgKGW3aGisCcJtaYcpx73lwqz9ZBhalgY
         /tsg==
X-Gm-Message-State: APjAAAURew1Zp+M336YWrlF1KybZmgRAxkSaZhH2GwmFru1jU0JaVs43
        FqSFw+F4+w32wed9jHaznT8=
X-Google-Smtp-Source: APXvYqzFEhUhoMbvJ+dMFP1fHZY7u43hjf0Ydx1AtPN8kQZ0UFLEecCP0onL5y0FIk42usYSrzPz3A==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr45964730wrp.321.1577387565138;
        Thu, 26 Dec 2019 11:12:45 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id o7sm8965937wmh.11.2019.12.26.11.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 11:12:44 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        sboyd@kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] clk: clarify that clk_set_rate() does updates from top to bottom
Date:   Thu, 26 Dec 2019 20:12:24 +0100
Message-Id: <20191226191224.3785282-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191226191224.3785282-1-martin.blumenstingl@googlemail.com>
References: <20191226191224.3785282-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_set_rate() currently starts updating the rate for a clock at the
top-most affected clock and then walks down the tree to update the
bottom-most affected clock last.
This behavior is important for protected clocks where we can switch
between multiple parents to achieve the same output.

An example for this is the mali clock tree on Amlogic SoCs:
  mali_0_mux (must not change when enabled)
    mali_0_div (must not change when enabled)
     mali_0 (gate)
  mali_1_mux (must not change when enabled)
    mali_1_div (must not change when enabled)
      mali_1 (gate)
The final output can either use mali_0_gate or mali_1. To change the
final output we must switch to the "inactive" tree. Assuming mali_0 is
active, then we need to prepare mali_1 with the new desired rate and
finally switch the output to the mali_1 tree. This process will then
protect the mali_1 tree and at the same time unprotect the mali_0 tree.
The next call to clk_set_rate() will then switch from the mali_1 tree
back to mali_0.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/linux/clk.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 18b7b95a8253..7fd6a1febcf4 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -627,6 +627,9 @@ long clk_round_rate(struct clk *clk, unsigned long rate);
  * @clk: clock source
  * @rate: desired clock rate in Hz
  *
+ * Updating the rate starts at the top-most affected clock and then
+ * walks the tree down to the bottom-most clock that needs updating.
+ *
  * Returns success (0) or negative errno.
  */
 int clk_set_rate(struct clk *clk, unsigned long rate);
-- 
2.24.1

