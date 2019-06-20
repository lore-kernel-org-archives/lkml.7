Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC5C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D1A2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jiMFQLFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbfFTPBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:01:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36879 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbfFTPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:00:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so3392482wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpe6ifKz7SuClVLyY+/xaKksjob7YtLZf3uysFqr17Y=;
        b=jiMFQLFWtay0rRLzh+SDB1Dk3ZblEFbfmuUEilGmgJhW7Qz4KUAOuTU5opeNKO7nWt
         3n6KP2WFOgh4jIbh0CB9N9m692nzvHycKqZRsgw92Mlfi9t2kewxfiNiBnBP5KlFLxic
         9sQlOpOiP0tLfshVxMI7gTuXYR4gXXsG0+JRzy1uCzshnXvPYB+bAiQslnrgRGdC0QLh
         NMa/SVGZJA10pDNrdq1V2bwTLxwVHMR7VPnGXjDgUXHQq/AVt4tl6/UlAxL1WAvBtdy6
         2FmQiQyKUnniVQIQw0J8yoVz/rtn/FkGaG8a51HsMYSRhJKY5QMSsch1/WLNdyKN+7zC
         oXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpe6ifKz7SuClVLyY+/xaKksjob7YtLZf3uysFqr17Y=;
        b=VQLcwXSYscZ/EwHwY2EN5hoGzn360iYbEf4n9CJBJ3YbvJcfqRw4fvVtRcI24D/DoV
         LX+3bSu4VNSqDdqwrsHKa6KRagbf25PQlbxt0W0IXI/qKNEf1BILml1CFUny+gdtBiAE
         x3NPKY3O9fVSSwX2Ir2/olg9VMPp4TueRlmt905ptXes0I9Fsp/a8UvPYYmwk6vnmlDm
         uTvpCSdJYgLKjR6pM+0s3fLyAeO4C+dCHtVyFwVndvVujYF+a5S8Wadu3QKhUCPExqVP
         zUrsOE/J6PmmO47LvLTDUX6K+6y+uCFVhKAAofwK+SkGEDpcmXYFbWDySh5g2Kphz64f
         NUaQ==
X-Gm-Message-State: APjAAAXAGXWioH8pNYbXfntAOXFTBgPDEhru6zHu0uPqBNx7Gz9jvm8h
        nfk6LrXESzfkjOhdlSOq0bNSwQ==
X-Google-Smtp-Source: APXvYqz/51ebhU5rXHGYChuENG7sgffban6b+i1SauMMfobKCffeLHRbzIr3Iq24zACKZETqEf1n9Q==
X-Received: by 2002:adf:f046:: with SMTP id t6mr41634172wro.307.1561042827408;
        Thu, 20 Jun 2019 08:00:27 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o126sm6802520wmo.1.2019.06.20.08.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 08:00:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT 06/14] soc: amlogic: meson-clk-measure: add G12B second cluster cpu clk
Date:   Thu, 20 Jun 2019 17:00:05 +0200
Message-Id: <20190620150013.13462-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620150013.13462-1-narmstrong@baylibre.com>
References: <20190620150013.13462-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the G12B second CPU cluster CPU and SYS_PLL measure IDs.

These IDs returns 0Hz on G12A.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-clk-measure.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index c470e24f1dfa..f09b404b39d3 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -324,6 +324,8 @@ static struct meson_msr_id clk_msr_g12a[CLK_MSR_MAX] = {
 	CLK_MSR_ID(84, "co_tx"),
 	CLK_MSR_ID(89, "hdmi_todig"),
 	CLK_MSR_ID(90, "hdmitx_sys"),
+	CLK_MSR_ID(91, "sys_cpub_div16"),
+	CLK_MSR_ID(92, "sys_pll_cpub_div16"),
 	CLK_MSR_ID(94, "eth_phy_rx"),
 	CLK_MSR_ID(95, "eth_phy_pll"),
 	CLK_MSR_ID(96, "vpu_b"),
-- 
2.21.0

