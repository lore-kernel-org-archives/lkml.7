Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B880FC2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F988206EC
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbJs8Xa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfLUXks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:40:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40025 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfLUXkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 18:40:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so12705842wmi.5;
        Sat, 21 Dec 2019 15:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYQSBkLnONYX/PnkBykc7VPkafXkRFxOt23+Xt4Hyj4=;
        b=vbJs8Xa4w/qfeT8hm5vUIRoIlz1EyU1WbXsJrK+a/YuRcmaep9FBGdIbysAyH5WNCq
         CuyEhJ8unlr7cilQGDNxqh25N5gbBiXIIiChFMUr/ms3AICy0ZTKB7f/WhDQdeUzTbYu
         5p/XBUQsqE6hYsW6eUn4v0qBB7ZPQDwE0xwwk5YELe7MKoktA5yZXFeRDGyqT1T3vJIt
         RnBw8lx/vDDRF+Je2+ZbSABK+gcawonOh3Bt3BbHmTMPG/RW9jG+fcy6popGCe0oyiPV
         35QFMhQzv/mWVCa64SnqsqY323OK14WMV6Pj2iXELoqmiqkEdndwpGgT0STXFHyzkFV+
         qQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYQSBkLnONYX/PnkBykc7VPkafXkRFxOt23+Xt4Hyj4=;
        b=sxDl6KMudlbgHuCJCpEa4SbW7/Q8SnWy2GkB7Nkr6PEcEsF5IX5Fj9AUvF++puiQ8V
         jFJrYyRFBikId+how3+d3fH5aHWDQhjCZHgH94ou+lI3vZry+lGent99wSGGPgP7c9Vy
         kyjHRJw3/qsgRa1e6cjLPALmSMxrsPrSRwDEvwXQCqy4jOzUy/0KiqD7sMjaeorPFSKv
         C3ostcAoKtS9+6FDdbCxeV99DwVJ5MNNLFYbVie3QY/eWgleC/YHvDAjS7lwycgJ9RQY
         LJrjyXoGdewBgfzz6/2mMeYYZeAO65g91OQNLwPeSAxXm5sYJCZTLi5ROXUgxnhIFjm5
         Vp6A==
X-Gm-Message-State: APjAAAUVO5QNK4OU0jI6X4nvXBa5eF1QawW79eFLTX16nsthaLbkXc4K
        TVBHhjWaNk6CLKqFwhEoZhY=
X-Google-Smtp-Source: APXvYqyxf7sIDPAaRsDn5U90srMvtYW4xh9mIepxtcaBsKhY4ht4JVzmmq/1jeqSP4icm9DE7UhQBA==
X-Received: by 2002:a1c:20d3:: with SMTP id g202mr24246732wmg.169.1576971645133;
        Sat, 21 Dec 2019 15:40:45 -0800 (PST)
Received: from localhost.localdomain (p5B3F6223.dip0.t-ipconnect.de. [91.63.98.35])
        by smtp.gmail.com with ESMTPSA id q3sm14179151wmj.38.2019.12.21.15.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 15:40:44 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] MAINTAINERS: Add entry for mpq7920 PMIC driver
Date:   Sun, 22 Dec 2019 00:40:29 +0100
Message-Id: <20191221234029.7796-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191221234029.7796-1-sravanhome@gmail.com>
References: <20191221234029.7796-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Monolithic Power Systems mpq7920 PMIC driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fd82e674cf4..8a31285b59c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11128,6 +11128,13 @@ S:	Maintained
 F:	Documentation/driver-api/serial/moxa-smartio.rst
 F:	drivers/tty/mxser.*
 
+MONOLITHIC POWER SYSTEM PMIC DRIVER
+M:	Saravanan Sekar <sravanhome@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/regulator/mpq7920.yaml
+F:	drivers/regulator/mpq7920.c
+F:	drivers/regulator/mpq7920.h
+
 MR800 AVERMEDIA USB FM RADIO DRIVER
 M:	Alexey Klimov <klimov.linux@gmail.com>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

