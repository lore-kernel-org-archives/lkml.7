Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA52BC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC89B217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elQKMHk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLGS3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 13:29:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44982 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLGS27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:28:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so11394606wrm.11;
        Sat, 07 Dec 2019 10:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vM1/W3s9hUaBco1QIjxvNVf/2zcrVA1YhKGQhQIbg0U=;
        b=elQKMHk6ID0owo0bTH483lkx2/Jf2c56iQOQELwCDnt+v/XqkIZG1TKbYtrPMRu2QD
         iiTQnCGwaJ1AwmHWy5fwqJZQPWj0kFgxRbb3UX5ujkLN9KBxwYQlUmxZHZkwpF1PCUQ5
         Fq8SV+mfFaW1+rrq0G4xsLDI/vgMvj3rt2jOnHhChtAcB5Yw7Fgw9ECiHz70aV+xj+Ib
         8Xhs735pnNofdBxar5IHsRhbr1IUfutyEEpwxoBud885IsIERHu19UR1vCHq/XYhuYI7
         sMANfPFlwsh2iMkfzi2N1a1ndvrRsLYMTqA49LUTwAVbwgCcvZLuUjgLeC/39ABg7Xow
         hELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vM1/W3s9hUaBco1QIjxvNVf/2zcrVA1YhKGQhQIbg0U=;
        b=TYJ7hEoxM6BnM9EogUFclgjPANQZi5XVIW5DoQE+LMosH+iEvHXSOT/Q/ub0yEBsaz
         uFH8iCliXuTtTFbzKrkIZCq2jJLoao1q1AxgGOs5sxJ9wTmhqeap2ZioPERu4oRvqAym
         oyt5tK3Bixsthl5KSKXCXa3pkF1xALXFEjxOVAWwPM/YWuOB0XfAxdZP7JWy9ulx8je9
         H4dQj6x8mqoS/AiaMb9ziE3qjhAJQ59SeovPnwPhpScobTsqjaYnfBt+5pHZhtmDBQGc
         vCUli1kwbm+Ei+OTyFRo3BzwbNR3hXz+RBLWeAVzPRiSJaJP9l0IQ7Wdpszc0pNt/fpR
         RQ+Q==
X-Gm-Message-State: APjAAAULT3nzBDFSrzjN7mOuKe7O6hEYczmBw/QNlpNjFGCiYBYBACOV
        75lDY7PXyIwYusw/WketTBsirXMoO7U=
X-Google-Smtp-Source: APXvYqyRctEgA8Nk5/jOqosRNw2OGnkv4XbCS2a56OlvwIK0EODDU/XxzFChGzOjSbY1ugkWpQL5EA==
X-Received: by 2002:adf:8150:: with SMTP id 74mr23100017wrm.114.1575743337462;
        Sat, 07 Dec 2019 10:28:57 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4f:f100:30e3:988a:bff1:5a99])
        by smtp.gmail.com with ESMTPSA id g25sm9022146wmh.3.2019.12.07.10.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 10:28:57 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Joe Perches <joe@perches.com>, kernel@pengutronix.de,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: fix style in RESET CONTROLLER FRAMEWORK
Date:   Sat,  7 Dec 2019 19:28:39 +0100
Message-Id: <20191207182839.14482-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 37859277374d ("MAINTAINERS: add reset controller framework
keywords") slips in some formatting with spaces instead of tabs, which
./scripts/checkpatch.pl -f MAINTAINERS complains about:

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #14047: FILE: MAINTAINERS:14047:
  +K:      \b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b

Fixes: 37859277374d ("MAINTAINERS: add reset controller framework keywords")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master (eea2d5da29e3) and next-20191207

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f282e5cbc40e..0b5cb337f78c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14044,7 +14044,7 @@ F:	include/dt-bindings/reset/
 F:	include/linux/reset.h
 F:	include/linux/reset/
 F:	include/linux/reset-controller.h
-K:      \b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b
+K:	\b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b
 
 RESTARTABLE SEQUENCES SUPPORT
 M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
-- 
2.17.1

