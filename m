Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6809CC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F87D205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUUaPG5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbfGOUNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:13:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45009 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbfGOUMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:12:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so7923925pfe.11;
        Mon, 15 Jul 2019 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AxHo20cpPm/W3wEm88+I5u1phSMUfiBcovFIe0miYs=;
        b=XUUaPG5nxmt6MX9oO4OuNI7ZEmksD7SNdmudaVKnX9gtzsrAfvXOJ++XysB5veR5Z7
         774wUO4X32g2WGY9TZbmLV2NU5qSuYbLZz2eEjZRNYFyZwdNx+Nicmu/KLEvRXa6NfjJ
         UYsLordgh/KaPoxBAF4q745TnQukni134KSpZbYdp+rIvILlM6GP2pjBMEHl2JkAl/eN
         6caSdHswVYlUcqstbM2CyySzgg6qNxAkBlu9hlU7lanUdh+7hCFhSQ887EWJfymxI9gV
         wbKdzb10plrLqWYe4xYPUGipPPH/VNHYeo1AZI6R+MZaNG1/BHDnUU7nbhnO9Obc1fvp
         TcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AxHo20cpPm/W3wEm88+I5u1phSMUfiBcovFIe0miYs=;
        b=rIc/YoglmjeCo9ID3p6/AjABuSMOJn4TlQvnc4mlqdgdqTdV/sYvWWVIGbENgd7qs9
         baem9EXE9kLKztxInhvAvFT2+vQieJji8Dg6bCAoyKK7cKOTcObqB0Vid61zvm/uvxdY
         TNrtSCAtLGX70w+SCRs1zdNDvqziO3ZL3JG+darrxJ92rhlQPjf8jh9MOzNXbEZGBj+k
         mcFopoC8NT+utRpRH1NJ9bRLWdBZzteAaXpvTvmaaS86Q5Vl7aZmsHaF2LRsHd1XSz57
         K4/Oz6xhCE4dWB7CRUnBKEWD8CB9hwo6dcTQsXYE/DwSw/qmgvcgUSSyY+wZ6iALxNIS
         eijg==
X-Gm-Message-State: APjAAAXwq8KMpOpqJVHJ5h/d+m5iF0dj5xNHVK7pg7Ml9MtC5VPVuV3A
        1IQOpPCiUxDCOZvFC44xIq6MMObR
X-Google-Smtp-Source: APXvYqwz7qi222kKr5U+GxET6ohcsuPcHHhRH2cnZi5gAEZU/EPVSTrv90JucGBWlPFi5pBHRep0wA==
X-Received: by 2002:a63:dd4e:: with SMTP id g14mr18449598pgj.227.1563221573007;
        Mon, 15 Jul 2019 13:12:53 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id d21sm7327783pgm.75.2019.07.15.13.12.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:12:52 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] clk: Constify second argument of clk_bulk_disable_unprepare()
Date:   Mon, 15 Jul 2019 13:12:34 -0700
Message-Id: <20190715201234.13556-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715201234.13556-1-andrew.smirnov@gmail.com>
References: <20190715201234.13556-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both clk_bulk_disable() and clk_bulk_unprepare() take const struct
clk_bulk_data, so change clk_bulk_disable_unprepare() to do so as
well. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/clk.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 3956ae05b1cf..7a795fd6d141 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -936,7 +936,7 @@ clk_bulk_prepare_enable(int num_clks, const struct clk_bulk_data *clks)
 }
 
 static inline void clk_bulk_disable_unprepare(int num_clks,
-					      struct clk_bulk_data *clks)
+					      const struct clk_bulk_data *clks)
 {
 	clk_bulk_disable(num_clks, clks);
 	clk_bulk_unprepare(num_clks, clks);
-- 
2.21.0

