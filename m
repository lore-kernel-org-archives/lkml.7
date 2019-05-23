Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115E4C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A6F21019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="s9ui9vJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfEWMvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:51:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40495 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbfEWMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id q62so5348301ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sr3q+U1eMl/yAW7j8+VmGxN32duQd8dX2jbMshZTZ4s=;
        b=s9ui9vJnc8eOVXnf7ED0z4qUqkyiwh94tqkJK1PSzsZZcnrjJY9KfwJKMMW9V1zgYF
         lsaZnmEodpfsTw02J1dgawNxrHvNu9vSlLbEFcx5B87fepseyC3TaYtWJEVFwe26AiyQ
         9hdYiMKL68UYW7ox8To0Y50q3cvVEr/BDxT9ZfFSCVx+CBfAcSBcRfWi9xHcZj0TMYjU
         SRT6n7LsY0AX+QGw+6vHqktX9fN8M86CZvwi5eblEw+zEVosvwSnVP0tJf7EJOd3Ode1
         WVywZcYiedyQwVjbDhvOUmU61RI/bXZxzBKQUtMkL74YaiwMr7FzK/TgQnac9uAgN44X
         cfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sr3q+U1eMl/yAW7j8+VmGxN32duQd8dX2jbMshZTZ4s=;
        b=Zjue1HPVGJiztoSyGYnMA5yGEOL+Lvb8WLQFZUxXNxe+R9GBnVJt4ypDgCGagKHUXa
         TtpLo5/qE+4kzQwNEWM7IS+bgwk1XzS8v/4D3pqzXHfTzvLLdG0RZx03McRkh+q9/h4+
         igbEzoHPg8suQdmUexLcQvG37isxNrDTaY07mixG/XPEUA2QQpYbb/lJLf+kBdj8fi4Q
         cfa012b43d9yZDz7gVTU2meL75YghrjtbqfaG2W/iMqLBX+m85ITWGFTHxmzLxDqrASk
         eNBkXIHTdAwLGBDg6WvDolNFzi+iEFh1NYCYiiJrIFhUoxwhNHHB9oApxkRQaotLFcrA
         DScg==
X-Gm-Message-State: APjAAAXIUoF3P88d/4ToWIHqi2NRo8X4PS8QE84Ivc2p9qS2NyR7teG1
        9JgtHNl85pydwlPKl9TG7q4bHw==
X-Google-Smtp-Source: APXvYqxvKprStAqdVyypXJpegvM61kwochDKE/AbVUmkUROg08eJUHMB8Y605duz88Pc36qg+GbAYw==
X-Received: by 2002:a2e:880d:: with SMTP id x13mr8142330ljh.72.1558615909344;
        Thu, 23 May 2019 05:51:49 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id c19sm5947154lfi.69.2019.05.23.05.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:51:48 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] staging: kpc2000: add missing asterisk in comment
Date:   Thu, 23 May 2019 14:51:37 +0200
Message-Id: <20190523125143.32511-4-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523125143.32511-1-simon@nikanor.nu>
References: <20190523125143.32511-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl error "code indent should use tabs where possible".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index b559ade04aca..945d8e4e7ba5 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -25,7 +25,7 @@
  *                                                              D                   C2S DMA Present
  *                                                               DDD                C2S DMA Channel Number    [up to 8 channels]
  *                                                                  II              IRQ Count [0 to 3 IRQs per core]
-                                                                      1111111000
+ *                                                                    1111111000
  *                                                                    IIIIIII       IRQ Base Number [up to 128 IRQs per card]
  *                                                                           ___    Spare
  *
-- 
2.20.1

