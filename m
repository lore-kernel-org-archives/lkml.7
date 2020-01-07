Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C62C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173912187F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 14:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgxO9545"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgAGOLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 09:11:53 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36505 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 09:11:53 -0500
Received: by mail-wr1-f42.google.com with SMTP id z3so54115593wru.3;
        Tue, 07 Jan 2020 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXPcYVB30xhm6gxEB0gvLyqs4GZoHNZT9ztvtTk+fFQ=;
        b=FgxO9545VskxHdJfVvn1tBI9A3UGeuOqdRPg00rxYVknBk5+0A0+BeLRo6ya9Q8zg1
         q259O/l0MJDndgkDFAeV2kzqT121mXVxR8ll3yDU93GYIxyAJaVNQNNVdifkkBAswQ2R
         mm2PQyXSrInjHhHs2QgUKqrA1KqKzyl7as/TeAZsSuVhiZd95QWB5NaCh3ozi1f7QYbb
         c3bCN/b3XxVVJp54P4QR7hGtWd/hrHS4+XZx+68kE5ArF9eDWTaKKm+fwrqfIuZwp/0v
         8pZ+1eEhiSnGCGpyQyYpgrFTcuyK8w2EPZh4rRcO76/55KquRwIPvCs5jaQEh0kCtxIq
         8aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXPcYVB30xhm6gxEB0gvLyqs4GZoHNZT9ztvtTk+fFQ=;
        b=N8Dh/tnl0xVQT70OI+6nW6tZG15V2kZzHFc3v4uVWQ7fhSf+0yaMV7uh9F9Komcool
         ZZc63nzxOroMUkgWlJUnEko9WI/bzkPK+QuCPGHKVSMxfkgqsPfILMqxwVx0U02p0Q/d
         RXccqllFYAy8mg6jKhWggtABWSiRiZ4pSPi88KP12mesy8KVila+teukuIvuuPgq43TN
         YxuQQYpCZWxzhZoiWRp7vDuutiyhTbsLEVu3ezfiXG8+M7oRZ1gmwMBsUzwlACjiFXX6
         GBhWNVm5b4ufQavS+ibk1NuhCbW96m5wXp/HySnodCz/STisbSKL3EJkrjvQ2cyU3YSw
         ANHQ==
X-Gm-Message-State: APjAAAX74IOmcQmEV8UbKU6gr5aHuhH+vocrGRmjqDHDVsJ2j9wP0EpW
        TSHOzPcP3sSGfKYezmh51sqTz63oJEx8ow==
X-Google-Smtp-Source: APXvYqz1QI4XS31P1PNOZE+0WObqXH1kplJZw6jUyS/QqmL60a1DQE5wdTxT3VFtI3SKI+m72hpbug==
X-Received: by 2002:adf:f605:: with SMTP id t5mr25536036wrp.282.1578406310894;
        Tue, 07 Jan 2020 06:11:50 -0800 (PST)
Received: from localhost.localdomain (3e6b1cc1.rev.stofanet.dk. [62.107.28.193])
        by smtp.googlemail.com with ESMTPSA id d14sm78822429wru.9.2020.01.07.06.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 06:11:50 -0800 (PST)
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Bruno Thomsen <bruno.thomsen@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dt: bindings: add vendor prefix for Kamstrup A/S
Date:   Tue,  7 Jan 2020 15:11:38 +0100
Message-Id: <20200107141143.11838-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kamstrup manufactures meters for electricity, heating, cooling
and water. Including long-life communication infrastructure
for e.g. smart grid based on Linux, more information on
https://www.kamstrup.com

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6046f4555852..aab35a93e5ec 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -475,6 +475,8 @@ patternProperties:
     description: Shenzhen Jesurun Electronics Business Dept.
   "^jianda,.*":
     description: Jiandangjing Technology Co., Ltd.
+  "^kam,.*":
+    description: Kamstrup A/S
   "^karo,.*":
     description: Ka-Ro electronics GmbH
   "^keithkoep,.*":
-- 
2.24.1

