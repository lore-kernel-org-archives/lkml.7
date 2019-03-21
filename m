Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA548C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9263218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HQrpCn3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfCUOA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:00:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34195 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfCUOA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:00:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so4278860pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=027hMzfKYQEQdfMu8qZkppGAvGQRPJuwDJK4s8kel0A=;
        b=HQrpCn3UrwnzowF+4LyPfiO40tX7VWFT05bQmpD5hJ3HVNKfhwjfBryesqDNt7hY3v
         MSEh+5dXRMXZcKNfZEKdNtki+yUQyUMGzruteGV8+N5Mn+vdhkdBIE6bAit+hpQVgOpa
         CXSa8CUnerBjx+XWusyWfD8bilXKr2idnikkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=027hMzfKYQEQdfMu8qZkppGAvGQRPJuwDJK4s8kel0A=;
        b=hQZcHIPbEgjCnkfg8kPahFKn6T8wZYmcybsiOe9m/t8rwxJVwW9CeUoS2gHNdd1Jfk
         XeJUXYR+p1EySbe8yz8Enh2EtBIfr1vrU3qhn7SteBRBIjX2j9V/8lISp1eY+hbh7ZuE
         qD6HpU0lkT4E4/NlGPkIySNQPhQ6Nl2x9ZNbJemz10ysz/i9N3YBA1ErHKrPqKEGp/ay
         +IzlMtW1CDK13EVokZS6bQWO6z1zGEccsVURzxPLZ1jQiR3cn5NGv7H9GHX27f5PelOf
         ze1o2flRu2tFALporV0BgxYtSD+ly/wt9/yK28Hqxa6KeDbMkRXhmfLWgGwvVV7/4TgI
         eSKg==
X-Gm-Message-State: APjAAAU6WfhLlgWpRPra3wGqZcoFJv/8RtFYyFr0vKccHupxCeLz0hzG
        f350K9wIFbJX/UttJU0RwRZHlQ==
X-Google-Smtp-Source: APXvYqwRefcyhunLuH0FJ74yh5WPdBS3rYU0zw08zoDkm/w58d3u9fXtcQlKPjyNy/vORVxcDYqW+g==
X-Received: by 2002:a65:60c1:: with SMTP id r1mr3435155pgv.137.1553176826663;
        Thu, 21 Mar 2019 07:00:26 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.234])
        by smtp.gmail.com with ESMTPSA id i126sm7985158pfc.101.2019.03.21.07.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:00:25 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Ryan Pannell <ryan@osukl.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/4] dt-bindings: Add vendor prefix for microtech
Date:   Thu, 21 Mar 2019 19:29:53 +0530
Message-Id: <20190321135955.25661-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190321135955.25661-1-jagan@amarulasolutions.com>
References: <20190321135955.25661-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for microtech, known as
Microtech Technology Company Limited. a known producer for
Liquid Crytal Display modules and Touch Panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index caa7dbae750b..9e0b83e61414 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -249,6 +249,7 @@ micrel	Micrel Inc.
 microchip	Microchip Technology Inc.
 microcrystal	Micro Crystal AG
 micron	Micron Technology Inc.
+microtech	Microtech Technology Company Limited
 mikroe		MikroElektronika d.o.o.
 minix	MINIX Technology Ltd.
 miramems	MiraMEMS Sensing Technology Co., Ltd.
-- 
2.18.0.321.gffc6fa0e3

