Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89890C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B61206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMxhyvbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLZW34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:29:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34258 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfLZW3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:29:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so24686545wrr.1;
        Thu, 26 Dec 2019 14:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYQSBkLnONYX/PnkBykc7VPkafXkRFxOt23+Xt4Hyj4=;
        b=aMxhyvbL6kizu+9jCXYyLPOff9KQggKXtOu+n68QL2xUjCsPWuBnuGMKjz+o3h0h85
         HdRkKvamoJN370gZ2FG6tZGJRczJNmWac5+fSClSwg8z64H7hDJE4+ZY1uZ3arKf4qAd
         vSghnz6vnXVy+aRjlH8CBMMw5rhGWuTg3ZwJ/2Pf32Dt4QH3CLwfc6Hyq0z9Rd4wh11c
         muExlaUl465cgOoduaYJ61A4AJJTN/XptyxKG3IP/s/8QQgeybslKy/rZj+CFPYqqGLQ
         kuBxjAZNYOqij1eV4Kh3yFCsItW2jGi0MRkObXAs/oIon76GX2myngmrK2Z5OPXg37FL
         At+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYQSBkLnONYX/PnkBykc7VPkafXkRFxOt23+Xt4Hyj4=;
        b=DyP79nWibCKJdFyau8Vh5ItbhaGeK7tmFAvHmNHWE8XnqN+xU30phP3YQ4sw1SbxVV
         gAsfVyfL2HiYj3EV2OVdVOnNM2iBrQO9WnqzameUJtlMhy5pIXVFTXkdPe/BrfO238ec
         B0NnibTzVC2kfT6isbW8njfUhAu87YwcoCyhRXeKC2XOYLsKY1gevpISvqTiKdbLxmzu
         jbW2b2weAmt6iXhPR9QijgnItap9OdvtLAkd2WFzOLafPQVK9l8lMaSBt74MHjfTcMJO
         wc52osoVCXOLrTonAdueCDfb9A3VxWj1KOzV8F/LqPlGEUa5d01Cpm0U7g1gDvCB08zj
         3oMA==
X-Gm-Message-State: APjAAAXtWvoVfkZamUh3VkDc5rnsC+TC5o8WTzsKf+N1EKO+gne3bpax
        oIuKTnNjRfF7SZaNCBzSpac=
X-Google-Smtp-Source: APXvYqzwN+PR7T0DBlSL3aYoPiqdEUnGMhN2rMUynlDSJkm1qIzruGiDVALIbw+NP0u/HM1JZlB5ow==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr44168192wru.297.1577399386829;
        Thu, 26 Dec 2019 14:29:46 -0800 (PST)
Received: from localhost.localdomain (p5B3F7018.dip0.t-ipconnect.de. [91.63.112.24])
        by smtp.gmail.com with ESMTPSA id j2sm9731276wmk.23.2019.12.26.14.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:29:46 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] MAINTAINERS: Add entry for mpq7920 PMIC driver
Date:   Thu, 26 Dec 2019 23:29:30 +0100
Message-Id: <20191226222930.8882-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191226222930.8882-1-sravanhome@gmail.com>
References: <20191226222930.8882-1-sravanhome@gmail.com>
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

